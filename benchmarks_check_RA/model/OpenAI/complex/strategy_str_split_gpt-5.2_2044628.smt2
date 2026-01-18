(
  (define-fun T_1 () Bool
    false)
  (define-fun var_0xINPUT_130984 () String
    "file:")
  (define-fun restLabels () String
    ".")
  (define-fun email () String
    "file:")
  (define-fun local () String
    "f")
  (define-fun firstLabel () String
    "A")
  (define-fun dotCount () Int
    8857)
  (define-fun domain () String
    "")
  (define-fun tld () String
    "e:")
  (define-fun secondLabel () String
    "B")
  (define-fun T_2 () Bool
    true)
  (define-fun subdomain () String
    ".")
  (define-fun atCount () Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ".")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 102))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 58))))
              (= x!1 (seq.unit (_ Char 64)))
              (= x!2 1))
      ""
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 0)) "A"
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 1)) "B"
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 8856)) "e:"
      "f")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 102))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 58))))
              (= x!1 (seq.unit (_ Char 64))))
      2
    (ite (and (= x!0 "") (= x!1 ".")) 8857
      1)))
)
