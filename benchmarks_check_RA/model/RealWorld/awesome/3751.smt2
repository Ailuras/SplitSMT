(
  ;; universe for var3543:
  ;;   var3543!val!1 var3543!val!0 var3543!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3543!val!1 () var3543)
  (declare-fun var3543!val!0 () var3543)
  (declare-fun var3543!val!2 () var3543)
  ;; cardinality constraint:
  (forall ((x var3543))
          (or (= x var3543!val!1) (= x var3543!val!0) (= x var3543!val!2)))
  ;; -----------
  ;; universe for var2214:
  ;;   var2214!val!0 var2214!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2214!val!0 () var2214)
  (declare-fun var2214!val!1 () var2214)
  ;; cardinality constraint:
  (forall ((x var2214)) (or (= x var2214!val!0) (= x var2214!val!1)))
  ;; -----------
  (define-fun var951 () (Array Int var3543)
    arr-var3543-init)
  (define-fun var3211 () Int
    (let ((a!1 (ite (< (num_splits_re var3808 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var3808 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var3808 (str.to_re "\u{a}")))))
  (define-fun null-String () String
    "A")
  (define-fun var951!1 () (Array Int var3543)
    (store ((as const (Array Int var3543)) var3543!val!0) 27 var3543!val!1))
  (define-fun var1791 () var2214
    var2214!val!0)
  (define-fun null-__Array__Int__var3543__ () (Array Int var3543)
    ((as const (Array Int var3543)) var3543!val!2))
  (define-fun var3808 () String
    "Identification of Mentions")
  (define-fun null-var2214 () var2214
    var2214!val!1)
  (define-fun var1496 () Int
    0)
  (define-fun var3098 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re var3808 (str.to_re "\u{a}")) (- 1)))))
  (ite a!1
       (split_rest_re var3808 (str.to_re "\u{a}") (- (- 1) 1))
       (split_at_re var3808 (str.to_re "\u{a}") 0))))
  (define-fun var3766 () Bool
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re var3808 (str.to_re "\u{a}")) (- 1)))))
(let ((a!2 (ite a!1
                (split_rest_re var3808 (str.to_re "\u{a}") (- (- 1) 1))
                (split_at_re var3808 (str.to_re "\u{a}") 0))))
  (str.prefixof "Identification of Mentions" a!2))))
  (define-fun null-Bool () Bool
    true)
  (define-fun var3185 () Bool
    false)
  (define-fun arr-var3543-init () (Array Int var3543)
    ((as const (Array Int var3543)) var3543!val!0))
  (define-fun var1791!1 () var2214
    var2214!val!0)
  (define-fun var951!2 () (Array Int var3543)
    ((as const (Array Int var3543)) var3543!val!0))
  (define-fun var3098!1 () String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    1)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "Identification of Mentions")
  (define-fun cast-from-String-to-var3543 ((x!0 String)) var3543
    var3543!val!0)
  (define-fun var2163_log/2127824580 ((x!0 (Array Int var3543))) void
    void!val!0)
  (define-fun info/114590825 ((x!0 var2214) (x!1 String)) void
    void!val!0)
)
