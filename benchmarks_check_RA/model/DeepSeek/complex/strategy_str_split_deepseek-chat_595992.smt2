(
  (define-fun log_entry () String
    " ")
  (define-fun source () String
    ".")
  (define-fun message () String
    "")
  (define-fun log_level () String
    "INFO")
  (define-fun timestamp () String
    " ")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 32)))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 0))
      " "
    (ite (and (= x!0 (seq.unit (_ Char 32)))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "INFO"
    (ite (and (= x!0 (seq.unit (_ Char 32)))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 2))
      "."
      " "))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 32))) (= x!1 (seq.unit (_ Char 58)))) 3
      4))
)
