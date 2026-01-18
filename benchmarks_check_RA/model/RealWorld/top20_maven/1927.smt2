(
  ;; universe for var364:
  ;;   var364!val!0 var364!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var364!val!0 () var364)
  (declare-fun var364!val!1 () var364)
  ;; cardinality constraint:
  (forall ((x var364)) (or (= x var364!val!0) (= x var364!val!1)))
  ;; -----------
  (define-fun var2469 () String
    ",")
  (define-fun null-String () String
    "")
  (define-fun null-var364 () var364
    var364!val!1)
  (define-fun var3316 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2469 ",") (- 1)) (num_splits var2469 ",") (- 1))
     (num_splits var2469 ",")))
  (define-fun var815 () var364
    var364!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
