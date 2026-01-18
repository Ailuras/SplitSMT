(
  (define-fun log_entry () String
    ": INFO B")
  (define-fun minutes () String
    "22")
  (define-fun seconds () String
    "24")
  (define-fun message () String
    "B")
  (define-fun log_level () String
    "INFO")
  (define-fun hours () String
    "22")
  (define-fun timestamp () String
    ": INFO")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ": INFO B") (= x!1 " ") (= x!2 0)) ": INFO"
    (ite (and (= x!0 ": INFO B") (= x!1 " ") (= x!2 1)) "INFO"
    (ite (and (= x!0 ": INFO") (= x!1 ":") (= x!2 2)) "24"
      "22"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
