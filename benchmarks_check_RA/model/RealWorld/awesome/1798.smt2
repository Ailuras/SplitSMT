(
  (define-fun var1251 () var2911
    var1661_newHashMap/701256970)
  (define-fun var3626 () String
    ",")
  (define-fun null-String () String
    "")
  (define-fun var3822 () Int
    0)
  (define-fun var2087 () Int
    (let ((a!1 (< (num_splits_re var3626 (re.union (str.to_re ",") (str.to_re ";")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var3626
                               (re.union (str.to_re ",") (str.to_re ";")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var3626 (re.union (str.to_re ",") (str.to_re ";")))))))
  (define-fun var1661_newHashMap/701256970 () var2911
    var2911!val!0)
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
