(
  (define-fun var385 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3769 "(") (- 1)) (num_splits var3769 "(") (- 1))
     (num_splits var3769 "(")))
  (define-fun var2028 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3769 "(") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var3769 "(" (- (- 1) 1))
                (split_at var3769 "(" 0))))
  (trim-right (trim-left a!2)))))
  (define-fun null-String () String
    "")
  (define-fun var3769 () String
    "(")
  (define-fun var1048 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var3769 "(") (- 1)))))
  (ite a!1 (split_rest var3769 "(" (- (- 1) 1)) (split_at var3769 "(" 0))))
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
)
