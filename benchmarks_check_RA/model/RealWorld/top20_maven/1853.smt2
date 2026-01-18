(
  ;; universe for var423:
  ;;   var423!val!1 var423!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var423!val!1 () var423)
  (declare-fun var423!val!0 () var423)
  ;; cardinality constraint:
  (forall ((x var423)) (or (= x var423!val!1) (= x var423!val!0)))
  ;; -----------
  ;; universe for var2733:
  ;;   var2733!val!1 var2733!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2733!val!1 () var2733)
  (declare-fun var2733!val!0 () var2733)
  ;; cardinality constraint:
  (forall ((x var2733)) (or (= x var2733!val!1) (= x var2733!val!0)))
  ;; -----------
  (define-fun var119 () var423
    var423!val!0)
  (define-fun var2401 () String
    (toString/1403215111 var3365))
  (define-fun var1152 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/1403215111 var3365)
                                   (str.to_re "?"))
                    (- 1)))))
  (ite a!1
       (split_rest_re (toString/1403215111 var3365) (str.to_re "?") (- (- 1) 1))
       (split_at_re (toString/1403215111 var3365) (str.to_re "?") 0))))
  (define-fun var3365 () var2733
    var2733!val!0)
  (define-fun var1058!1 () (Array Int String)
    ((as const (Array Int String)) "?"))
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun null-var2733 () var2733
    var2733!val!1)
  (define-fun null-var423 () var423
    var423!val!1)
  (define-fun var1058 () (Array Int String)
    arr-String-init)
  (define-fun var406 () var3156
    var3156-init)
  (define-fun var1399 () Int
    (let ((a!1 (ite (< (num_splits_re (toString/1403215111 var3365) (str.to_re "?"))
                   (- 1))
                (num_splits_re (toString/1403215111 var3365) (str.to_re "?"))
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits_re (toString/1403215111 var3365) (str.to_re "?")))))
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var406!1 () var3156
    var3156!val!0)
  (define-fun var3156-init () var3156
    var3156!val!0)
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
    "?")
  (define-fun toString/1403215111 ((x!0 var2733)) String
    "?")
  (define-fun <init>/-325640736 ((x!0 var3156)) void
    void!val!0)
)
