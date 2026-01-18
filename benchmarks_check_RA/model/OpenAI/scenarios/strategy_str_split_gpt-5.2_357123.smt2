(
  (define-fun domain_sat () String
    "IA.")
  (define-fun email_sat () String
    "john.doe+tag@sub.example.co")
  (define-fun domain_unsat () String
    "n")
  (define-fun tld_sat () String
    "BC")
  (define-fun email_unsat () String
    "alice@@example.com")
  (define-fun domain_labels_sat () Int
    8858)
  (define-fun local_unsat () String
    ".")
  (define-fun local_sat () String
    ".")
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
                         (seq.unit (_ Char 111))))
              (= x!1 "@")
              (= x!2 1))
      "IA."
    (ite (and (= x!0 "IA.") (= x!1 ".") (= x!2 8857)) "BC"
    (ite (and (= x!0 "IA.") (= x!1 ".") (= x!2 0)) "IA"
    (ite (and (= x!0 "IA.") (= x!1 ".") (= x!2 1)) "D"
    (ite (and (= x!0 "IA.") (= x!1 ".") (= x!2 2)) "E"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 64))
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
      "n"
    (ite (and (= x!0 "n") (= x!1 ".") (= x!2 0)) "F"
    (ite (and (= x!0 "n") (= x!1 ".") (= x!2 1)) "GH"
      ".")))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "IA.") (= x!1 ".")) 8858
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
