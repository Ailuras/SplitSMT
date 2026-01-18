(
  ;; universe for var1923:
  ;;   var1923!val!1 var1923!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1923!val!1 () var1923)
  (declare-fun var1923!val!0 () var1923)
  ;; cardinality constraint:
  (forall ((x var1923)) (or (= x var1923!val!1) (= x var1923!val!0)))
  ;; -----------
  (define-fun var3243 () String
    "")
  (define-fun var2096 () Int
    (getLength-Arr-String-1 var3242))
  (define-fun var1256 () (Array Int String)
    arr-String-init)
  (define-fun var766 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3243 ";") (- 1)) (num_splits var3243 ";") (- 1))
     (num_splits var3243 ";")))
  (define-fun null-String () String
    ";")
  (define-fun var1350 () String
    "")
  (define-fun var3242 () (Array Int String)
    ((as const (Array Int String)) ";"))
  (define-fun var3036 () Int
    0)
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var1242 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3243 ";") (- 1))
                     (num_splits var3243 ";")
                     (- 1))
                (num_splits var3243 ";"))))
  (var423_max/1360571700 a!1 (getLength-Arr-String-1 var3242))))
  (define-fun var2207 () Int
    (str.len var3243))
  (define-fun var841 () var1923
    var1923!val!0)
  (define-fun null-var1923 () var1923
    var1923!val!1)
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    3)
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
  (define-fun var423_max/1360571700 ((x!0 Int) (x!1 Int)) Int
    0)
)
