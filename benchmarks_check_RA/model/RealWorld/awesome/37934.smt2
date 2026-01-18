(
  ;; universe for var1627:
  ;;   var1627!val!1 var1627!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1627!val!1 () var1627)
  (declare-fun var1627!val!0 () var1627)
  ;; cardinality constraint:
  (forall ((x var1627)) (or (= x var1627!val!1) (= x var1627!val!0)))
  ;; -----------
  (define-fun null-var1627 () var1627
    var1627!val!1)
  (define-fun var2047 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 2 (- 9 1)) (>= (num_splits_re var552 a!2) 9))
       (split_rest_re var552 a!2 (- 9 1))
       (split_at_re var552 a!2 2)))))
  (define-fun var3605 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 3 (- 9 1)) (>= (num_splits_re var552 a!2) 9))
       (split_rest_re var552 a!2 (- 9 1))
       (split_at_re var552 a!2 3)))))
  (define-fun var601 () String
    (docId/615252293 var1881))
  (define-fun var2298 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 0 (- 9 1)) (>= (num_splits_re var552 a!2) 9))
       (split_rest_re var552 a!2 (- 9 1))
       (split_at_re var552 a!2 0)))))
  (define-fun var1881 () var1627
    var1627!val!0)
  (define-fun null-String () String
    "")
  (define-fun var70 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 1 (- 9 1)) (>= (num_splits_re var552 a!2) 9))
       (split_rest_re var552 a!2 (- 9 1))
       (split_at_re var552 a!2 1)))))
  (define-fun var2149 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 8 (- 9 1)) (>= (num_splits_re var552 a!2) 9))
       (split_rest_re var552 a!2 (- 9 1))
       (split_at_re var552 a!2 8)))))
  (define-fun var459 () Bool
    (initialized/615252293 var1881))
  (define-fun var2771 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (and (> 9 0) (= 0 (- 9 1)) (>= (num_splits_re var552 a!2) 9))
                (split_rest_re var552 a!2 (- 9 1))
                (split_at_re var552 a!2 0))))
  (= a!3 (docId/615252293 var1881))))))
  (define-fun var552 () String
    " ")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    " ")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun initialized/615252293 ((x!0 var1627)) Bool
    true)
  (define-fun docId/615252293 ((x!0 var1627)) String
    "")
)
