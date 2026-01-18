(
  ;; universe for var2133:
  ;;   var2133!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2133!val!0 () var2133)
  ;; cardinality constraint:
  (forall ((x var2133)) (= x var2133!val!0))
  ;; -----------
  ;; universe for var2436:
  ;;   var2436!val!0 var2436!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2436!val!0 () var2436)
  (declare-fun var2436!val!1 () var2436)
  ;; cardinality constraint:
  (forall ((x var2436)) (or (= x var2436!val!0) (= x var2436!val!1)))
  ;; -----------
  ;; universe for var345:
  ;;   var345!val!1 var345!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var345!val!1 () var345)
  (declare-fun var345!val!0 () var345)
  ;; cardinality constraint:
  (forall ((x var345)) (or (= x var345!val!1) (= x var345!val!0)))
  ;; -----------
  ;; universe for var2402:
  ;;   var2402!val!1 var2402!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2402!val!1 () var2402)
  (declare-fun var2402!val!0 () var2402)
  ;; cardinality constraint:
  (forall ((x var2402)) (or (= x var2402!val!1) (= x var2402!val!0)))
  ;; -----------
  ;; universe for var2407:
  ;;   var2407!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2407!val!0 () var2407)
  ;; cardinality constraint:
  (forall ((x var2407)) (= x var2407!val!0))
  ;; -----------
  ;; universe for var887:
  ;;   var887!val!1 var887!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var887!val!1 () var887)
  (declare-fun var887!val!0 () var887)
  ;; cardinality constraint:
  (forall ((x var887)) (or (= x var887!val!1) (= x var887!val!0)))
  ;; -----------
  (define-fun var2205 () var887
    var887!val!0)
  (define-fun null-var2402 () var2402
    var2402!val!1)
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var209 () var1928
    (charset/-811599492 var2205))
  (define-fun var2498 () (Array Int Int)
    arr-Int-init)
  (define-fun null-var345 () var345
    var345!val!1)
  (define-fun arr-Int-init () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun null-var2436 () var2436
    var2436!val!1)
  (define-fun var1610 () Int
    (read/-1845806611 (cast-from-var2407-to-var2133 var1073!1) arr-Int-init))
  (define-fun var423 () String
    var3067!1)
  (define-fun var1073 () var2407
    var2407-init)
  (define-fun var156 () var345
    var345!val!0)
  (define-fun null-var887 () var887
    var887!val!1)
  (define-fun var972 () Int
    0)
  (define-fun var3067 () String
    String-init)
  (define-fun var3458 () var2402
    var2402!val!0)
  (define-fun var1128 () Int
    (let ((a!1 (< (num_splits_re var3067!1
                             (re.union (str.to_re "\u{d}\u{a}")
                                       (str.to_re "\u{a}\u{d}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var3067!1
                               (re.union (str.to_re "\u{d}\u{a}")
                                         (str.to_re "\u{a}\u{d}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var3067!1
                      (re.union (str.to_re "\u{d}\u{a}")
                                (str.to_re "\u{a}\u{d}")))))))
  (define-fun var1820 () var2436
    var2436!val!0)
  (define-fun var1073!1 () var2407
    var2407!val!0)
  (define-fun var3067!1 () String
    "")
  (define-fun var2407-init () var2407
    var2407!val!0)
  (define-fun var209!1 () var1928
    var1928!val!0)
  (define-fun String-init () String
    "")
  (define-fun var156!1 () var345
    var345!val!1)
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
  (define-fun cast-from-var2407-to-var2133 ((x!0 var2407)) var2133
    var2133!val!0)
  (define-fun read/-1845806611 ((x!0 var2133) (x!1 (Array Int Int))) Int
    (- 1))
  (define-fun charset/-811599492 ((x!0 var887)) var1928
    var1928!val!0)
  (define-fun cast-from-var345-to-var2064 ((x!0 var345)) var2064
    var2064!val!0)
  (define-fun <init>/-1518332612 ((x!0 var2407) (x!1 var2064) (x!2 var1928)) void
    void!val!0)
)
