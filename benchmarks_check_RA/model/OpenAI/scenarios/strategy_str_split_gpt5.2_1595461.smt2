(
  (define-fun domain_label0 () String
    "D")
  (define-fun email_bad () String
    "a@b.c")
  (define-fun bad_tld () String
    "FG")
  (define-fun email () String
    "first.last@sub.example.co")
  (define-fun local () String
    ".")
  (define-fun bad_domain () String
    ".")
  (define-fun domain () String
    ".c")
  (define-fun domain_rest1 () String
    "")
  (define-fun tld () String
    "BE")
  (define-fun bad_label0 () String
    "FG")
  (define-fun bad_local () String
    "A")
  (define-fun domain_rest2 () String
    "")
  (define-fun domain_label1 () String
    "C")
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
              (= x!1 "@")
              (= x!2 1))
      ".c"
    (ite (and (= x!0 ".c") (= x!1 ".") (= x!2 0)) "D"
    (ite (and (= x!0 ".c") (= x!1 ".") (= x!2 1)) "C"
    (ite (and (= x!0 ".c") (= x!1 ".") (= x!2 8366)) "BE"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))))
              (= x!1 "@")
              (= x!2 0))
      "A"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 0)) "FG"
      ".")))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".c") (= x!1 ".")) 8367
    (ite (and (= x!0 ".") (= x!1 ".")) 1
      2)))
)
