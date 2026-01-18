(
  ;; universe for var3226:
  ;;   var3226!val!0 var3226!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3226!val!0 () var3226)
  (declare-fun var3226!val!1 () var3226)
  ;; cardinality constraint:
  (forall ((x var3226)) (or (= x var3226!val!0) (= x var3226!val!1)))
  ;; -----------
  (define-fun var1358 () var3226
    var3226!val!0)
  (define-fun var2264 () String
    "-")
  (define-fun var1890 () var3226
    var3226-init)
  (define-fun null-String () String
    "")
  (define-fun var3268 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2264 "-") (- 1)) (num_splits var2264 "-") (- 1))
     (num_splits var2264 "-")))
  (define-fun null-var3226 () var3226
    var3226!val!1)
  (define-fun var1757 () Int
    1)
  (define-fun var3226-init () var3226
    var3226!val!0)
  (define-fun var1890!1 () var3226
    var3226!val!0)
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
  (define-fun <init>/248943908 ((x!0 var3226)) void
    void!val!0)
)
