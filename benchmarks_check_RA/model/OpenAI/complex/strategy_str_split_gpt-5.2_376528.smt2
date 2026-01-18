(
  (define-fun var_0xINPUT_364697 () String
    "2")
  (define-fun T_1 () Bool
    false)
  (define-fun ts () String
    "")
  (define-fun time () String
    "user")
  (define-fun mm () String
    "00")
  (define-fun level () String
    "INFO:")
  (define-fun ss () String
    "00")
  (define-fun T_3 () Bool
    false)
  (define-fun hh () String
    "00")
  (define-fun date () String
    "42--000002")
  (define-fun message () String
    "user")
  (define-fun T_2 () Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "user")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "2") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "INFO:"
    (ite (and (= x!0 "2") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) ""
    (ite (and (= x!0 "") (= x!1 ":") (= x!2 0)) "42--000002"
      "00"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 ":")) 4
      3))
)
