(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3"))) (str.to_re ":\u{a}") (re.range "0" "5") (re.range "0" "9"))))
(assert (not (str.in_re X (re.++ (str.to_re "UploadFriendly is an easy to use Java Applet that will allow multiple file uploads on a web server in a web page") re.allchar (str.to_re " The control supports file filtering, limits and more") re.allchar (str.to_re " Samples available in the following languages: ASP, ASP") re.allchar (str.to_re "NET, PHP, Coldfusion and JSP\u{a}")))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (str.num_splits X delimiter) 2))
(assert (= (str.split_at X delimiter 0) (str.substr X 0 (str.indexof X delimiter 0))))
(assert (= (str.split_at X delimiter 1) (str.substr X (+ (str.indexof X delimiter 0) 1) (- (str.len X) (+ (str.indexof X delimiter 0) 1)))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
