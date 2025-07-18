#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT-LIB Multi-LLM Mutator
This script uses various LLM providers to intelligently add str.split_at constraints to SMT-LIB files
Supports: OpenAI, Claude, DeepSeek
"""

import os
import random
import sys
import re
import json
import logging
import argparse
import time
from typing import List, Dict, Optional, Tuple
import requests

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class LLMConfig:
    """Configuration for different LLM providers"""
    
    PROVIDERS = {
        "openai": {
            "api_key": "sk-YXvRQcCLnbWOjyEJ5BjTI3dcikKzl3SGeocvoms0g3MxEc0q",
            "base_url": "https://api2.aigcbest.top/v1",
            "models": ["gpt-4.1", "gpt-o1", "gpt-3.5-turbo"],
            "default_model": "gpt-4o"
        },
        "claude": {
            "api_key": "sk-YXvRQcCLnbWOjyEJ5BjTI3dcikKzl3SGeocvoms0g3MxEc0q",
            "base_url": "https://api2.aigcbest.top/v1",
            "models": ["claude-3-opus-20240229", "claude-3-sonnet-20240229", "claude-3-haiku-20240307"],
            "default_model": "claude-3-sonnet-20240229"
        },
        "deepseek": {
            "api_key": "sk-YXvRQcCLnbWOjyEJ5BjTI3dcikKzl3SGeocvoms0g3MxEc0q",
            "base_url": "https://api2.aigcbest.top/v1",
            "models": ["deepseek-chat", "deepseek-coder"],
            "default_model": "deepseek-chat"
        }
    }

class BaseLLMProvider:
    """Base class for LLM providers"""
    
    def __init__(self, provider: str, model: str = None):
        self.provider = provider
        self.config = LLMConfig.PROVIDERS[provider]
        self.model = model or self.config["default_model"]
        self.api_key = self.config["api_key"]
        self.base_url = self.config["base_url"]
        self.max_retries = 3
        self.retry_delay = 1
    
    def generate_completion(self, messages: List[Dict[str, str]]) -> str:
        """Generate completion using the specific provider"""
        raise NotImplementedError("Subclasses must implement generate_completion")

class OpenAIProvider(BaseLLMProvider):
    """OpenAI API provider"""
    
    def generate_completion(self, messages: List[Dict[str, str]]) -> str:
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        data = {
            "model": self.model,
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 1000,
            "top_p": 1.0,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0
        }
        
        for attempt in range(self.max_retries):
            try:
                response = requests.post(
                    f"{self.base_url}/chat/completions",
                    headers=headers,
                    json=data,
                    timeout=30
                )
                
                if response.status_code == 200:
                    result = response.json()
                    return result["choices"][0]["message"]["content"].strip()
                else:
                    error_msg = f"OpenAI API error {response.status_code}: {response.text}"
                    if self._should_retry_status(response.status_code, attempt):
                        continue
                    raise Exception(error_msg)
                    
            except requests.exceptions.RequestException as e:
                if attempt < self.max_retries - 1:
                    wait_time = self.retry_delay * (2 ** attempt)
                    logging.warning(f"OpenAI request failed, retrying in {wait_time}s: {e}")
                    time.sleep(wait_time)
                    continue
                raise e
    
    def _should_retry_status(self, status_code, attempt):
        if attempt >= self.max_retries - 1:
            return False
        
        if status_code in [429, 500, 502, 503, 504]:
            wait_time = self.retry_delay * (2 ** attempt)
            logging.warning(f"Retrying OpenAI in {wait_time}s due to status {status_code}")
            time.sleep(wait_time)
            return True
        return False

class ClaudeProvider(BaseLLMProvider):
    """Claude API provider (using OpenAI-compatible format for custom interface)"""
    
    def generate_completion(self, messages: List[Dict[str, str]]) -> str:
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        data = {
            "model": self.model,
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 1000,
            "top_p": 1.0,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0
        }
        
        for attempt in range(self.max_retries):
            try:
                response = requests.post(
                    f"{self.base_url}/chat/completions",
                    headers=headers,
                    json=data,
                    timeout=30
                )
                
                if response.status_code == 200:
                    result = response.json()
                    return result["choices"][0]["message"]["content"].strip()
                else:
                    error_msg = f"Claude API error {response.status_code}: {response.text}"
                    if self._should_retry_status(response.status_code, attempt):
                        continue
                    raise Exception(error_msg)
                    
            except requests.exceptions.RequestException as e:
                if attempt < self.max_retries - 1:
                    wait_time = self.retry_delay * (2 ** attempt)
                    logging.warning(f"Claude request failed, retrying in {wait_time}s: {e}")
                    time.sleep(wait_time)
                    continue
                raise e
    
    def _should_retry_status(self, status_code, attempt):
        if attempt >= self.max_retries - 1:
            return False
        
        if status_code in [429, 500, 502, 503, 504]:
            wait_time = self.retry_delay * (2 ** attempt)
            logging.warning(f"Retrying Claude in {wait_time}s due to status {status_code}")
            time.sleep(wait_time)
            return True
        return False

class DeepSeekProvider(BaseLLMProvider):
    """DeepSeek API provider (using OpenAI-compatible format for custom interface)"""
    
    def generate_completion(self, messages: List[Dict[str, str]]) -> str:
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        data = {
            "model": self.model,
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 1000,
            "top_p": 1.0,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0
        }
        
        for attempt in range(self.max_retries):
            try:
                response = requests.post(
                    f"{self.base_url}/chat/completions",
                    headers=headers,
                    json=data,
                    timeout=30
                )
                
                if response.status_code == 200:
                    result = response.json()
                    return result["choices"][0]["message"]["content"].strip()
                else:
                    error_msg = f"DeepSeek API error {response.status_code}: {response.text}"
                    if self._should_retry_status(response.status_code, attempt):
                        continue
                    raise Exception(error_msg)
                    
            except requests.exceptions.RequestException as e:
                if attempt < self.max_retries - 1:
                    wait_time = self.retry_delay * (2 ** attempt)
                    logging.warning(f"DeepSeek request failed, retrying in {wait_time}s: {e}")
                    time.sleep(wait_time)
                    continue
                raise e
    
    def _should_retry_status(self, status_code, attempt):
        if attempt >= self.max_retries - 1:
            return False
        
        if status_code in [429, 500, 502, 503, 504]:
            wait_time = self.retry_delay * (2 ** attempt)
            logging.warning(f"Retrying DeepSeek in {wait_time}s due to status {status_code}")
            time.sleep(wait_time)
            return True
        return False

class LLMProviderFactory:
    """Factory for creating LLM providers"""
    
    @staticmethod
    def create_provider(provider: str, model: str = None) -> BaseLLMProvider:
        provider = provider.lower()
        
        if provider == "openai":
            return OpenAIProvider(provider, model)
        elif provider == "claude":
            return ClaudeProvider(provider, model)
        elif provider == "deepseek":
            return DeepSeekProvider(provider, model)
        else:
            raise ValueError(f"Unsupported provider: {provider}")
    
    @staticmethod
    def list_providers() -> List[str]:
        return list(LLMConfig.PROVIDERS.keys())
    
    @staticmethod
    def list_models(provider: str) -> List[str]:
        return LLMConfig.PROVIDERS.get(provider, {}).get("models", [])

class LLMMutator:
    def __init__(self, provider: str = "openai", model: str = None, method_type : str = None):
        self.provider_name = provider
        self.provider = LLMProviderFactory.create_provider(provider, model)
        self.method_type = method_type

        self.rws_task = {'User Input Validation secnario': ['Email format validation', 'URL parsing', 'phone number formats'],
                         'Configuration File Processing secnario': ['Key-value pairs', 'INI files', 'JSON-like structures'],
                         'Log Analysis secnario': ['Timestamp extraction', 'log level parsing', 'IP address validation'],
                         'CSV/TSV Parsing secnario': ['Field separation', 'quoted strings', 'escape characters'],
                         'Authentication Token Handling secnario': ['JWT parsing', 'API key validation', 'session tokens']}

        self.rws_system_prompt = lambda x: f"""You are an expert in SMT solver constraints and string operations. 
