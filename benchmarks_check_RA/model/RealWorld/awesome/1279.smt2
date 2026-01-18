(
  ;; universe for var1412:
  ;;   var1412!val!1 var1412!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1412!val!1 () var1412)
  (declare-fun var1412!val!0 () var1412)
  ;; cardinality constraint:
  (forall ((x var1412)) (or (= x var1412!val!1) (= x var1412!val!0)))
  ;; -----------
  (define-fun var3544 () Int
    0)
  (define-fun null-var1412 () var1412
    var1412!val!1)
  (define-fun var3356 () String
    (str.++ var1200!1 "Invalid subnet: " var79))
  (define-fun var1699 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var79 "/") (- 1)) (num_splits var79 "/") (- 1))
     (num_splits var79 "/")))
  (define-fun null-String () String
    "")
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var79 () String
    "/")
  (define-fun var2880 () var1412
    var1412!val!0)
  (define-fun var1200 () String
    String-init)
  (define-fun var687 () String
    (str.++ var1200!1 "Invalid subnet: "))
  (define-fun var3219 () String
    (str.++ var1200!1 "Invalid subnet: " var79))
  (define-fun var3750 () var1496
    var1496-init)
  (define-fun var1371 () String
    (let ((a!1 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits var79 "/") (- 1)))))
  (ite a!1 (split_rest var79 "/" (- (- 1) 1)) (split_at var79 "/" 0))))
  (define-fun var1200!1 () String
    "")
  (define-fun var687!1 () String
    "Invalid subnet: /")
  (define-fun var1200!2 () String
    "Invalid subnet: ")
  (define-fun var3219!1 () String
    "")
  (define-fun var3750!1 () var1496
    var1496!val!0)
  (define-fun var1496-init () var1496
    var1496!val!0)
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
  (define-fun <init>/875830710 ((x!0 var1496) (x!1 String)) void
    void!val!0)
)
