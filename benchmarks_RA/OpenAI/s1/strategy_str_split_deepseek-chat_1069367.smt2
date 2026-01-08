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

; Uninterpreted interface for string split operations

; Seed-style string building blocks retained (mutated to log paths/messages)
(declare-fun sigmaStar_5 () String)
(declare-fun sigmaStar_6 () String)
(declare-fun sigmaStar_7 () String)
(declare-fun literal_8 () String)
(declare-fun x_11 () String)
(declare-fun literal_9 () String)
(declare-fun x_12 () String)
(declare-fun literal_10 () String)
(declare-fun x_13 () String)
(declare-fun x_16 () String)
(declare-fun literal_1 () String)

; New variables for log analysis scenario
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const pid String)
(declare-const component String)
(declare-const msg String)
(declare-const datePart String)
(declare-const timePart String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const ms String)
(declare-const levelPrefix String)
(declare-const unusedRest String)

; Mutate literals to resemble log tokens / message tails
(assert (= literal_8 "ERROR"))
(assert (= x_11 (str.++ sigmaStar_5 literal_8)))
(assert (= literal_9 "WARN"))
(assert (= x_12 (str.++ sigmaStar_6 literal_9)))
(assert (= literal_10 "INFO"))
(assert (= x_13 (str.++ sigmaStar_7 literal_10)))
(assert (= literal_1 "DEBUG"))

; Choose extracted level among common levels (core structure preserved via x_16)
(assert (or (= x_16 x_11) (= x_16 literal_1) (= x_16 x_13) (= x_16 x_12)))

; Split log line by spaces: "<ts> <level>: <pid> <component>: <msg>"
(assert (>= (num_splits logline " ") 5))
(assert (= ts (split_at logline " " 0)))
(assert (= levelPrefix (split_at logline " " 1)))
(assert (= pid (split_at logline " " 2)))
(assert (= component (split_at logline " " 3)))
(assert (= msg (split_rest logline " " 4)))

; Extract level token before ':'
(assert (>= (num_splits levelPrefix ":") 2))
(assert (= level (split_at levelPrefix ":" 0)))
(assert (= x_16 level))

; Component must end with ':' in the original token (e.g., "auth:")
(assert (str.in_re component (re.++ (re.* re.allchar) (str.to_re ":"))))

; Timestamp validation: enforce ISO-like "YYYY-MM-DDTHH:MM:SS.mmmZ"
(assert (>= (num_splits ts "T") 2))
(assert (= datePart (split_at ts "T" 0)))
(assert (= timePart (split_at ts "T" 1)))

; Date pattern YYYY-MM-DD
(assert (str.in_re datePart
  (re.++
    (re.++
      (re.++
        (re.++ (re.loop (re.range "0" "9") 4 4) (str.to_re "-"))
        (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re "-")))
      (re.loop (re.range "0" "9") 2 2))
    (re.* (str.to_re "")))))

; Time part split on ':' -> HH, MM, and "SS.mmmZ"
(assert (>= (num_splits timePart ":") 3))
(assert (= hour (split_at timePart ":" 0)))
(assert (= minute (split_at timePart ":" 1)))
(assert (= second (split_at timePart ":" 2)))

; Hour and minute are 2 digits
(assert (str.in_re hour (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re minute (re.loop (re.range "0" "9") 2 2)))

; Seconds token must be "SS.mmmZ" with SS 2 digits, mmm 3 digits, Z literal
(assert (>= (num_splits second ".") 2))
(assert (= ms (split_at second "." 1)))
(assert (= unusedRest (split_at second "." 0)))
(assert (str.in_re unusedRest (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re ms (re.++ (re.loop (re.range "0" "9") 3 3) (str.to_re "Z"))))

; PID must be digits
(assert (str.in_re pid (re.+ (re.range "0" "9"))))

; Message should contain either "timeout" or "login" (simple content check)
(assert (or (str.contains msg "timeout") (str.contains msg "login")))

; Security check: message must not contain "evil" (UNSAT if combined with next assertion)
(assert (not (str.contains msg "evil")))

; Keep seed's regex-style check but adapt to log message content to create tension
(assert (str.in_re msg (re.++ (re.* re.allchar) (re.++ (str.to_re "evil") (re.* re.allchar)))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
