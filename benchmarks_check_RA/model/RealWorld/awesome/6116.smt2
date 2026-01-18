(
  ;; universe for var1902:
  ;;   var1902!val!0 var1902!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1902!val!0 () var1902)
  (declare-fun var1902!val!1 () var1902)
  ;; cardinality constraint:
  (forall ((x var1902)) (or (= x var1902!val!0) (= x var1902!val!1)))
  ;; -----------
  (define-fun var3653 () (Array Int Int)
    ((as const (Array Int Int)) 3))
  (define-fun var3519 () Int
    0)
  (define-fun var853 () String
    var921)
  (define-fun var1372 () var1902
    var1902!val!0)
  (define-fun var2908 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var921 ";") (- 1))
                     (num_splits var921 ";")
                     (- 1))
                (num_splits var921 ";"))))
  (var198_max/1360571700 a!1 (getLength-Arr-Int-1 var3653))))
  (define-fun var3451 () (Array Int Int)
    arr-Int-init)
  (define-fun var3463 () String
    var921)
  (define-fun null-String () String
    ";")
  (define-fun var1685 () Int
    (getLength-Arr-Int-1 var3653))
  (define-fun var834 () Int
    (str.len var921))
  (define-fun var921 () String
    "")
  (define-fun var2306 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var921 ";") (- 1)) (num_splits var921 ";") (- 1))
     (num_splits var921 ";")))
  (define-fun null-__Array__Int__Int__ () (Array Int Int)
    (store ((as const (Array Int Int)) 3) 0 4))
  (define-fun null-var1902 () var1902
    var1902!val!1)
  (define-fun var2813 () String
    "")
  (define-fun arr-Int-init () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
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
  (define-fun getLength-Arr-Int-1 ((x!0 (Array Int Int))) Int
    3)
  (define-fun var198_max/1360571700 ((x!0 Int) (x!1 Int)) Int
    0)
)
