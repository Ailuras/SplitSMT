(
  ;; universe for var3344:
  ;;   var3344!val!0 var3344!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3344!val!0 () var3344)
  (declare-fun var3344!val!1 () var3344)
  ;; cardinality constraint:
  (forall ((x var3344)) (or (= x var3344!val!0) (= x var3344!val!1)))
  ;; -----------
  (define-fun var191 () Int
    (size/-1863229846 var3932))
  (define-fun var2747 () String
    ":")
  (define-fun null-var3344 () var3344
    var3344!val!1)
  (define-fun var2078 () Int
    (mod (size/-1863229846 var3932) 2))
  (define-fun null-String () String
    "=")
  (define-fun var1813 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2747 ":") (- 1)) (num_splits var2747 ":") (- 1))
     (num_splits var2747 ":")))
  (define-fun var3063 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2747 "=") (- 1)) (num_splits var2747 "=") (- 1))
     (num_splits var2747 "=")))
  (define-fun var3932 () var3344
    var3344!val!0)
  (define-fun var2747!1 () String
    "")
  (define-fun var3932!1 () var3344
    var3344!val!0)
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
  (define-fun size/-1863229846 ((x!0 var3344)) Int
    0)
  (define-fun cast-from-String-to-var3888 ((x!0 String)) var3888
    var3888!val!0)
  (define-fun add/1770215592 ((x!0 var3344) (x!1 var3888)) Bool
    false)
)