Your task is to generate SMT-LIB2 constraints and add intelligent split constraints using str.split_at functions, for "{x}" secnario.

Output format: Return all the SMT-LIB2 text, starting with "; --- LLM Generated Split Constraints ---" and ending with "; --- End LLM Generated Constraints ---"
"""

        self.rws_examples = {
            'Email format validation':[
                {""}
            ],
            'URL parsing':[],
            'phone number formats':[],
            'Key-value pairs':[],
            'INI files':[],
            'JSON-like structures':[],
            'Timestamp extraction':[],
            'log level parsing':[],
            'IP address validation':[],
            'Field separation':[],
            'quoted strings':[],
            'escape characters':[],
            'JWT parsing':[],
            'API key validation':[],
            'session tokens':[]
        }

        self.sfc_system_prompt = """You are an expert in SMT solver constraints and string operations.
Your task is to analyze the given SMT-LIB2 file and add intelligent split constraints using str.split_at functions.

Guidelines:
1. Analyze existing string variables and constraints
2. Add meaningful str.split_at constraints that could reveal interesting behaviors
3. Declare necessary auxiliary variables (String for split_at results)
4. Use delimiters that are relevant to the problem context
5. Use small index values (0, 1, 2) for str.split_at
6. Add validation constraints for split results

Output format: Return ONLY the additional constraints to be inserted, one per line, starting with "; --- LLM Generated Split Constraints ---" and ending with "; --- End LLM Generated Constraints ---"
"""

        self.sfc_examples = [
            {
                "input": """(set-logic QF_SLIA)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "T") (str.to_re "N")))))
