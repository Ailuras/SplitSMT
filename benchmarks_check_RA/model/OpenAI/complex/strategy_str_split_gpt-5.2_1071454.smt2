(
  (define-fun email () String
    "p@p")
  (define-fun tld () String
    "")
  (define-fun sld () String
    "A")
  (define-fun badEmail () String
    "a@b")
  (define-fun badDomain () String
    "")
  (define-fun restDomain () String
    "")
  (define-fun local () String
    "p")
  (define-fun label1 () String
    "E")
  (define-fun firstLabel () String
    "A")
  (define-fun domain () String
    "p")
  (define-fun label0 () String
    "A")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "A"
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "E"
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46))) (= x!2 2)) "F"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 98))))
              (= x!1 "@")
              (= x!2 1))
      ""
      "p")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46)))) 3
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
