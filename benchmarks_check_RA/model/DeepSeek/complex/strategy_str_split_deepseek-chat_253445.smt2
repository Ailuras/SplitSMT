(
  (define-fun log_entry () String
    " ")
  (define-fun source () String
    "")
  (define-fun message () String
    ":")
  (define-fun log_level () String
    "INFO")
  (define-fun timestamp () String
    ":")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 " ") (= x!1 " ") (= x!2 1)) "INFO"
      ":"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ":") (= x!1 ":")) 3
      4))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
