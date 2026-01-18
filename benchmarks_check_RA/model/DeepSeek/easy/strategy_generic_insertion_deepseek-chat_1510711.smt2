(
  (define-fun X () String
    "/\u{0}\\u{0}n\u{0}w\u{0}d\u{0}b\u{0}l\u{0}i\u{0}b\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")
  (define-fun delimiter () String
    "/")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "dll")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 "/\u{0}\\u{0}n\u{0}w\u{0}d\u{0}b\u{0}l\u{0}i\u{0}b\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")
              (= x!1 (seq.unit (_ Char 47)))
              (= x!2 1))
      "n"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
