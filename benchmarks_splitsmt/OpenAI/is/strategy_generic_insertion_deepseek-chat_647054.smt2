(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "toolbar_domain_redirectriggiymd/wdhi.vhi\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "User-Agent:") (re.+ (re.range "0" "9")) (str.to_re "PortaURLSSKC|roogoo|.cfgmPOPrtCUSTOMPal\u{a}")))))

; --- START CONSTRAINT ---
; str_split interface function signatures

; New helper variables
(declare-const ua_prefix String)
(declare-const ua_digits_and_tail String)

; Enforce a structured split on a potential "User-Agent:" prefix
(assert (= ua_prefix (str.split_at X "User-Agent:" 0)))
(assert (= ua_digits_and_tail (str.split_rest X "User-Agent:" 1)))
(assert (>= (str.num_splits X "User-Agent:") 1))

; Either X does not contain the marker, or it contains it with a non-empty remainder
(assert (or (= (str.num_splits X "User-Agent:") 1)
            (> (str.len ua_digits_and_tail) 0)))

; If X does contain the marker, the prefix must match the substring before the first occurrence
(assert (=> (str.contains X "User-Agent:")
            (= ua_prefix (str.substr X 0 (str.indexof X "User-Agent:" 0)))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
