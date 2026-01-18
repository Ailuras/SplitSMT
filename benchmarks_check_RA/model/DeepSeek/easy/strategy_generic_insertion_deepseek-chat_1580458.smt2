(
  (define-fun T_1 () Bool
    true)
  (define-fun segment_1 () String
    "B")
  (define-fun total_segments () Int
    2)
  (define-fun segment_0 () String
    "A")
  (define-fun var_0xINPUT_89849 () String
    "-")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 45)))
              (= x!1 (seq.unit (_ Char 45)))
              (= x!2 1))
      "B"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
