(
  ;; universe for var1095:
  ;;   var1095!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1095!val!0 () var1095)
  ;; cardinality constraint:
  (forall ((x var1095)) (= x var1095!val!0))
  ;; -----------
  ;; universe for var251:
  ;;   var251!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var251!val!0 () var251)
  ;; cardinality constraint:
  (forall ((x var251)) (= x var251!val!0))
  ;; -----------
  ;; universe for var3067:
  ;;   var3067!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3067!val!0 () var3067)
  ;; cardinality constraint:
  (forall ((x var3067)) (= x var3067!val!0))
  ;; -----------
  ;; universe for var1383:
  ;;   var1383!val!2 var1383!val!0 var1383!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1383!val!2 () var1383)
  (declare-fun var1383!val!0 () var1383)
  (declare-fun var1383!val!1 () var1383)
  ;; cardinality constraint:
  (forall ((x var1383))
          (or (= x var1383!val!2) (= x var1383!val!0) (= x var1383!val!1)))
  ;; -----------
  (define-fun null-var1383 () var1383
    var1383!val!1)
  (define-fun null-String () String
    "")
  (define-fun var2468!1 () var1383
    var1383!val!2)
  (define-fun var2684 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1863 ",") (- 1)) (num_splits var1863 ",") (- 1))
     (num_splits var1863 ",")))
  (define-fun var2704 () var251
    (morphoSpec/-974673759 var2468!1))
  (define-fun var452 () var251
    (var1095_morphFeatureSpec/-1525671968
  (tlp/-1510366313 (cast-from-var1383-to-var3067 var2468))))
  (define-fun var1511 () String
    (toString/1418588163 (morphoSpec/-974673759 var2468!1)))
  (define-fun var1863 () String
    ",")
  (define-fun var2468 () var1383
    var1383!val!0)
  (define-fun var3129 () Int
    0)
  (define-fun var2336 () var1095
    (tlp/-1510366313 (cast-from-var1383-to-var3067 var2468)))
  (define-fun tlp/-1510366313 ((x!0 var3067)) var1095
    var1095!val!0)
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
  (define-fun cast-from-var1383-to-var3067 ((x!0 var1383)) var3067
    var3067!val!0)
  (define-fun var1095_morphFeatureSpec/-1525671968 ((x!0 var1095)) var251
    var251!val!0)
  (define-fun morphoSpec/-974673759 ((x!0 var1383)) var251
    var251!val!0)
  (define-fun toString/1418588163 ((x!0 var251)) String
    "")
)
