(
  (define-fun var3243 () String
    "\u{a}")
  (define-fun var818 () Int
    0)
  (define-fun var750 () var3601
    var3601-init)
  (define-fun null-String () String
    "")
  (define-fun var1194 () Int
    (let ((a!1 (ite (< (num_splits_re var3243 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var3243 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var3243 (str.to_re "\u{a}")))))
  (define-fun var3601-init () var3601
    var3601!val!0)
  (define-fun var750!1 () var3601
    var3601!val!0)
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
  (define-fun <init>/927978603 ((x!0 var3601)) void
    void!val!0)
)
