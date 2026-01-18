(
  (define-fun dom_label1 () String
    "@")
  (define-fun email () String
    "alice@sub.example")
  (define-fun rest_after_first_dot () String
    "...")
  (define-fun dom_label0 () String
    "A")
  (define-fun domain () String
    "...")
  (define-fun tld () String
    "CD")
  (define-fun dom_label2 () String
    "CD")
  (define-fun rest_after_at () String
    "...")
  (define-fun local_part () String
    "B")
  (define-fun case_sat () Bool
    true)
  (define-fun case_unsat () Bool
    false)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "...")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
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
      "B"
    (ite (and (= x!0 "...") (= x!1 ".") (= x!2 0)) "A"
    (ite (and (= x!0 "...") (= x!1 ".") (= x!2 1)) "@"
    (ite (and (= x!0 "...") (= x!1 ".") (= x!2 2)) "CD"
      "...")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "...") (= x!1 ".")) 3
      2))
)
