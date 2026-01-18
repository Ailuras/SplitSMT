(
  (define-fun T2_4 () String
    "")
  (define-fun T5_2 () String
    "_")
  (define-fun T3_6 () String
    "")
  (define-fun T0_6 () String
    "")
  (define-fun T4_6 () String
    "")
  (define-fun T4_2 () String
    "=")
  (define-fun T3_4 () String
    "")
  (define-fun T1_6 () String
    "_")
  (define-fun T4_4 () String
    "")
  (define-fun T2_6 () String
    "")
  (define-fun T2_2 () String
    "_")
  (define-fun T_SELECT_3 () Bool
    false)
  (define-fun T1_4 () String
    "_")
  (define-fun T_SELECT_1 () Bool
    false)
  (define-fun T0_4 () String
    "")
  (define-fun var_0xINPUT_107890 () String
    "_")
  (define-fun T_SELECT_2 () Bool
    false)
  (define-fun T5_4 () String
    "")
  (define-fun PCTEMP_LHS_1 () Int
    (- 1))
  (define-fun PCTEMP_LHS_2 () Int
    (- 1))
  (define-fun T3_2 () String
    "_")
  (define-fun T1_2 () String
    "_")
  (define-fun PCTEMP_LHS_3 () Int
    (- 1))
  (define-fun T5_6 () String
    "")
  (define-fun T0_2 () String
    "")
  (define-fun first_value () String
    "A")
  (define-fun T_5 () Bool
    true)
  (define-fun cookie_delim () String
    "&")
  (define-fun first_key () String
    "B")
  (define-fun first_pair () String
    "")
  (define-fun T_9 () Bool
    true)
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    false)
  (define-fun rest_pairs () String
    "")
  (define-fun T_6 () Bool
    false)
  (define-fun T_4 () Bool
    false)
  (define-fun I0_4 () Int
    0)
  (define-fun I0_6 () Int
    0)
  (define-fun I0_2 () Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 61))) (= x!2 0)) "B"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 61))) (= x!2 1)) "A"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 61)))) 2
      1))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
