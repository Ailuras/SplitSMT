(
  (define-fun input () String
    "x:y:z")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 120))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 122))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "x"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 120))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 122))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      "y"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 120))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 122))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 2))
      "z"
      "x"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
