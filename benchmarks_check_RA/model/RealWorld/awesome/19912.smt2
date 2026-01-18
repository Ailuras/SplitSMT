(
  ;; universe for var3829:
  ;;   var3829!val!0 var3829!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3829!val!0 () var3829)
  (declare-fun var3829!val!1 () var3829)
  ;; cardinality constraint:
  (forall ((x var3829)) (or (= x var3829!val!0) (= x var3829!val!1)))
  ;; -----------
  (define-fun var2490 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
  (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 1))))))
  (define-fun var3121 () var3737
    (mwtMiscs/-371264511 var3225))
  (define-fun var1441 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
(let ((a!4 (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 0))))
  (- (Int_parseInt/1370970945 a!4) 1))))))
  (define-fun null-var3829 () var3829
    var3829!val!1)
  (define-fun var2764 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
(let ((a!4 (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 1))))
  (- (Int_parseInt/1370970945 a!4) 1))))))
  (define-fun var34 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 9 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
  (ite a!1
       (split_rest var1887 "\u{9}" (- (- 1) 1))
       (split_at var1887 "\u{9}" 9))))
  (define-fun var992 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
  (ite a!1
       (split_rest var1887 "\u{9}" (- (- 1) 1))
       (split_at var1887 "\u{9}" 1))))
  (define-fun var2605 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
(let ((a!4 (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 1))))
  (Int_parseInt/1370970945 a!4))))))
  (define-fun null-String () String
    "-")
  (define-fun var3225 () var3829
    var3829!val!0)
  (define-fun var3362 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
(let ((a!4 (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 0))))
  (Int_parseInt/1370970945 a!4))))))
  (define-fun var2959 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
  (ite a!1
       (split_rest var1887 "\u{9}" (- (- 1) 1))
       (split_at var1887 "\u{9}" 0))))
  (define-fun var1802 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 1 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
(let ((a!4 (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 1))))
  (Int_valueOf/-1371140006 (- (Int_parseInt/1370970945 a!4) 1)))))))
  (define-fun var1887 () String
    "\u{9}")
  (define-fun var2431 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1887 "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1887 "\u{9}" (- (- 1) 1))
                (split_at var1887 "\u{9}" 0))))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!2 "-") (- 1)))))
  (ite a!3 (split_rest a!2 "-" (- (- 1) 1)) (split_at a!2 "-" 0))))))
  (define-fun var1311 () var3737
    (mwtTokens/-371264511 var3225))
  (define-fun var1085 () var3737
    (mwtLastCoreLabels/-371264511 var3225))
  (define-fun var992!1 () String
    "")
  (define-fun var1085!1 () var3737
    var3737!val!0)
  (define-fun var3121!1 () var3737
    var3737!val!0)
  (define-fun var1311!1 () var3737
    var3737!val!0)
  (define-fun var1802!1 () Int
    0)
  (define-fun var34!1 () String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "-") (= x!1 "-") (= x!2 1)) "\u{9}"
      "-"))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun Int_parseInt/1370970945 ((x!0 String)) Int
    (ite (= x!0 "-") 1
      0))
  (define-fun cast-from-Int-to-var3726 ((x!0 Int)) var3726
    var3726!val!0)
  (define-fun mwtLastCoreLabels/-371264511 ((x!0 var3829)) var3737
    var3737!val!0)
  (define-fun var3737_add/328494887 ((x!0 var3737) (x!1 var3726)) Bool
    false)
  (define-fun cast-from-String-to-var3726 ((x!0 String)) var3726
    var3726!val!0)
  (define-fun mwtMiscs/-371264511 ((x!0 var3829)) var3737
    var3737!val!0)
  (define-fun Int_valueOf/-1371140006 ((x!0 Int)) Int
    0)
  (define-fun mwtTokens/-371264511 ((x!0 var3829)) var3737
    var3737!val!0)
)
