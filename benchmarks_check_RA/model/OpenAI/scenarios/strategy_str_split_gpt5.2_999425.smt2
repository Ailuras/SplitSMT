(
  (define-fun domain_sat () String
    "o")
  (define-fun email_unsat () String
    "alice@nodots")
  (define-fun tld_unsat () String
    "oj")
  (define-fun email_sat () String
    "john.doe+tag@sub.example.com")
  (define-fun domain_unsat () String
    "j")
  (define-fun local_unsat () String
    "o")
  (define-fun tld_sat () String
    "oj")
  (define-fun domain_before_tld_sat () String
    "o")
  (define-fun local_first_token_sat () String
    "o")
  (define-fun sub0_sat () String
    "o")
  (define-fun domain_rest1_sat () String
    "oj")
  (define-fun local_sat () String
    ".")
  (define-fun sub1_sat () String
    "o")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "oj")
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
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
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
              (= x!2 0))
      "."
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 115))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "j"
      "o")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".") (= x!1 ".")) 1
    (ite (and (= x!0 "o") (= x!1 ".")) 3
      2)))
)
