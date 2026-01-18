(
  (define-fun var7 () String
    "<")
  (define-fun var2585 () var405
    var405-init)
  (define-fun var2438 () String
    (str.++ var2725!1 "Invalid sieve ordering constraint: "))
  (define-fun null-String () String
    "")
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var2966 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var7 "<") (- 1)) (num_splits var7 "<") (- 1))
     (num_splits var7 "<")))
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) "<"))
  (define-fun var770 () String
    (str.++ var2725!1 "Invalid sieve ordering constraint: " var7))
  (define-fun var495 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var2725 () String
    String-init)
  (define-fun var2839 () String
    (str.++ var2725!1 "Invalid sieve ordering constraint: " var7))
  (define-fun var2725!2 () String
    "Invalid sieve ordering constraint: ")
  (define-fun var2438!1 () String
    "Invalid sieve ordering constraint: <")
  (define-fun var2725!1 () String
    "")
  (define-fun var405-init () var405
    var405!val!0)
  (define-fun var2585!1 () var405
    var405!val!0)
  (define-fun var770!1 () String
    "")
  (define-fun String-init () String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
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
  (define-fun <init>/875830710 ((x!0 var405) (x!1 String)) void
    void!val!0)
)
