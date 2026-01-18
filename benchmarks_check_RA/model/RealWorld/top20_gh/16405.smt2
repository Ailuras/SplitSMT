(
  ;; universe for var1054:
  ;;   var1054!val!0 var1054!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1054!val!0 () var1054)
  (declare-fun var1054!val!1 () var1054)
  ;; cardinality constraint:
  (forall ((x var1054)) (or (= x var1054!val!0) (= x var1054!val!1)))
  ;; -----------
  (define-fun var2930 () Int
    (- 1))
  (define-fun null-var1054 () var1054
    var1054!val!1)
  (define-fun var1573 () Bool
    (ite (= 1 0) true false))
  (define-fun var2257 () String
    ":")
  (define-fun null-String () String
    "")
  (define-fun var3189 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2257 ":") (- 1)) (num_splits var2257 ":") (- 1))
     (num_splits var2257 ":")))
  (define-fun var1680 () var1054
    var1054!val!0)
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
