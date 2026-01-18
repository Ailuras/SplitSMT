(
  ;; universe for var495:
  ;;   var495!val!0 var495!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var495!val!0 () var495)
  (declare-fun var495!val!1 () var495)
  ;; cardinality constraint:
  (forall ((x var495)) (or (= x var495!val!0) (= x var495!val!1)))
  ;; -----------
  ;; universe for var3493:
  ;;   var3493!val!0 var3493!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3493!val!0 () var3493)
  (declare-fun var3493!val!1 () var3493)
  ;; cardinality constraint:
  (forall ((x var3493)) (or (= x var3493!val!0) (= x var3493!val!1)))
  ;; -----------
  (define-fun var1452 () var3493
    var3493!val!0)
  (define-fun var153 () String
    (trim-right (trim-left var1466)))
  (define-fun var1466 () String
    "\u{1f7e6}")
  (define-fun var1256 () var495
    var495!val!0)
  (define-fun null-var495 () var495
    var495!val!1)
  (define-fun null-String () String
    "")
  (define-fun var1928 () Int
    (let ((a!1 (num_splits_re (trim-right (trim-left var1466))
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun null-var3493 () var3493
    var3493!val!1)
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
)
