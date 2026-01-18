(set-logic ALL)
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

; Scenario: CSV Processing
; Goal: reason about comma-separated fields, field counts, and empty fields.

; Uninterpreted interface operations (as required)

; Core inputs
(declare-const X String)
(declare-const csv String)
(declare-const delim String)

; Derived fields
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)

; Basic setup
(assert (= delim ","))
(assert (= csv X))

; Preserve mutated core structure: keep the original negative regex checks on X
(assert (not (str.in_re X (re.++ (str.to_re "wowokay") (re.+ (re.range "0" "9")) (str.to_re "FTP") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:Filtered\u{22}reaction.txt\u{22}\u{a}")))))
(assert (not (str.in_re X (str.to_re "clvompycem/cen.vcnHost:User-Agent:\u{d}\u{a}\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".jfif/i\u{a}")))))

; CSV constraints: ensure correct field counts and detect empty fields
(assert (>= (str.len csv) 0))
(assert (>= (num_splits csv delim) 1))

; Tie split interface to named fields
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= f2 (split_at csv delim 2)))
(assert (= f3 (split_at csv delim 3)))

; Force exactly 4 fields (3 commas)
(assert (= (num_splits csv delim) 4))

; Ensure CSV has no newlines (typical single-line record)
(assert (not (str.contains csv "\u{a}")))
(assert (not (str.contains csv "\u{d}")))

; Detect empty fields: require at least one empty field among the first four
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Also require at least one non-empty field (avoid all-empty degenerate row like ",,,")
(assert (or (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

; Simple content restrictions on specific fields to mimic CSV validation
; f0 is an ID: must be digits only and non-empty if present
(assert (=> (not (= f0 "")) (str.in_re f0 (re.+ (re.range "0" "9")))))

; f1 is a name-like token: cannot contain commas
(assert (not (str.contains f1 delim)))

; f2 is a flag: either "Y" or "N" if non-empty
(assert (=> (not (= f2 "")) (or (= f2 "Y") (= f2 "N"))))

; f3 is a comment: may contain spaces, but cannot contain commas (since split is on commas)
(assert (not (str.contains f3 delim)))

; Additional shape constraint using split_rest: concatenation from field 2 onward should not be empty
(assert (not (= (split_rest csv delim 2) "")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
