(
  (define-fun T2_4 () String
    "!3!")
  (define-fun T5_2 () String
    "!2!")
  (define-fun T3_6 () String
    "!8!")
  (define-fun T0_6 () String
    "")
  (define-fun T4_6 () String
    "!9!")
  (define-fun T0_2 () String
    "")
  (define-fun T3_4 () String
    "!4!")
  (define-fun T1_6 () String
    "id,,name")
  (define-fun T4_4 () String
    "!5!")
  (define-fun T2_6 () String
    "!7!")
  (define-fun T2_2 () String
    "!0!")
  (define-fun T_SELECT_3 () Bool
    false)
  (define-fun T1_4 () String
    "id,,name")
  (define-fun T_SELECT_1 () Bool
    false)
  (define-fun T0_4 () String
    "")
  (define-fun T_SELECT_2 () Bool
    false)
  (define-fun T5_4 () String
    "!6!")
  (define-fun PCTEMP_LHS_1 () Int
    (- 1))
  (define-fun PCTEMP_LHS_2 () Int
    (- 1))
  (define-fun T3_2 () String
    "!1!")
  (define-fun bad_field_count () Bool
    false)
  (define-fun T1_2 () String
    "id,,name")
  (define-fun PCTEMP_LHS_3 () Int
    (- 1))
  (define-fun T5_6 () String
    "!a!")
  (define-fun T4_2 () String
    ",")
  (define-fun T_5 () Bool
    true)
  (define-fun csv_line () String
    "id,,name")
  (define-fun field0 () String
    "A")
  (define-fun T_6 () Bool
    false)
  (define-fun T_4 () Bool
    false)
  (define-fun var_0xINPUT_107890 () String
    "id,,name")
  (define-fun rest1 () String
    "")
  (define-fun T_9 () Bool
    true)
  (define-fun rest2 () String
    "")
  (define-fun field2 () String
    "C")
  (define-fun has_empty_field () Bool
    false)
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    false)
  (define-fun field1 () String
    "B")
  (define-fun delim () String
    ",")
  (define-fun I0_4 () Int
    0)
  (define-fun I0_6 () Int
    0)
  (define-fun I0_2 () Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 105))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))))
              (= x!1 ",")
              (= x!2 1))
      "B"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 105))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))))
              (= x!1 ",")
              (= x!2 2))
      "C"
      "A")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
