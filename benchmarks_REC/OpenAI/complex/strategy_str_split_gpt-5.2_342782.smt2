(set-logic ALL)

; HTTP Header Parsing scenario using regex and str_split interface

; --- str_split interface (uninterpreted) ---
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

; --- Core variables ---
(declare-const X String)              ; entire HTTP request header block
(declare-const req_line String)
(declare-const hdr_host String)
(declare-const hdr_cl String)         ; Content-Length value (string)
(declare-const hdr_ct String)
(declare-const body String)
(declare-const cl Int)                ; Content-Length value (int)

; Split request into lines by LF
(assert (>= (num_splits X "\u{a}") 3))
(assert (= req_line (split_at X "\u{a}" 0)))

; Require HTTP request-line shape: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re req_line
  (re.++
    (re.union (str.to_re "GET") (str.to_re "POST"))
    (str.to_re " ")
    (re.+ (re.comp (str.to_re " ")))
    (str.to_re " HTTP/1.1"))))

; Extract a couple of header lines by fixed indices (relaxation-style)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)
(assert (= line1 (split_at X "\u{a}" 1)))
(assert (= line2 (split_at X "\u{a}" 2)))
(assert (= line3 (split_at X "\u{a}" 3)))

; Each header line must contain a colon key/value separator
(assert (str.contains line1 ":"))
(assert (str.contains line2 ":"))

; Parse Host from either line1 or line2 (relaxed disjunction)
(assert (or
  (and (str.prefixof "Host:" line1) (= hdr_host (split_rest line1 ":" 1)))
  (and (str.prefixof "Host:" line2) (= hdr_host (split_rest line2 ":" 1)))))

; Host must be non-empty after the colon and optional spaces/tabs
(assert (str.in_re hdr_host (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))) (re.+ re.allchar))))

; Parse Content-Length from either line1/line2/line3
(assert (or
  (and (str.prefixof "Content-Length:" line1) (= hdr_cl (split_rest line1 ":" 1)))
  (and (str.prefixof "Content-Length:" line2) (= hdr_cl (split_rest line2 ":" 1)))
  (and (str.prefixof "Content-Length:" line3) (= hdr_cl (split_rest line3 ":" 1)))))

; Content-Length must be digits with optional leading spaces/tabs
(assert (str.in_re hdr_cl (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))) (re.+ (re.range "0" "9")))))

; Bind integer cl to a constrained range and require it matches body length (modelled)
(assert (>= cl 0))
(assert (<= cl 1024))

; Body is everything after the first empty line (CRLFCRLF or LFLF); relaxed: take rest after two consecutive LFs
(declare-const after_first_lf String)
(assert (= after_first_lf (split_rest X "\u{a}" 1)))
; If there is an empty line, then split_at after_first_lf at 0 is headers continuation, at 1 is body
(assert (>= (num_splits after_first_lf "\u{a}\u{a}") 1))
(assert (= body (split_rest X "\u{a}\u{a}" 1)))

; Constrain body length equals cl (approximate by forcing a fixed-length when cl is fixed)
; Here we pick a concrete cl=10 to create a satisfiable core with meaningful checking
(assert (= cl 10))
(assert (= (str.len body) cl))

; Content-Type header: require application/octet-stream (mutated from seed)
(assert (or
  (and (str.prefixof "Content-Type:" line1) (= hdr_ct (split_rest line1 ":" 1)))
  (and (str.prefixof "Content-Type:" line2) (= hdr_ct (split_rest line2 ":" 1)))
  (and (str.prefixof "Content-Type:" line3) (= hdr_ct (split_rest line3 ":" 1)))))
(assert (str.in_re hdr_ct (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))) (str.to_re "application/octet-stream"))))

; --- Mutated seed-style negative regex constraints to avoid suspicious filename parameters in any header block ---
(assert (not (str.in_re X (re.++ (str.to_re "filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".abc")))))
(assert (not (str.in_re X (re.++ (str.to_re "filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".csv")))))

; --- Additional security: forbid header injection via embedded CR in header lines ---
(assert (not (str.contains req_line "\u{d}")))
(assert (not (str.contains line1 "\u{d}")))
(assert (not (str.contains line2 "\u{d}")))
(assert (not (str.contains line3 "\u{d}")))

; --- UNSAT branch (guarded) to create diversity: if a special marker exists, enforce inconsistent length ---
(declare-const marker String)
(assert (= marker "X-Force-Unsat"))
(assert (=> (str.contains X marker) (and (= cl 5) (= cl 10))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
