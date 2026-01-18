(
  (define-fun var2036 () String
    "|||")
  (define-fun var1263 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2036 "|||") (- 1)) (num_splits var2036 "|||") (- 1))
     (num_splits var2036 "|||")))
  (define-fun var972 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun var3374 () var2214
    var2214-init)
  (define-fun var3374!1 () var2214
    var2214!val!0)
  (define-fun var2214-init () var2214
    var2214!val!0)
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
  (define-fun <init>/598147663 ((x!0 var2214)) void
    void!val!0)
)
