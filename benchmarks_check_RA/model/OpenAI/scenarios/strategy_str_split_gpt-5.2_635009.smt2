(
  (define-fun tld_bad () String
    ".....")
  (define-fun domain_left_ok () String
    "co")
  (define-fun email_ok () String
    "user.name+tag-01@sub.mail.example.co.uk")
  (define-fun local_suffix_ok () String
    ".")
  (define-fun domain_bad () String
    "")
  (define-fun tld_ok () String
    "uk")
  (define-fun userpart_ok () String
    "")
  (define-fun local_bad () String
    ".")
  (define-fun local_prefix_ok () String
    ".")
  (define-fun local_ok () String
    "+.")
  (define-fun email_bad () String
    "abc@x.y")
  (define-fun tag_ok () String
    ".")
  (define-fun domain_ok () String
    "example")
  (define-fun org_ok () String
    "example")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "example")
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
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
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
      "+."
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
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
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
      "example"
    (ite (and (= x!0 "+.") (= x!1 "+") (= x!2 0)) ""
    (ite (and (= x!0 "example") (= x!1 ".") (= x!2 8367)) "uk"
    (ite (and (= x!0 "example") (= x!1 ".") (= x!2 8366)) "co"
    (ite (and (= x!0 "example") (= x!1 ".") (= x!2 2)) "example"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 121))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 32287)) "....."
      ".")))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 ".")) 32288
    (ite (and (= x!0 "example") (= x!1 ".")) 8368
      2)))
)
