(
  (define-fun T_1 () Bool
    false)
  (define-fun delimiter () String
    ";")
  (define-fun T_2 () Bool
    true)
  (define-fun var_0xINPUT_135296 () String
    "A9jaaDKZbG")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "example")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 65))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 106))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 68))
                         (seq.unit (_ Char 75))
                         (seq.unit (_ Char 90))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 71))))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 0))
      "A9jaaDKZbG"
      "A9jaaDKZbG"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
