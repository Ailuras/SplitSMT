(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (re.++ (re.opt (re.++ (str.to_re "CZ") (re.opt (str.to_re "-")))) ((_ re.loop 8 10) (re.range "0" "9")) (str.to_re "\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/cgi/logurl.cgi") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:User-Agent:Surveillance\u{13}com\u{a}")))))

; --- START CONSTRAINT ---

(declare-const prefix String)
(declare-const tail_after_cz String)
(declare-const digits8to10 String)
(declare-const last_char String)

(assert (= prefix (split_at X "CZ" 0)))
(assert (= tail_after_cz (split_at X "CZ" 1)))
(assert (or (= (num_splits X "CZ") 1) (= (num_splits X "CZ") 2)))

; tail_after_cz is either "" (no CZ) or begins with optional "-" then digits then "\n"
(assert (or (= tail_after_cz "") (str.prefixof "-" tail_after_cz) (str.prefixof "0" tail_after_cz) (str.prefixof "1" tail_after_cz) (str.prefixof "2" tail_after_cz) (str.prefixof "3" tail_after_cz) (str.prefixof "4" tail_after_cz) (str.prefixof "5" tail_after_cz) (str.prefixof "6" tail_after_cz) (str.prefixof "7" tail_after_cz) (str.prefixof "8" tail_after_cz) (str.prefixof "9" tail_after_cz)))

; isolate the final LF and ensure it is present as last character
(assert (>= (str.len X) 1))
(assert (= last_char (str.substr X (- (str.len X) 1) 1)))
(assert (= last_char "\n"))

; split using the LF; must end with LF so last segment is empty
(assert (>= (num_splits X "\n") 2))
(assert (= (split_at X "\n" (- (num_splits X "\n") 1)) ""))

; constrain that X does not contain the forbidden CGI prefix by requiring the part before it equals X
(assert (= (num_splits X "/cgi/logurl.cgi") 1))
(assert (= (split_at X "/cgi/logurl.cgi" 0) X))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
