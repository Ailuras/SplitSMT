(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

; CSV Processing scenario: comma-separated fields, field counts, and empty-field detection

; Uninterpreted split interface

; Seed-style boolean tracking
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)

; Input CSV line
(declare-fun var_0xINPUT_35287 () String)

; Additional derived variables
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const n Int)
(declare-const i Int)

(assert (= delim ","))

; Preserve core structure: input is not "-" and not empty
(assert (= T_1 (= "-" var_0xINPUT_35287)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_35287)))
(assert (= T_4 (not T_3)))
(assert T_4)

; CSV-specific constraints: at least 3 fields (2 commas) and no trailing comma
(assert (= n (num_splits var_0xINPUT_35287 delim)))
(assert (>= n 3))
(assert (not (str.suffixof delim var_0xINPUT_35287)))

; Bind fields via split interface
(assert (= f0 (split_at var_0xINPUT_35287 delim 0)))
(assert (= f1 (split_at var_0xINPUT_35287 delim 1)))
(assert (= f2 (split_at var_0xINPUT_35287 delim 2)))
(assert (= rest1 (split_rest var_0xINPUT_35287 delim 1)))
(assert (= rest2 (split_rest var_0xINPUT_35287 delim 2)))

; Index discipline for split_at/split_rest calls
(assert (>= i 0))
(assert (< i n))

; Detect empty fields (presence of ,,) and disallow it (SAT side)
(assert (= T_5 (str.contains var_0xINPUT_35287 ",,")))
(assert (= T_6 (not T_5)))
(assert T_6)

; Require each of first three fields non-empty and not just whitespace
(assert (not (= f0 "")))
(assert (not (= f1 "")))
(assert (not (= f2 "")))
(assert (not (= f0 " ")))
(assert (not (= f1 " ")))
(assert (not (= f2 " ")))

; Ensure rest concatenations are consistent with having delimiters
(assert (str.contains rest1 delim))
(assert (or (= n 3) (str.contains rest2 delim)))

; A small structured format: first field must be alphabetic prefix, second numeric-like, third arbitrary non-empty
(assert (str.in_re f0 (re.++ (re.+ (re.range "A" "Z")) (re.* (re.range "a" "z")))))
(assert (str.in_re f1 (re.+ (re.range "0" "9"))))

; Add an UNSAT branch condition guarded by a boolean, to diversify but keep overall satisfiable
; Force T_7 true, but make it consistent (do not contradict the SAT constraints)
(assert (= T_7 (<= (str.len var_0xINPUT_35287) 200)))
(assert T_7)

; Another boolean derived check: ensure the CSV line actually contains a comma
(assert (= T_8 (str.contains var_0xINPUT_35287 delim)))
(assert T_8)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
