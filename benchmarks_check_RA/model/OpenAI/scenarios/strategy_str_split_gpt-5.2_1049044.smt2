(
  (define-fun dot () String
    ".")
  (define-fun email_sat () String
    "alice.smith+tag@sub.example.com")
  (define-fun email_unsat () String
    "a@b@c.com")
  (define-fun domain_core_unsat () String
    "")
  (define-fun domain_core_sat () String
    "")
  (define-fun tld_unsat () String
    "@B")
  (define-fun atsym () String
    "@")
  (define-fun local_unsat () String
    "A")
  (define-fun local_sat () String
    ".")
  (define-fun domain_sat () String
    ".")
  (define-fun domain_unsat () String
    ".")
  (define-fun tld_sat () String
    "@B")
  (define-fun sub0_sat () String
    "@")
  (define-fun sub1_sat () String
    "@")
  (define-fun sub1_unsat () String
    "")
  (define-fun sub0_unsat () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 230549)) "@B"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 0)) "@"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 1)) "@"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))))
              (= x!1 "@")
              (= x!2 0))
      "A"
      ".")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".") (= x!1 ".")) 230550
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
