(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".flv/i\u{a}")))))
(assert (not (str.in_re X (str.to_re "wlpgskmv/lwzo.qv#www.kliksearch.com\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "\u{a}") (re.opt (re.union (str.to_re "-") (str.to_re "+"))) (re.union (re.++ (re.+ (re.range "0" "9")) (re.opt (str.to_re ".")) (re.* (re.range "0" "9"))) (re.++ (re.* (re.range "0" "9")) (re.opt (str.to_re ".")) (re.+ (re.range "0" "9"))))))))
(assert (not (str.in_re X (re.++ (str.to_re "//") ((_ re.loop 32 32) (re.union (re.range "a" "f") (re.range "0" "9"))) (str.to_re "/") ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "/") ((_ re.loop 32 32) (re.union (re.range "a" "f") (re.range "0" "9"))) (str.to_re ".jar/Ui\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "http") (re.opt (str.to_re "s")) (str.to_re "://") (re.* (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) (str.to_re "."))) (re.union ((_ re.loop 3 61) (re.union (re.range "a" "z") (re.range "A" "Z"))) (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))) (str.to_re ".") ((_ re.loop 2 2) (re.union (re.range "a" "z") (re.range "A" "Z"))))) (str.to_re "/") (re.* re.allchar) (str.to_re "\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const Proto String)
(declare-const AfterProto String)
(declare-const HostPath String)
(declare-const Host String)
(declare-const PathAndMore String)

(assert (>= (num_splits X "://") 2))
(assert (= Proto (split_at X "://" 0)))
(assert (or (= Proto "http") (= Proto "https")))
(assert (= AfterProto (split_rest X "://" 1)))

(assert (>= (num_splits AfterProto "/") 2))
(assert (= Host (split_at AfterProto "/" 0)))
(assert (= PathAndMore (split_rest AfterProto "/" 1)))
(assert (str.contains Host "."))
(assert (not (str.contains Host "#")))
(assert (not (str.contains Host "?")))

(assert (>= (str.len PathAndMore) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]