(
  ;; universe for var347:
  ;;   var347!val!1 var347!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var347!val!1 () var347)
  (declare-fun var347!val!0 () var347)
  ;; cardinality constraint:
  (forall ((x var347)) (or (= x var347!val!1) (= x var347!val!0)))
  ;; -----------
  ;; universe for var631:
  ;;   var631!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var631!val!0 () var631)
  ;; cardinality constraint:
  (forall ((x var631)) (= x var631!val!0))
  ;; -----------
  (define-fun null-var347 () var347
    var347!val!1)
  (define-fun var1829 () Int
    var3634)
  (define-fun var1829!1 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (+ var696 (str.len a!2) 1))))
  (define-fun var3420 () String
    (var347_s/45959816 var696))
  (define-fun var74 () Int
    0)
  (define-fun null-Int () Int
    1)
  (define-fun var3867 () var631
    (commander/-2133873678 var3064))
  (define-fun var1805 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (str.len a!2))))
  (define-fun var2306 () String
    (str.++ var3488 "\u{a}" (var347_s/45959816 var696)))
  (define-fun var3488 () String
    "")
  (define-fun var788!1 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3778 " ") (- 1)) (num_splits var3778 " ") (- 1))
     (num_splits var3778 " ")))
  (define-fun var2249 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (str.len a!2))))
  (define-fun var1036 () Int
    (getColumnSize/-165698927 (commander/-2133873678 var3064)))
  (define-fun var3013 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (+ var696 (str.len a!2)))))
  (define-fun var3634 () Int
    0)
  (define-fun var788 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3778 " ") (- 1)) (num_splits var3778 " ") (- 1))
     (num_splits var3778 " ")))
  (define-fun var3212 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (+ var3634 1 (str.len a!2)))))
  (define-fun var3458 () Int
    (+ var3634 1))
  (define-fun null-String () String
    " ")
  (define-fun var936 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (str.++ var3488 "\u{a}" (var347_s/45959816 var696) a!2))))
  (define-fun var2592 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3778 " " (- (- 1) 1))
                (split_at var3778 " " 0))))
  (str.len a!2))))
  (define-fun var396 () String
    (str.++ var3488 "\u{a}"))
  (define-fun var696 () Int
    2)
  (define-fun var74!1 () Int
    (+ 0 1))
  (define-fun var2050 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3778 " ") (- 1)))))
  (ite a!1 (split_rest var3778 " " (- (- 1) 1)) (split_at var3778 " " 0))))
  (define-fun var3064 () var347
    var347!val!0)
  (define-fun var3778 () String
    "")
  (define-fun var3488!1 () String
    "\u{a}")
  (define-fun var936!1 () String
    "\u{a} ")
  (define-fun var2306!1 () String
    "\u{a}")
  (define-fun var396!1 () String
    "\u{a}")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun commander/-2133873678 ((x!0 var347)) var631
    var631!val!0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun getColumnSize/-165698927 ((x!0 var631)) Int
    0)
  (define-fun var347_s/45959816 ((x!0 Int)) String
    "")
)
