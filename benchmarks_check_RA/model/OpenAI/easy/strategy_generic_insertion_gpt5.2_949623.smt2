(
  (define-fun var0 () String
    "000000000eeeeffgjjjjjjjjjjjj")
  (define-fun seg0 () String
    "000")
  (define-fun seg1 () String
    "A")
  (define-fun rest2 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "000000000eeeeffgjjjjjjjjjjjj")
              (= x!1 (seq.unit (_ Char 97)))
              (= x!2 1))
      "A"
      "000"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
