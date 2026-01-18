(
  (define-fun domain_first_label () String
    "\")
  (define-fun domainDotCount () Int
    18459)
  (define-fun email () String
    "alice.smith@example.co")
  (define-fun local () String
    "[")
  (define-fun atCount_bad () Int
    2)
  (define-fun domain_bad () String
    ".")
  (define-fun domain () String
    "e.co")
  (define-fun domain_rest () String
    "]")
  (define-fun tld () String
    "ZZ")
  (define-fun local_bad () String
    "[")
  (define-fun atCount () Int
    2)
  (define-fun domainDotCount_bad () Int
    1325)
  (define-fun email_bad () String
    "bob@@example")
  (define-fun dotCount () Int
    2)
  (define-fun tld_bad () String
    "^_")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "e.co") (= x!1 ".") (= x!2 1)) "]"
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
      "e.co"
    (ite (and (= x!0 "e.co") (= x!1 ".") (= x!2 0)) "\"
    (ite (and (= x!0 "e.co") (= x!1 ".") (= x!2 18458)) "ZZ"
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
                         (seq.unit (_ Char 101))))
              (= x!1 "@")
              (= x!2 1))
      "."
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 1324)) "^_"
      "["))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "e.co") (= x!1 ".")) 18459
    (ite (and (= x!0 ".") (= x!1 ".")) 1325
      2)))
)
