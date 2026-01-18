(
  ;; universe for var348:
  ;;   var348!val!1 var348!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var348!val!1 () var348)
  (declare-fun var348!val!0 () var348)
  ;; cardinality constraint:
  (forall ((x var348)) (or (= x var348!val!1) (= x var348!val!0)))
  ;; -----------
  (define-fun var2399 () Int
    0)
  (define-fun var2196 () var348
    var348!val!0)
  (define-fun null-String () String
    "")
  (define-fun var1391 () String
    ",")
  (define-fun var3164 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1391 ",") (- 1)) (num_splits var1391 ",") (- 1))
     (num_splits var1391 ",")))
  (define-fun null-var348 () var348
    var348!val!1)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
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
