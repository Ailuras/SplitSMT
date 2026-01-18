(
  ;; universe for var3575:
  ;;   var3575!val!0 var3575!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3575!val!0 () var3575)
  (declare-fun var3575!val!1 () var3575)
  ;; cardinality constraint:
  (forall ((x var3575)) (or (= x var3575!val!0) (= x var3575!val!1)))
  ;; -----------
  ;; universe for var1294:
  ;;   var1294!val!1 var1294!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1294!val!1 () var1294)
  (declare-fun var1294!val!0 () var1294)
  ;; cardinality constraint:
  (forall ((x var1294)) (or (= x var1294!val!1) (= x var1294!val!0)))
  ;; -----------
  ;; universe for var2050:
  ;;   var2050!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2050!val!0 () var2050)
  ;; cardinality constraint:
  (forall ((x var2050)) (= x var2050!val!0))
  ;; -----------
  (define-fun var831 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3638) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var3638) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var3638) a!2 0))))
  (var1294_contains/-441121415 var2254 (cast-from-String-to-var2050 a!4)))))))
  (define-fun var2450 () Int
    0)
  (define-fun var3638 () var3575
    var3575!val!0)
  (define-fun null-var3575 () var3575
    var3575!val!1)
  (define-fun var2450!1 () Int
    (+ 0 1))
  (define-fun var2254 () var1294
    var1294!val!0)
  (define-fun var1120 () String
    (toString/-512974245 var3638))
  (define-fun var2051 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3638) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var3638) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var3638) a!2 0))))
  (var3328_isNotBlank/-616714458 a!4))))))
  (define-fun null-var1294 () var1294
    var1294!val!1)
  (define-fun var2398 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var3638) a!2) (- 1)))))
  (ite a!3
       (split_rest_re (toString/-512974245 var3638) a!2 (- (- 1) 1))
       (split_at_re (toString/-512974245 var3638) a!2 0))))))
  (define-fun var3707 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var3638) a!2) (- 1))
                (num_splits_re (toString/-512974245 var3638) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var3638) a!2))))))
  (define-fun var1194 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var3638) a!2) (- 1))
                (num_splits_re (toString/-512974245 var3638) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var3638) a!2))))))
  (define-fun var2254!1 () var1294
    var1294!val!1)
  (define-fun var2398!1 () String
    "")
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
    1)
  (define-fun toString/-512974245 ((x!0 var3575)) String
    " ")
  (define-fun cast-from-String-to-var2050 ((x!0 String)) var2050
    var2050!val!0)
  (define-fun var3328_isNotBlank/-616714458 ((x!0 String)) Bool
    true)
  (define-fun var1294_contains/-441121415 ((x!0 var1294) (x!1 var2050)) Bool
    false)
  (define-fun var1294_add/328494887 ((x!0 var1294) (x!1 var2050)) Bool
    false)
)
