(
  ;; universe for var265:
  ;;   var265!val!0 var265!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var265!val!0 () var265)
  (declare-fun var265!val!1 () var265)
  ;; cardinality constraint:
  (forall ((x var265)) (or (= x var265!val!0) (= x var265!val!1)))
  ;; -----------
  (define-fun var902 () var265
    var265!val!0)
  (define-fun var3283 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2018 ", ") (- 1)))))
  (ite a!1 (split_rest var2018 ", " (- (- 1) 1)) (split_at var2018 ", " 0))))
  (define-fun null-String () String
    "!1!")
  (define-fun null-var265 () var265
    var265!val!1)
  (define-fun var1450 () var2578
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2018 ", ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2018 ", " (- (- 1) 1))
                (split_at var2018 ", " 0))))
  (var2578_valueOf/2134747254 var3680!class a!2))))
  (define-fun var844 () var3680
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2018 ", ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2018 ", " (- (- 1) 1))
                (split_at var2018 ", " 0))))
  (cast-from-var2578-to-var3680 (var2578_valueOf/2134747254 var3680!class a!2)))))
  (define-fun var273 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2018 ", ") (- 1)))))
  (ite a!1 (split_rest var2018 ", " (- (- 1) 1)) (split_at var2018 ", " 0))))
  (define-fun var2018 () String
    "!0!")
  (define-fun var3232 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2018 ", ") (- 1)))))
  (ite a!1 (split_rest var2018 ", " (- (- 1) 1)) (split_at var2018 ", " 1))))
  (define-fun var3680!class () ClassObject
    ClassObject!val!0)
  (define-fun var3283!1 () String
    "")
  (define-fun var3232!1 () String
    "")
  (define-fun var844!1 () var3680
    var3680!val!0)
  (define-fun var902!1 () var265
    var265!val!0)
  (define-fun var902!2 () var265
    var265!val!0)
  (define-fun var844!2 () var3680
    var3680!val!0)
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
  (define-fun cast-from-var2578-to-var3680 ((x!0 var2578)) var3680
    var3680!val!0)
  (define-fun cast-from-var3680-to-var3712 ((x!0 var3680)) var3712
    var3712!val!0)
  (define-fun var2578_valueOf/2134747254 ((x!0 ClassObject) (x!1 String)) var2578
    var2578!val!0)
  (define-fun var265_put/1464166817 ((x!0 var265) (x!1 var3712) (x!2 var3712)) var3712
    var3712!val!0)
  (define-fun cast-from-String-to-var3712 ((x!0 String)) var3712
    var3712!val!0)
)