(assert (str.in_re y (re.* (re.* (str.to_re "T")))))
(assert (= (str.len x) (str.len y)))
(assert (not (= x y)))
(assert (= (str.len x) 7))
(check-sat)""",
                "output": """; --- LLM Generated Split Constraints ---
(declare-const first_T_segment_of_x String)
(declare-const second_T_segment_of_x String)
(assert (= (str.split_at x "N" 0) first_T_segment_of_x))
(assert (= (str.split_at x "N" 1) second_T_segment_of_x))
(assert (> (str.len first_T_segment_of_x) 0))
(assert (> (str.len second_T_segment_of_x) 0))
(assert (str.in_re first_T_segment_of_x (re.+ (str.to_re "T"))))
(assert (str.in_re second_T_segment_of_x (re.+ (str.to_re "T"))))
; --- End LLM Generated Constraints ---"""
            },
            {
                "input": """(set-logic QF_SLIA)
(declare-const email String)
(declare-const domain String)
(assert (str.contains email "@"))
(assert (> (str.len email) 5))
(assert (str.suffix email ".com"))
(check-sat)""",
                "output": """; --- LLM Generated Split Constraints ---
(declare-const local_part String)
(declare-const domain_part String)
(declare-const subdomain_part String)
(declare-const tld_part String)
(assert (= (str.split_at email "@" 0) local_part))
(assert (= (str.split_at email "@" 1) domain_part))
(assert (> (str.len local_part) 0))
(assert (> (str.len domain_part) 0))
(assert (str.suffix domain_part ".com"))
(assert (= (str.split_at domain_part "." 0) subdomain_part))
(assert (= (str.split_at domain_part "." 1) tld_part))
(assert (> (str.len subdomain_part) 0))
(assert (= tld_part "com"))
; --- End LLM Generated Constraints ---"""
            }            
        ]

# Create sophisticated constraints where the same string variable appears in multiple partitions with different delimiters, 
# split results serve as inputs to further split operations (nested splits), and multiple interdependent operations form constraint networks.

        self.cso_system_prompt = """You are an expert in SMT solver constraints and string operations. 
