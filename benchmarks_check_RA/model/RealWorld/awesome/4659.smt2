(
  ;; universe for var2350:
  ;;   var2350!val!1 var2350!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2350!val!1 () var2350)
  (declare-fun var2350!val!0 () var2350)
  ;; cardinality constraint:
  (forall ((x var2350)) (or (= x var2350!val!1) (= x var2350!val!0)))
  ;; -----------
  ;; universe for var3904:
  ;;   var3904!val!0 var3904!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3904!val!0 () var3904)
  (declare-fun var3904!val!1 () var3904)
  ;; cardinality constraint:
  (forall ((x var3904)) (or (= x var3904!val!0) (= x var3904!val!1)))
  ;; -----------
  ;; universe for var57:
  ;;   var57!val!0 var57!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var57!val!0 () var57)
  (declare-fun var57!val!1 () var57)
  ;; cardinality constraint:
  (forall ((x var57)) (or (= x var57!val!0) (= x var57!val!1)))
  ;; -----------
  (define-fun null-var57 () var57
    var57!val!1)
  (define-fun var3450 () var57
    var57!val!0)
  (define-fun null-var3904 () var3904
    var3904!val!1)
  (define-fun var2712 () Bool
    (ite (= 1 1) true false))
  (define-fun var1155 () String
    (let ((a!1 (>= (num_splits (cast-from-var2350-to-String
                             (var3904_getValue/381491177 var3003))
                           " ")
               (- 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) a!1)))
  (ite a!2
       (split_rest (cast-from-var2350-to-String
                     (var3904_getValue/381491177 var3003))
                   " "
                   (- (- 1) 1))
       (split_at (cast-from-var2350-to-String
                   (var3904_getValue/381491177 var3003))
                 " "
                 0)))))
  (define-fun var3003 () var3904
    var3904!val!0)
  (define-fun var1499 () var2350
    (var3904_getValue/381491177 var3003))
  (define-fun var3940 () String
    (cast-from-var2350-to-String (var3904_getValue/381491177 var3003)))
  (define-fun var3859 () Bool
    (let ((a!1 (>= (num_splits (cast-from-var2350-to-String
                             (var3904_getValue/381491177 var3003))
                           " ")
               (- 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) a!1)))
(let ((a!3 (ite a!2
                (split_rest (cast-from-var2350-to-String
                              (var3904_getValue/381491177 var3003))
                            " "
                            (- (- 1) 1))
                (split_at (cast-from-var2350-to-String
                            (var3904_getValue/381491177 var3003))
                          " "
                          0))))
  (var57_contains/1636690605 var3450 (cast-from-String-to-var2350 a!3))))))
  (define-fun var3904_getValue/381491177 ((x!0 var3904)) var2350
    var2350!val!0)
  (define-fun cast-from-String-to-var2350 ((x!0 String)) var2350
    var2350!val!1)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 32)))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 0))
      " "
      " "))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun var57_contains/1636690605 ((x!0 var57) (x!1 var2350)) Bool
    false)
  (define-fun cast-from-var2350-to-String ((x!0 var2350)) String
    (ite (= x!0 var2350!val!0) " "
      " "))
)
