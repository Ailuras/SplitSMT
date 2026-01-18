(
  (define-fun csv_line () String
    ",")
  (define-fun rest1 () String
    ",")
  (define-fun nfields () Int
    3)
  (define-fun rest2 () String
    "")
  (define-fun field2 () String
    "A")
  (define-fun field0 () String
    "")
  (define-fun literal_5 () String
    "<option value=""##user##"">##user##</option>")
  (define-fun field1 () String
    "")
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 1)) ","
      ""))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 2)) "A"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
