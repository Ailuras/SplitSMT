(
  (define-fun domain_label0 () String
    "@")
  (define-fun domain_len () Int
    1)
  (define-fun at_count () Int
    2)
  (define-fun email () String
    "Search")
  (define-fun local_len () Int
    1)
  (define-fun domain () String
    "D")
  (define-fun tld () String
    "BC")
  (define-fun dot_count () Int
    2)
  (define-fun T_2 () Bool
    true)
  (define-fun T_1 () Bool
    true)
  (define-fun domain_label1 () String
    "BC")
  (define-fun local_part () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "D") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "BC"
      "D"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 83))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 104))))
              (= x!1 "@")
              (= x!2 0))
      "A"
    (ite (and (= x!0 "D") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "BC"
    (ite (and (= x!0 "D") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "@"
      "D"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
