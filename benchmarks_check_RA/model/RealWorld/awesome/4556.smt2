(
  ;; universe for var3277:
  ;;   var3277!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3277!val!0 () var3277)
  ;; cardinality constraint:
  (forall ((x var3277)) (= x var3277!val!0))
  ;; -----------
  ;; universe for var1154:
  ;;   var1154!val!1 var1154!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1154!val!1 () var1154)
  (declare-fun var1154!val!0 () var1154)
  ;; cardinality constraint:
  (forall ((x var1154)) (or (= x var1154!val!1) (= x var1154!val!0)))
  ;; -----------
  ;; universe for var782:
  ;;   var782!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var782!val!0 () var782)
  ;; cardinality constraint:
  (forall ((x var782)) (= x var782!val!0))
  ;; -----------
  ;; universe for var3626:
  ;;   var3626!val!1 var3626!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3626!val!1 () var3626)
  (declare-fun var3626!val!0 () var3626)
  ;; cardinality constraint:
  (forall ((x var3626)) (or (= x var3626!val!1) (= x var3626!val!0)))
  ;; -----------
  (define-fun var3925 () Int
    0)
  (define-fun null-var1154 () var1154
    var1154!val!1)
  (define-fun var2789 () var782
    var782-FINEST)
  (define-fun var19 () String
    ",")
  (define-fun null-String () String
    "")
  (define-fun var3610 () Bool
    (isLoggable/-616065502 var1154-log var782-FINEST))
  (define-fun var2478 () var1154
    var1154!val!0)
  (define-fun var629 () var3277
    var1154-log)
  (define-fun var782-FINEST () var782
    var782!val!0)
  (define-fun var664 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var19 ",") (- 1)) (num_splits var19 ",") (- 1))
     (num_splits var19 ",")))
  (define-fun null-var3626 () var3626
    var3626!val!1)
  (define-fun var3271 () var3626
    var3626!val!0)
  (define-fun var1154-log () var3277
    var3277!val!0)
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
  (define-fun isLoggable/-616065502 ((x!0 var3277) (x!1 var782)) Bool
    false)
)
