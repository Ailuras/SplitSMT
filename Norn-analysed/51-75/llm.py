import sys
import os
import json
import logging
from typing import List, Dict
import hashlib
import openai
import time

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class LLM:  
    def __init__(self, model: str):  
        self.model = model
        # export OPENAI_API_KEY="sk-CR2xrVsTQxfw82qSHLm3Ld7DOLo5OT6tgBMM10naD1f0ejJC"
        openai.api_key = os.getenv("OPENAI_API_KEY")  
        openai.api_base = os.getenv("OPENAI_API_BASE", "https://oneapi.kylelv.com/v1")  
        
        self.system_prompt = """You are an expert in SMT solver constraints.
        Analyze the given SMT-LIB2 constraint and output it in an easily understandable format.
        Be concise and precise in your output."""  
        
        # Few-shot examples  
        self.examples = [  
            {  
                "constraint": """(assert (str.in_re var_7 (re.* (re.range "a" "u"))))""",  
                "explanation": "; x7 in [a-u]*"  
            },  
            {  
                "constraint": """(assert (str.in_re (str.++ var_7 "z" var_8 ) (re.++ (re.* (re.union (str.to_re "z") (re.++ (re.union (str.to_re "b") (str.to_re "a")) (re.union (str.to_re "z") (str.to_re "b"))))) (re.union (str.to_re "b") (str.to_re "a")))))""",  
                "explanation": "; x7 + z + x8 in [z | [[b | a] + [z | b]]]* + [b | a]"  
            },  
            {  
                "constraint": """(assert (not (str.in_re (str.++ var_7 "z" var_8 "a" ) (re.* (re.union (str.to_re "a") (re.++ (re.union (str.to_re "z") (str.to_re "b")) (re.++ (re.* (str.to_re "b")) (re.union (str.to_re "z") (str.to_re "a")))))))))""",  
                "explanation": "; x7 + z + x8 + a not in [a | [[z | b] + [b]* + [z | a]]]*"  
            }  
        ]  
        
        self.max_retries = 3  
        self.retry_delay = 1  

    def create_messages(self, new_constraint: str) -> List[Dict[str, str]]:  
        messages = [{"role": "system", "content": self.system_prompt}]  
        
        for example in self.examples:  
            messages.extend([  
                {"role": "user", "content": example["constraint"]},  
                {"role": "assistant", "content": example["explanation"]}  
            ])  
        
        messages.append({"role": "user", "content": new_constraint})  
        
        return messages  

    def ans(self, info: str) -> str:  
        for attempt in range(self.max_retries):  
            try:  
                response = openai.ChatCompletion.create(  
                    model="gpt-4o",  
                    messages=self.create_messages(info),  
                    temperature=0.3,
                    max_tokens=150,  
                    top_p=1.0,  
                    frequency_penalty=0.0,  
                    presence_penalty=0.0  
                )  
                
                answer = response.choices[0].message.content.strip()  
                return answer  
                
            except openai.error.RateLimitError:  
                if attempt < self.max_retries - 1:  
                    wait_time = self.retry_delay * (2 ** attempt)  
                    logging.warning(f"Rate limit hit, waiting {wait_time} seconds...")  
                    time.sleep(wait_time)  
                    continue  
                logging.error("Rate limit exceeded after max retries")  
                raise  
                
            except openai.error.APIError as e:  
                logging.error(f"API error: {e}")  
                raise  
                
            except Exception as e:  
                logging.error(f"Unexpected error: {e}")  
                raise  

    def add_example(self, constraint: str, explanation: str):  
        self.examples.append({  
            "constraint": constraint,  
            "explanation": explanation  
        })  

    def clear_examples(self):  
        self.examples = []  

    def set_api_key(self, api_key: str):  
        openai.api_key = api_key  

    def set_api_base(self, api_base: str):  
        openai.api_base = api_base 

