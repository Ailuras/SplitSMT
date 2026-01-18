(
  (define-fun segment_0 () String
    "")
  (define-fun var_0xINPUT_125039 () String
    "-")
  (define-fun T_2 () Bool
    true)
  (define-fun T_1 () String
    "-")
  (define-fun T2_3 () String
    "-")
  (define-fun T1_3 () String
    "")
  (define-fun segment_1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 45)))
              (= x!1 (seq.unit (_ Char 45)))
              (= x!2 0))
      "-"
      "-"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
