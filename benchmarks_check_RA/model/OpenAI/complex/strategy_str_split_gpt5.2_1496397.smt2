(
  (define-fun X () String
    "\u{a}")
  (define-fun tld () String
    "PP")
  (define-fun domain_head () String
    "B")
  (define-fun alpha () String
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
  (define-fun local () String
    "j")
  (define-fun subdomain () String
    "x")
  (define-fun domain () String
    "p")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "x"
      "p"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 64))) (= x!2 1)) "p"
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "B"
    (ite (and (= x!0 "p") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "PP"
      "j"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "j") (= x!1 (seq.unit (_ Char 64)))) 1
      2))
)
