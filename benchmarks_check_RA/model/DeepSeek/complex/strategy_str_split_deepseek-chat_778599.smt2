(
  (define-fun tld () String
    "pp")
  (define-fun email () String
    "user.name@example.com")
  (define-fun domain_name () String
    ".")
  (define-fun at_splits () Int
    2)
  (define-fun dot_splits () Int
    2)
  (define-fun domain () String
    "A.B")
  (define-fun local_part () String
    "C")
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
              (= x!2 0))
      "C"
    (ite (and (= x!0 "A.B") (= x!1 ".") (= x!2 0)) "."
      "A.B")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
