(
  (define-fun sentence () String
    "a b c")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 99))))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 3))
      "d"
      "d"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
