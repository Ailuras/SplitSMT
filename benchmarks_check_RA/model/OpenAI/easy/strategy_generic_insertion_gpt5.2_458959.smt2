(
  (define-fun T_1 () Bool
    false)
  (define-fun prefix_part () String
    "file")
  (define-fun T_2 () Bool
    true)
  (define-fun rest_part () String
    "")
  (define-fun var_0xINPUT_155219 () String
    "file:")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
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
)
