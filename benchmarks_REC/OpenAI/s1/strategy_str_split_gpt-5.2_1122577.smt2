(set-logic ALL)

; Uninterpreted interface operations for str_split
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
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

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

; Seed structure preserved and extended for log analysis
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_193661 String)

; Additional boolean guards
(declare-fun T_ts_ok () Bool)
(declare-fun T_level_ok () Bool)
(declare-fun T_structure_ok () Bool)

; Log-field variables
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Maintain original core: input is not empty
(assert (= T_1 (= var_0xINPUT_193661 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; Basic structure: "<ts> <level> <msg...>" (split by single space)
(assert (= ts (split_at var_0xINPUT_193661 " " 0)))
(assert (= level (split_at var_0xINPUT_193661 " " 1)))
(assert (= msg (split_rest var_0xINPUT_193661 " " 2)))
(assert (>= (num_splits var_0xINPUT_193661 " ") 3))

; Timestamp sub-structure: "YYYY-MM-DDTHH:MM:SS" (split at 'T')
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))
(assert (>= (num_splits ts "T") 2))

; Time sub-structure: "HH:MM:SS" (split at ':')
(assert (= hour (split_at time ":" 0)))
(assert (= minute (split_at time ":" 1)))
(assert (= second (split_at time ":" 2)))
(assert (= (num_splits time ":") 3))

; Timestamp format validation via regex: YYYY-MM-DDTHH:MM:SS
(assert (= T_ts_ok (str.in_re ts (re.++ (re.loop (re.range "0" "9") 4 4)
                                         (str.to_re "-")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re "-")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re "T")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re ":")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re ":")
                                         (re.loop (re.range "0" "9") 2 2)))))

; Log level extraction/validation
(assert (= T_level_ok (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))))

; Message must be non-empty and not contain newline
(assert (>= (str.len msg) 1))
(assert (not (str.contains msg "\n")))

; Combined structural check boolean
(assert (= T_structure_ok (and T_ts_ok T_level_ok)))
(assert T_structure_ok)

; Additional consistency checks on subfields lengths
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; UNSAT trigger: contradict the validated timestamp by forcing it to contain a space
; This preserves the scenario but makes the instance UNSAT deliberately.
(assert (str.contains ts " "))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