Your task is to analyze the given SMT-LIB2 file and add sophisticated split constraints using str.split_at functions. 

Guidelines: 
1. Analyze existing string variables and constraints 
2. Add meaningful str.split_at constraints that could reveal interesting behaviors
3. Declare necessary auxiliary variables (String for split_at results)
4. Apply different delimiters to the same string variable to create overlapping partition views
5. Use split results as inputs to subsequent split operations, creating deep dependency chains
6. Combine multi-delimiter and nested split operations so that results from different delimiter paths feed into each other's nested chains

Output format: Return ONLY the additional constraints to be inserted, one per line, starting with "; --- LLM Generated Split Constraints ---" and ending with "; --- End LLM Generated Constraints ---"
"""

        self.cso_examples = [
            {
                "input": """(set-logic QF_SLIA)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "T") (str.to_re "N")))))
(assert (str.in_re y (re.* (re.* (str.to_re "T")))))
(assert (= (str.len x) (str.len y)))
(assert (not (= x y)))
(assert (= (str.len x) 7))
(check-sat)""",
                "output": """; --- LLM Generated Split Constraints ---

; Split x at position 2 and 5 to create two-level partitions
(declare-const x_split1 String)
(declare-const x_split2 String)
(assert (= (str.substr x 0 2) x_split1))
(assert (= (str.substr x 2 5) x_split2))

; Split x_split1 at position 1 (nested split from first part)
(declare-const x_split1a String)
(declare-const x_split1b String)
(assert (= (str.substr x_split1 0 1) x_split1a))
(assert (= (str.substr x_split1 1 1) x_split1b))

; Split x_split2 at position 3 (nested split from second part)
(declare-const x_split2a String)
(declare-const x_split2b String)
(assert (= (str.substr x_split2 0 3) x_split2a))
(assert (= (str.substr x_split2 3 2) x_split2b))

; Create an overlapping view of x using different delimiter positions
(declare-const x_alt1 String)
(declare-const x_alt2 String)
(assert (= (str.substr x 1 3) x_alt1))
(assert (= (str.substr x 4 3) x_alt2))

; Nested split on overlapping part x_alt1
(declare-const x_alt1a String)
(declare-const x_alt1b String)
(assert (= (str.substr x_alt1 0 2) x_alt1a))
(assert (= (str.substr x_alt1 2 1) x_alt1b))

; Use y as secondary split source
(declare-const y_split1 String)
(declare-const y_split2 String)
(assert (= (str.substr y 0 3) y_split1))
(assert (= (str.substr y 3 4) y_split2))

; Combine split results from x and y
; For example: concatenating splits across x and y
(declare-const xy_merge String)
(assert (= xy_merge (str.++ x_split1b y_split1)))

; Further split merged result
(declare-const xy_merge_sub String)
(assert (= (str.substr xy_merge 1 3) xy_merge_sub))

; Use xy_merge_sub as a dependent in nested split chains
(declare-const xy_merge_sub_a String)
(declare-const xy_merge_sub_b String)
(assert (= (str.substr xy_merge_sub 0 2) xy_merge_sub_a))
(assert (= (str.substr xy_merge_sub 2 1) xy_merge_sub_b))

; --- End LLM Generated Constraints ---
"""
            },
            {
                "input": """(set-logic QF_SLIA)
(declare-const email String)
(declare-const domain String)
(assert (str.contains email "@"))
(assert (> (str.len email) 5))
(assert (str.suffix email ".com"))
(check-sat)""",
                "output": """; --- LLM Generated Split Constraints ---

; Split email at the '@' character to separate local-part and domain
(declare-const local String)
(declare-const email_domain_part String)
(assert (= (str.indexof email "@" 0)  (str.len local)))
(assert (= email (str.++ local "@" email_domain_part)))

