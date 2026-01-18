(
  (define-fun dom_bad_dot_count () Int
    174307)
  (define-fun tld_second () String
    "pp")
  (define-fun domain_bad () String
    "`")
  (define-fun email () String
    "first.last@example.co.uk")
  (define-fun local () String
    "`")
  (define-fun local_first () String
    "@")
  (define-fun local_dot_count () Int
    174307)
  (define-fun domain () String
    ".")
  (define-fun tld () String
    "pp")
  (define-fun local_bad () String
    "@")
  (define-fun local_last () String
    "@")
  (define-fun tld_first () String
    "pp")
  (define-fun email_bad () String
    "a@b.com")
  (define-fun dom_dot_count () Int
    25909)
  (define-fun domain_bad_tld () String
    "@")
  (define-fun domain_head () String
    "@")
  (define-fun domain_bad_head () String
    "@")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
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
      "`"
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
      "."
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 25908)) "pp"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 25907)) "pp"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))))
              (= x!1 "@")
              (= x!2 1))
      "`"
      "@"))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "`") (= x!1 ".")) 174307
    (ite (and (= x!0 ".") (= x!1 ".")) 25909
      2)))
)
