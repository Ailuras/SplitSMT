(
  (define-fun log_entry () String
    "[]")
  (define-fun hours_str () String
    "CB")
  (define-fun message () String
    "D")
  (define-fun log_level () String
    "WARN")
  (define-fun timestamp () String
    ":")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "D")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "[]") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "WARN"
    (ite (and (= x!0 ":") (= x!1 ":") (= x!2 0)) "CB"
      ":")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
