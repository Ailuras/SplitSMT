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

; Log Analysis scenario: parsing structured server log entries separated by spaces and colons
; We keep the original seed constraint (mutated by embedding it as an additional check on a payload field)

(declare-const X String)
(declare-const log String)
(declare-const ts String)
(declare-const rest1 String)
(declare-const levelAndRest String)
(declare-const level String)
(declare-const msg String)
(declare-const tag String)
(declare-const payload String)
(declare-const host String)
(declare-const pidStr String)
(declare-const pid Int)

; str_split interface

; Basic splitting by spaces: "<ts> <LEVEL>: <msg>"
(assert (= ts (split_at log " " 0)))
(assert (= rest1 (split_rest log " " 1)))
(assert (>= (num_splits log " ") 2))

; Extract "LEVEL:" then message
(assert (= levelAndRest (split_at rest1 " " 0)))
(assert (>= (num_splits rest1 " ") 1))
(assert (= msg (split_rest rest1 " " 1)))

; Split "LEVEL:" by ':' to obtain level
(assert (>= (num_splits levelAndRest ":") 2))
(assert (= level (split_at levelAndRest ":" 0)))

; Timestamp format: YYYY-MM-DDTHH:MM:SSZ (strict digits and separators)
(assert (str.in_re ts (re.++
  ((_ re.loop 4 4) (re.range "0" "9"))
  (str.to_re "-")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re "-")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re "T")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re ":")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re ":")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re "Z")
)))

; Allowed log levels
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message contains a tag with colon: "host:<hostname> pid:<digits>" somewhere
(assert (str.contains msg "host:"))
(assert (str.contains msg "pid:"))

; Parse host and pid using ':' and spaces
(assert (= tag (split_at msg " " 0)))
(assert (>= (num_splits msg " ") 1))
(assert (= payload (split_rest msg " " 1)))

; tag expected to be "host:<hostname>"
(assert (= (split_at tag ":" 0) "host"))
(assert (>= (num_splits tag ":") 2))
(assert (= host (split_rest tag ":" 1)))
(assert (>= (str.len host) 1))
(assert (str.in_re host (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "-") (str.to_re ".")))))))))

; payload expected to start with "pid:<digits>" then optionally more text
(assert (= (split_at payload " " 0) (split_at payload " " 0)))
(assert (= (split_at (split_at payload " " 0) ":" 0) "pid"))
(assert (>= (num_splits (split_at payload " " 0) ":") 2))
(assert (= pidStr (split_rest (split_at payload " " 0) ":" 1)))
(assert (str.in_re pidStr (re.+ (re.range "0" "9"))))
(assert (= pid (str.to_int pidStr)))
(assert (>= pid 0))
(assert (<= pid 65535))

; --- Seed-derived constraint (mutated/embedded) ---
; Ensure X does NOT match a suspicious Referer payload regex (as in the seed), and also keep X tied to payload.
(assert (= X payload))
(assert (not (str.in_re X (re.++
  (str.to_re "/Referer:")
  (re.* (re.union (str.to_re " ") (re.union (str.to_re "\u{9}") (re.union (str.to_re "\u{a}") (re.union (str.to_re "\u{c}") (str.to_re "\u{d}"))))))
  (str.to_re "http:")
  ((_ re.loop 2 2) (str.to_re "/"))
  (re.+ (re.union (re.range "a" "z") (re.union (re.range "0" "9") (re.union (str.to_re ".") (str.to_re "-")))))
  (str.to_re "/s/?k=/Hi\u{a}")
))))

; --- Additional constraints to create both SAT and UNSAT branches in one file ---
; SAT branch: choose a concrete well-formed log line
(declare-const is_sat Bool)
(assert is_sat)
(assert (= log "2025-01-07T13:45:59Z INFO: host:server-1 pid:1234 started"))

; UNSAT sub-instance encoded but disabled by is_sat
(declare-const is_unsat Bool)
(assert (not is_unsat))
(assert (=> is_unsat (= log "2025-13-99T99:99:99Z ERROR: host:bad pid:99999 /Referer: http://aa/s/?k=/Hi\u{a}")))
(assert (=> is_unsat (and (= level "TRACE") (< pid 0))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
