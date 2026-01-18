(
  (define-fun email_bad () String
    "a")
  (define-fun tld_bad () String
    "AB")
  (define-fun email_ok () String
    "alice+dev@mail.example.co.uk")
  (define-fun at_delim () String
    "@")
  (define-fun domain_bad () String
    "example")
  (define-fun tld_ok () String
    "ll")
  (define-fun sub2_ok () String
    "example")
  (define-fun local_bad () String
    "l")
  (define-fun local_ok () String
    "+")
  (define-fun remainder_domain_ok () String
    "co.uk")
  (define-fun tag_ok () String
    "dev")
  (define-fun dot_delim () String
    ".")
  (define-fun domain_ok () String
    ".")
  (define-fun user_ok () String
    "alice")
  (define-fun sub1_ok () String
    "mail")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 2)) "co.uk"
      ""))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 118))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 108))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 0))
      "+"
    (ite (and (= x!0 "+") (= x!1 "+") (= x!2 0)) "alice"
    (ite (and (= x!0 "+") (= x!1 "+") (= x!2 1)) "dev"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 118))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 108))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "."
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 0)) "mail"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 1)) "example"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 ".")
              (= x!2 2438))
      "ll"
    (ite (and (= x!0 "a") (= x!1 (seq.unit (_ Char 64))) (= x!2 1)) "example"
    (ite (and (= x!0 "a") (= x!1 (seq.unit (_ Char 64))) (= x!2 0)) "l"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))))
              (= x!1 ".")
              (= x!2 8856))
      "AB"
      "example")))))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".") (= x!1 ".")) 3
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "."))
      2439
    (ite (and (= x!0 "+") (= x!1 (seq.unit (_ Char 64)))) 1
    (ite (and (= x!0 ".") (= x!1 (seq.unit (_ Char 64)))) 1
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))))
              (= x!1 "."))
      8857
    (ite (and (= x!0 "l") (= x!1 ".")) 1
      2)))))))
)
