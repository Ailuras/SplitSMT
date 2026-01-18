(
  (define-fun var3160 () String
    "")
  (define-fun var718 () String
    (trim-right (trim-left var3160)))
  (define-fun null-String () String
    "A")
  (define-fun var3853 () Int
    (let ((a!1 (re.++ (str.to_re ",")
                  (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!2 (< (num_splits_re (trim-right (trim-left var3160)) a!1) (- 1))))
(let ((a!3 (ite a!2 (num_splits_re (trim-right (trim-left var3160)) a!1) (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (trim-right (trim-left var3160)) a!1))))))
  (define-fun var349 () Int
    0)
  (define-fun var3736 () var1295
    var1295-init)
  (define-fun var3736!1 () var1295
    var1295!val!0)
  (define-fun var1295-init () var1295
    var1295!val!0)
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
  (define-fun <init>/-1461814690 ((x!0 var1295)) void
    void!val!0)
)
