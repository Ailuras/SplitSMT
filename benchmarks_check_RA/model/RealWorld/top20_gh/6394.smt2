(
  (define-fun var3772 () Int
    0)
  (define-fun var3817 () String
    "!2!")
  (define-fun var3566 () String
    "!0!")
  (define-fun var1609 () var1657
    var1657-init)
  (define-fun null-String () String
    "!1!")
  (define-fun var2618 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3566 var3817) (- 1))
          (num_splits var3566 var3817)
          (- 1))
     (num_splits var3566 var3817)))
  (define-fun var2393 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3566 var3817) (- 1))
          (num_splits var3566 var3817)
          (- 1))
     (num_splits var3566 var3817)))
  (define-fun var1609!1 () var1657
    var1657!val!0)
  (define-fun var2618!1 () Int
    0)
  (define-fun var1657-init () var1657
    var1657!val!0)
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
  (define-fun <init>/613807010 ((x!0 var1657) (x!1 Int)) void
    void!val!0)
)
