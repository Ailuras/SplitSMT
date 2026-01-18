(
  (define-fun var_0xINPUT_42194 () String
    ",")
  (define-fun T_1 () Bool
    false)
  (define-fun part2 () String
    "A")
  (define-fun part1 () String
    "B")
  (define-fun T_2 () Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "A"
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
