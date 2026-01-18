(
  (define-fun log_entry () String
    " ")
  (define-fun message () String
    "L")
  (define-fun log_level () String
    "WARN")
  (define-fun timestamp () String
    ":BCDGHKJ")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "L")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 32)))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "WARN"
      ":BCDGHKJ"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
