(
  ;; universe for var757:
  ;;   var757!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var757!val!0 () var757)
  ;; cardinality constraint:
  (forall ((x var757)) (= x var757!val!0))
  ;; -----------
  ;; universe for var810:
  ;;   var810!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var810!val!0 () var810)
  ;; cardinality constraint:
  (forall ((x var810)) (= x var810!val!0))
  ;; -----------
  ;; universe for var1136:
  ;;   var1136!val!0 var1136!val!1 var1136!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1136!val!0 () var1136)
  (declare-fun var1136!val!1 () var1136)
  (declare-fun var1136!val!2 () var1136)
  ;; cardinality constraint:
  (forall ((x var1136))
          (or (= x var1136!val!0) (= x var1136!val!1) (= x var1136!val!2)))
  ;; -----------
  ;; universe for var3009:
  ;;   var3009!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3009!val!0 () var3009)
  ;; cardinality constraint:
  (forall ((x var3009)) (= x var3009!val!0))
  ;; -----------
  (define-fun var3180 () var3009
    (var757_morphFeatureSpec/-1525671968
  (tlp/-1510366313 (cast-from-var1136-to-var810 var3336))))
  (define-fun var2187 () var757
    (tlp/-1510366313 (cast-from-var1136-to-var810 var3336)))
  (define-fun var3336!1 () var1136
    var1136!val!2)
  (define-fun var3831 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1836 ",") (- 1)) (num_splits var1836 ",") (- 1))
     (num_splits var1836 ",")))
  (define-fun null-String () String
    "")
  (define-fun var208 () Int
    0)
  (define-fun var2971 () String
    (toString/1418588163 (morphoSpec/1364860559 var3336!1)))
  (define-fun null-var1136 () var1136
    var1136!val!1)
  (define-fun var1338 () var3009
    (morphoSpec/1364860559 var3336!1))
  (define-fun var1836 () String
    ",")
  (define-fun var3336 () var1136
    var1136!val!0)
  (define-fun var757_morphFeatureSpec/-1525671968 ((x!0 var757)) var3009
    var3009!val!0)
  (define-fun cast-from-var1136-to-var810 ((x!0 var1136)) var810
    var810!val!0)
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
  (define-fun tlp/-1510366313 ((x!0 var810)) var757
    var757!val!0)
  (define-fun morphoSpec/1364860559 ((x!0 var1136)) var3009
    var3009!val!0)
  (define-fun toString/1418588163 ((x!0 var3009)) String
    "")
)
