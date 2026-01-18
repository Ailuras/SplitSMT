(
  ;; universe for var2121:
  ;;   var2121!val!0 var2121!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2121!val!0 () var2121)
  (declare-fun var2121!val!1 () var2121)
  ;; cardinality constraint:
  (forall ((x var2121)) (or (= x var2121!val!0) (= x var2121!val!1)))
  ;; -----------
  (define-fun var529 () var2726
    var2726-init)
  (define-fun null-var2121 () var2121
    var2121!val!1)
  (define-fun var19 () Int
    (let ((a!1 (ite (< (num_splits_re var1620 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var1620 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var1620 (str.to_re "\u{a}")))))
  (define-fun var3924 () var2121
    var2121!val!0)
  (define-fun null-String () String
    "")
  (define-fun var1620 () String
    "\u{a}")
  (define-fun var808 () Int
    0)
  (define-fun var529!1 () var2726
    var2726!val!0)
  (define-fun var2726-init () var2726
    var2726!val!0)
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
  (define-fun <init>/-325640736 ((x!0 var2726)) void
    void!val!0)
)
