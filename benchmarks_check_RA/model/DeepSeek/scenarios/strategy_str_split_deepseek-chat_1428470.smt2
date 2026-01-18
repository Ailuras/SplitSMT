(
  (define-fun tld () String
    "pl")
  (define-fun email () String
    "user.name_123@example.co.uk")
  (define-fun domain_name () String
    "-")
  (define-fun domain () String
    "u")
  (define-fun local_part () String
    "p")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "pl")
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
              (= x!2 1))
      "u"
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "-"
      "p")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
