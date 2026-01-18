(
  (define-fun email_sat () String
    "user.name+tag@sub.example.com")
  (define-fun at_delim () String
    "@")
  (define-fun domain_tail_sat () String
    "")
  (define-fun email_unsat () String
    "invalid_email")
  (define-fun tld_unsat () String
    "C@")
  (define-fun first_label_sat () String
    "@")
  (define-fun local_unsat () String
    "B")
  (define-fun domain_name_sat () String
    "@.@")
  (define-fun local_sat () String
    "B")
  (define-fun domain_sat () String
    "B")
  (define-fun second_label_sat () String
    "@")
  (define-fun dot_delim () String
    ".")
  (define-fun domain_unsat () String
    "")
  (define-fun third_label_sat () String
    "Pp")
  (define-fun tld_sat () String
    "Pp")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "B") (= x!1 ".") (= x!2 0)) "@"
    (ite (and (= x!0 "B") (= x!1 ".") (= x!2 1)) "@"
    (ite (and (= x!0 "B") (= x!1 ".") (= x!2 2)) "Pp"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 118))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 95))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 108))))
              (= x!1 "@")
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 1)) "C@"
      "B"))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "B") (= x!1 ".")) 3
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
