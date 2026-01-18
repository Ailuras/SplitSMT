(
  (define-fun y () String
    "!!$$")
  (define-fun x () String
    "bbaa")
  (define-fun delimiter () String
    "!!")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "$$")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "!!$$bbaa")
              (= x!1 (str.++ (seq.unit (_ Char 33)) (seq.unit (_ Char 33))))
              (= x!2 1))
      "bb"
      "aa"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
