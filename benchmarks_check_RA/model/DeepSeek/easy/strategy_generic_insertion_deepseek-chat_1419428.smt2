(
  (define-fun X () String
    "03 361021 42\u{a}")
  (define-fun segment0 () String
    "User-Agent:")
  (define-fun delimiter2 () String
    "\u{a}")
  (define-fun delimiter1 () String
    "@")
  (define-fun total_segments () Int
    2)
  (define-fun segment1 () String
    "PORT3")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "03 361021 42\u{a}")
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "PORT3"
      "User-Agent:"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
