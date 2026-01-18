(
  (define-fun tld_bad () String
    "AB")
  (define-fun dot_count_ok () Int
    21240)
  (define-fun email_ok () String
    "user.name+tag@sub.example.co")
  (define-fun domain_bad () String
    "e")
  (define-fun tld_ok () String
    "ss")
  (define-fun local_bad () String
    "s")
  (define-fun at_count_ok () Int
    2)
  (define-fun at_count_bad () Int
    1)
  (define-fun local_ok () String
    "s")
  (define-fun email_bad () String
    "a@b.c")
  (define-fun dot_count_bad () Int
    2439)
  (define-fun first_label_ok () String
    "s")
  (define-fun domain_ok () String
    "u")
  (define-fun remainder_ok () String
    "")
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
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "u"
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46))) (= x!2 21239)) "ss"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "e"
    (ite (and (= x!0 "e") (= x!1 (seq.unit (_ Char 46))) (= x!2 2438)) "AB"
      "s")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
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
              (= x!1 (seq.unit (_ Char 64))))
      2
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46)))) 21240
    (ite (and (= x!0 "e") (= x!1 (seq.unit (_ Char 46)))) 2439
      1))))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
