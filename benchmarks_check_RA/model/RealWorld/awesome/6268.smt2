(
  (define-fun var2606 () String
    "!2!")
  (define-fun null-String () String
    "!1!")
  (define-fun var3101 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var674 var1173) (- 1))
          (num_splits var674 var1173)
          (- 1))
     (num_splits var674 var1173)))
  (define-fun var674 () String
    "!0!")
  (define-fun var1173 () String
    "!3!")
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
