(
  (define-fun domain_parts () Int
    15923)
  (define-fun email () String
    "user@example.com")
  (define-fun top_level_domain () String
    "PP")
  (define-fun domain () String
    "P")
  (define-fun local_part () String
    "x")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 117))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
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
      "P"
    (ite (and (= x!0 "P") (= x!1 (seq.unit (_ Char 46))) (= x!2 15922)) "PP"
      "x")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "P") (= x!1 (seq.unit (_ Char 46)))) 15923
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
