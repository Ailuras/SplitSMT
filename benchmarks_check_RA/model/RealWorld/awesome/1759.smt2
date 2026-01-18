(
  (define-fun var1217 () Int
    (let ((a!1 (< (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var717
                               (re.union (str.to_re ",") (str.to_re ";")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))))))
  (define-fun var1143 () (Array Int String)
    arr-String-init)
  (define-fun null-String () String
    "")
  (define-fun var3635 () Int
    (+ 0 1))
  (define-fun var2112 () Int
    0)
  (define-fun var1739 () (Array Int String)
    arr-String-init)
  (define-fun var2610 () Int
    0)
  (define-fun var1049 () Int
    (let ((a!1 (< (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var717
                               (re.union (str.to_re ",") (str.to_re ";")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))))))
  (define-fun var2678 () Int
    (let ((a!1 (< (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var717
                               (re.union (str.to_re ",") (str.to_re ";")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))))))
  (define-fun var1042 () Int
    0)
  (define-fun var1876 () (Array Int Int)
    arr-Int-init)
  (define-fun var1463 () Int
    (let ((a!1 (< (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var717
                               (re.union (str.to_re ",") (str.to_re ";")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var717 (re.union (str.to_re ",") (str.to_re ";")))))))
  (define-fun var717 () String
    ",")
  (define-fun arr-Int-init () (Array Int Int)
    ((as const (Array Int Int)) 0))
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) ""))
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
