(
  (define-fun tld_bad () String
    "@@")
  (define-fun email_ok () String
    "john.doe+news@sub.example.co.uk")
  (define-fun user_suffix_ok () String
    "@")
  (define-fun at_delim () String
    "@")
  (define-fun domain_bad () String
    "")
  (define-fun tld_ok () String
    "@@")
  (define-fun domain_rest_ok () String
    "+A")
  (define-fun local_bad () String
    "")
  (define-fun local_ok () String
    "+++")
  (define-fun email_bad () String
    "a..b@x.")
  (define-fun domain_first_ok () String
    "@")
  (define-fun dot_delim () String
    ".")
  (define-fun domain_ok () String
    "")
  (define-fun user_prefix_ok () String
    "@")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "+A")
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
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 119))
                         (seq.unit (_ Char 115))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "@")
              (= x!2 0))
      "+++"
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
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 119))
                         (seq.unit (_ Char 115))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "@")
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 374107)) "@@"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 46))))
              (= x!1 "@")
              (= x!2 0))
      ""
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 46))))
              (= x!1 "@")
              (= x!2 1))
      ""
      "@"))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 ".")) 374108
      2))
)
