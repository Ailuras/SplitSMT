(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "toolbar_domain_redirectriggiymd/wdhi.vhi\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "User-Agent:") (re.+ (re.range "0" "9")) (str.to_re "PortaURLSSKC|roogoo|.cfgmPOPrtCUSTOMPal\u{a}")))))

; --- START CONSTRAINT ---
; str_split interface function signatures
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; New helper variables
(declare-const delim String)
(declare-const seg0 String)
(declare-const seg1 String)
(declare-const rest1 String)

; Use split constraints over X
(assert (= delim "/"))
(assert (>= (num_splits X delim) 2))
(assert (= seg0 (split_at X delim 0)))
(assert (= seg1 (split_at X delim 1)))
(assert (= rest1 (split_rest X delim 1)))

; Tie split components back to X via containment-style properties
(assert (str.contains X seg0))
(assert (str.contains X seg1))
(assert (str.contains X rest1))
(assert (>= (str.len seg0) 0))
(assert (>= (str.len seg1) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
