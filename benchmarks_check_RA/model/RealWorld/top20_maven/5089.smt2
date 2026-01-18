(
  ;; universe for var3476:
  ;;   var3476!val!0 var3476!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3476!val!0 () var3476)
  (declare-fun var3476!val!1 () var3476)
  ;; cardinality constraint:
  (forall ((x var3476)) (or (= x var3476!val!0) (= x var3476!val!1)))
  ;; -----------
  ;; universe for var3322:
  ;;   var3322!val!0 var3322!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3322!val!0 () var3322)
  (declare-fun var3322!val!1 () var3322)
  ;; cardinality constraint:
  (forall ((x var3322)) (or (= x var3322!val!0) (= x var3322!val!1)))
  ;; -----------
  (define-fun null-var3476 () var3476
    var3476!val!1)
  (define-fun var2473 () var3476
    var3476!val!0)
  (define-fun var1936 () var3322
    var3322!val!0)
  (define-fun var3891 () String
    (toString/-512974245 var2473))
  (define-fun var662 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var2473) a!2) (- 1))
                (num_splits_re (toString/-512974245 var2473) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var2473) a!2))))))
  (define-fun null-var3322 () var3322
    var3322!val!1)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun toString/-512974245 ((x!0 var3476)) String
    "!0!")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
