(
  (define-fun domain_part () String
    "u")
  (define-fun T_1 () Bool
    false)
  (define-fun T_5 () Bool
    true)
  (define-fun tld () String
    "CD")
  (define-fun T_3 () Bool
    false)
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun domain_label1 () String
    "B")
  (define-fun domain_label0 () String
    "A")
  (define-fun var_0xINPUT_151642 () String
    "user.name+tag@example.co")
  (define-fun unsat_guard () Bool
    false)
  (define-fun T_9 () Bool
    true)
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    true)
  (define-fun local_part () String
    "u")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "A"
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "B"
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46))) (= x!2 30613)) "CD"
      "u"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "u") (= x!1 (seq.unit (_ Char 46)))) 30614
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
