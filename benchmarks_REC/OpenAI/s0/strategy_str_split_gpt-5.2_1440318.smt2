(set-logic ALL)

; Uninterpreted split interface
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

; ---------- SAT instance: well-formed log line ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const rest1_sat String)
(declare-const level_sat String)
(declare-const module_sat String)
(declare-const message_sat String)
(declare-const yyyy_sat String)
(declare-const mm_sat String)
(declare-const dd_sat String)
(declare-const hh_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL module: message..."
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= rest1_sat (split_rest log_line_sat " " 1)))
(assert (= level_sat (split_at rest1_sat " " 0)))
(assert (= module_sat (split_at rest1_sat " " 1)))
(assert (= message_sat (split_rest rest1_sat " " 2)))

; Ensure enough fields
(assert (>= (num_splits log_line_sat " ") 4))
(assert (>= (num_splits rest1_sat " ") 3))

; Timestamp token is "YYYY-MM-DD" and "HH:MM:SS" joined by 'T' to validate via regex
(assert (= (str.len ts_sat) 19))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) " "))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))

(assert (= yyyy_sat (str.substr ts_sat 0 4)))
(assert (= mm_sat   (str.substr ts_sat 5 2)))
(assert (= dd_sat   (str.substr ts_sat 8 2)))
(assert (= hh_sat   (str.substr ts_sat 11 2)))
(assert (= min_sat  (str.substr ts_sat 14 2)))
(assert (= sec_sat  (str.substr ts_sat 17 2)))

; Regex digit helper
(define-fun is2d ((s String)) Bool (str.in_re s (re.++ (re.range "0" "9") (re.range "0" "9"))))
(define-fun is4d ((s String)) Bool
  (str.in_re s (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))

(assert (is4d yyyy_sat))
(assert (is2d mm_sat))
(assert (is2d dd_sat))
(assert (is2d hh_sat))
(assert (is2d min_sat))
(assert (is2d sec_sat))

; Constrain log level extraction
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Module token must contain a colon and be of form "name:" with no spaces
(assert (str.contains module_sat ":"))
(assert (= (split_at module_sat ":" 1) ""))
(assert (>= (str.len (split_at module_sat ":" 0)) 1))

; Message exists and does not start with a space
(assert (>= (str.len message_sat) 1))
(assert (not (= (str.at message_sat 0) " ")))

; Provide a concrete satisfying example
(assert (= log_line_sat "2025-12-31 23:59:58 INFO auth: user login ok"))


; ---------- UNSAT instance: contradictory timestamp/level constraints ----------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const rest1_unsat String)
(declare-const level_unsat String)
(declare-const module_unsat String)
(declare-const message_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= rest1_unsat (split_rest log_line_unsat " " 1)))
(assert (= level_unsat (split_at rest1_unsat " " 0)))
(assert (= module_unsat (split_at rest1_unsat " " 1)))
(assert (= message_unsat (split_rest rest1_unsat " " 2)))

(assert (>= (num_splits log_line_unsat " ") 4))

; Force an invalid timestamp length but simultaneously require 19
(assert (= (str.len ts_unsat) 19))
(assert (= ts_unsat "2025-12-31"))

; Contradictory level constraints
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Also enforce module format
(assert (str.contains module_unsat ":"))
(assert (= (split_at module_unsat ":" 1) ""))
(assert (>= (str.len message_unsat) 0))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
