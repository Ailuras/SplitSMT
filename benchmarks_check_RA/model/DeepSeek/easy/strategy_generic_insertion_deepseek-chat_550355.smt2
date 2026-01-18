(
  (define-fun X () String
    "-10-18\u{d}20:00\u{a}2000")
  (define-fun segment0 () String
    "password")
  (define-fun total_segments () Int
    2)
  (define-fun delim () String
    " ")
  (define-fun segment1 () String
    "20")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "-10-18\u{d}20:00\u{a}2000")
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "20"
      "password"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
