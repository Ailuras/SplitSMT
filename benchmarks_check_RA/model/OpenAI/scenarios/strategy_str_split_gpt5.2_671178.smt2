(
  (define-fun email_bad () String
    "f")
  (define-fun tld2 () String
    "le")
  (define-fun another_domain () String
    "le")
  (define-fun another_email () String
    "user@a.b.co")
  (define-fun email () String
    "first.last+tag@sub.example")
  (define-fun local () String
    "first.last+tag")
  (define-fun another_tld () String
    "BC")
  (define-fun domain_bad () String
    "le")
  (define-fun domain () String
    "sub.example")
  (define-fun tld () String
    "le")
  (define-fun dom_head () String
    "A")
  (define-fun reconstructed () String
    "first.last+tag@sub.example")
  (define-fun local_bad () String
    "@")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 102))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
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
                         (seq.unit (_ Char 101))))
              (= x!1 "@")
              (= x!2 0))
      "first.last+tag"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 102))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
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
                         (seq.unit (_ Char 101))))
              (= x!1 "@")
              (= x!2 1))
      "sub.example"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))))
              (= x!1 (seq.unit (_ Char 46)))
              (= x!2 0))
      "A"
    (ite (and (= x!0 "f") (= x!1 "@") (= x!2 0)) "@"
    (ite (and (= x!0 "le") (= x!1 (seq.unit (_ Char 46))) (= x!2 2)) "BC"
    (ite (and (= x!0 "le") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "@"
      "le")))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 102))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))))
              (= x!1 "@"))
      1
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))))
              (= x!1 (seq.unit (_ Char 46))))
      8857
    (ite (and (= x!0 "@") (= x!1 "@")) 1
    (ite (and (= x!0 "le") (= x!1 (seq.unit (_ Char 46)))) 3
      2)))))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
