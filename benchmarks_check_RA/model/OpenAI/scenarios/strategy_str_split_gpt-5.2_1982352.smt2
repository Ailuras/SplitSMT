(
  (define-fun email_unsat () String
    "")
  (define-fun domain_sat () String
    "")
  (define-fun email_sat () String
    "alice-1@sub.example.co")
  (define-fun dot_delim () String
    ".")
  (define-fun at_delim () String
    "@")
  (define-fun domain_unsat () String
    "i")
  (define-fun tld_sat () String
    "pd")
  (define-fun tld_unsat () String
    "AB")
  (define-fun local_unsat () String
    "C")
  (define-fun dom_before_last_sat () String
    "a")
  (define-fun local_sat () String
    "C")
  (define-fun dom_last_sat () String
    "pd")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 49))
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
                         (seq.unit (_ Char 111))))
              (= x!1 "@")
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 21657)) "pd"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 21656)) "a"
    (ite (and (= x!0 "") (= x!1 "@") (= x!2 1)) "i"
    (ite (and (= x!0 "i") (= x!1 (seq.unit (_ Char 46))) (= x!2 25907)) "AB"
      "C"))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46)))) 21658
    (ite (and (= x!0 "i") (= x!1 (seq.unit (_ Char 46)))) 25908
      2)))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
