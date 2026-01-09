(set-logic ALL)

; CSV Processing scenario: ensure correct field counts and detect empty fields

; str_split interface operations
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

; Variables
(declare-const X String)
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail1 String)
(declare-const emptyField Bool)
(declare-const hasHeader Bool)
(declare-const idx0 Int)
(declare-const idx1 Int)
(declare-const idx2 Int)

; Keep core structure from seed: X matches a specific numeric-ish line ending with newline
(assert (str.in_re X
  (re.++
    (re.opt (re.union (str.to_re "E") (str.to_re "V")))
    ((_ re.loop 3 3) (re.range "0" "9"))
    (re.opt (re.++ (str.to_re ".") ((_ re.loop 1 2) (re.range "0" "9"))))
    (str.to_re "\u{a}"))))

; Keep seed-style exclusions (harmless in CSV context; treated as forbidden exact strings)
(assert (not (str.in_re X (str.to_re "User-Agent:User-Agent:\u{a}"))))
(assert (not (str.in_re X (str.to_re "User-Agent:Host:passwordhavewww.alfacleaner.com\u{a}"))))
(assert (not (str.in_re X (str.to_re "XPPreUser-Agent:RemoteYOURsqlStarLoggerclvompycem/cen.vcn\u{a}"))))
(assert (not (str.in_re X
  (re.++
    ((_ re.loop 5 5)
      (re.++
        ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "a" "f") (re.range "A" "F")))
        (str.to_re ":")))
    ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "a" "f") (re.range "A" "F")))
    (str.to_re "\u{a}")))))

; CSV-specific constraints
(assert (= delim ","))

; Construct a CSV row by prefixing X with a header and adding two more fields
; Example shape: "ID,<X>,42,"
(assert (= csv (str.++ "ID" delim X delim "42" delim "")))

; Require 4 fields (3 commas => 4 segments)
(assert (= (num_splits csv delim) 4))

; Index bounds for split_at/split_rest usage (natural and within segment range)
(assert (= idx0 0))
(assert (= idx1 1))
(assert (= idx2 2))
(assert (>= idx0 0))
(assert (>= idx1 0))
(assert (>= idx2 0))
(assert (< idx0 (num_splits csv delim)))
(assert (< idx1 (num_splits csv delim)))
(assert (< idx2 (num_splits csv delim)))

; Extract fields
(assert (= f0 (split_at csv delim idx0)))
(assert (= f1 (split_at csv delim idx1)))
(assert (= f2 (split_at csv delim idx2)))
(assert (= tail1 (split_rest csv delim 1)))

; Header detection and constraints
(assert (= hasHeader (= f0 "ID")))
(assert hasHeader)

; The second field is exactly X (after header)
(assert (= f1 X))

; Field 3 must be numeric and equal to "42"
(assert (= f2 "42"))

; Detect empty fields: the last field is empty because csv ends with a delimiter
(assert (= emptyField (= (split_at csv delim 3) "")))
(assert emptyField)

; Additional CSV sanity: exactly one empty field (force other fields non-empty)
(assert (not (= f0 "")))
(assert (not (= f1 "")))
(assert (not (= f2 "")))

; Ensure the remainder after field 1 starts with X and a comma (structure check)
(assert (str.prefixof (str.++ X delim) tail1))

; UNSAT branch: contradictory requirement that there are no empty fields
; This forces UNSAT while preserving core structure and CSV constraints
(assert (forall ((k Int))
  (=> (and (>= k 0) (< k (num_splits csv delim)))
      (not (= (split_at csv delim k) "")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
