(
  ;; universe for var2242:
  ;;   var2242!val!0 var2242!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2242!val!0 () var2242)
  (declare-fun var2242!val!1 () var2242)
  ;; cardinality constraint:
  (forall ((x var2242)) (or (= x var2242!val!0) (= x var2242!val!1)))
  ;; -----------
  (define-fun var1157 () var2242
    var2242!val!0)
  (define-fun null-var2242 () var2242
    var2242!val!1)
  (define-fun var2171 () Bool
    (ite (= 1 1) true false))
  (define-fun var3225 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3051 ":") (- 1)) (num_splits var3051 ":") (- 1))
     (num_splits var3051 ":")))
  (define-fun null-String () String
    "")
  (define-fun var2401 () Int
    (- 1))
  (define-fun var3051 () String
    ":")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
