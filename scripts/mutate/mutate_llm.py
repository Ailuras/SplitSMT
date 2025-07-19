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
                         'CSV/TSV Parsing secnario': ['Field separation', 'escape characters'],
                         'Authentication Token Handling secnario': ['JWT parsing', 'API key validation', 'session tokens']}

        self.rws_system_prompt = lambda x: f"""You are an expert in SMT solver constraints and string reasoning.
Your task is to generate SMT-LIB2 constraints for the "{x}" scenario, incorporating intelligent split constraints using a custom operation called str.split_at. This operation supports the following forms:
(str.split_at x d k): returns the (k+1)th part of x after splitting it by the delimiter d.
(str.num_splits x d): returns the number of parts obtained after splitting x by the delimiter.
(str.split_rest x d k): returns all segments after the (k+1)th part of x when split by the delimiter.
Note these custom operations may only appear inside assert statements, and please ensure that all variables used are explicitly declared before use.
Output format:
Return the complete SMT-LIB2 constraints as plain text, starting with:
; --- LLM Generated Split Constraints ---
and ending with:
; --- End LLM Generated Constraints ---
"""

        self.rws_examples = {
            'Email format validation':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Assume email is a string variable
(declare-const email String)

; Split email by "@", must get exactly 2 parts (local-part and domain)
(assert (= (str.num_splits email "@") 2))

; Extract local-part (before @) and domain (after @)
(define-const local-part String (str.split_at email "@" 0))
(define-const domain String (str.split_at email "@" 1))

; Ensure local-part is non-empty
(assert (not (= local-part "")))

; Split domain by ".", must have at least 2 parts (domain name and TLD)
(assert (>= (str.num_splits domain ".") 2))

; Extract top-level domain (TLD) as the last segment after the last "."
(define-const tld String 
  (str.split_at domain "." (- (str.num_splits domain ".") 1)))

; Ensure TLD has at least 2 characters
(assert (>= (str.len tld) 2))

; Optional: ensure domain name (before TLD) is non-empty
(define-const domain-name String (str.split_at domain "." 0))
(assert (not (= domain-name "")))

; Optional: check rest segments of domain after domain-name
(define-const domain-rest String (str.split_rest domain "." 0))
; (optional further processing on domain-rest if needed)

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare email address as a string variable
(declare-const email String)

; Split email by "@", should yield exactly 2 parts
(assert (= (str.num_splits email "@") 2))

; Extract local and domain parts using str.split_at
(define-const local-part String (str.split_at email "@" 0))
(define-const domain-part String (str.split_at email "@" 1))

; Ensure local-part is not empty
(assert (not (= local-part "")))

; Ensure domain-part contains at least one "."
(assert (>= (str.num_splits domain-part ".") 2))

; Extract first subdomain (before first ".")
(define-const subdomain String (str.split_at domain-part "." 0))
(assert (not (= subdomain "")))

; Extract top-level domain (TLD) as all segments after first subdomain
(define-const tld-part String (str.split_rest domain-part "." 0))

; Ensure TLD part contains at least one non-empty segment
(assert (>= (str.len tld-part) 2))

; Optional: Ensure entire email contains no spaces
(assert (= (str.contains email " ") false))

; --- End LLM Generated Constraints ---
"""],
            'URL parsing':[
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; URL variable declaration
(declare-fun url () String)

; Scheme extraction: e.g., http in "http://example.com"
(declare-fun scheme () String)
(assert (= scheme (str.split_at url "://" 0)))

; Host extraction: e.g., example.com in "http://example.com/path"
(declare-fun host () String)
(assert (= host (str.split_at url "/" 2))) ; After splitting by '/', the host appears as the 3rd part

; Path extraction: everything after host as raw path
(declare-fun raw_path () String)
(assert (= raw_path (str.split_rest url "/" 2))) ; Segments after the host

; Split path further by '/'
(declare-fun first_path_segment () String)
(assert (= first_path_segment (str.split_at raw_path "/" 0)))

(declare-fun second_path_segment () String)
(assert (>= (str.num_splits raw_path "/") 2))
(assert (= second_path_segment (str.split_at raw_path "/" 1)))

; Enforce example property: scheme must be "https"
(assert (= scheme "https"))

; Example constraint: host must contain "example.com"
(assert (str.contains host "example.com"))

; Example constraint: first path segment must not be empty
(assert (not (= first_path_segment "")))

; --- End LLM Generated Constraints ---
""",
"""
; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare URL variable
(declare-fun url () String)

; Extract protocol (e.g., "ftp" in "ftp://files.server.com/downloads/file.txt")
(declare-fun protocol () String)
(assert (= protocol (str.split_at url "://" 0)))

; Extract authority section (host and optional port)
(declare-fun authority () String)
(assert (= authority (str.split_at url "/" 2))) ; After splitting at '/', host is at position 2

; Extract path segments after authority
(declare-fun full_path () String)
(assert (= full_path (str.split_rest url "/" 2)))

; Split authority by ":" to separate host and port (if present)
(declare-fun hostname () String)
(assert (= hostname (str.split_at authority ":" 0)))

(declare-fun port () String)
(assert (ite (>= (str.num_splits authority ":") 2)
             (= port (str.split_at authority ":" 1))
             (= port ""))) ; No port if no ":" present

; Extract first path segment (e.g., "downloads")
(declare-fun top_folder () String)
(assert (>= (str.num_splits full_path "/") 1))
(assert (= top_folder (str.split_at full_path "/" 0)))

; Example constraint: protocol must be "ftp"
(assert (= protocol "ftp"))

; Example constraint: hostname must end with ".com"
(assert (str.suffixof ".com" hostname))

; Example constraint: port must be "21" if present
(assert (or (= port "") (= port "21")))

; Example constraint: top folder must not be "private"
(assert (not (= top_folder "private")))

; --- End LLM Generated Constraints ---
"""],
            'phone number formats':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; A phone number variable: format examples include "123-456-7890", "123 456 7890", "(123) 456-7890"
