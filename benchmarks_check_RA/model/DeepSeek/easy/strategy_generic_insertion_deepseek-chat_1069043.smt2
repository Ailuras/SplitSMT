(
  (define-fun var0 () String
    "220011100ccccccdd")
  (define-fun delimiter () String
    "00")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "111")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "220011100ccccccdd")
              (= x!1 (str.++ (seq.unit (_ Char 48)) (seq.unit (_ Char 48))))
              (= x!2 0))
      "prefix"
      "prefix"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
