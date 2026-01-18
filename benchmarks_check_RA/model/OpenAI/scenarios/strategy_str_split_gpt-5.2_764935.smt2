(
  (define-fun rest_after_first_ok () String
    "E")
  (define-fun domain_first_ok () String
    "B")
  (define-fun domain_bad () String
    "@")
  (define-fun email_ok () String
    "alice.smith@sub.example.com")
  (define-fun dot_delim () String
    ".")
  (define-fun at_delim () String
    "@")
  (define-fun tld_ok () String
    "CD")
  (define-fun domain_ok () String
    "")
  (define-fun local_bad () String
    "F")
  (define-fun email_bad () String
    "bob@@example.com")
  (define-fun local_ok () String
    "F")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "E"
      ""))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 104))
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
              (= x!1 "@")
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "B"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 5854)) "CD"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 98))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 98))
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
      "@"
      "F")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46)))) 5855
      2))
)