(declare-fun phone_number () String)

; Check that phone_number uses "-" as delimiter and has exactly 3 parts
(assert (= (str.num_splits phone_number "-") 3))

; Extract the first, second, and third segments
(declare-fun area_code () String)
(declare-fun central_office_code () String)
(declare-fun line_number () String)

(assert (= area_code (str.split_at phone_number "-" 0)))
(assert (= central_office_code (str.split_at phone_number "-" 1)))
(assert (= line_number (str.split_at phone_number "-" 2)))

; Constraints on each segment
(assert (and (>= (str.len area_code) 3)
              (= (str.len area_code) 3)
              (str.in.re area_code (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")))))

(assert (and (>= (str.len central_office_code) 3)
              (= (str.len central_office_code) 3)
              (str.in.re central_office_code (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")))))

(assert (and (>= (str.len line_number) 4)
              (= (str.len line_number) 4)
              (str.in.re line_number (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9")))))

; Example: optionally verify no extra segments exist after third part
(assert (= (str.split_rest phone_number "-" 2) ""))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; A phone number variable: formats like "86-10-12345678" (country code - area code - local number)
(declare-fun phone_number () String)

; Ensure phone_number split by "-" has exactly 3 parts
(assert (= (str.num_splits phone_number "-") 3))

; Extract the segments
(declare-fun country_code () String)
(declare-fun area_code () String)
(declare-fun local_number () String)

(assert (= country_code (str.split_at phone_number "-" 0)))
(assert (= area_code (str.split_at phone_number "-" 1)))
(assert (= local_number (str.split_at phone_number "-" 2)))

; Country code: starts with "86"
(assert (= country_code "86"))

; Area code: at least 2 digits
(assert (and (>= (str.len area_code) 2)
              (str.in.re area_code (re.+ (re.range "0" "9")))))

; Local number: between 6 and 8 digits
(assert (and (>= (str.len local_number) 6)
              (<= (str.len local_number) 8)
              (str.in.re local_number (re.+ (re.range "0" "9")))))

; Ensure no remaining parts after third segment
(assert (= (str.split_rest phone_number "-" 2) ""))

; --- End LLM Generated Constraints ---
"""],
            'Key-value pairs':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the input string representing key-value pairs, e.g., "key1:value1;key2:value2;key3:value3"
(declare-fun kv_string () String)

; Example: Ensure the input contains at least two key-value pairs (i.e., at least two semicolons, leading to at least 3 parts)
(assert (>= (str.num_splits kv_string ";") 2))

; Extract the first key-value pair (before the first semicolon)
; Example constraint: first pair must start with key1:
(assert (str.prefixof "key1:" (str.split_at kv_string ";" 0)))

; Extract the second key-value pair (between first and second semicolon)
; Example constraint: second pair must contain key2 as the key
(assert (str.prefixof "key2:" (str.split_at kv_string ";" 1)))

; Extract rest of pairs after the second semicolon, ensure non-empty if exists
(assert (or 
    (= (str.num_splits kv_string ";") 2)
    (not (= (str.split_rest kv_string ";" 1) ""))))

; Additional example: enforce that the total number of key-value pairs does not exceed 5
(assert (<= (str.num_splits kv_string ";") 5))

; Example: verify that the third key (if present) is not "key0:"
(assert (or 
    (<= (str.num_splits kv_string ";") 2)
    (not (str.prefixof "key0:" (str.split_at kv_string ";" 2)))))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the input string: a sequence of key-value pairs like "id:123;name:John;age:30"
(declare-fun kv_pairs () String)

; Ensure there are at least 3 key-value pairs (i.e., at least two semicolons)
(assert (>= (str.num_splits kv_pairs ";") 3))

; Extract first key-value pair and ensure it starts with "id:"
(assert (str.prefixof "id:" (str.split_at kv_pairs ";" 0)))

; Extract second key-value pair and ensure it contains "name:"
(assert (str.contains (str.split_at kv_pairs ";" 1) "name:"))

; Extract third key-value pair and ensure it starts with "age:"
(assert (str.prefixof "age:" (str.split_at kv_pairs ";" 2)))

; Ensure that any remaining pairs after the third are optional but, if present, non-empty
(assert (or 
    (= (str.num_splits kv_pairs ";") 3)
    (not (= (str.split_rest kv_pairs ";" 2) ""))))

; Ensure that total key-value pairs do not exceed 6
(assert (<= (str.num_splits kv_pairs ";") 6))

; Example constraint: ensure no key called "password:" appears in the fourth position (if exists)
(assert (or 
    (<= (str.num_splits kv_pairs ";") 3)
    (not (str.prefixof "password:" (str.split_at kv_pairs ";" 3)))))

; --- End LLM Generated Constraints ---
"""],
            'INI files':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare input variable representing a line from INI file
(declare-fun line () String)

; Declare constants for known delimiters
(define-fun delim_equals () String "=")
(define-fun delim_bracket_open () String "[")
(define-fun delim_bracket_close () String "]")

; Example scenario: Parse a property line like "key=value"

; Ensure line contains exactly 2 parts when split by "="
(assert (= (str.num_splits line delim_equals) 2))

; Extract key and value parts
(define-fun key_part () String (str.split_at line delim_equals 0))
(define-fun value_part () String (str.split_at line delim_equals 1))

; Example constraints:
; Key must be non-empty
(assert (not (= key_part "")))

; Value must be non-empty
(assert (not (= value_part "")))

; Example of processing section header like "[SectionName]"

; If line starts with "[", handle as section header
(assert (=> (= (str.at line 0) "[")
    (and
        ; Ensure line ends with "]"
        (= (str.at line (- (str.len line) 1)) "]")

        ; Extract content inside brackets
        (let ((section_inner (str.substring line 1 (- (str.len line) 2))))
            ; Section name must be non-empty
            (not (= section_inner ""))
        )
    )
))

; Example use of str.split_rest: After extracting key and value, ensure no extra parts remain
; (Here used illustratively, though line only splits into two)
(assert (= (str.split_rest line delim_equals 1) ""))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare input variable representing an INI configuration line
(declare-fun ini_line () String)

; Define delimiter as "="
(define-fun eq_delim () String "=")

; Constraint 1: The line must contain exactly two parts when split by "="
(assert (= (str.num_splits ini_line eq_delim) 2))

; Extract key and value using str.split_at
(define-fun ini_key () String (str.split_at ini_line eq_delim 0))
(define-fun ini_value () String (str.split_at ini_line eq_delim 1))

; Constraint 2: Key must not be empty
(assert (not (= ini_key "")))

; Constraint 3: Value must not be empty
(assert (not (= ini_value "")))

; Constraint 4: Forbid spaces in key (illustrative constraint)
(assert (not (str.contains ini_key " ")))

; Example use of str.split_rest: Ensure no trailing parts after extracting value
(assert (= (str.split_rest ini_line eq_delim 1) ""))

; Additional example: Prefix condition (if needed)
; (assert (str.prefixof "config_" ini_key))

; --- End LLM Generated Constraints ---"""],
            'JSON-like structures':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Variables representing a JSON-like key-value string
(declare-const json_string String)

; Example: json_string = "key1:value1,key2:value2,key3:value3"

; Split json_string by comma to get individual key-value pairs
; Ensure there are exactly 3 pairs (can be adjusted as needed)
(assert (= (str.num_splits json_string ",") 3))

; Extract first key-value pair
(declare-const pair1 String)
(assert (= pair1 (str.split_at json_string "," 0)))

; Extract second key-value pair
(declare-const pair2 String)
(assert (= pair2 (str.split_at json_string "," 1)))

; Extract third key-value pair
(declare-const pair3 String)
(assert (= pair3 (str.split_at json_string "," 2)))

; Extract remaining (none in this example)
(declare-const remaining_pairs String)
(assert (= remaining_pairs (str.split_rest json_string "," 3)))

; From each key-value pair, split by colon to separate key and value
; First pair split
(declare-const key1 String)
(declare-const value1 String)
(assert (= (str.num_splits pair1 ":") 2))
(assert (= key1 (str.split_at pair1 ":" 0)))
(assert (= value1 (str.split_at pair1 ":" 1)))

; Second pair split
(declare-const key2 String)
(declare-const value2 String)
(assert (= (str.num_splits pair2 ":") 2))
(assert (= key2 (str.split_at pair2 ":" 0)))
(assert (= value2 (str.split_at pair2 ":" 1)))

; Third pair split
(declare-const key3 String)
(declare-const value3 String)
(assert (= (str.num_splits pair3 ":") 2))
(assert (= key3 (str.split_at pair3 ":" 0)))
(assert (= value3 (str.split_at pair3 ":" 1)))

; Example constraints: key1 must be equal to "user"
(assert (= key1 "user"))

; Example constraints: value2 must contain "id"
(assert (str.contains value2 "id"))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Variable representing a JSON-like array string
(declare-const json_array String)

; Example: json_array = "[item1,item2,item3]"

; Remove brackets (assume preprocessing or handle brackets separately if needed)
; For simplicity, assume json_array = "item1,item2,item3"

; Ensure there are exactly 3 items
(assert (= (str.num_splits json_array ",") 3))

; Extract first item
(declare-const item1 String)
(assert (= item1 (str.split_at json_array "," 0)))

; Extract second item
(declare-const item2 String)
(assert (= item2 (str.split_at json_array "," 1)))

; Extract third item
(declare-const item3 String)
(assert (= item3 (str.split_at json_array "," 2)))

; Collect all remaining items after the third (should be empty)
(declare-const remaining_items String)
(assert (= remaining_items (str.split_rest json_array "," 3)))

; Example constraint: item1 must be equal to "apple"
(assert (= item1 "apple"))

; Example constraint: item3 must not be empty
(assert (not (= item3 "")))

; Example constraint: item2 must start with "item"
(assert (str.prefixof "item" item2))

; --- End LLM Generated Constraints ---
"""],
            'Timestamp extraction':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Input string variable (a log entry)
(declare-fun log_entry () String)

; Declare variables for timestamp components
(declare-fun date_part () String)
(declare-fun time_part () String)
(declare-fun hour_part () String)
(declare-fun minute_part () String)
(declare-fun second_part () String)

; Example assumption: log_entry format is "YYYY-MM-DD HH:MM:SS - message"

; Split to extract the full timestamp (before the first " - ")
(assert (= date_part (str.split_at log_entry " " 0)))
(assert (= time_part (str.split_at log_entry " " 1)))

; Further split time_part by ":" to extract hour, minute, and second
(assert (= hour_part (str.split_at time_part ":" 0)))
(assert (= minute_part (str.split_at time_part ":" 1)))
(assert (= second_part (str.split_at time_part ":" 2)))

; Optional: Example constraints enforcing numeric-like formatting (simplified)
(assert (str.contains "0123456789" (str.at hour_part 0)))
(assert (str.contains "0123456789" (str.at minute_part 0)))
(assert (str.contains "0123456789" (str.at second_part 0)))

; Optional: Constraint that log_entry contains at least 2 parts split by space (date and time)
(assert (>= (str.num_splits log_entry " ") 2))

; Optional: Constraint that time_part contains exactly 3 parts split by ":"
(assert (= (str.num_splits time_part ":") 3))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the input log line
(declare-fun log_line () String)

; Declare variables for extracted timestamp fields
(declare-fun full_timestamp () String)
(declare-fun date_field () String)
(declare-fun time_field () String)
(declare-fun hour_field () String)
(declare-fun minute_field () String)
(declare-fun second_field () String)

; Example format: "2025-07-18T21:45:30Z|INFO|User logged in"

; Extract the full timestamp before the first "|"
(assert (= full_timestamp (str.split_at log_line "|" 0)))

; Split full_timestamp at "T" to get date and time components
(assert (= date_field (str.split_at full_timestamp "T" 0)))
(assert (= time_field (str.split_at full_timestamp "T" 1)))

; Further split time_field at ":" to extract hour, minute, and second
(assert (= hour_field (str.split_at time_field ":" 0)))
(assert (= minute_field (str.split_at time_field ":" 1)))

; Split_rest used to handle seconds and potential timezone suffix (like "30Z")
(assert (= second_field (str.split_rest time_field ":" 2)))

; Constraint: Ensure log_line contains at least 2 "|" splits
(assert (>= (str.num_splits log_line "|") 2))

; Constraint: time_field contains at least 3 parts when split by ":"
(assert (>= (str.num_splits time_field ":") 3))

; Optional: Ensure hour, minute, and second fields are non-empty
(assert (not (= hour_field "")))
(assert (not (= minute_field "")))
(assert (not (= second_field "")))

; --- End LLM Generated Constraints ---
"""],
            'log level parsing':["""
; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Log level parsing scenario:
; Example log string format: "<timestamp>:<log_level>:<message>"

; Declare log string
(declare-const log_entry String)

; Split log_entry by ":" and extract fields
; log_level is the second part after splitting
; timestamp is the first part
; message is everything after log_level

; Extract timestamp (first field)
(assert (= (str.split_at log_entry ":" 0) timestamp))

; Extract log_level (second field)
(declare-const log_level String)
(assert (= (str.split_at log_entry ":" 1) log_level))

; Extract message (all parts after log_level)
(declare-const message String)
(assert (= (str.split_rest log_entry ":" 1) message))

; Ensure log_entry contains exactly 3 parts after splitting
(assert (= (str.num_splits log_entry ":") 3))

; Example constraint: log_level must be either "INFO", "WARN", or "ERROR"
(assert (or
    (= log_level "INFO")
    (= log_level "WARN")
    (= log_level "ERROR")
))

; Example constraint: message is non-empty
(assert (> (str.len message) 0))

; --- End LLM Generated Constraints ---
""",
"""
; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Log level parsing scenario:
; Example log entry format: "[log_level] - [component] - [message]"

; Declare the log entry string
(declare-const log_entry String)

; Split by delimiter " - "
; Part 0: log_level (without brackets)
; Part 1: component
; Part 2 and beyond: message content

; Extract log_level (remove brackets manually if needed downstream)
(declare-const log_level_raw String)
(assert (= (str.split_at log_entry " - " 0) log_level_raw))

; Extract component
(declare-const component String)
(assert (= (str.split_at log_entry " - " 1) component))

; Extract message (all remaining segments)
(declare-const message String)
(assert (= (str.split_rest log_entry " - " 1) message))

; Ensure log entry contains at least 3 parts (log_level, component, message)
(assert (>= (str.num_splits log_entry " - ") 3))

; Example constraint: log_level_raw must contain "INFO", "DEBUG", or "ERROR"
(assert (or
    (= log_level_raw "[INFO]")
    (= log_level_raw "[DEBUG]")
    (= log_level_raw "[ERROR]")
))

; Example constraint: component string length at least 2 characters
(assert (>= (str.len component) 2))

; Example constraint: message is not empty
(assert (> (str.len message) 0))

; --- End LLM Generated Constraints ---
"""],
            'IP address validation':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the input string (the IP address)
(declare-const ip String)

; Each IP address must consist of 4 parts separated by "."
(assert (= (str.num_splits ip ".") 4))

; Declare variables for each segment after splitting
(declare-const seg0 String)
(declare-const seg1 String)
(declare-const seg2 String)
(declare-const seg3 String)

; Extract each segment using str.split_at
(assert (= seg0 (str.split_at ip "." 0)))
(assert (= seg1 (str.split_at ip "." 1)))
(assert (= seg2 (str.split_at ip "." 2)))
(assert (= seg3 (str.split_at ip "." 3)))

; Ensure that each segment is non-empty
(assert (not (= seg0 "")))
(assert (not (= seg1 "")))
(assert (not (= seg2 "")))
(assert (not (= seg3 "")))

; Optional: Ensure no extra parts after the 4th segment
; This follows from num_splits constraint

; Optional: Basic numeric format checks (simple digit constraints)
; You may replace with actual regex or numeric conversion if supported

; Example constraints: segments are at most 3 digits long
(assert (<= (str.len seg0) 3))
(assert (<= (str.len seg1) 3))
(assert (<= (str.len seg2) 3))
(assert (<= (str.len seg3) 3))

; You may further refine this to enforce actual numeric range [0,255]

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the input string representing the IP address
(declare-const ip String)

; Constraint: IP address must contain exactly 4 parts split by "."
(assert (= (str.num_splits ip ".") 4))

; Declare the four parts (segments)
(declare-const part0 String)
(declare-const part1 String)
(declare-const part2 String)
(declare-const part3 String)

; Split extraction using str.split_at
(assert (= part0 (str.split_at ip "." 0)))
(assert (= part1 (str.split_at ip "." 1)))
(assert (= part2 (str.split_at ip "." 2)))
(assert (= part3 (str.split_at ip "." 3)))

; Ensure each part is non-empty
(assert (not (= part0 "")))
(assert (not (= part1 "")))
(assert (not (= part2 "")))
(assert (not (= part3 "")))

; Optional numeric constraints: each segment length <= 3 (simplified form)
(assert (<= (str.len part0) 3))
(assert (<= (str.len part1) 3))
(assert (<= (str.len part2) 3))
(assert (<= (str.len part3) 3))

; Example rest constraint: after the third split, no additional parts should exist
(declare-const rest String)
(assert (= rest (str.split_rest ip "." 3)))
(assert (= rest ""))

; --- End LLM Generated Constraints ---
"""],
            'Field separation':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Scenario:
; Given a log entry formatted as "timestamp|level|module|message",
; extract and validate its fields using intelligent split constraints.

(declare-const log_entry String)
(declare-const timestamp String)
(declare-const level String)
(declare-const module String)
(declare-const message String)
(declare-const rest_of_log String)

; Extract fields using str.split_at
(assert (= (str.split_at log_entry "|" 0) timestamp))
(assert (= (str.split_at log_entry "|" 1) level))
(assert (= (str.split_at log_entry "|" 2) module))
(assert (= (str.split_at log_entry "|" 3) message))

; Validate that log_entry splits into exactly 4 parts
(assert (= (str.num_splits log_entry "|") 4))

; Field validations
(assert (not (= timestamp "")))  ; Timestamp should not be empty

(assert (or                      ; Level should be INFO, WARN, or ERROR
  (= level "INFO")
  (= level "WARN")
  (= level "ERROR")
))

(assert (not (= module "")))     ; Module name should not be empty
(assert (> (str.len message) 0)) ; Message must be non-empty

; Example of using split_rest to capture module and message together
(assert (= (str.split_rest log_entry "|" 1) rest_of_log))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Scenario:
; Given a product record formatted as "productID#category#price#stock#description",
; parse and validate each field using split constraints.

(declare-const product_record String)
(declare-const productID String)
(declare-const category String)
(declare-const price String)
(declare-const stock String)
(declare-const description String)
(declare-const remaining_fields String)

; Extract fields using str.split_at
(assert (= (str.split_at product_record "#" 0) productID))
(assert (= (str.split_at product_record "#" 1) category))
(assert (= (str.split_at product_record "#" 2) price))
(assert (= (str.split_at product_record "#" 3) stock))
(assert (= (str.split_at product_record "#" 4) description))

; Ensure there are exactly 5 fields
(assert (= (str.num_splits product_record "#") 5))

; Field validations
(assert (not (= productID "")))                      ; Product ID must be non-empty
(assert (> (str.len category) 1))                     ; Category must have at least 2 characters
(assert (str.in_re price (re.+ (re.range "0" "9"))))  ; Price must be numeric
(assert (str.in_re stock (re.+ (re.range "0" "9"))))  ; Stock must be numeric
(assert (> (str.len description) 0))                  ; Description must be non-empty

; Use split_rest to extract description and any following parts (should be empty after description)
(assert (= (str.split_rest product_record "#" 4) remaining_fields))

; --- End LLM Generated Constraints ---
"""],
            'escape characters':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare string variables
(declare-fun input_str () String)
(declare-fun delim () String)

; Declare extracted parts
(declare-fun part0 () String)
(declare-fun part1 () String)
(declare-fun escaped_char () String)
(declare-fun remaining_parts () String)

; Example: The input_str represents a pattern where escape characters are encoded using backslash "\" as delimiter,
; and the first segment is the command, the second segment is the escaped character, 
; the rest represents arguments.

; Assume delimiter is backslash
(assert (= delim "\\"))

; Extract first part (command)
(assert (= part0 (str.split_at input_str delim 0)))

; Extract second part (escaped character)
(assert (= part1 (str.split_at input_str delim 1)))

; Treat second part as the escaped character
(assert (= escaped_char part1))

; Extract remaining parts after the escaped character
(assert (= remaining_parts (str.split_rest input_str delim 1)))

; Example constraints: input must contain at least 2 parts (command and escaped character)
(assert (>= (str.num_splits input_str delim) 2))

; Example constraint: escaped_char must be either "n" (newline) or "t" (tab)
(assert (or (= escaped_char "n") (= escaped_char "t")))

; Example constraint: command should not be empty
(assert (not (= part0 "")))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare variables
(declare-fun input_str () String)
(declare-fun delim () String)
(declare-fun prefix () String)
(declare-fun escape_seq () String)
(declare-fun suffix () String)
(declare-fun parts_after_escape () String)

; Delimiter is assumed to be backslash
(assert (= delim "\\"))

; Split: extract prefix (first segment before first backslash)
(assert (= prefix (str.split_at input_str delim 0)))

; Split: extract escape sequence (second segment after first backslash)
(assert (= escape_seq (str.split_at input_str delim 1)))

; Split: get all remaining parts after the escape sequence
(assert (= parts_after_escape (str.split_rest input_str delim 1)))

; Example constraint: total number of splits must be at least 2
(assert (>= (str.num_splits input_str delim) 2))

; Example constraint: escape sequence should be one of double-quote or backslash itself
(assert (or (= escape_seq "\") (= escape_seq "\\")))

; Example constraint: prefix must not end with a backslash (prevent accidental escapes)
(assert (not (str.suffixof "\\" prefix)))

; Optional: suffix must not be empty (ensure something exists after escape sequence)
(assert (not (= parts_after_escape "")))

; --- End LLM Generated Constraints ---
"""],
            'JWT parsing':["""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the JWT token as a string variable
(declare-fun jwt () String)

; Declare parts of the JWT
(declare-fun header () String)
(declare-fun payload () String)
(declare-fun signature () String)

; Ensure the JWT splits correctly using '.' as the delimiter
(assert (= header (str.split_at jwt "." 0)))
(assert (= payload (str.split_at jwt "." 1)))
(assert (= signature (str.split_at jwt "." 2)))

; Ensure the JWT has exactly 3 parts
(assert (= (str.num_splits jwt ".") 3))

; Example constraint: header must be non-empty
(assert (not (= header "")))

; Example constraint: payload must contain "sub"
(declare-fun sub_present () Bool)
(assert (= sub_present (str.contains payload "sub")))
(assert sub_present)

; Example constraint: signature must be non-empty
(assert (not (= signature "")))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare JWT token variable
(declare-fun jwt_token () String)

; Declare components of the JWT
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Split jwt_token by '.' into 3 parts
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; Ensure jwt_token has exactly 3 segments
(assert (= (str.num_splits jwt_token ".") 3))

; Example constraint: header starts with '{'
(assert (str.prefixof "{" jwt_header))

; Example constraint: payload contains "exp"
(declare-fun contains_exp () Bool)
(assert (= contains_exp (str.contains jwt_payload "exp")))
(assert contains_exp)

; Example constraint: signature is at least 16 characters long
(assert (<= 16 (str.len jwt_signature)))

; --- End LLM Generated Constraints ---"""],
            'API key validation':["""smt
; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the API key as a string variable
(declare-const api_key String)

; Basic format:
; API key format: PREFIX-USERID-SECRET
; Example: ABC-12345-XYZ987

; Split constraints:
; (str.split_at api_key "-" 0) should be equal to "ABC"
(assert (= (str.split_at api_key "-" 0) "ABC"))

; Ensure that after splitting, there are exactly 3 parts
(assert (= (str.num_splits api_key "-") 3))

; Extract USERID (should be a numeric sequence of length >= 3)
(declare-const userid String)
(assert (= userid (str.split_at api_key "-" 1)))
; UserID length constraint: at least 3 characters
(assert (>= (str.len userid) 3))

; Extract SECRET part
(declare-const secret String)
(assert (= secret (str.split_at api_key "-" 2)))
; SECRET should not be empty
(assert (> (str.len secret) 0))

; Example of using split_rest for future extension (not strictly necessary here):
; Optionally ensure no extra parts beyond SECRET
; (str.split_rest api_key "-" 2) should be empty
(assert (= (str.split_rest api_key "-" 2) ""))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare API key variable
(declare-const api_key String)

; Example API key format: KEY-REGION-IDENTIFIER-CHECKSUM
; Example: X9A-NA-87452-5F7D

; Ensure API key splits into exactly 4 parts
(assert (= (str.num_splits api_key "-") 4))

; Split 0: KEY part, should be prefix "X9A"
(assert (= (str.split_at api_key "-" 0) "X9A"))

; Split 1: REGION code (e.g., "NA", "EU", "AP")
(declare-const region String)
(assert (= region (str.split_at api_key "-" 1)))
; REGION length must be exactly 2 characters
(assert (= (str.len region) 2))

; Split 2: IDENTIFIER, a numeric string
(declare-const identifier String)
(assert (= identifier (str.split_at api_key "-" 2)))
; IDENTIFIER length must be at least 4 characters
(assert (>= (str.len identifier) 4))

; Split 3: CHECKSUM, a non-empty string
(declare-const checksum String)
(assert (= checksum (str.split_at api_key "-" 3)))
(assert (> (str.len checksum) 0))

; Optional: Ensure nothing remains after split 3
(assert (= (str.split_rest api_key "-" 3) ""))

; --- End LLM Generated Constraints ---
"""],
            'session tokens':["""
; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the session token variable
(declare-fun token () String)

; Example token format: "userID-sessionID-timestamp-signature"

; Declare each part after splitting the token by "-"
(declare-fun userID () String)
(declare-fun sessionID () String)
(declare-fun timestamp () String)
(declare-fun signature () String)

; Ensure the token splits into exactly 4 parts
(assert (= (str.num_splits token "-") 4))

; Extract and bind each part using str.split_at
(assert (= userID     (str.split_at token "-" 0)))
(assert (= sessionID  (str.split_at token "-" 1)))
(assert (= timestamp  (str.split_at token "-" 2)))
(assert (= signature  (str.split_at token "-" 3)))

; Example semantic constraints:
; UserID must not be empty
(assert (not (= userID "")))

; SessionID must be numeric (simplified check)
(assert (str.in_re sessionID (re.+ (re.range "0" "9"))))

; Timestamp must be numeric and of length at least 10
(assert (str.in_re timestamp (re.+ (re.range "0" "9"))))
(assert (>= (str.len timestamp) 10))

; Signature must be a non-empty string
(assert (not (= signature "")))

; Optionally, assert that all remaining parts after the third split are empty (since only 4 parts exist)
(assert (= (str.split_rest token "-" 3) ""))

; --- End LLM Generated Constraints ---
""",
"""; --- LLM Generated Split Constraints ---
(set-logic QF_S)

; Declare the session token variable
(declare-fun token () String)

; Example token format: "appID:userID:timestamp:hash"

; Declare parts after splitting token by ":"
(declare-fun appID () String)
(declare-fun userID () String)
(declare-fun timestamp () String)
(declare-fun hash () String)

; Ensure token splits into exactly 4 parts
(assert (= (str.num_splits token ":") 4))

; Bind each part using str.split_at
(assert (= appID     (str.split_at token ":" 0)))
(assert (= userID    (str.split_at token ":" 1)))
(assert (= timestamp (str.split_at token ":" 2)))
(assert (= hash      (str.split_at token ":" 3)))

; Semantic constraints:
; appID must be exactly "APP01"
(assert (= appID "APP01"))

; userID must not contain the substring "admin"
(assert (not (str.contains userID "admin")))

; timestamp should be numeric and of fixed length 14 (e.g., YYYYMMDDHHMMSS)
(assert (str.in_re timestamp (re.+ (re.range "0" "9"))))
(assert (= (str.len timestamp) 14))

; hash must not be empty and must have at least length 32
(assert (not (= hash "")))
(assert (>= (str.len hash) 32))

; Verify that no remaining parts exist after extracting four
(assert (= (str.split_rest token ":" 3) ""))

; --- End LLM Generated Constraints ---
"""]
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
            for i in range(len(self.rws_examples[task])):
                example = self.rws_examples[task][i]
                messages.extend([
                    {"role": "user", "content": f"example {i}:"},
                    {"role": "assistant", "content": example}
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