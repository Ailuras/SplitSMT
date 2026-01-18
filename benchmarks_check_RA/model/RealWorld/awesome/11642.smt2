(
  ;; universe for var2396:
  ;;   var2396!val!1 var2396!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2396!val!1 () var2396)
  (declare-fun var2396!val!0 () var2396)
  ;; cardinality constraint:
  (forall ((x var2396)) (or (= x var2396!val!1) (= x var2396!val!0)))
  ;; -----------
  (define-fun var802 () String
    (select var582 0))
  (define-fun var1915 () Int
    (let ((a!1 (ite (< (num_splits (select var582 1) ",") (- 1))
                (num_splits (select var582 1) ",")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (select var582 1) ","))))
  (define-fun var3331 () Int
    0)
  (define-fun var2158 () var2396
    var2396!val!0)
  (define-fun null-var2396 () var2396
    var2396!val!1)
  (define-fun var2658 () var92
    var92-init)
  (define-fun var2281 () String
    (select var582 1))
  (define-fun var1047 () var699
    var699-init)
  (define-fun var2679 () var282
    var282-init)
  (define-fun var582 () (Array Int String)
    ((as const (Array Int String)) ","))
  (define-fun var2670 () Int
    (getLength-Arr-String-1 var582))
  (define-fun var2978 () var1622
    var1622-init)
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var2028 () var2333
    var2333-init)
  (define-fun var2158!1 () var2396
    var2396!val!1)
  (define-fun var2978!1 () var1622
    var1622!val!0)
  (define-fun var1622-init () var1622
    var1622!val!0)
  (define-fun var2028!1 () var2333
    var2333!val!0)
  (define-fun var699-init () var699
    var699!val!0)
  (define-fun var92-init () var92
    var92!val!0)
  (define-fun var802!1 () String
    "")
  (define-fun var2333-init () var2333
    var2333!val!0)
  (define-fun var282-init () var282
    var282!val!0)
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    2)
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
  (define-fun <init>/720541530 ((x!0 var2333)) void
    void!val!0)
  (define-fun <init>/-1681595970 ((x!0 var1622) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-var2396-to-var3930 ((x!0 var2396)) var3930
    var3930!val!0)
  (define-fun printStackTrace/885456489 ((x!0 var3930)) void
    void!val!0)
)