; Split email_domain_part at the first '.' to separate domain name and TLD
(declare-const domain_name String)
(declare-const tld_with_dot String)
(assert (= (str.indexof email_domain_part "." 0) (str.len domain_name)))
(assert (= email_domain_part (str.++ domain_name tld_with_dot)))

; Remove the leading '.' from tld_with_dot to isolate the TLD
(declare-const tld String)
(assert (= (str.substr tld_with_dot 1 (- (str.len tld_with_dot) 1)) tld))

; Assert domain matches domain_name extracted from email
(assert (= domain domain_name))

; --- End LLM Generated Constraints ---
"""
            }            
        ]

    def create_messages(self, smt_content: str) -> List[Dict[str, str]]:
        # rws or sfc or cso
        if self.method_type == 'rws':
            scenario = random.sample(list(self.rws_task.keys()), 1)[0]
            task = random.sample(self.rws_task[scenario], 1)[0]
            messages = [{"role": "system", "content": self.rws_system_prompt(task)}]
            for example in self.rws_examples[task]:
                messages.extend([
                    {"role": "user", "content": example["input"]},
                    {"role": "assistant", "content": example["output"]}
                ])
        else:
            if self.method_type == 'sfc':
                messages = [{"role": "system", "content": self.sfc_system_prompt}]
                for example in self.sfc_examples:
                    messages.extend([
                        {"role": "user", "content": example["input"]},
                        {"role": "assistant", "content": example["output"]}
                    ])                
            elif self.method_type == 'cso':
                messages = [{"role": "system", "content": self.cso_system_prompt}]
                for example in self.cso_examples:
                    messages.extend([
                        {"role": "user", "content": example["input"]},
                        {"role": "assistant", "content": example["output"]}
                    ])                
            else:
                raise ValueError('invalid method type')
            
            messages.append({"role": "user", "content": smt_content})
        return messages

    def generate_split_constraints(self, smt_content: str) -> str:
        try:
            messages = self.create_messages(smt_content)
            return self.provider.generate_completion(messages)
        except Exception as e:
            logging.error(f"Error generating constraints with {self.provider_name}: {e}")
            raise

class SMTFileMutator:
    def __init__(self, provider: str = "openai", model: str = None, method_type :str = None):
        self.llm_mutator = LLMMutator(provider, model, method_type)
    
    def extract_string_variables(self, content: str) -> List[str]:
        """Extract declared string variable names from SMT content"""
        string_vars = []
        
        declare_patterns = [
            r'\(declare-const\s+(\w+)\s+String\)',
            r'\(declare-fun\s+(\w+)\s+\(\)\s+String\)'
        ]
        
        for pattern in declare_patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            string_vars.extend(matches)
        
        return list(set(string_vars))
    
    def has_split_functions(self, content: str) -> bool:
        """Check if the file already contains split functions"""
        return 'str.split_at' in content
    
    def find_insertion_point(self, lines: List[str]) -> int:
        """Find the best place to insert new constraints (before check-sat)"""
        for i in range(len(lines) - 1, -1, -1):
            line = lines[i].strip()
            if line.startswith('(check-sat'):
                return i
        return len(lines)
    
    def clean_generated_constraints(self, generated_text: str) -> List[str]:
        """Extract and clean the constraints from LLM output"""
        lines = generated_text.split('\n')
        constraints = []
        in_constraints = False
        
        for line in lines:
            line = line.strip()
            if '; --- LLM Generated Split Constraints ---' in line:
                in_constraints = True
                constraints.append(line)
                continue
            elif '; --- End LLM Generated Constraints ---' in line:
                constraints.append(line)
                break
            elif in_constraints:
                if line and not line.startswith(';'):
                    # Validate that it's a proper SMT statement
                    if line.startswith('(') and line.endswith(')'):
                        constraints.append(line)
                elif line.startswith(';'):
                    constraints.append(line)
        
        return constraints
    
    def mutate_file(self, input_path: str, output_path: str) -> bool:
        """Mutate a single SMT file"""
        try:
            with open(input_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Check if file has string variables
            string_vars = self.extract_string_variables(content)
            if not string_vars:
                logging.info(f"No string variables found in {input_path}, copying as-is")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            # Check if already has split constraints
            if self.has_split_functions(content):
                logging.info(f"File {input_path} already has split functions, copying as-is")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            logging.info(f"Processing {input_path} with string variables: {string_vars}")
            
            # Generate split constraints using LLM
            generated_constraints = self.llm_mutator.generate_split_constraints(content)
            
            if not generated_constraints:
                logging.warning(f"No constraints generated for {input_path}")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            # Clean and validate generated constraints
            constraint_lines = self.clean_generated_constraints(generated_constraints)
            
            if not constraint_lines:
                logging.warning(f"No valid constraints extracted for {input_path}")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            # Insert constraints into the file
            lines = content.split('\n')
            insertion_point = self.find_insertion_point(lines)
            
            # Insert empty line before constraints
            if insertion_point > 0 and lines[insertion_point - 1].strip():
                constraint_lines.insert(0, "")
            
            # Insert constraints
            for i, constraint in enumerate(reversed(constraint_lines)):
                lines.insert(insertion_point, constraint)
            
            # Add empty line after constraints if needed
            if insertion_point < len(lines) - len(constraint_lines) and lines[insertion_point + len(constraint_lines)].strip():
                lines.insert(insertion_point + len(constraint_lines), "")
            
            # Write the mutated file
            mutated_content = '\n'.join(lines)
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(mutated_content)
            
            logging.info(f"Successfully mutated {input_path} -> {output_path}")
            logging.info(f"Added {len(constraint_lines)} constraint lines")
            
            return True
            
        except Exception as e:
            logging.error(f"Error mutating {input_path}: {e}")
            # Copy original file on error
            try:
                with open(input_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
            except:
                pass
            return False

def main():
    parser = argparse.ArgumentParser(description='Multi-LLM based SMT-LIB mutation with split constraints')
    parser.add_argument('--input', '-i', help='Input SMT file')
    parser.add_argument('--output', '-o', help='Output SMT file')
    parser.add_argument('--provider', '-p', default='openai', 
                       choices=LLMProviderFactory.list_providers(),
                       help='LLM provider to use')
    parser.add_argument('--model', '-m', help='Model to use (default: provider default)')
    parser.add_argument('--list-providers', action='store_true', help='List available providers')
    parser.add_argument('--list-models', help='List models for a provider')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose logging')
    parser.add_argument('--method_type', '-t', help='rws or sfc or cso')

    args = parser.parse_args()
    
    if args.verbose:
        logging.getLogger().setLevel(logging.DEBUG)
    
    if args.list_providers:
        print("Available providers:")
        for provider in LLMProviderFactory.list_providers():
            print(f"  - {provider}")
        return
    
    if args.list_models:
        models = LLMProviderFactory.list_models(args.list_models)
        print(f"Available models for {args.list_models}:")
        for model in models:
            print(f"  - {model}")
        return
    
    # Check required arguments for mutation
    if not args.input or not args.output:
        parser.error("--input and --output are required for mutation")
    
    # Initialize mutator
    try:
        mutator = SMTFileMutator(args.provider, args.model, args.method_type)
        logging.info(f"Using provider: {args.provider}")
        if args.model:
            logging.info(f"Using model: {args.model}")
    except Exception as e:
        logging.error(f"Failed to initialize mutator: {e}")
        sys.exit(1)
    
    # Process single file
    logging.info(f"Processing single file: {args.input}")
    success = mutator.mutate_file(args.input, args.output)
    if success:
        logging.info("File mutation completed successfully")
    else:
        logging.info("File was copied without mutation")

if __name__ == "__main__":
    main()