(
  ;; universe for var812:
  ;;   var812!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var812!val!0 () var812)
  ;; cardinality constraint:
  (forall ((x var812)) (= x var812!val!0))
  ;; -----------
  ;; universe for var1442:
  ;;   var1442!val!1 var1442!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1442!val!1 () var1442)
  (declare-fun var1442!val!0 () var1442)
  ;; cardinality constraint:
  (forall ((x var1442)) (or (= x var1442!val!1) (= x var1442!val!0)))
  ;; -----------
  ;; universe for var250:
  ;;   var250!val!1 var250!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var250!val!1 () var250)
  (declare-fun var250!val!0 () var250)
  ;; cardinality constraint:
  (forall ((x var250)) (or (= x var250!val!1) (= x var250!val!0)))
  ;; -----------
  (define-fun var1592 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var2379) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var2379) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var2379) a!2 0))))
  (var250_contains/-441121415 var3884 (cast-from-String-to-var812 a!4)))))))
  (define-fun var2442 () String
    (toString/-512974245 var2379))
  (define-fun var1134 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var2379) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var2379) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var2379) a!2 0))))
  (var1487_isNotBlank/-616714458 a!4))))))
  (define-fun var907 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var2379) a!2) (- 1))
                (num_splits_re (toString/-512974245 var2379) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var2379) a!2))))))
  (define-fun var2379 () var1442
    var1442!val!0)
  (define-fun var1571 () Int
    0)
  (define-fun var3884 () var250
    var250!val!0)
  (define-fun null-var250 () var250
    var250!val!1)
  (define-fun null-var1442 () var1442
    var1442!val!1)
  (define-fun var1571!1 () Int
    (+ 0 1))
  (define-fun var1565 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var2379) a!2) (- 1))
                (num_splits_re (toString/-512974245 var2379) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var2379) a!2))))))
  (define-fun var3421 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var2379) a!2) (- 1)))))
  (ite a!3
       (split_rest_re (toString/-512974245 var2379) a!2 (- (- 1) 1))
       (split_at_re (toString/-512974245 var2379) a!2 0))))))
  (define-fun var250_contains/-441121415 ((x!0 var250) (x!1 var812)) Bool
    true)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    1)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    " ")
  (define-fun var1487_isNotBlank/-616714458 ((x!0 String)) Bool
    true)
  (define-fun cast-from-String-to-var812 ((x!0 String)) var812
    var812!val!0)
  (define-fun toString/-512974245 ((x!0 var1442)) String
    " ")
)
