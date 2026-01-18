(
  (define-fun log_entry () String
    "")
  (define-fun message () String
    "C")
  (define-fun log_level () String
    "WARN")
  (define-fun timestamp () String
    "HJKLMPQ:")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "WARN"
      "HJKLMPQ:"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
