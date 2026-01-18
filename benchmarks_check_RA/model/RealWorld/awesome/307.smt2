(
  ;; universe for var1224:
  ;;   var1224!val!0 var1224!val!1 var1224!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1224!val!0 () var1224)
  (declare-fun var1224!val!1 () var1224)
  (declare-fun var1224!val!2 () var1224)
  ;; cardinality constraint:
  (forall ((x var1224))
          (or (= x var1224!val!0) (= x var1224!val!1) (= x var1224!val!2)))
  ;; -----------
  ;; universe for var858:
  ;;   var858!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var858!val!0 () var858)
  ;; cardinality constraint:
  (forall ((x var858)) (= x var858!val!0))
  ;; -----------
  ;; universe for var2517:
  ;;   var2517!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2517!val!0 () var2517)
  ;; cardinality constraint:
  (forall ((x var2517)) (= x var2517!val!0))
  ;; -----------
  (define-fun var2172 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun null-var1224 () var1224
    var1224!val!1)
  (define-fun var2997 () var1224
    var1224!val!0)
  (define-fun var2997!1 () var1224
    var1224!val!2)
  (define-fun var1982 () var858
    var858-init)
  (define-fun var2105 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var840 ",") (- 1)) (num_splits var840 ",") (- 1))
     (num_splits var840 ",")))
  (define-fun var1982!1 () var858
    var858!val!0)
  (define-fun var840 () String
    ",")
  (define-fun var858-init () var858
    var858!val!0)
  (define-fun tabs/618735517 ((x!0 var1224)) var2517
    var2517!val!0)
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
  (define-fun cast-from-var858-to-var2517 ((x!0 var858)) var2517
    var2517!val!0)
  (define-fun <init>/-325640736 ((x!0 var858)) void
    void!val!0)
)
