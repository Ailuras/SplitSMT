(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "MyAgentprotocolprotocolHost:/s(robert@blackcastlesoft.com)data2.activshopper.com\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "//download.asp?p=") (re.range "0" "9") (str.to_re "/Ui\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const proto String)
(declare-const after_proto String)
(declare-const hostpart String)
(declare-const pathpart String)

(assert (>= (num_splits X "://") 2))
(assert (= proto (split_at X "://" 0)))
(assert (= after_proto (split_rest X "://" 1)))

(assert (>= (num_splits after_proto "/") 2))
(assert (= hostpart (split_at after_proto "/" 0)))
(assert (= pathpart (split_rest after_proto "/" 1)))

(assert (not (str.contains hostpart "@")))
(assert (not (str.contains pathpart "download.asp")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
