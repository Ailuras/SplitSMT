(set-logic ALL)
(declare-fun key1 () String)
(declare-fun key2 () String)
(assert (and (and (and (and (and (and (and (not (not (not (= (ite (= key1 "transfer-encoding") 1 0) 0)))) (not (not (= (ite (= key1 "trailers") 1 0) 0)))) (not (not (= (ite (= key1 "te") 1 0) 0)))) (not (not (= (ite (= key1 "proxy-authorization") 1 0) 0)))) (not (not (= (ite (= key1 "proxy-authenticate") 1 0) 0)))) (not (not (= (ite (= key1 "keep-alive") 1 0) 0)))) (not (not (= (ite (= key1 "connection") 1 0) 0)))) (not (= (ite (= key1 key2) 1 0) 0))))

; --- START CONSTRAINT ---

(declare-fun key1_name () String)
(declare-fun key1_namespace () String)

(assert (>= (str.num_splits key1 "-") 2))
(assert (= key1_namespace (str.split_at key1 "-" 0)))
(assert (= key1_name (str.split_rest key1 "-" 1)))

(assert (or (= key1_namespace "proxy") (= key1_namespace "transfer") (= key1_namespace "keep") (= key1_namespace "trailers") (= key1_namespace "te") (= key1_namespace "connection")))
(assert (not (= key1_namespace key2)))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
