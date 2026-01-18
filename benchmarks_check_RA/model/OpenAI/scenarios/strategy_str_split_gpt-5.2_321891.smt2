(
  (define-fun domain_mixed () String
    "l")
  (define-fun email_sat () String
    "alice+dev@sub.example.com")
  (define-fun domain_tail_sat () String
    "A.B")
  (define-fun email_mixed () String
    "carol@test.co")
  (define-fun tld_unsat () String
    "EF")
  (define-fun plus_part_sat () String
    "a")
  (define-fun email_unsat () String
    "bob@localhost")
  (define-fun local_unsat () String
    "a")
  (define-fun local_sat () String
    "i")
  (define-fun rest_labels_mixed () String
    "")
  (define-fun domain_sat () String
    "A.B")
  (define-fun first_label_mixed () String
    "G")
  (define-fun local_mixed () String
    "")
  (define-fun domain_unsat () String
    "a")
  (define-fun tld_sat () String
    "CD")
  (define-fun sub0_sat () String
    "H")
  (define-fun sub1_sat () String
    "I")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "l") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) ""
      "A.B"))
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
              (= x!2 1))
      "A.B"
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
      "i"
    (ite (and (= x!0 "i") (= x!1 (seq.unit (_ Char 43))) (= x!2 0))
      "bob@localhost"
    (ite (and (= x!0 "A.B") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "H"
    (ite (and (= x!0 "A.B") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "I"
    (ite (and (= x!0 "A.B") (= x!1 (seq.unit (_ Char 46))) (= x!2 10451)) "CD"
    (ite (and (= x!0 "a") (= x!1 (seq.unit (_ Char 46))) (= x!2 30613)) "EF"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 99))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "l"
    (ite (and (= x!0 "l") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "G"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 99))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 0))
      ""
      "a")))))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "i") (= x!1 (seq.unit (_ Char 43)))) 1
    (ite (and (= x!0 "A.B") (= x!1 (seq.unit (_ Char 46)))) 10452
    (ite (and (= x!0 "a") (= x!1 (seq.unit (_ Char 46)))) 30614
      2))))
)
