(set-logic ALL)

; Uninterpreted split interface
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

; Seed-preserved core
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_103698 String)
(assert (= T_1 (= "rAdAdKXaYb" var_0xINPUT_103698)))
(assert T_1)

; Log Analysis scenario: parsing structured server log entries
(declare-const log_line String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const yyyy String)
(declare-const mon String)
(declare-const dd String)
(declare-const payload String)

; Space-separated layout: "<timestamp> <level>:<message>"
(assert (= ts (split_at log_line " " 0)))
(assert (= payload (split_at log_line " " 1)))
(assert (= message (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 2))

; Level/message split on colon within payload
(assert (= level (split_at payload ":" 0)))
(assert (= message (split_rest payload ":" 1)))
(assert (>= (num_splits payload ":") 2))

; Timestamp split: "YYYY-MM-DDTHH:MM:SS"
(assert (= ts_date (split_at ts "T" 0)))
(assert (= ts_time (split_at ts "T" 1)))
(assert (= "" (split_rest ts "T" 2)))
(assert (= (num_splits ts "T") 2))

; Date split: "YYYY-MM-DD"
(assert (= yyyy (split_at ts_date "-" 0)))
(assert (= mon (split_at ts_date "-" 1)))
(assert (= dd (split_at ts_date "-" 2)))
(assert (= "" (split_rest ts_date "-" 3)))
(assert (= (num_splits ts_date "-") 3))

; Time split: "HH:MM:SS"
(assert (= hh (split_at ts_time ":" 0)))
(assert (= mm (split_at ts_time ":" 1)))
(assert (= ss (split_at ts_time ":" 2)))
(assert (= "" (split_rest ts_time ":" 3)))
(assert (= (num_splits ts_time ":") 3))

; Timestamp format validation via regexes
(assert (str.in_re yyyy (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re dd (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction constraints
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message sanity checks
(assert (>= (str.len message) 1))
(assert (str.contains message "request"))

; Tie the scenario to the seed input by embedding it in the log line
(assert (str.contains log_line var_0xINPUT_103698))

; Concrete shape example to make the instance satisfiable
(assert (= log_line (str.++ ts (str.++ " " (str.++ level (str.++ ":" (str.++ message "")))))))
(assert (= ts "2025-01-09T12:34:56"))
(assert (= level "INFO"))
(assert (= message (str.++ "request id=" var_0xINPUT_103698)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
