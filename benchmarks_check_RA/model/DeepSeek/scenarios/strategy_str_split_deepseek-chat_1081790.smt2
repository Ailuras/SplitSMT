(
  (define-fun tld () String
    "pp")
  (define-fun email () String
    "user.name+tag@sub-domain.example.com")
  (define-fun domain_name () String
    "pP")
  (define-fun domain () String
    "")
  (define-fun local_part () String
    "+")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "pp")
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
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 46))
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
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "pP"
      "+")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
