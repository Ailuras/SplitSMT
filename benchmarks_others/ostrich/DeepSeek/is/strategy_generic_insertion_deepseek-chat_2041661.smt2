(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/document.execCommand(") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (str.to_re "\u{22}") (str.to_re "'")) (str.to_re "InsertUnorderedList") (re.union (str.to_re "\u{22}") (str.to_re "'")) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ")") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ";") ((_ re.loop 0 250) re.allchar) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re ".swapNode(") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 1 75) (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re "(") (str.to_re ")") (str.to_re "\u{22}") (str.to_re "'") (str.to_re ".") (str.to_re "=") (str.to_re " "))) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ")") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "document.execCommand(") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (str.to_re "\u{22}") (str.to_re "'")) (str.to_re "Undo") (re.union (str.to_re "\u{22}") (str.to_re "'")) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ")") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ";/smi\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "User-Agent:") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "\u{d}\u{a}subject=GhostVoice\u{a}"))))
(assert (not (str.in_re X (re.union (re.++ (str.to_re "<") (re.opt (str.to_re "/")) (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.* (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.* (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "=") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (re.++ (str.to_re "\u{22}") (re.* (re.comp (str.to_re "\u{22}"))) (str.to_re "\u{22}")) (re.++ (str.to_re "';") (re.union (str.to_re "'") (str.to_re ";")) (str.to_re "';")) (re.* (re.comp (str.to_re ">"))))))) (re.++ (re.opt (str.to_re "/")) (str.to_re ">\u{a}"))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Declare new variables for splitting
(declare-const delimiter1 String)
(declare-const delimiter2 String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter1 "\u{d}\u{a}"))
(assert (= delimiter2 ";"))
(assert (= segment0 (split_at X delimiter1 0)))
(assert (= segment1 (split_at X delimiter1 1)))
(assert (= total_segments (num_splits X delimiter1)))
(assert (>= total_segments 2))
(assert (str.contains segment0 "User-Agent:"))
(assert (str.contains segment1 "subject=GhostVoice"))
(assert (>= (num_splits X delimiter2) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
