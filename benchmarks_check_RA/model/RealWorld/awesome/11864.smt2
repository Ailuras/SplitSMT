(
  ;; universe for var2021:
  ;;   var2021!val!1 var2021!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2021!val!1 () var2021)
  (declare-fun var2021!val!0 () var2021)
  ;; cardinality constraint:
  (forall ((x var2021)) (or (= x var2021!val!1) (= x var2021!val!0)))
  ;; -----------
  (define-fun var1973 () var2021
    var2021!val!0)
  (define-fun null-var2021 () var2021
    var2021!val!1)
  (define-fun var2278 () String
    ",")
  (define-fun null-String () String
    "")
  (define-fun var1868 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2278 ",") (- 1)) (num_splits var2278 ",") (- 1))
     (num_splits var2278 ",")))
  (define-fun var1117 () Int
    0)
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
