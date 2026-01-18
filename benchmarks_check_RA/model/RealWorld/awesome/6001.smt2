(
  (define-fun var3325 () String
    ",")
  (define-fun var3553 () var832
    var832-init)
  (define-fun var694 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun var2365 () Int
    (let ((a!1 (< (num_splits_re var3325 (re.union (str.to_re ",") (str.to_re ";")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var3325
                               (re.union (str.to_re ",") (str.to_re ";")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var3325 (re.union (str.to_re ",") (str.to_re ";")))))))
  (define-fun var832-init () var832
    var832!val!0)
  (define-fun var3553!1 () var832
    var832!val!0)
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
  (define-fun <init>/-325640736 ((x!0 var832)) void
    void!val!0)
)
