(
  (define-fun seg0 () String
    "4")
  (define-fun T_1 () Bool
    true)
  (define-fun T_5 () Bool
    false)
  (define-fun var_0xINPUT_233086 () String
    "4PH2ujcENG")
  (define-fun seg1 () String
    "H2ujcENG")
  (define-fun seg_rest1 () String
    "H2ujcENG")
  (define-fun T_3 () Bool
    false)
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 80))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 106))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 71))))
              (= x!1 (seq.unit (_ Char 80)))
              (= x!2 1))
      "H2ujcENG"
      "H2ujcENG"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 80))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 106))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 71))))
              (= x!1 (seq.unit (_ Char 80)))
              (= x!2 1))
      "H2ujcENG"
      "4"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
