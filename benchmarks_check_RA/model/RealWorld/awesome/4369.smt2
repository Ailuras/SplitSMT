(
  ;; universe for var267:
  ;;   var267!val!0 var267!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var267!val!0 () var267)
  (declare-fun var267!val!1 () var267)
  ;; cardinality constraint:
  (forall ((x var267)) (or (= x var267!val!0) (= x var267!val!1)))
  ;; -----------
  (define-fun null-var267 () var267
    var267!val!1)
  (define-fun var3435 () Int
    0)
  (define-fun var1845 () var267
    var267!val!0)
  (define-fun var341 () String
    "utf-8")
  (define-fun var1602 () String
    (getContentType/125337655 var1845))
  (define-fun var127 () Int
    (let ((a!1 (ite (< (num_splits (getContentType/125337655 var1845) ";") (- 1))
                (num_splits (getContentType/125337655 var1845) ";")
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits (getContentType/125337655 var1845) ";"))))
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
  (define-fun getContentType/125337655 ((x!0 var267)) String
    (ite (= x!0 var267!val!0) ";"
      ";"))
)
