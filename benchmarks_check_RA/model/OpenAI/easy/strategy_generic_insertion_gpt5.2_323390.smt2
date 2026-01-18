(
  (define-fun var_0xINPUT_49578 () String
    ",")
  (define-fun T_1 () Bool
    true)
  (define-fun seg0_49578 () String
    "B")
  (define-fun delim_49578 () String
    ",")
  (define-fun seg1_49578 () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "!0!"
      "A!0!"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "A"
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
