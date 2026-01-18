(
  (define-fun T0_6 () String
    "")
  (define-fun T5_2 () String
    "")
  (define-fun T3_6 () String
    ";")
  (define-fun T2_4 () String
    "C")
  (define-fun T4_6 () String
    "")
  (define-fun T4_2 () String
    "")
  (define-fun T3_4 () String
    "D")
  (define-fun T1_6 () String
    "")
  (define-fun T4_4 () String
    "")
  (define-fun T2_6 () String
    ";")
  (define-fun T2_2 () String
    "B")
  (define-fun T1_4 () String
    "")
  (define-fun T_SELECT_3 () Bool
    false)
  (define-fun T_SELECT_1 () Bool
    false)
  (define-fun T0_4 () String
    "")
  (define-fun T_SELECT_2 () Bool
    false)
  (define-fun T5_4 () String
    "")
  (define-fun PCTEMP_LHS_1 () Int
    (- 1))
  (define-fun PCTEMP_LHS_2 () Int
    (- 1))
  (define-fun T3_2 () String
    "A")
  (define-fun T1_2 () String
    "")
  (define-fun PCTEMP_LHS_3 () Int
    (- 1))
  (define-fun T5_6 () String
    "")
  (define-fun T0_2 () String
    "")
  (define-fun rest_after_1 () String
    "")
  (define-fun T_5 () Bool
    true)
  (define-fun split_segment_1 () String
    "__utmb")
  (define-fun split_segment_0 () String
    "__utma")
  (define-fun split_count () Int
    2)
  (define-fun T_6 () Bool
    true)
  (define-fun var_0xINPUT_18338 () String
    "")
  (define-fun T_4 () Bool
    false)
  (define-fun I0_4 () Int
    0)
  (define-fun I0_6 () Int
    0)
  (define-fun I0_2 () Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 59))) (= x!2 1)) "__utmb"
      "__utma"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
