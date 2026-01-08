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

; Uninterpreted functions for string splitting (relaxation-based interface)

; =====================
; Instance A (SAT): parse headers and validate Content-Length
; =====================
(declare-const reqA String)
(declare-const headerBlockA String)
(declare-const bodyA String)
(declare-const contentLenLineA String)
(declare-const clKeyA String)
(declare-const clValA String)
(declare-const hostLineA String)
(declare-const hostKeyA String)
(declare-const hostValA String)
(declare-const userAgentLineA String)
(declare-const uaKeyA String)
(declare-const uaValA String)
(declare-const parsedCLA Int)

; Request consists of headers, blank line, then body
(assert (= reqA (str.++ headerBlockA "\r\n\r\n" bodyA)))

; Header block has at least 3 lines: Host, User-Agent, Content-Length
(assert (>= (num_splits headerBlockA "\r\n") 3))
(assert (= hostLineA (split_at headerBlockA "\r\n" 0)))
(assert (= userAgentLineA (split_at headerBlockA "\r\n" 1)))
(assert (= contentLenLineA (split_at headerBlockA "\r\n" 2)))

; Each header line must have at least one colon splitting key and value
(assert (>= (num_splits hostLineA ":") 2))
(assert (>= (num_splits userAgentLineA ":") 2))
(assert (>= (num_splits contentLenLineA ":") 2))

; Extract keys and values around ':'
(assert (= hostKeyA (split_at hostLineA ":" 0)))
(assert (= hostValA (split_rest hostLineA ":" 1)))
(assert (= uaKeyA (split_at userAgentLineA ":" 0)))
(assert (= uaValA (split_rest userAgentLineA ":" 1)))
(assert (= clKeyA (split_at contentLenLineA ":" 0)))
(assert (= clValA (split_rest contentLenLineA ":" 1)))

; Constrain exact keys (common HTTP header casing)
(assert (= hostKeyA "Host"))
(assert (= uaKeyA "User-Agent"))
(assert (= clKeyA "Content-Length"))

; Values should be non-empty; allow leading space after ':'
(assert (>= (str.len hostValA) 2))
(assert (= (str.at hostValA 0) " "))
(assert (>= (str.len uaValA) 2))
(assert (= (str.at uaValA 0) " "))
(assert (>= (str.len clValA) 2))
(assert (= (str.at clValA 0) " "))

; Host value constraints (simple domain-like token after leading space): " example.com"
(assert (= hostValA " example.com"))

; User-Agent contains a product token; keep it simple
(assert (str.contains uaValA " MyClient/1.0"))

; Content-Length value is " 5" and matches body length 5
(assert (= clValA " 5"))
(assert (= bodyA "abcde"))
(assert (= (str.len bodyA) 5))

; Validate parsed Content-Length as integer with explicit binding
(assert (= parsedCLA 5))
(assert (= parsedCLA (str.len bodyA)))

; Constrain full concrete request for satisfiable example
(assert (= headerBlockA (str.++ "Host: example.com\r\n" "User-Agent: MyClient/1.0\r\n" "Content-Length: 5")))

; =====================
; Instance B (UNSAT): inconsistent Content-Length vs body
; =====================
(declare-const reqB String)
(declare-const headerBlockB String)
(declare-const bodyB String)
(declare-const contentLenLineB String)
(declare-const clKeyB String)
(declare-const clValB String)
(declare-const parsedCLB Int)

(assert (= reqB (str.++ headerBlockB "\r\n\r\n" bodyB)))
(assert (>= (num_splits headerBlockB "\r\n") 1))
(assert (= contentLenLineB (split_at headerBlockB "\r\n" 0)))
(assert (>= (num_splits contentLenLineB ":") 2))
(assert (= clKeyB (split_at contentLenLineB ":" 0)))
(assert (= clValB (split_rest contentLenLineB ":" 1)))
(assert (= clKeyB "Content-Length"))
(assert (= clValB " 4"))

; Body is length 5 but parsed content-length is 4 -> UNSAT
(assert (= bodyB "HELLO"))
(assert (= (str.len bodyB) 5))
(assert (= parsedCLB 4))
(assert (= parsedCLB (str.len bodyB)))

; Concrete header block for clarity
(assert (= headerBlockB "Content-Length: 4"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
