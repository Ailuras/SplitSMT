(
  ;; universe for var1445:
  ;;   var1445!val!0 var1445!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1445!val!0 () var1445)
  (declare-fun var1445!val!1 () var1445)
  ;; cardinality constraint:
  (forall ((x var1445)) (or (= x var1445!val!0) (= x var1445!val!1)))
  ;; -----------
  ;; universe for var1853:
  ;;   var1853!val!0 var1853!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1853!val!0 () var1853)
  (declare-fun var1853!val!1 () var1853)
  ;; cardinality constraint:
  (forall ((x var1853)) (or (= x var1853!val!0) (= x var1853!val!1)))
  ;; -----------
  ;; universe for var1045:
  ;;   var1045!val!0 var1045!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1045!val!0 () var1045)
  (declare-fun var1045!val!1 () var1045)
  ;; cardinality constraint:
  (forall ((x var1045)) (or (= x var1045!val!0) (= x var1045!val!1)))
  ;; -----------
  (define-fun var250 () var1853
    var1853!val!0)
  (define-fun var1381 () String
    (var1445_toString/-646077907 var3239))
  (define-fun var361 () Int
    0)
  (define-fun null-var1045 () var1045
    var1045!val!1)
  (define-fun null-var1445 () var1445
    var1445!val!1)
  (define-fun null-var1853 () var1853
    var1853!val!1)
  (define-fun var3239 () var1445
    var1445!val!0)
  (define-fun var1567 () Int
    (let ((a!1 (ite (< (num_splits (var1445_toString/-646077907 var3239) ",") (- 1))
                (num_splits (var1445_toString/-646077907 var3239) ",")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (var1445_toString/-646077907 var3239) ","))))
  (define-fun var652 () var1045
    var1045!val!0)
  (define-fun var1445_toString/-646077907 ((x!0 var1445)) String
    (ite (= x!0 var1445!val!0) ","
      ","))
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
)
