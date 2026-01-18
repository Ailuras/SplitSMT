(
  (define-fun tld_bad () String
    "")
  (define-fun dom_first_ok () String
    "j")
  (define-fun domain_bad () String
    "")
  (define-fun email_ok () String
    "john_doe+tag@example.co.uk")
  (define-fun tld_ok () String
    "@A")
  (define-fun domain_ok () String
    "B")
  (define-fun local_bad () String
    "")
  (define-fun dom_rest_ok () String
    "")
  (define-fun email_bad () String
    "nodomainseparators")
  (define-fun local_ok () String
    "j")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 106))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 95))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "@"))
      2
    (ite (and (= x!0 "B") (= x!1 (seq.unit (_ Char 46)))) 2
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 110))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 115))))
              (= x!1 "@"))
      2
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46)))) 3
      8)))))
  (define-fun is_tld ((x!0 String)) Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 106))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 95))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "@")
              (= x!2 0))
      "j"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 106))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 95))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "@")
              (= x!2 1))
      "B"
    (ite (and (= x!0 "B") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "j"
    (ite (and (= x!0 "B") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "@A"
      "")))))
  (define-fun is_domain_label ((x!0 String)) Bool
    true)
  (define-fun is_alnum_underscore_plus_hyphen ((x!0 String)) Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
