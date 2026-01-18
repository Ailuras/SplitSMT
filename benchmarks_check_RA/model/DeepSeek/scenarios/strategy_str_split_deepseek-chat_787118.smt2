(
  (define-fun log_entry () String
    "D")
  (define-fun source () String
    "")
  (define-fun message () String
    "C")
  (define-fun log_level () String
    "DEBUG")
  (define-fun timestamp () String
    "0000-00-00 00:00:00")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "D") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "DEBUG"
    (ite (and (= x!0 "D") (= x!1 (seq.unit (_ Char 32))) (= x!2 2)) ""
      "0000-00-00 00:00:00")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 58)))) 2
      4))
)
