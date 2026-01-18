(
  (define-fun var2881_getVersion/530152056 () String
    ".")
  (define-fun var3400 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2881_getVersion/530152056 ".") (- 1)))))
  (ite a!1
       (split_rest var2881_getVersion/530152056 "." (- (- 1) 1))
       (split_at var2881_getVersion/530152056 "." 0))))
  (define-fun var1391 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2881_getVersion/530152056 ".") (- 1))
          (num_splits var2881_getVersion/530152056 ".")
          (- 1))
     (num_splits var2881_getVersion/530152056 ".")))
  (define-fun var2390 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2881_getVersion/530152056 ".") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2881_getVersion/530152056 "." (- (- 1) 1))
                (split_at var2881_getVersion/530152056 "." 0))))
  (Int_parseInt/1370970945 a!2))))
  (define-fun var3576 () String
    var2881_getVersion/530152056)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
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
