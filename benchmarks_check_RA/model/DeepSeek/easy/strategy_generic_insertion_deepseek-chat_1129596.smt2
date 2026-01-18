(
  (define-fun var0 () String
    "jfffhhhhhhffffffjj")
  (define-fun segment0 () String
    "BACDE")
  (define-fun rest_segments () String
    "")
  (define-fun delimiter () String
    ":")
  (define-fun segment1 () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "jfffhhhhhhffffffjj")
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      ""
      "BACDE"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
