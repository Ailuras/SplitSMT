(
  ;; universe for var3135:
  ;;   var3135!val!0 var3135!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3135!val!0 () var3135)
  (declare-fun var3135!val!1 () var3135)
  ;; cardinality constraint:
  (forall ((x var3135)) (or (= x var3135!val!0) (= x var3135!val!1)))
  ;; -----------
  ;; universe for var28:
  ;;   var28!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var28!val!0 () var28)
  ;; cardinality constraint:
  (forall ((x var28)) (= x var28!val!0))
  ;; -----------
  (define-fun var367 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2549 " " (- (- 1) 1))
                (split_at var2549 " " 0))))
  (+ var1881 (str.len a!2)))))
  (define-fun var533 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var2549 " ") (- 1))
                     (num_splits var2549 " ")
                     (- 1))
                (num_splits var2549 " "))))
  (- a!1 1)))
  (define-fun var3076!1 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2549 " " (- (- 1) 1))
                (split_at var2549 " " 0))))
  (+ var1881 (str.len a!2)))))
  (define-fun var3246 () Int
    0)
  (define-fun null-Int () Int
    0)
  (define-fun var3498 () var3135
    var3135!val!0)
  (define-fun var2753 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2549 " " (- (- 1) 1))
                (split_at var2549 " " 0))))
  (str.len a!2))))
  (define-fun var2125 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2549 " ") (- 1)) (num_splits var2549 " ") (- 1))
     (num_splits var2549 " ")))
  (define-fun var2971 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2549 " ") (- 1)) (num_splits var2549 " ") (- 1))
     (num_splits var2549 " ")))
  (define-fun var2525 () var28
    (commander/-2133873678 var3498))
  (define-fun var992 () Int
    (+ var1881 1))
  (define-fun var3246!1 () Int
    (+ 0 1))
  (define-fun var2549 () String
    "")
  (define-fun null-String () String
    " ")
  (define-fun null-var3135 () var3135
    var3135!val!1)
  (define-fun var1943 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2549 " " (- (- 1) 1))
                (split_at var2549 " " 0))))
  (str.len a!2))))
  (define-fun var653 () Int
    (getColumnSize/-165698927 (commander/-2133873678 var3498)))
  (define-fun var3076 () Int
    var1881)
  (define-fun var3405 () Int
    1)
  (define-fun var3656 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
  (ite a!1 (split_rest var2549 " " (- (- 1) 1)) (split_at var2549 " " 0))))
  (define-fun var2208 () String
    "")
  (define-fun var2125!1 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2549 " ") (- 1)) (num_splits var2549 " ") (- 1))
     (num_splits var2549 " ")))
  (define-fun var1881 () Int
    (- 1))
  (define-fun var325 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2549 " " (- (- 1) 1))
                (split_at var2549 " " 0))))
  (str.len a!2))))
  (define-fun var203 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2549 " ") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2549 " " (- (- 1) 1))
                (split_at var2549 " " 0))))
  (+ var1881 1 (str.len a!2)))))
  (define-fun var2208!1 () String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
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
  (define-fun commander/-2133873678 ((x!0 var3135)) var28
    var28!val!0)
  (define-fun getColumnSize/-165698927 ((x!0 var28)) Int
    0)
)
