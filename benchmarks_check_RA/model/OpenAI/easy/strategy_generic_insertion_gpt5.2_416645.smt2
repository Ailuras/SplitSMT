(
  (define-fun after_colon () String
    "")
  (define-fun T_1 () Bool
    false)
  (define-fun T_2 () Bool
    true)
  (define-fun var_0xINPUT_102366 () String
    "file:")
  (define-fun scheme () String
    "file")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 102))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 58))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "file"
      "file"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
