(
  (define-fun log_entry () String
    " ")
  (define-fun message () String
    " ")
  (define-fun log_level () String
    "ERROR")
  (define-fun timestamp () String
    "0000-00-00T00:00:00")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    " ")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 " ") (= x!1 " ") (= x!2 1)) "ERROR"
      "0000-00-00T00:00:00"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
