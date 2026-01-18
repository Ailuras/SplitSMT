(
  ;; universe for var546:
  ;;   var546!val!2 var546!val!1 var546!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var546!val!2 () var546)
  (declare-fun var546!val!1 () var546)
  (declare-fun var546!val!0 () var546)
  ;; cardinality constraint:
  (forall ((x var546))
          (or (= x var546!val!2) (= x var546!val!1) (= x var546!val!0)))
  ;; -----------
  (define-fun var1012 () var546
    var546!val!0)
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var594 () Int
    (- 1))
  (define-fun var1345 () Int
    (- 1))
  (define-fun var2449 () var1403
    var1403-init)
  (define-fun var1132 () String
    String-init)
  (define-fun null-var546 () var546
    var546!val!1)
  (define-fun var520 () String
    (getPath/39698060 var1012))
  (define-fun var2564 () String
    (getPath/39698060 var1175))
  (define-fun var2014 () Int
    (let ((a!1 (ite (< (num_splits (getPath/39698060 var1012) "/") (- 1))
                (num_splits (getPath/39698060 var1012) "/")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (getPath/39698060 var1012) "/"))))
  (define-fun var1175 () var546
    var546!val!2)
  (define-fun var1132!1 () String
    "")
  (define-fun var2449!1 () var1403
    var1403!val!0)
  (define-fun var1403-init () var1403
    var1403!val!0)
  (define-fun var2318 () String
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
  (define-fun getPath/39698060 ((x!0 var546)) String
    (ite (= x!0 var546!val!0) "/"
      "/"))
  (define-fun <init>/875830710 ((x!0 var1403) (x!1 String)) void
    void!val!0)
)
