(
  (define-fun tld () String
    "pp")
  (define-fun email () String
    "john.doe_123@example.co.uk")
  (define-fun domain_name () String
    "-")
  (define-fun domain () String
    "ACB")
  (define-fun local_part () String
    "_")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "pp")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 106))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 95))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 0))
      "_"
    (ite (and (= x!0 "ACB") (= x!1 ".") (= x!2 0)) "-"
      "ACB")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
