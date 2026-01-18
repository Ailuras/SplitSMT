(
  ;; universe for var3342:
  ;;   var3342!val!0 var3342!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3342!val!0 () var3342)
  (declare-fun var3342!val!1 () var3342)
  ;; cardinality constraint:
  (forall ((x var3342)) (or (= x var3342!val!0) (= x var3342!val!1)))
  ;; -----------
  (define-fun var953 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (and (> 9 0) (= 0 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
                (split_rest_re var1786 a!2 (- 9 1))
                (split_at_re var1786 a!2 0))))
  (= a!3 (docId/615252293 var1639))))))
  (define-fun var1417 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 0 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
       (split_rest_re var1786 a!2 (- 9 1))
       (split_at_re var1786 a!2 0)))))
  (define-fun var2986 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 3 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
       (split_rest_re var1786 a!2 (- 9 1))
       (split_at_re var1786 a!2 3)))))
  (define-fun var1786 () String
    " ")
  (define-fun var3903 () String
    (sentId/615252293 var1639))
  (define-fun var42 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (and (> 9 0) (= 3 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
                (split_rest_re var1786 a!2 (- 9 1))
                (split_at_re var1786 a!2 3))))
  (= a!3 (sentId/615252293 var1639))))))
  (define-fun null-var3342 () var3342
    var3342!val!1)
  (define-fun var1950 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 2 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
       (split_rest_re var1786 a!2 (- 9 1))
       (split_at_re var1786 a!2 2)))))
  (define-fun var2627 () String
    (docId/615252293 var1639))
  (define-fun null-String () String
    "")
  (define-fun var1639 () var3342
    var3342!val!0)
  (define-fun var1398 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 1 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
       (split_rest_re var1786 a!2 (- 9 1))
       (split_at_re var1786 a!2 1)))))
  (define-fun var2617 () Bool
    (initialized/615252293 var1639))
  (define-fun var1599 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "|"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (and (> 9 0) (= 8 (- 9 1)) (>= (num_splits_re var1786 a!2) 9))
       (split_rest_re var1786 a!2 (- 9 1))
       (split_at_re var1786 a!2 8)))))
  (define-fun docId/615252293 ((x!0 var3342)) String
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
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    " ")
  (define-fun sentId/615252293 ((x!0 var3342)) String
    "")
  (define-fun initialized/615252293 ((x!0 var3342)) Bool
    true)
)
