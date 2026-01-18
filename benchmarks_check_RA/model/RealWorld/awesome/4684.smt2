(
  ;; universe for var2570:
  ;;   var2570!val!0 var2570!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2570!val!0 () var2570)
  (declare-fun var2570!val!1 () var2570)
  ;; cardinality constraint:
  (forall ((x var2570)) (or (= x var2570!val!0) (= x var2570!val!1)))
  ;; -----------
  ;; universe for var3940:
  ;;   var3940!val!0 var3940!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3940!val!0 () var3940)
  (declare-fun var3940!val!1 () var3940)
  ;; cardinality constraint:
  (forall ((x var3940)) (or (= x var3940!val!0) (= x var3940!val!1)))
  ;; -----------
  ;; universe for var1550:
  ;;   var1550!val!0 var1550!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1550!val!0 () var1550)
  (declare-fun var1550!val!1 () var1550)
  ;; cardinality constraint:
  (forall ((x var1550)) (or (= x var1550!val!0) (= x var1550!val!1)))
  ;; -----------
  (define-fun null-var3940 () var3940
    var3940!val!1)
  (define-fun var3494 () Bool
    (ite (= 1 0) true false))
  (define-fun var3795 () var1550
    (var3940_getValue/381491177 var1576))
  (define-fun var1738 () String
    (cast-from-var1550-to-String (var3940_getValue/381491177 var1576)))
  (define-fun var1122 () Bool
    (let ((a!1 (>= (num_splits (cast-from-var1550-to-String
                             (var3940_getValue/381491177 var1576))
                           " ")
               (- 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) a!1)))
(let ((a!3 (ite a!2
                (split_rest (cast-from-var1550-to-String
                              (var3940_getValue/381491177 var1576))
                            " "
                            (- (- 1) 1))
                (split_at (cast-from-var1550-to-String
                            (var3940_getValue/381491177 var1576))
                          " "
                          0))))
  (var2570_contains/1636690605 var1846 (cast-from-String-to-var1550 a!3))))))
  (define-fun var1846 () var2570
    var2570!val!0)
  (define-fun var1306 () String
    (let ((a!1 (>= (num_splits (cast-from-var1550-to-String
                             (var3940_getValue/381491177 var1576))
                           " ")
               (- 1))))
(let ((a!2 (and (> (- 1) 0) (= 0 (- (- 1) 1)) a!1)))
  (ite a!2
       (split_rest (cast-from-var1550-to-String
                     (var3940_getValue/381491177 var1576))
                   " "
                   (- (- 1) 1))
       (split_at (cast-from-var1550-to-String
                   (var3940_getValue/381491177 var1576))
                 " "
                 0)))))
  (define-fun null-var2570 () var2570
    var2570!val!1)
  (define-fun var1576 () var3940
    var3940!val!0)
  (define-fun cast-from-var1550-to-String ((x!0 var1550)) String
    (ite (= x!0 var1550!val!0) " "
      " "))
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
  (define-fun var2570_contains/1636690605 ((x!0 var2570) (x!1 var1550)) Bool
    true)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun cast-from-String-to-var1550 ((x!0 String)) var1550
    var1550!val!1)
  (define-fun var3940_getValue/381491177 ((x!0 var3940)) var1550
    var1550!val!0)
)
