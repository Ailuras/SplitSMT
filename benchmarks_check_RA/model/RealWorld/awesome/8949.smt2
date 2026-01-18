(
  ;; universe for var2567:
  ;;   var2567!val!1 var2567!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2567!val!1 () var2567)
  (declare-fun var2567!val!0 () var2567)
  ;; cardinality constraint:
  (forall ((x var2567)) (or (= x var2567!val!1) (= x var2567!val!0)))
  ;; -----------
  (define-fun var3315 () String
    "\u{a}")
  (define-fun var2924 () String
    var3378!1)
  (define-fun var3378 () String
    String-init)
  (define-fun null-String () String
    "")
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var73 () Int
    0)
  (define-fun var2575 () var2567
    var2567!val!0)
  (define-fun var1979 () Int
    (let ((a!1 (ite (< (num_splits_re var3315 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var3315 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var3315 (str.to_re "\u{a}")))))
  (define-fun null-var2567 () var2567
    var2567!val!1)
  (define-fun var2644 () Bool
    true)
  (define-fun null-Bool () Bool
    false)
  (define-fun var3378!1 () String
    "")
  (define-fun var2575!1 () var2567
    var2567!val!1)
  (define-fun var2924!1 () String
    "")
  (define-fun String-init () String
    "")
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
  (define-fun info/114590825 ((x!0 var2567) (x!1 String)) void
    void!val!0)
)
