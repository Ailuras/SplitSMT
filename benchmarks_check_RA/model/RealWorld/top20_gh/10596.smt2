(
  (define-fun var2425 () String
    "")
  (define-fun var1861 () Int
    0)
  (define-fun var432 () var1997
    null-var1997)
  (define-fun null-String () String
    "A")
  (define-fun var1684 () String
    "")
  (define-fun var2113 () Int
    (str.len var2425))
  (define-fun var280 () String
    (str.substr var2425 0 (- (str.len var2425) 0)))
  (define-fun var1250 () String
    "")
  (define-fun var2880 () Int
    (let ((a!1 (num_splits_re (str.substr var2425 0 (- (str.len var2425) 0))
                          (str.to_re "."))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var1356 () Int
    (- 1))
  (define-fun var2347 () Int
    0)
  (define-fun null-var1997 () var1997
    var1997!val!0)
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
)
