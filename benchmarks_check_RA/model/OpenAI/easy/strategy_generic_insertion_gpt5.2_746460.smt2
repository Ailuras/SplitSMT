(
  (define-fun var_0xINPUT_42194 () String
    "|")
  (define-fun delim_42194 () String
    "|")
  (define-fun T_1 () Bool
    false)
  (define-fun seg0_42194 () String
    "abc")
  (define-fun rest1_42194 () String
    "def")
  (define-fun T_2 () Bool
    true)
  (define-fun seg1_42194 () String
    "abc")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "def")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 124)))
              (= x!1 (seq.unit (_ Char 124)))
              (= x!2 0))
      "abc"
      "abc"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
