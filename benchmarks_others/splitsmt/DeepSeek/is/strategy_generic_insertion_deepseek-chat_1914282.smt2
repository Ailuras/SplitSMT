(set-logic ALL)
(declare-fun key1 () String)
(declare-fun key2 () String)
(assert (and (and (and (and (and (not (not (= (ite (= key1 "te") 1 0) 0))) (not (not (= (ite (= key1 "proxy-authorization") 1 0) 0)))) (not (not (= (ite (= key1 "proxy-authenticate") 1 0) 0)))) (not (not (= (ite (= key1 "keep-alive") 1 0) 0)))) (not (not (= (ite (= key1 "connection") 1 0) 0)))) (not (= (ite (= key1 key2) 1 0) 0))))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (str.num_splits key1 delimiter) 2))
(assert (= (str.split_at key1 delimiter 0) "header"))
(assert (= (str.split_at key1 delimiter 1) "value"))
(assert (= (str.split_rest key1 delimiter 2) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
