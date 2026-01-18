(
  (define-fun var_0xINPUT_163608 () String
    ";")
  (define-fun T_1 () Bool
    true)
  (define-fun T_5 () Bool
    false)
  (define-fun T_c () Bool
    true)
  (define-fun segment1 () String
    "A")
  (define-fun total_segments () Int
    2)
  (define-fun T_3 () Bool
    true)
  (define-fun delimiter () String
    ";")
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun T_a () Bool
    false)
  (define-fun segment0 () String
    "B")
  (define-fun T_9 () Bool
    true)
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    true)
  (define-fun T_b () Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 59)))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 1))
      "A"
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