class SMTProcessor:
    def __init__(self):
        self.llm = LLM("gpt4o")
        self.constraints_dict: Dict[str, Dict] = {}
        self.file_indices: Dict[str, List[int]] = {}
        self.current_index = 1

    def classify_line(self, line: str) -> str:
        if not line.strip():
            return 'empty'
            
        line_start_mapping = {
            ';': 'comment',
            '(set-logic': 'logic',
            '(check-sat': 'check_sat',
            '(exit': 'exit',
            '(declare-fun': 'declare',
            '(define-fun': 'declare',
            '(assert': 'assert'
        }

        for start, line_type in line_start_mapping.items():
            if line.startswith(start):
                return line_type
        return 'info'

    def process_lines(self, lines: List[str]) -> List[str]:
        constraints = []
        current_constraint = []

        for line in lines:
            line = line.rstrip()
            if not line:
                continue
                
            line_type = self.classify_line(line)
            
            if line_type == 'assert':
                if current_constraint:
                    constraints.append('\n'.join(current_constraint))
                current_constraint = [line]
            elif line_type == 'info' and current_constraint:
                current_constraint.append(line)
                
        if current_constraint:
            constraints.append('\n'.join(current_constraint))
            
        return constraints

    def get_constraint_hash(self, constraint: str) -> str:
        return hashlib.md5(constraint.encode()).hexdigest()

    def process_constraint(self, constraint: str) -> int:
        constraint_hash = self.get_constraint_hash(constraint)
        
        if constraint_hash not in self.constraints_dict:
            answer = self.llm.ans(constraint)
            self.constraints_dict[constraint_hash] = {
                "index": self.current_index,
                "constraint": constraint,
                "answer": answer
            }
            self.current_index += 1
            
        return self.constraints_dict[constraint_hash]["index"]

    def process_folder(self, input_folder: str, output_dir: str):
        try:
            os.makedirs(output_dir, exist_ok=True)
            constraints_file = os.path.join(output_dir, "constraints.jsonl")
            file_indices_file = os.path.join(output_dir, "file_indices.json")

            for filename in sorted(os.listdir(input_folder)):
                if not filename.endswith('.smt2'):
                    continue

                file_path = os.path.join(input_folder, filename)
                logging.info(f"Processing file: {filename}")

                try:
                    with open(file_path, 'r') as f:
                        lines = f.readlines()
                except Exception as e:
                    logging.error(f"Error reading file {filename}: {e}")
                    continue

                constraints = self.process_lines(lines)
                
                file_indices = []
                for constraint in constraints:
                    index = self.process_constraint(constraint)
                    file_indices.append(index)
                
                self.file_indices[filename] = file_indices
                
                comments = []
                for constraint in constraints:
                    constraint_hash = self.get_constraint_hash(constraint)
                    answer = self.constraints_dict[constraint_hash]["answer"]
                    comments.append(answer)
                
                with open(file_path, 'a') as f:
                    f.write("; ============================ [llm] =============================\n")
                    f.write('\n'.join(comments))
                    f.write('\n')

            with open(constraints_file, 'w', encoding='utf-8') as f:
                for constraint_info in self.constraints_dict.values():
                    f.write(json.dumps(constraint_info, ensure_ascii=False) + '\n')

            with open(file_indices_file, 'w', encoding='utf-8') as f:
                json.dump(self.file_indices, f, ensure_ascii=False, indent=2)

            logging.info(f"Constraints saved to: {constraints_file}")
            logging.info(f"File indices saved to: {file_indices_file}")

        except Exception as e:
            logging.error(f"Error processing folder: {input_folder}")
            logging.error(f"Exception: {e}")
            raise

def main():
    if len(sys.argv) != 3:
        print('Usage: python script.py <input_folder> <output_dir>')
        sys.exit(1)

    input_folder = sys.argv[1]
    output_dir = sys.argv[2]

    if not os.path.exists(input_folder):
        print(f"Input folder does not exist: {input_folder}")
        sys.exit(1)

    processor = SMTProcessor()
    processor.process_folder(input_folder, output_dir)

if __name__ == '__main__':
    main()