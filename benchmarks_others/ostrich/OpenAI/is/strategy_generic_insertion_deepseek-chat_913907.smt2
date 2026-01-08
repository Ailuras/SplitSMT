(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/Host:") (re.+ (re.union (str.to_re "\u{d}") (str.to_re "\u{a}"))) ((_ re.loop 1 3) (re.range "0" "9")) (str.to_re ".") ((_ re.loop 1 3) (re.range "0" "9")) (str.to_re ".") ((_ re.loop 1 3) (re.range "0" "9")) (str.to_re ".") ((_ re.loop 1 3) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 1 5) (re.range "0" "9")) (re.opt (str.to_re "\u{d}")) (str.to_re "/mi\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "Subject:") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "www.searchwords.com\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "DmInf^") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Contactfrom=GhostVoiceServerUser-Agent:\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const subj_tail String)
(declare-const subj_prefix String)

(assert (>= (num_splits X "Subject:") 2))
(assert (= subj_prefix (split_at X "Subject:" 0)))
(assert (= subj_tail (split_rest X "Subject:" 1)))
(assert (str.contains subj_tail "www.searchwords.com"))

(assert (>= (num_splits X "DmInf^") 2))
(assert (str.contains (split_rest X "DmInf^" 1) "Contactfrom=GhostVoiceServerUser-Agent:"))

(assert (>= (num_splits X "Host:") 1))
(assert (not (str.contains (split_at X "Host:" 0) "Host:")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
