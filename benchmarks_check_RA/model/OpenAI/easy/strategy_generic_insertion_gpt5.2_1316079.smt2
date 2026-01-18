(
  (define-fun T_1 () Bool
    false)
  (define-fun T_2 () Bool
    true)
  (define-fun delim_81724 () String
    "")
  (define-fun var_0xINPUT_81724 () String
    "qXdHDo7IZR")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 113))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 68))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 55))
                         (seq.unit (_ Char 73))
                         (seq.unit (_ Char 90))
                         (seq.unit (_ Char 82))))
              (= x!1 "")
              (= x!2 0))
      "qXdHDo7IZR"
      "qXdHDo7IZR"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 113))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 68))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 55))
                         (seq.unit (_ Char 73))
                         (seq.unit (_ Char 90))
                         (seq.unit (_ Char 82))))
              (= x!1 "")
              (= x!2 0))
      "qXdHDo7IZR"
      "qXdHDo7IZR"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
)
