(
  (define-fun T0_2 () String
    "")
  (define-fun T5_2 () String
    "")
  (define-fun T3_6 () String
    "D@.")
  (define-fun I0_6 () Int
    0)
  (define-fun T4_6 () String
    "")
  (define-fun T3_4 () String
    "")
  (define-fun T1_6 () String
    "D@.")
  (define-fun T4_4 () String
    "")
  (define-fun T2_6 () String
    "")
  (define-fun T_SELECT_3 () Bool
    true)
  (define-fun T1_4 () String
    "D@.")
  (define-fun T0_4 () String
    "")
  (define-fun tld () String
    "pP")
  (define-fun T3_2 () String
    "")
  (define-fun recon_email () String
    "D@.")
  (define-fun T1_2 () String
    "D@.")
  (define-fun PCTEMP_LHS_3 () Int
    0)
  (define-fun T5_6 () String
    "")
  (define-fun T2_4 () String
    "@")
  (define-fun T0_6 () String
    "")
  (define-fun T2_2 () String
    "")
  (define-fun T_SELECT_1 () Bool
    false)
  (define-fun T_SELECT_2 () Bool
    false)
  (define-fun T5_4 () String
    "E")
  (define-fun PCTEMP_LHS_1 () Int
    (- 1))
  (define-fun PCTEMP_LHS_2 () Int
    (- 1))
  (define-fun T4_2 () String
    "C")
  (define-fun T_5 () Bool
    true)
  (define-fun local () String
    "D")
  (define-fun d2 () String
    "")
  (define-fun var_0xINPUT_40206 () String
    "D@.")
  (define-fun domain () String
    "")
  (define-fun T_6 () Bool
    false)
  (define-fun recon_domain () String
    ".")
  (define-fun T_4 () Bool
    false)
  (define-fun d1 () String
    "pP")
  (define-fun d3 () String
    "")
  (define-fun has_plus () Bool
    false)
  (define-fun unsat_branch () Bool
    false)
  (define-fun has_underscore () Bool
    false)
  (define-fun d0 () String
    "B")
  (define-fun I0_4 () Int
    0)
  (define-fun I0_2 () Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ".")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 0)) "B"
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 1)) "pP"
    (ite (and (= x!0 "D@.") (= x!1 "@") (= x!2 0)) "D"
      ""))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
