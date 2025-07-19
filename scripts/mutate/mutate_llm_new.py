#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
SMT-LIB Multi-LLM Mutator for Split Constraints
Based on the paper "Solving String Split Constraints via Relaxation"
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
from typing import List, Dict, Optional, Tuple, Set
import requests

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class LLMConfig:
    """Configuration for different LLM providers"""
    
    PROVIDERS = {
        "openai": {
            "api_key": "sk-YXvRQcCLnbWOjyEJ5BjTI3dcikKzl3SGeocvoms0g3MxEc0q",
            "base_url": "https://api2.aigcbest.top/v1",
            "models": ["gpt-4o", "gpt-4o-mini", "gpt-3.5-turbo"],
            "default_model": "gpt-4o"
        },
        "claude": {
            "api_key": "sk-YXvRQcCLnbWOjyEJ5BjTI3dcikKzl3SGeocvoms0g3MxEc0q",
            "base_url": "https://api2.aigcbest.top/v1",
            "models": ["claude-3.5-sonnet", "claude-3-opus", "claude-3-haiku"],
            "default_model": "claude-3.5-sonnet"
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
            "max_tokens": 2000,
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
                    timeout=60
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
    """Claude API provider"""
    
    def generate_completion(self, messages: List[Dict[str, str]]) -> str:
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        data = {
            "model": self.model,
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 2000,
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
                    timeout=60
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
    """DeepSeek API provider"""
    
    def generate_completion(self, messages: List[Dict[str, str]]) -> str:
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        data = {
            "model": self.model,
            "messages": messages,
            "temperature": 0.7,
            "max_tokens": 2000,
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
                    timeout=60
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
    def __init__(self, provider: str = "openai", model: str = None, method_type: str = None):
        self.provider_name = provider
        self.provider = LLMProviderFactory.create_provider(provider, model)
        self.method_type = method_type

        # Real-world scenarios based on the paper
        self.rws_scenarios = {
            'Email Validation': {
                'description': 'Email format validation with local-part and domain parsing',
                'delimiters': ['@', '.'],
                'constraints': ['segment count', 'non-empty segments', 'domain structure']
            },
            'URL Parsing': {
                'description': 'URL parsing with protocol, host, and path extraction',
                'delimiters': ['://', '/', ':', '?', '&'],
                'constraints': ['protocol validation', 'host structure', 'path segments']
            },
            'CSV Processing': {
                'description': 'CSV/TSV field separation and validation',
                'delimiters': [',', '\t', ';', '|'],
                'constraints': ['field count', 'escape handling', 'empty fields']
            },
            'Log Analysis': {
                'description': 'Log entry parsing with timestamp and level extraction',
                'delimiters': [' ', ':', '-', '|', '[', ']'],
                'constraints': ['timestamp format', 'log level validation', 'message extraction']
            },
            'Configuration Parsing': {
                'description': 'Key-value pair and INI file processing',
                'delimiters': ['=', ':', '\n', '[', ']'],
                'constraints': ['key validation', 'value extraction', 'section handling']
            },
            'Authentication Token': {
                'description': 'JWT and API key validation',
                'delimiters': ['.', '-', ':'],
                'constraints': ['segment count', 'base64 validation', 'signature checking']
            }
        }

        # System prompts aligned with paper methodology
        self.rws_system_prompt = """You are an expert in SMT solver constraints and string reasoning, following the methodology from "Solving String Split Constraints via Relaxation".

Your task is to generate a COMPLETE SMT-LIB2 file for real-world string processing scenarios using the following split operations:
- (str.split_at x d k): returns the k-th segment after splitting string x by delimiter d (0-based indexing)
- (str.num_splits x d): returns the total number of segments after splitting
- (str.split_rest x d k): returns the concatenation of all segments from index k onwards with delimiters preserved

Important guidelines:
1. Generate a complete, standalone SMT-LIB2 file with proper header
2. Use only string constants as delimiters (no regex patterns)
3. Focus on practical constraints that would appear in real programs
4. Ensure all variables are properly declared before use
5. Create meaningful relationships between split operations
6. Include both satisfiable and unsatisfiable constraint combinations
7. End with (check-sat) and (exit)
8. Use semicolon (;) for comments, NOT asterisks or markdown formatting
9. Do not use bold (**) or any other markdown formatting
10. Follow standard SMT-LIB2 syntax exactly

The output should be a complete SMT-LIB2 file that can be directly processed by SMT solvers."""

        self.sfc_system_prompt = """You are an expert in SMT solver constraints implementing the approach from "Solving String Split Constraints via Relaxation".

Generate SIMPLE split constraints using:
- (str.split_at x d k): access k-th segment (use small indices: 0, 1, 2)
- (str.num_splits x d): count segments
- (str.split_rest x d k): get remaining segments from index k

Guidelines:
1. Analyze existing string variables and add basic split operations
2. Use single-character or simple multi-character delimiters (no regex)
3. Keep index values small (0-3)
4. Add simple validation constraints
5. Focus on fundamental split operation semantics
6. Use semicolon (;) for comments, not asterisks or markdown
7. Do not use bold (**) or any markdown formatting

Output only the additional constraints to insert, starting with:
; --- LLM Generated Split Constraints ---
and ending with:
; --- End LLM Generated Constraints ---"""

        self.cso_system_prompt = """You are an expert in SMT solver constraints implementing complex split patterns from "Solving String Split Constraints via Relaxation".

Generate COMPLEX split constraints with:
1. Multiple partitions: same string split by different delimiters
2. Nested splits: split results used as inputs to further splits
3. Cross-dependencies: relationships between different split operations
4. Advanced validation: complex constraints on segment relationships

Use only string constant delimiters (no regex). Create sophisticated constraint networks that test solver capabilities.
Use semicolon (;) for comments, not asterisks or markdown formatting.

Output format: Return only the additional constraints, starting with:
; --- LLM Generated Split Constraints ---
and ending with:
; --- End LLM Generated Constraints ---"""

        # Example constraints for each method type
        self.rws_examples = {
            'Email Validation': [
                """(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated by: LLM-based constraint generator
Application: Email validation scenario
Target solver: CVC4, Z3, Z3str3, Z3-Noodler
|)
(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Email validation scenario
(declare-const email String)

; Email must split into exactly 2 parts by "@"
(assert (= (str.num_splits email "@") 2))

; Extract local-part and domain
(declare-const local_part String)
(declare-const domain_part String)
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain_part (str.split_at email "@" 1)))

; Local part must be non-empty
(assert (> (str.len local_part) 0))

; Domain must contain at least one "."
(assert (>= (str.num_splits domain_part ".") 2))

; Extract domain name and TLD
(declare-const domain_name String)
(assert (= domain_name (str.split_at domain_part "." 0)))
(assert (> (str.len domain_name) 0))

; Get TLD (everything after first dot)
(declare-const tld_part String)
(assert (= tld_part (str.split_rest domain_part "." 1)))
(assert (>= (str.len tld_part) 2))

; Example constraint: email should not contain spaces
(assert (not (str.contains email " ")))

(check-sat)
(exit)"""
            ],
            'CSV Processing': [
                """(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated by: LLM-based constraint generator
Application: CSV processing scenario
Target solver: CVC4, Z3, Z3str3, Z3-Noodler
|)
(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; CSV line processing
(declare-const csv_line String)

; Ensure at least 3 fields
(assert (>= (str.num_splits csv_line ",") 3))

; Extract first three fields
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(assert (= field1 (str.split_at csv_line "," 0)))
(assert (= field2 (str.split_at csv_line "," 1)))
(assert (= field3 (str.split_at csv_line "," 2)))

; First field must not be empty (ID field)
(assert (> (str.len field1) 0))

; Second field has length constraints (status field)
(assert (and (>= (str.len field2) 2) (<= (str.len field2) 10)))

; Get remaining fields
(declare-const remaining_fields String)
(assert (= remaining_fields (str.split_rest csv_line "," 3)))

; Example: ensure no field contains quotes
(assert (not (str.contains field1 "\"")))
(assert (not (str.contains field2 "\"")))

(check-sat)
(exit)"""
            ]
        }

        self.sfc_examples = [
            {
                "input": """(set-logic QF_SLIA)
(declare-const x String)
(declare-const y String)
(assert (str.contains x "hello"))
(assert (= (str.len x) 10))
(check-sat)""",
                "output": """; --- LLM Generated Split Constraints ---
(declare-const x_first String)
(declare-const x_second String)
(assert (= x_first (str.split_at x "l" 0)))
(assert (= x_second (str.split_at x "l" 1)))
(assert (> (str.len x_first) 0))
(assert (> (str.len x_second) 0))
(assert (= (str.num_splits x "l") 3))
; --- End LLM Generated Constraints ---"""
            }
        ]

        self.cso_examples = [
            {
                "input": """(set-logic QF_SLIA)
(declare-const data String)
(assert (str.contains data "#"))
(assert (str.contains data ":"))
(assert (> (str.len data) 20))
(check-sat)""",
                "output": """; --- LLM Generated Split Constraints ---
; Complex multi-delimiter splitting
(declare-const hash_parts_count Int)
(assert (= hash_parts_count (str.num_splits data "#")))
(assert (>= hash_parts_count 2))

; First split by "#"
(declare-const part1 String)
(declare-const part2_onwards String)
(assert (= part1 (str.split_at data "#" 0)))
(assert (= part2_onwards (str.split_rest data "#" 1)))

; Split first part by ":"
(assert (>= (str.num_splits part1 ":") 2))
(declare-const key String)
(declare-const value String)
(assert (= key (str.split_at part1 ":" 0)))
(assert (= value (str.split_rest part1 ":" 1)))

; Nested split on part2_onwards by ":"
(declare-const part2_first String)
(assert (= part2_first (str.split_at part2_onwards ":" 0)))

; Cross-partition constraint
(assert (not (= key part2_first)))

; Length relationships
(assert (< (str.len key) (str.len value)))
(assert (> (str.len part2_onwards) (+ (str.len key) (str.len value))))

; --- End LLM Generated Constraints ---"""
            }
        ]

    def create_messages(self, smt_content: str) -> List[Dict[str, str]]:
        """Create messages for LLM based on method type"""
        if self.method_type == 'rws':
            # Select a random scenario
            scenario_name = random.choice(list(self.rws_scenarios.keys()))
            scenario = self.rws_scenarios[scenario_name]
            
            messages = [
                {"role": "system", "content": self.rws_system_prompt},
                {"role": "user", "content": f"Generate a complete SMT-LIB2 file for {scenario_name}: {scenario['description']}. Use delimiters: {scenario['delimiters']}. Focus on: {scenario['constraints']}. The output should be a complete, standalone SMT-LIB2 file. Remember to use only semicolon (;) for comments and avoid any markdown formatting."}
            ]
            
            # Add relevant example if available
            if scenario_name in self.rws_examples:
                example = random.choice(self.rws_examples[scenario_name])
                messages.extend([
                    {"role": "assistant", "content": example}
                ])
                messages.append({"role": "user", "content": "Generate a different complete SMT-LIB2 file for the same scenario with different constraints and variables. Use proper SMT-LIB2 syntax with semicolon comments."})
                
        elif self.method_type == 'sfc':
            messages = [{"role": "system", "content": self.sfc_system_prompt}]
            for example in self.sfc_examples:
                messages.extend([
                    {"role": "user", "content": example["input"]},
                    {"role": "assistant", "content": example["output"]}
                ])
            messages.append({"role": "user", "content": smt_content + "\n\nGenerate split constraints using proper SMT-LIB2 syntax with semicolon comments."})
            
        elif self.method_type == 'cso':
            messages = [{"role": "system", "content": self.cso_system_prompt}]
            for example in self.cso_examples:
                messages.extend([
                    {"role": "user", "content": example["input"]},
                    {"role": "assistant", "content": example["output"]}
                ])
            messages.append({"role": "user", "content": smt_content + "\n\nGenerate complex split constraints using proper SMT-LIB2 syntax with semicolon comments."})
        else:
            raise ValueError(f'Invalid method type: {self.method_type}')
            
        return messages

    def validate_generated_constraints(self, constraints: str) -> bool:
        """Validate that generated constraints follow the expected format"""
        lines = constraints.strip().split('\n')
        
        # Check for markdown formatting issues
        if any('**' in line for line in lines):
            logging.warning("Found markdown bold formatting in generated content")
            return False
        
        # Check for incorrect comment style
        for line in lines:
            stripped = line.strip()
            if stripped.startswith('*') and stripped.endswith('*') and not stripped.startswith(';'):
                logging.warning(f"Found incorrect comment style: {line}")
                return False
        
        # For RWS method, check for complete SMT-LIB file structure
        if self.method_type == 'rws':
            # Check for basic SMT-LIB structure
            has_logic = any('set-logic' in line for line in lines)
            has_check_sat = any('check-sat' in line for line in lines)
            has_exit = any('exit' in line for line in lines)
            
            if not (has_logic and has_check_sat and has_exit):
                logging.warning("RWS generated content missing basic SMT-LIB structure")
                return False
        else:
            # For SFC and CSO methods, check for markers
            if not any('; --- LLM Generated Split Constraints ---' in line for line in lines):
                return False
            if not any('; --- End LLM Generated Constraints ---' in line for line in lines):
                return False
            
        # Check for split operations
        has_split = any('str.split_at' in line or 'str.num_splits' in line or 'str.split_rest' in line for line in lines)
        if not has_split:
            return False
            
        # Check for no regex patterns (common regex indicators)
        regex_indicators = [
            r're.', 'regex',  # regex functions
            r're.++', r're.*', r're.+',  # regex operators
            r'str.in_re',  # regex membership
            r're.range', r're.union'  # regex constructors
        ]
        for line in lines:
            # Skip comment lines
            if line.strip().startswith(';'):
                continue
            # Check for regex patterns in actual constraints
            for indicator in regex_indicators:
                if indicator in line:
                    logging.warning(f"Possible regex pattern detected: {line}")
                    return False
                
        return True

    def post_process_smt_content(self, content: str) -> str:
        """Post-process generated SMT content to fix formatting issues"""
        lines = content.strip().split('\n')
        
        # Remove invalid first lines (not starting with ; or ()
        while lines and lines[0].strip() and not (lines[0].strip().startswith(';') or lines[0].strip().startswith('(')):
            lines.pop(0)
        
        # Remove invalid last lines (not starting with ; or ()
        while lines and lines[-1].strip() and not (lines[-1].strip().startswith(';') or lines[-1].strip().startswith('(')):
            lines.pop()
        
        processed_lines = []
        
        for line in lines:
            original_line = line
            
            # Skip lines that are markdown artifacts or invalid SMT content
            stripped = line.strip()
            if stripped and not (stripped.startswith(';') or stripped.startswith('(')):
                # Check if it might be a markdown artifact
                if any(marker in stripped for marker in ['```', 'smt', 'lib']):
                    continue
            
            # Remove markdown-style formatting
            # Remove bold markers
            line = line.replace('**', '')
            
            # Remove italics markers
            line = line.replace('*', '')
            
            # Fix comment formatting
            stripped = line.strip()
            
            # Convert various comment styles to SMT-LIB style
            if stripped and not stripped.startswith('('):
                # Check if it looks like a comment
                if (stripped.startswith('*') and stripped.endswith('*')) or \
                   (stripped.startswith('//')) or \
                   (stripped.startswith('#')) or \
                   (any(keyword in stripped.lower() for keyword in 
                        ['example', 'note:', 'constraint:', 'extract', 'validate', 'check'])):
                    # Convert to proper SMT comment
                    comment_content = stripped
                    # Remove comment markers if present
                    if stripped.startswith('*') and stripped.endswith('*'):
                        comment_content = stripped[1:-1].strip()
                    elif stripped.startswith('//'):
                        comment_content = stripped[2:].strip()
                    elif stripped.startswith('#'):
                        comment_content = stripped[1:].strip()
                    
                    # Only add as comment if it's not an SMT command
                    if not any(cmd in comment_content for cmd in 
                              ['declare-fun', 'declare-const', 'assert', 'check-sat', 
                               'set-logic', 'set-option', 'set-info', 'exit']):
                        line = '; ' + comment_content
            
            # Fix malformed SMT-LIB commands
            # Common LLM mistakes
            line = line.replace('(**declare-fun**', '(declare-fun')
            line = line.replace('(**assert**', '(assert')
            line = line.replace('(**declare-const**', '(declare-const')
            line = line.replace('(*', '(')
            line = line.replace('*)', ')')
            
            # Fix spacing issues
            line = re.sub(r'\(\s+', '(', line)  # Remove space after opening paren
            line = re.sub(r'\s+\)', ')', line)  # Remove space before closing paren
            line = re.sub(r'\s+', ' ', line)    # Normalize multiple spaces
            
            # Skip empty lines or lines that became empty after processing
            if not line.strip():
                if original_line.strip():  # Only skip if originally non-empty
                    continue
            
            processed_lines.append(line)
        
        # Join and clean up the result
        result = '\n'.join(processed_lines)
        
        # Final cleanup: ensure proper spacing
        result = re.sub(r'\n\n\n+', '\n\n', result)  # Max 2 consecutive newlines
        
        return result

    def generate_split_constraints(self, smt_content: str) -> str:
        """Generate split constraints using LLM"""
        try:
            messages = self.create_messages(smt_content)
            
            max_attempts = 3
            for attempt in range(max_attempts):
                result = self.provider.generate_completion(messages)
                
                # Post-process the result to fix formatting
                result = self.post_process_smt_content(result)
                
                # Validate the generated constraints
                if self.validate_generated_constraints(result):
                    return result
                else:
                    logging.warning(f"Invalid constraints generated on attempt {attempt + 1}, retrying...")
                    if attempt < max_attempts - 1:
                        messages.append({"role": "assistant", "content": result})
                        if self.method_type == 'rws':
                            messages.append({"role": "user", "content": "The generated content is invalid. Please generate a complete SMT-LIB2 file with proper structure (set-logic, declarations, assertions with split operations, check-sat, exit). Use only string constant delimiters (no regex). Use semicolon (;) for comments, not asterisks."})
                        else:
                            messages.append({"role": "user", "content": "The generated constraints are invalid. Please ensure you use only string constant delimiters (no regex) and include proper split operations. Use semicolon (;) for comments."})
                        
            logging.error(f"Failed to generate valid constraints after {max_attempts} attempts")
            return ""
            
        except Exception as e:
            logging.error(f"Error generating constraints with {self.provider_name}: {e}")
            raise

class SMTFileMutator:
    def __init__(self, provider: str = "openai", model: str = None, method_type: str = None):
        self.llm_mutator = LLMMutator(provider, model, method_type)
        self.method_type = method_type
    
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
        split_functions = ['str.split_at', 'str.num_splits', 'str.split_rest']
        return any(func in content for func in split_functions)
    
    def find_insertion_point(self, lines: List[str]) -> int:
        """Find the best place to insert new constraints (before check-sat)"""
        for i in range(len(lines) - 1, -1, -1):
            line = lines[i].strip()
            if line.startswith('(check-sat'):
                return i
        return len(lines)
    
    def clean_generated_constraints(self, generated_text: str) -> List[str]:
        """Extract and clean the constraints from LLM output"""
        # For RWS method, return the complete file as-is
        if self.method_type == 'rws':
            return generated_text.strip().split('\n') if generated_text else []
        
        # For SFC and CSO methods, extract constraints between markers
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
                    if line.startswith('(') and line.count('(') == line.count(')'):
                        constraints.append(line)
                elif line.startswith(';'):
                    constraints.append(line)
        
        return constraints
    
    def mutate_file(self, input_path: str, output_path: str) -> bool:
        """Mutate a single SMT file"""
        try:
            # For RWS method, generate completely new file
            if self.method_type == 'rws':
                logging.info(f"Generating new RWS constraints file -> {output_path}")
                
                # Generate complete SMT-LIB file using LLM
                generated_content = self.llm_mutator.generate_split_constraints("")
                
                if not generated_content:
                    logging.warning(f"No content generated for RWS method")
                    return False
                
                # Write the complete generated file
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(generated_content)
                
                # Count lines for logging
                line_count = len(generated_content.strip().split('\n'))
                logging.info(f"Successfully generated RWS file -> {output_path}")
                logging.info(f"Generated {line_count} lines of SMT-LIB content")
                return True
            
            # For SFC and CSO methods, process the input file
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
            
            logging.info(f"Processing {input_path} with method '{self.method_type}' and string variables: {string_vars}")
            
            # Generate split constraints using LLM
            generated_constraints = self.llm_mutator.generate_split_constraints(content)
            
            if not generated_constraints:
                logging.warning(f"No constraints generated for {input_path}")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            # Clean and validate generated constraints
            constraint_lines = self.clean_generated_constraints(generated_constraints)
            
            if not constraint_lines or len(constraint_lines) < 3:  # At least start marker, one constraint, end marker
                logging.warning(f"No valid constraints extracted for {input_path}")
                with open(output_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                return False
            
            # Insert constraints into the file
            lines = content.split('\n')
            insertion_point = self.find_insertion_point(lines)
            
            # Insert empty line before constraints if needed
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
            logging.info(f"Added {len(constraint_lines)} constraint lines using method '{self.method_type}'")
            
            return True
            
        except Exception as e:
            logging.error(f"Error mutating {input_path}: {e}")
            # Copy original file on error for SFC/CSO methods
            if self.method_type != 'rws':
                try:
                    with open(input_path, 'r', encoding='utf-8') as f:
                        content = f.read()
                    with open(output_path, 'w', encoding='utf-8') as f:
                        f.write(content)
                except:
                    pass
            return False

def main():
    parser = argparse.ArgumentParser(
        description='Multi-LLM based SMT-LIB mutation with split constraints',
        epilog='Based on "Solving String Split Constraints via Relaxation"\n\n'
               'Note: For RWS method, input file is required for consistency but not used in generation.'
    )
    parser.add_argument('--input', '-i', help='Input SMT file (ignored for RWS method)', required=True)
    parser.add_argument('--output', '-o', help='Output SMT file', required=True)
    parser.add_argument('--provider', '-p', default='openai', 
                       choices=LLMProviderFactory.list_providers(),
                       help='LLM provider to use (default: openai)')
    parser.add_argument('--model', '-m', help='Model to use (default: provider default)')
    parser.add_argument('--method', '-t', default='sfc',
                       choices=['rws', 'sfc', 'cso'],
                       help='Generation method:\n'
                            '  rws: Real-World Scenarios - generates complete new SMT-LIB file\n'
                            '  sfc: Simple Function Calls - adds basic split constraints to input\n'
                            '  cso: Complex Split Operations - adds complex split patterns to input\n'
                            '(default: sfc)')
    parser.add_argument('--list-providers', action='store_true', help='List available providers')
    parser.add_argument('--list-models', help='List models for a provider')
    parser.add_argument('--verbose', '-v', action='store_true', help='Verbose logging')

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
    
    # Initialize mutator
    try:
        mutator = SMTFileMutator(args.provider, args.model, args.method)
        logging.info(f"Using provider: {args.provider}, method: {args.method}")
        if args.model:
            logging.info(f"Using model: {args.model}")
    except Exception as e:
        logging.error(f"Failed to initialize mutator: {e}")
        sys.exit(1)
    
    # Process single file
    if args.method == 'rws':
        logging.info(f"Generating new RWS constraints file: {args.output}")
        logging.info("Note: Input file is specified for consistency but not used in RWS generation")
    else:
        logging.info(f"Processing {args.input} with method '{args.method}'")
    
    success = mutator.mutate_file(args.input, args.output)
    if success:
        if args.method == 'rws':
            logging.info("RWS file generation completed successfully")
        else:
            logging.info("File mutation completed successfully")
    else:
        if args.method == 'rws':
            logging.info("RWS file generation failed")
        else:
            logging.info("File was copied without mutation")

if __name__ == "__main__":
    main()