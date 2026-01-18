(
  ;; universe for var1300:
  ;;   var1300!val!0 var1300!val!2 var1300!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1300!val!0 () var1300)
  (declare-fun var1300!val!2 () var1300)
  (declare-fun var1300!val!1 () var1300)
  ;; cardinality constraint:
  (forall ((x var1300))
          (or (= x var1300!val!0) (= x var1300!val!2) (= x var1300!val!1)))
  ;; -----------
  (define-fun var3285 () Int
    (let ((a!1 (ite (< (num_splits (surfaceForm/46288021 var3702) " ") (- 1))
                (num_splits (surfaceForm/46288021 var3702) " ")
                (- 1)))
      (a!2 (ite (< (num_splits (surfaceForm/46288021 var319) " ") (- 1))
                (num_splits (surfaceForm/46288021 var319) " ")
                (- 1))))
  (- (ite (> (- 1) 0) a!1 (num_splits (surfaceForm/46288021 var3702) " "))
     (ite (> (- 1) 0) a!2 (num_splits (surfaceForm/46288021 var319) " ")))))
  (define-fun var3142 () Int
    (let ((a!1 (ite (< (num_splits (surfaceForm/46288021 var319) " ") (- 1))
                (num_splits (surfaceForm/46288021 var319) " ")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (surfaceForm/46288021 var319) " "))))
  (define-fun var2069 () Int
    (let ((a!1 (ite (< (num_splits (surfaceForm/46288021 var3702) " ") (- 1))
                (num_splits (surfaceForm/46288021 var3702) " ")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (surfaceForm/46288021 var3702) " "))))
  (define-fun var995 () String
    (surfaceForm/46288021 var319))
  (define-fun var3702 () var1300
    var1300!val!2)
  (define-fun var319 () var1300
    var1300!val!0)
  (define-fun null-var1300 () var1300
    var1300!val!1)
  (define-fun var1711 () String
    (surfaceForm/46288021 var3702))
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
    "")
  (define-fun surfaceForm/46288021 ((x!0 var1300)) String
    "")
)
