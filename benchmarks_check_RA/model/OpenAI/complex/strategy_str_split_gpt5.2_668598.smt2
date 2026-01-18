(
  (define-fun T0_2 () String
    "")
  (define-fun T4_2 () String
    "a,")
  (define-fun T1_2 () String
    "a,cb,")
  (define-fun field0 () String
    "A")
  (define-fun csv_line () String
    "a,cb,")
  (define-fun T3_2 () String
    "b,")
  (define-fun PCTEMP_LHS_1 () Int
    2)
  (define-fun T_SELECT_1 () Bool
    true)
  (define-fun I0_2 () Int
    2)
  (define-fun total_fields () Int
    3)
  (define-fun T2_2 () String
    "a,c")
  (define-fun field2 () String
    "C")
  (define-fun has_empty_field () Bool
    false)
  (define-fun rest_after_2 () String
    "")
  (define-fun field1 () String
    "B")
  (define-fun T5_2 () String
    "c")
  (define-fun delim () String
    ",")
  (define-fun var_0xINPUT_18338 () String
    "a,cb,")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))))
              (= x!1 ",")
              (= x!2 1))
      "B"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))))
              (= x!1 ",")
              (= x!2 2))
      "C"
      "A")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
