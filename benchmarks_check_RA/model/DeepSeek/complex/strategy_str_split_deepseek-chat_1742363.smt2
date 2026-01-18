(
  (define-fun log_entry () String
    "12:34:56 INFO Server started successfully")
  (define-fun space_split_count () Int
    2)
  (define-fun log_level () String
    "INFO")
  (define-fun message () String
    "1")
  (define-fun colon_split_count () Int
    2)
  (define-fun timestamp () String
    "00:00:00")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "1")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "1") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "INFO"
    (ite (and (= x!0 "1") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "B"
      "00:00:00")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
