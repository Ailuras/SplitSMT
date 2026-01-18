(
  (define-fun var1317 () Bool
    (= "auth" (select arr-String-init 0)))
  (define-fun var1109 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2552 ",") (- 1)) (num_splits var2552 ",") (- 1))
     (num_splits var2552 ",")))
  (define-fun var3051 () String
    (select arr-String-init 0))
  (define-fun null-String () String
    "auth")
  (define-fun var2552 () String
    ",")
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) "auth"))
  (define-fun var1308 () Int
    (getLength-Arr-String-1 arr-String-init))
  (define-fun var2523 () String
    "auth")
  (define-fun var3788 () Int
    0)
  (define-fun var3675 () Int
    0)
  (define-fun var1680 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2552 ",") (- 1)) (num_splits var2552 ",") (- 1))
     (num_splits var2552 ",")))
  (define-fun var2982 () (Array Int String)
    arr-String-init)
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    1)
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
)
