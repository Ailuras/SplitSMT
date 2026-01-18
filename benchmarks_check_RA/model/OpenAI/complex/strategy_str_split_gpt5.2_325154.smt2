(
  (define-fun make_unsat () Bool
    false)
  (define-fun value2 () String
    ",A=A")
  (define-fun key2 () String
    "cache-control")
  (define-fun rest2 () String
    "")
  (define-fun field2 () String
    "D")
  (define-fun field0 () String
    "E")
  (define-fun csv_line () String
    ",A=A")
  (define-fun field1 () String
    "")
  (define-fun field_count () Int
    3)
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",A=A") (= x!1 ",") (= x!2 1)) ""
    (ite (and (= x!0 ",A=A") (= x!1 ",") (= x!2 2)) "D"
      "E")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
