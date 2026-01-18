(
  ;; universe for var3923:
  ;;   var3923!val!1 var3923!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3923!val!1 () var3923)
  (declare-fun var3923!val!0 () var3923)
  ;; cardinality constraint:
  (forall ((x var3923)) (or (= x var3923!val!1) (= x var3923!val!0)))
  ;; -----------
  (define-fun null-var3923 () var3923
    var3923!val!1)
  (define-fun var54 () var3524
    var3524-init)
  (define-fun var3215 () String
    (select var2007 0))
  (define-fun var2007 () (Array Int String)
    ((as const (Array Int String)) ","))
  (define-fun var3374 () var939
    var939-init)
  (define-fun var654 () Int
    0)
  (define-fun var3907 () var3500
    var3500-init)
  (define-fun var3519 () var1672
    var1672-init)
  (define-fun var3449 () var3923
    var3923!val!0)
  (define-fun var1286 () String
    (select var2007 1))
  (define-fun var694 () Int
    (let ((a!1 (ite (< (num_splits (select var2007 1) ",") (- 1))
                (num_splits (select var2007 1) ",")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (select var2007 1) ","))))
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var1954 () var2501
    var2501-init)
  (define-fun var815 () Int
    (getLength-Arr-String-1 var2007))
  (define-fun var3374!1 () var939
    var939!val!0)
  (define-fun var1954!1 () var2501
    var2501!val!0)
  (define-fun var939-init () var939
    var939!val!0)
  (define-fun var3500-init () var3500
    var3500!val!0)
  (define-fun var3215!1 () String
    "")
  (define-fun var2501-init () var2501
    var2501!val!0)
  (define-fun var1672-init () var1672
    var1672!val!0)
  (define-fun var3524-init () var3524
    var3524!val!0)
  (define-fun var3449!1 () var3923
    var3923!val!1)
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
  (define-fun <init>/720541530 ((x!0 var2501)) void
    void!val!0)
  (define-fun <init>/-1681595970 ((x!0 var939) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-var3923-to-var1071 ((x!0 var3923)) var1071
    var1071!val!0)
  (define-fun printStackTrace/885456489 ((x!0 var1071)) void
    void!val!0)
)
