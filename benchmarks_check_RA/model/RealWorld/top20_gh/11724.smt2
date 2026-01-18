(
  ;; universe for var1468:
  ;;   var1468!val!0 var1468!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1468!val!0 () var1468)
  (declare-fun var1468!val!1 () var1468)
  ;; cardinality constraint:
  (forall ((x var1468)) (or (= x var1468!val!0) (= x var1468!val!1)))
  ;; -----------
  ;; universe for var2487:
  ;;   var2487!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2487!val!0 () var2487)
  ;; cardinality constraint:
  (forall ((x var2487)) (= x var2487!val!0))
  ;; -----------
  (define-fun var1049 () var2487
    (var1468_getServiceModel/1214805812 var255))
  (define-fun null-var1468 () var1468
    var1468!val!1)
  (define-fun var255 () var1468
    var1468!val!0)
  (define-fun var1461 () Int
    (let ((a!1 (ite (< (num_splits (var1468_getTargetServiceUniqueName/-1786712159
                                 var255)
                               "/")
                   (- 1))
                (num_splits (var1468_getTargetServiceUniqueName/-1786712159
                              var255)
                            "/")
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits (var1468_getTargetServiceUniqueName/-1786712159 var255) "/"))))
  (define-fun var691 () String
    (var1468_getTargetServiceUniqueName/-1786712159 var255))
  (define-fun var2035 () String
    null-String)
  (define-fun null-var2487 () var2487
    var2487!val!0)
  (define-fun null-String () String
    "")
  (define-fun var1468_getTargetServiceUniqueName/-1786712159 ((x!0 var1468)) String
    (ite (= x!0 var1468!val!0) "/"
      "/"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
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
  (define-fun var1468_getServiceModel/1214805812 ((x!0 var1468)) var2487
    var2487!val!0)
)
