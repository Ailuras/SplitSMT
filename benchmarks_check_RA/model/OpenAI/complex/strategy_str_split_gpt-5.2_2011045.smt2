(
  (define-fun domain_label0 () String
    ".")
  (define-fun T_1 () Bool
    false)
  (define-fun recomposed_domain () String
    "..")
  (define-fun tld () String
    "B.")
  (define-fun T_3 () Bool
    true)
  (define-fun domain_label1 () String
    ".")
  (define-fun T_2 () Bool
    true)
  (define-fun var_0xINPUT_244266 () String
    "4PH2ujcENG")
  (define-fun domain_part () String
    "..")
  (define-fun local_part () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 80))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 106))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 71))))
              (= x!1 "@")
              (= x!2 0))
      "A"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 80))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 106))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 71))))
              (= x!1 "@")
              (= x!2 1))
      ".."
    (ite (and (= x!0 "..") (= x!1 ".") (= x!2 20538)) "B."
      "."))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "..") (= x!1 ".")) 20539
      2))
)
