; Log Analysis scenario: structured server log entries separated by spaces and colons
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

; Keep core seed structure / names
(declare-fun T_SELECT_1 () Bool)
(declare-fun I0_2 () Int)
(declare-fun I0_8 () Int)
(declare-fun I1_8 () Int)
(declare-fun I2_8 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T_4 () Int)
(declare-fun T0_2 () String)
(declare-fun T1_2 () String)
(declare-fun T2_2 () String)
(declare-fun T3_2 () String)
(declare-fun T4_2 () String)
(declare-fun T5_2 () String)
(declare-fun var_0xINPUT_311 () String)

; Additional variables for log analysis
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const date String)
(declare-const time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Seed concatenation skeleton preserved
(assert (= var_0xINPUT_311 (str.++ T0_2 T1_2)))
(assert (= T1_2 (str.++ T2_2 T3_2)))
(assert (= T2_2 (str.++ T4_2 T5_2)))

; Mutated: use ":" rather than "?" to match colon-separated structured logs
; Enforce T4_2 is not exactly ":" and T5_2 is ":"
(assert (not (str.in_re T4_2 (str.to_re ":"))))
(assert (= T5_2 ":"))

; Preserve integer structure but connect lengths to log parts
(assert (>= I2_8 T_4))
(assert (= I2_8 I1_8))
(assert (<= I2_8 I1_8))
(assert (= I0_8 (- I2_8 T_4)))
(assert (>= T_4 0))
(assert (= T_4 (+ PCTEMP_LHS_1 1)))
(assert (= PCTEMP_LHS_1 (+ I0_2 0)))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))

; Keep zero-length prefix constraint
(assert (= 0 (str.len T0_2)))

; Logline tied to the seed input
(assert (= logline var_0xINPUT_311))

; Split by spaces into at least 4 segments: timestamp, level, component:, message...
(assert (>= (num_splits logline " ") 4))
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= component (split_at logline " " 2)))
(assert (= message (split_rest logline " " 3)))

; Component must end with ':' (common "module:" style)
(assert (str.suffixof ":" component))
(assert (> (str.len component) 1))

; Level extraction/validation (allow common levels)
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS (length 19)
(assert (= (str.len ts) 19))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))

; Split timestamp into date and time
(assert (>= (num_splits ts "T") 2))
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))
(assert (= (str.len date) 10))
(assert (= (str.len time) 8))

; Split time into hh:mm:ss and enforce numeric ranges via Int conversion
(assert (>= (num_splits time ":") 3))
(assert (= hh (split_at time ":" 0)))
(assert (= mm (split_at time ":" 1)))
(assert (= ss (split_at time ":" 2)))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

(declare-const hh_i Int)
(declare-const mm_i Int)
(declare-const ss_i Int)
(assert (= hh_i (str.to_int hh)))
(assert (= mm_i (str.to_int mm)))
(assert (= ss_i (str.to_int ss)))
(assert (and (<= 0 hh_i) (<= hh_i 23)))
(assert (and (<= 0 mm_i) (<= mm_i 59)))
(assert (and (<= 0 ss_i) (<= ss_i 59)))

; Connect seed length variable to a meaningful piece: the prefix before ':' in component
; component is something like "auth:" so stripping last char gives a non-empty name
(assert (= I0_2 (str.len T4_2)))
(assert (= T4_2 (str.substr component 0 (- (str.len component) 1))))
(assert (> I0_2 0))

; SAT branch: keep T_SELECT_1 enabled
(assert T_SELECT_1)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
