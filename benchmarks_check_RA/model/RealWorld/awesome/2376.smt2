(
  (define-fun var2696 () String
    var2102_getVersion/530152056)
  (define-fun var2820 () Int
    (let ((a!1 (ite (< (num_splits_re var2102_getVersion/530152056 (str.to_re "."))
                   (- 1))
                (num_splits_re var2102_getVersion/530152056 (str.to_re "."))
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits_re var2102_getVersion/530152056 (str.to_re ".")))))
  (define-fun var3128 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits_re var2102_getVersion/530152056 (str.to_re "."))
                    (- 1)))))
(let ((a!2 (ite a!1
                (split_rest_re var2102_getVersion/530152056
                               (str.to_re ".")
                               (- (- 1) 1))
                (split_at_re var2102_getVersion/530152056 (str.to_re ".") 1))))
  (Int_parseInt/1370970945 a!2))))
  (define-fun var2102_getVersion/530152056 () String
    "!0!")
  (define-fun var2481 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits_re var2102_getVersion/530152056 (str.to_re "."))
                    (- 1)))))
  (ite a!1
       (split_rest_re var2102_getVersion/530152056 (str.to_re ".") (- (- 1) 1))
       (split_at_re var2102_getVersion/530152056 (str.to_re ".") 1))))
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    2)
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
  (define-fun Int_parseInt/1370970945 ((x!0 String)) Int
    0)
)
