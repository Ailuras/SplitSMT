(
  ;; universe for var1017:
  ;;   var1017!val!1 var1017!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1017!val!1 () var1017)
  (declare-fun var1017!val!0 () var1017)
  ;; cardinality constraint:
  (forall ((x var1017)) (or (= x var1017!val!1) (= x var1017!val!0)))
  ;; -----------
  (define-fun var3370 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2380 "=") (- 1)))))
  (ite a!1 (split_rest var2380 "=" (- (- 1) 1)) (split_at var2380 "=" 0))))
  (define-fun null-String () String
    "!1!")
  (define-fun null-var1017 () var1017
    var1017!val!1)
  (define-fun var3144 () var3598
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2380 "=") (- 1))))
      (a!3 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2380 "=") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2380 "=" (- (- 1) 1))
                (split_at var2380 "=" 0)))
      (a!4 (ite a!3
                (split_rest var2380 "=" (- (- 1) 1))
                (split_at var2380 "=" 1))))
  (put/-1127386829 var2918
                   (cast-from-String-to-var3598 a!2)
                   (cast-from-String-to-var3598 a!4)))))
  (define-fun var2918 () var1017
    var1017!val!0)
  (define-fun var1687 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2380 "=") (- 1)))))
  (ite a!1 (split_rest var2380 "=" (- (- 1) 1)) (split_at var2380 "=" 1))))
  (define-fun var2380 () String
    "!0!")
  (define-fun var2164 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2380 "=") (- 1))))
      (a!3 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2380 "=") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2380 "=" (- (- 1) 1))
                (split_at var2380 "=" 0)))
      (a!4 (ite a!3
                (split_rest var2380 "=" (- (- 1) 1))
                (split_at var2380 "=" 1))))
  (cast-from-var3598-to-String
    (put/-1127386829 var2918
                     (cast-from-String-to-var3598 a!2)
                     (cast-from-String-to-var3598 a!4))))))
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
  (define-fun put/-1127386829 ((x!0 var1017) (x!1 var3598) (x!2 var3598)) var3598
    var3598!val!0)
  (define-fun cast-from-String-to-var3598 ((x!0 String)) var3598
    var3598!val!0)
  (define-fun cast-from-var3598-to-String ((x!0 var3598)) String
    "")
)
