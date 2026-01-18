(
  (define-fun T_1 () Bool
    true)
  (define-fun var_0xINPUT_447217 () String
    "array")
  (define-fun T_2 () Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 121))))
              (= x!1 (seq.unit (_ Char 114)))
              (= x!2 1))
      "ay"
      "ay"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 121))))
              (= x!1 (seq.unit (_ Char 114)))
              (= x!2 0))
      "a"
      "a"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
