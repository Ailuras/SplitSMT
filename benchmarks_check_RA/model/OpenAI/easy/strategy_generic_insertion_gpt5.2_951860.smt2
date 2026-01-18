(
  (define-fun s () String
    "ABC|EFJ|CBA")
  (define-fun seg0 () String
    "ABC|EFJ|CBA")
  (define-fun seg1 () String
    "ABC|EFJ|CBA")
  (define-fun delim () String
    "|")
  (define-fun rest1 () String
    "ABC|EFJ|CBA|ABC|EFJ|CBA")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "ABC|EFJ|CBA") (= x!1 "|") (= x!2 2)) "ABC|EFJ|CBA"
      "ABC|EFJ|CBA|ABC|EFJ|CBA"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "ABC|EFJ|CBA")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
