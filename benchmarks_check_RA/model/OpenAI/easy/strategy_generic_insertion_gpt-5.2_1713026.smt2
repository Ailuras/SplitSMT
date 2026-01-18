(
  (define-fun var_0xINPUT_99532 () String
    "a")
  (define-fun seg0 () String
    "C")
  (define-fun T_1 () Bool
    true)
  (define-fun seg1 () String
    "B")
  (define-fun T_2 () Bool
    true)
  (define-fun rest1 () String
    "B!0!")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 97)))
              (= x!1 (seq.unit (_ Char 97)))
              (= x!2 2))
      "!0!"
      "B!0!"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 97)))
              (= x!1 (seq.unit (_ Char 97)))
              (= x!2 0))
      "C"
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
