(
  (define-fun var1689 () String
    ".")
  (define-fun null-String () String
    "")
  (define-fun var1830 () Int
    0)
  (define-fun var1094 () Int
    0)
  (define-fun var3719 () Int
    (let ((a!1 (ite (< (num_splits_re var1689 (str.to_re ".")) (- 1))
                (num_splits_re var1689 (str.to_re "."))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var1689 (str.to_re ".")))))
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
