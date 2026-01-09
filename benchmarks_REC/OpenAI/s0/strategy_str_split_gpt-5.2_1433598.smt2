(set-logic ALL)

; Uninterpreted interface for string splitting
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

; ----------------------------
; SAT instance: well-formed log line
; Format (space-separated): "YYYY-MM-DDTHH:MM:SSZ LEVEL module:message"
; Example: "2026-01-09T13:45:07Z INFO auth:login ok"
; ----------------------------
(declare-const log_line_ok String)
(declare-const ts_ok String)
(declare-const level_ok String)
(declare-const modmsg_ok String)
(declare-const module_ok String)
(declare-const message_ok String)

; Basic split by spaces
(assert (>= (num_splits log_line_ok " ") 3))
(assert (= ts_ok (split_at log_line_ok " " 0)))
(assert (= level_ok (split_at log_line_ok " " 1)))
(assert (= modmsg_ok (split_rest log_line_ok " " 2)))

; Level extraction constraints
(assert (or (= level_ok "INFO") (= level_ok "WARN") (= level_ok "ERROR") (= level_ok "DEBUG")))

; modmsg_ok must contain a colon separating module and message
(assert (>= (num_splits modmsg_ok ":") 2))
(assert (= module_ok (split_at modmsg_ok ":" 0)))
(assert (= message_ok (split_rest modmsg_ok ":" 1)))

; Timestamp format validation via regex: YYYY-MM-DDTHH:MM:SSZ
(declare-const re_digit RegLan)
(declare-const re_2d RegLan)
(declare-const re_4d RegLan)
(declare-const re_ts RegLan)
(assert (= re_digit (re.range "0" "9")))
(assert (= re_2d (re.++ re_digit re_digit)))
(assert (= re_4d (re.++ re_2d re_2d)))
(assert (= re_ts
  (re.++
    re_4d (str.to_re "-") re_2d (str.to_re "-") re_2d
    (str.to_re "T")
    re_2d (str.to_re ":") re_2d (str.to_re ":") re_2d
    (str.to_re "Z"))))
(assert (str.in_re ts_ok re_ts))

; Some additional plausibility constraints
(assert (>= (str.len module_ok) 1))
(assert (>= (str.len message_ok) 1))
(assert (not (str.contains module_ok " ")))

; Provide a concrete witness to keep SAT straightforward
(assert (= log_line_ok "2026-01-09T13:45:07Z INFO auth:login ok"))

(check-sat)

; ----------------------------
; UNSAT instance: contradictory timestamp and level requirements
; ----------------------------
(declare-const log_line_bad String)
(declare-const ts_bad String)
(declare-const level_bad String)

(assert (>= (num_splits log_line_bad " ") 2))
(assert (= ts_bad (split_at log_line_bad " " 0)))
(assert (= level_bad (split_at log_line_bad " " 1)))

; Require valid timestamp regex...
(assert (str.in_re ts_bad re_ts))

; ...but also require an impossible timestamp length
(assert (not (= (str.len ts_bad) 20)))

; Level must be INFO, but also must not be INFO
(assert (= level_bad "INFO"))
(assert (not (= level_bad "INFO")))

; Concrete string (still unsat due to contradictions above)
(assert (= log_line_bad "2026-01-09T13:45:07Z INFO x:y"))

(check-sat)
(exit)
