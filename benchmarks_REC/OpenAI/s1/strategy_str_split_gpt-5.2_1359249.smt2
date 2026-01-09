(set-logic ALL)

; === Uninterpreted interface for str_split ===
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

; === Core input and derived CSV fields ===
(declare-const X String)
(declare-const csv String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)

; === Mutated seed-style regex constraints kept as "noise" structure ===
(assert (not (str.in_re X
  (re.++
    (re.union (str.to_re "<") (str.to_re ">") (str.to_re "&") (str.to_re "~") (str.to_re "^") (str.to_re "%")
              (re.range "A" "Z") (re.range "a" "z") (str.to_re "\\") (str.to_re " ")
              (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))
    ((_ re.loop 1 25)
      (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re "%") (str.to_re "^") (str.to_re "\\") (str.to_re "<") (str.to_re ">")))
    (str.to_re "\u{a}")))))
(assert (not (str.in_re X (str.to_re "ProjectMyWebSearchSearchAssistantfast-look.comOneReporter\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".f4v/i\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.range "0" "9")) (str.to_re "Host:") (re.* re.allchar) (str.to_re "communitytipHost:GirafaClient\u{13}\u{a}"))))

; === Scenario: CSV Processing ===
; X is the raw CSV record (reuse X as csv input)
(assert (= csv X))

; Require exactly 4 fields separated by commas => num_splits = 4
(assert (= (num_splits csv ",") 4))

; Bind each field via split_at
(assert (= f0 (split_at csv "," 0)))
(assert (= f1 (split_at csv "," 1)))
(assert (= f2 (split_at csv "," 2)))
(assert (= f3 (split_at csv "," 3)))

; Structural relation with split_rest
(assert (= (split_rest csv "," 0) csv))
(assert (= (split_rest csv "," 1) (str.++ f1 "," f2 "," f3)))
(assert (= (split_rest csv "," 2) (str.++ f2 "," f3)))
(assert (= (split_rest csv "," 3) f3))

; Detect empty fields: enforce at least one empty field exists
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Also enforce field-count sanity via comma counting: if 4 fields then at least 3 commas
(assert (>= (str.len csv) 3))
(assert (str.contains csv ","))

; Disallow newlines in CSV record
(assert (not (str.contains csv "\n")))
(assert (not (str.contains csv "\r")))

; Some content constraints typical for CSV processing
; f0 is an integer ID (digits only, non-empty)
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))

; f1 is a name: letters and spaces only (may be empty in this instance)
(assert (str.in_re f1 (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re " ")))))

; f2 is an amount like 12 or 12.34 (may be empty in this instance)
(declare-const dot String)
(assert (= dot "."))
(assert (or (= f2 "")
            (str.in_re f2 (re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (str.to_re ".") ((_ re.loop 2 2) (re.range "0" "9"))))))))

; f3 is a status token (must be one of OK/ERR/NA; may be empty in this instance)
(assert (or (= f3 "") (= f3 "OK") (= f3 "ERR") (= f3 "NA")))

; === UNSAT slice: force contradiction about emptiness ===
; Require no empty fields, while previously requiring at least one empty field.
(assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
