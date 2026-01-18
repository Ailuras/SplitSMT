(
  (define-fun tld () String
    "pP")
  (define-fun email () String
    "user.name@example.com")
  (define-fun domain_name () String
    ".")
  (define-fun domain () String
    "@DB")
  (define-fun local_part () String
    "C")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "pP")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 117))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))))
              (= x!1 "@")
              (= x!2 1))
      "@DB"
    (ite (and (= x!0 "@DB") (= x!1 ".") (= x!2 0)) "."
      "C")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
