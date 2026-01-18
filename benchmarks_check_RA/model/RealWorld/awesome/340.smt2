(
  ;; universe for var1528:
  ;;   var1528!val!1 var1528!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1528!val!1 () var1528)
  (declare-fun var1528!val!0 () var1528)
  ;; cardinality constraint:
  (forall ((x var1528)) (or (= x var1528!val!1) (= x var1528!val!0)))
  ;; -----------
  ;; universe for var1529:
  ;;   var1529!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1529!val!0 () var1529)
  ;; cardinality constraint:
  (forall ((x var1529)) (= x var1529!val!0))
  ;; -----------
  (define-fun var814 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var931 " ") (- 1)) (num_splits var931 " ") (- 1))
     (num_splits var931 " ")))
  (define-fun var1703 () Int
    var381)
  (define-fun var1331 () Int
    1)
  (define-fun var267 () var1529
    (commander/-2133873678 var1630))
  (define-fun var268 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var931 " ") (- 1)))))
(let ((a!2 (ite a!1 (split_rest var931 " " (- (- 1) 1)) (split_at var931 " " 0))))
  (str.len a!2))))
  (define-fun var3343!1 () Int
    (+ 0 1))
  (define-fun var3035 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var931 " ") (- 1)))))
(let ((a!2 (ite a!1 (split_rest var931 " " (- (- 1) 1)) (split_at var931 " " 0))))
  (+ var381 (str.len a!2)))))
  (define-fun var381 () Int
    1)
  (define-fun var1630 () var1528
    var1528!val!0)
  (define-fun var3618 () String
    "")
  (define-fun var1703!1 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var931 " ") (- 1)))))
(let ((a!2 (ite a!1 (split_rest var931 " " (- (- 1) 1)) (split_at var931 " " 0))))
  (+ var381 (str.len a!2)))))
  (define-fun var247!1 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var931 " ") (- 1)) (num_splits var931 " ") (- 1))
     (num_splits var931 " ")))
  (define-fun var2211 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var931 " ") (- 1)))))
(let ((a!2 (ite a!1 (split_rest var931 " " (- (- 1) 1)) (split_at var931 " " 0))))
  (str.len a!2))))
  (define-fun var2422 () Int
    (getColumnSize/-165698927 (commander/-2133873678 var1630)))
  (define-fun var3343 () Int
    0)
  (define-fun null-String () String
    " ")
  (define-fun null-var1528 () var1528
    var1528!val!1)
  (define-fun var1595 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var931 " ") (- 1)))))
  (ite a!1 (split_rest var931 " " (- (- 1) 1)) (split_at var931 " " 0))))
  (define-fun var931 () String
    "")
  (define-fun var247 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var931 " ") (- 1)) (num_splits var931 " ") (- 1))
     (num_splits var931 " ")))
  (define-fun var881 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var931 " ") (- 1))
                     (num_splits var931 " ")
                     (- 1))
                (num_splits var931 " "))))
  (- a!1 1)))
  (define-fun null-Int () Int
    0)
  (define-fun var3618!1 () String
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
  (define-fun getColumnSize/-165698927 ((x!0 var1529)) Int
    (- 1))
  (define-fun commander/-2133873678 ((x!0 var1528)) var1529
    var1529!val!0)
)
