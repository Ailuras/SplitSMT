(
  (define-fun var3550 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3833 var3496) (- 1))
                     (num_splits var3833 var3496)
                     (- 1))
                (num_splits var3833 var3496))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var3833 var3496) (- 1)))))
  (ite a!2
       (split_rest var3833 var3496 (- (- 1) 1))
       (split_at var3833 var3496 (- a!1 1))))))
  (define-fun var3496 () String
    "C")
  (define-fun null-String () String
    "")
  (define-fun var1429 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3833 var3496) (- 1))
                     (num_splits var3833 var3496)
                     (- 1))
                (num_splits var3833 var3496))))
  (- a!1 1)))
  (define-fun var3992 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3833 var3496) (- 1))
          (num_splits var3833 var3496)
          (- 1))
     (num_splits var3833 var3496)))
  (define-fun var34 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3833 var3496) (- 1))
          (num_splits var3833 var3496)
          (- 1))
     (num_splits var3833 var3496)))
  (define-fun var585 () String
    "A")
  (define-fun var3833 () String
    "C")
  (define-fun var591 () Bool
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3833 var3496) (- 1))
                     (num_splits var3833 var3496)
                     (- 1))
                (num_splits var3833 var3496))))
(let ((a!2 (and (> (- 1) 0)
                (= (- a!1 1) (- (- 1) 1))
                (>= (num_splits var3833 var3496) (- 1)))))
(let ((a!3 (ite a!2
                (split_rest var3833 var3496 (- (- 1) 1))
                (split_at var3833 var3496 (- a!1 1)))))
  (str.suffixof var585 a!3)))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (- 1))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
