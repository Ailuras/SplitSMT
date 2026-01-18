(
  ;; universe for var2896:
  ;;   var2896!val!1 var2896!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2896!val!1 () var2896)
  (declare-fun var2896!val!0 () var2896)
  ;; cardinality constraint:
  (forall ((x var2896)) (or (= x var2896!val!1) (= x var2896!val!0)))
  ;; -----------
  (define-fun var3307 () var2896
    var2896!val!0)
  (define-fun var3688 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2003 "/") (- 1)) (num_splits var2003 "/") (- 1))
     (num_splits var2003 "/")))
  (define-fun var2003 () String
    "/")
  (define-fun var3909 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2003 ":") (- 1)) (num_splits var2003 ":") (- 1))
     (num_splits var2003 ":")))
  (define-fun null-String () String
    ":")
  (define-fun null-var2896 () var2896
    var2896!val!1)
  (define-fun var1546 () String
    var2003)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
