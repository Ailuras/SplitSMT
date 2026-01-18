(
  (define-fun T_1 () Bool
    true)
  (define-fun local_len () Int
    1)
  (define-fun at_count () Int
    2)
  (define-fun email () String
    "user.name+tag@example.co.uk")
  (define-fun local () String
    "B")
  (define-fun rest_labels () String
    "")
  (define-fun domain () String
    "u")
  (define-fun var_0xINPUT_103698 () String
    "user.name+tag@example.co.uk")
  (define-fun tld () String
    "uk")
  (define-fun make_unsat () Bool
    false)
  (define-fun domain_len () Int
    1)
  (define-fun dot_count_dom () Int
    11799)
  (define-fun at_idx () Int
    13)
  (define-fun first_label () String
    "A")
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
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      "u"
    (ite (and (= x!0 "u") (= x!1 ".") (= x!2 0)) "A"
    (ite (and (= x!0 "u") (= x!1 ".") (= x!2 11798)) "uk"
      "B"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
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
              (= x!1 (seq.unit (_ Char 64))))
      2
    (ite (and (= x!0 "u") (= x!1 ".")) 11799
      1)))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
