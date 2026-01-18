(
  (define-fun f2 () String
    "B")
  (define-fun T_1 () Bool
    false)
  (define-fun empty_field_detected () Bool
    false)
  (define-fun csv_line () String
    "")
  (define-fun f0 () String
    "A")
  (define-fun T_2 () Bool
    true)
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "C")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "C"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) "B"
      "A")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
