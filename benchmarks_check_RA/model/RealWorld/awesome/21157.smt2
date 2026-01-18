(
  (define-fun var1936 () var376
    var376-init)
  (define-fun var2022 () String
    " ")
  (define-fun var3748 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re ","))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0)
       (ite (< (num_splits_re var2022 a!2) (- 1))
            (num_splits_re var2022 a!2)
            (- 1))
       (num_splits_re var2022 a!2)))))
  (define-fun null-String () String
    "")
  (define-fun var1395 () Int
    0)
  (define-fun var1936!1 () var376
    var376!val!0)
  (define-fun var376-init () var376
    var376!val!0)
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
  (define-fun <init>/-325640736 ((x!0 var376)) void
    void!val!0)
)
