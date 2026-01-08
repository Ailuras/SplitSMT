(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/<") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "col") (re.* (re.comp (str.to_re ">"))) (str.to_re "width") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "=") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.opt (re.union (str.to_re "\u{22}") (str.to_re "'"))) ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "/i\u{a}")))))
(assert (str.in_re X (str.to_re "NetTracker.htaServerTheef2trustyfiles.comlogsHost:version\u{a}")))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const host_part String)
(declare-const after_host String)
(declare-const before_version String)
(declare-const version_part String)

(assert (= host_part (split_at X "Host:" 1)))
(assert (>= (num_splits X "Host:") 2))
(assert (= after_host (split_rest X "Host:" 1)))

(assert (= before_version (split_at after_host ":" 0)))
(assert (= version_part (split_at after_host ":" 1)))
(assert (>= (num_splits after_host ":") 2))

(assert (str.in_re before_version (re.* (re.comp (str.to_re "\u{a}")))))
(assert (str.in_re version_part (re.++ (str.to_re "version") (str.to_re "\u{a}"))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]