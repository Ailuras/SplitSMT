(
  (define-fun num_segments () Int
    2)
  (define-fun T_1 () Bool
    true)
  (define-fun var_0xINPUT_208734 () String
    "array")
  (define-fun segment_1 () String
    "B")
  (define-fun segment_0 () String
    "A")
  (define-fun T_2 () Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 121))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "B"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
