(
  (define-fun empty_field_index () Int
    0)
  (define-fun T_1 () Bool
    true)
  (define-fun field3 () String
    "")
  (define-fun csv_line () String
    "-")
  (define-fun field2 () String
    "")
  (define-fun field0 () String
    "A")
  (define-fun var_0xINPUT_113268 () String
    "-")
  (define-fun field1 () String
    "")
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 45))) (= x!1 ",") (= x!2 0)) "A"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
