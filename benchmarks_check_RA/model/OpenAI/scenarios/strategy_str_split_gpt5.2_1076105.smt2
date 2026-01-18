(
  (define-fun local_second_ok () String
    "`")
  (define-fun tld_bad () String
    "`")
  (define-fun local_first_ok () String
    "`")
  (define-fun dom_label0_bad () String
    "`")
  (define-fun dom_label0_ok () String
    "3")
  (define-fun domain_bad () String
    "")
  (define-fun email_ok () String
    "alice+dev@acme.io")
  (define-fun tld_ok () String
    "pp")
  (define-fun domain_ok () String
    "`")
  (define-fun dom_tail_ok () String
    "")
  (define-fun local_bad () String
    "`")
  (define-fun email_bad () String
    "bob@x.y")
  (define-fun local_ok () String
    "k")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
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
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 111))))
              (= x!1 "@")
              (= x!2 0))
      "k"
    (ite (and (= x!0 "`") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "3"
    (ite (and (= x!0 "`") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "pp"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 98))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 121))))
              (= x!1 "@")
              (= x!2 1))
      ""
      "`")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "k") (= x!1 (seq.unit (_ Char 46)))) 1
      2))
)
