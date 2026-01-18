(
  (define-fun var3995 () var2263
    var2263-init)
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var3209 () var3102
    var3102-init)
  (define-fun var2509 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3533 "\u{9}") (- 1))
          (num_splits var3533 "\u{9}")
          (- 1))
     (num_splits var3533 "\u{9}")))
  (define-fun var851 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3533 "\u{9}") (- 1))
          (num_splits var3533 "\u{9}")
          (- 1))
     (num_splits var3533 "\u{9}")))
  (define-fun var2879 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3533 "\u{9}") (- 1))
                     (num_splits var3533 "\u{9}")
                     (- 1))
                (num_splits var3533 "\u{9}"))))
  (str.++ var852!1
          "ERROR: Invalid format token for serialized token (only "
          (str.from_int a!1)
          " tokens): ")))
  (define-fun var2453 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3533 "\u{9}") (- 1))
                     (num_splits var3533 "\u{9}")
                     (- 1))
                (num_splits var3533 "\u{9}"))))
  (str.++ var852!1
          "ERROR: Invalid format token for serialized token (only "
          (str.from_int a!1)
          " tokens): "
          var3533)))
  (define-fun var852 () String
    String-init)
  (define-fun null-String () String
    "")
  (define-fun var3533 () String
    "\u{9}")
  (define-fun var1852 () Bool
    true)
  (define-fun var946 () String
    (str.++ var852!1 "ERROR: Invalid format token for serialized token (only "))
  (define-fun var3434 () Int
    (- 1))
  (define-fun var2691 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3533 "\u{9}") (- 1))
                     (num_splits var3533 "\u{9}")
                     (- 1))
                (num_splits var3533 "\u{9}"))))
  (str.++ var852!1
          "ERROR: Invalid format token for serialized token (only "
          (str.from_int a!1))))
  (define-fun var946!1 () String
    "ERROR: Invalid format token for serialized token (only ")
  (define-fun var916 () String
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3533 "\u{9}") (- 1))
                     (num_splits var3533 "\u{9}")
                     (- 1))
                (num_splits var3533 "\u{9}"))))
  (str.++ var852!1
          "ERROR: Invalid format token for serialized token (only "
          (str.from_int a!1)
          " tokens): "
          var3533)))
  (define-fun null-Bool () Bool
    false)
  (define-fun var852!1 () String
    "")
  (define-fun var852!2 () String
    "ERROR: Invalid format token for serialized token (only ")
  (define-fun var2691!1 () String
    "ERROR: Invalid format token for serialized token (only 0 tokens): ")
  (define-fun var2879!1 () String
    "ERROR: Invalid format token for serialized token (only 0 tokens): \u{9}")
  (define-fun var3209!1 () var3102
    var3102!val!0)
  (define-fun var916!1 () String
    "")
  (define-fun var3102-init () var3102
    var3102!val!0)
  (define-fun String-init () String
    "")
  (define-fun var2263-init () var2263
    var2263!val!0)
  (define-fun var3995!1 () var2263
    var2263!val!0)
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
  (define-fun <init>/598147663 ((x!0 var3102)) void
    void!val!0)
  (define-fun <init>/-1253962986 ((x!0 var2263) (x!1 String)) void
    void!val!0)
)
