(
  ;; universe for var1219:
  ;;   var1219!val!1 var1219!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1219!val!1 () var1219)
  (declare-fun var1219!val!0 () var1219)
  ;; cardinality constraint:
  (forall ((x var1219)) (or (= x var1219!val!1) (= x var1219!val!0)))
  ;; -----------
  ;; universe for var2963:
  ;;   var2963!val!2 var2963!val!0 var2963!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2963!val!2 () var2963)
  (declare-fun var2963!val!0 () var2963)
  (declare-fun var2963!val!1 () var2963)
  ;; cardinality constraint:
  (forall ((x var2963))
          (or (= x var2963!val!2) (= x var2963!val!0) (= x var2963!val!1)))
  ;; -----------
  (define-fun var3816!1 () (Array Int var2963)
    (store ((as const (Array Int var2963)) var2963!val!1) 0 var2963!val!0))
  (define-fun var0 () Int
    (let ((a!1 (ite (< (num_splits_re var2604 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var2604 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var2604 (str.to_re "\u{a}")))))
  (define-fun var292 () Int
    0)
  (define-fun null-String () String
    "A")
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var1643 () var1219
    var1219!val!0)
  (define-fun var1525 () String
    String-init)
  (define-fun var3816 () (Array Int var2963)
    arr-var2963-init)
  (define-fun var269 () String
    var1525!1)
  (define-fun var2815 () String
    var1525!1)
  (define-fun null-__Array__Int__var2963__ () (Array Int var2963)
    ((as const (Array Int var2963)) var2963!val!2))
  (define-fun null-var1219 () var1219
    var1219!val!1)
  (define-fun var2604 () String
    "")
  (define-fun null-Bool () Bool
    false)
  (define-fun var1599 () Bool
    true)
  (define-fun var1525!1 () String
    "")
  (define-fun var1643!1 () var1219
    var1219!val!1)
  (define-fun arr-var2963-init () (Array Int var2963)
    ((as const (Array Int var2963)) var2963!val!0))
  (define-fun String-init () String
    "")
  (define-fun var3816!2 () (Array Int var2963)
    ((as const (Array Int var2963)) var2963!val!0))
  (define-fun var2815!1 () String
    "")
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
  (define-fun cast-from-String-to-var2963 ((x!0 String)) var2963
    var2963!val!0)
  (define-fun info/114590825 ((x!0 var1219) (x!1 String)) void
    void!val!0)
  (define-fun var1648_log/2127824580 ((x!0 (Array Int var2963))) void
    void!val!0)
)
