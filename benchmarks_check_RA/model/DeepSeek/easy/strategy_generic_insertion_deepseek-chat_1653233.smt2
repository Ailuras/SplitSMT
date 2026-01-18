(
  (define-fun A () String
    "dcfdefffdf")
  (define-fun delimiter () String
    ":")
  (define-fun J () String
    "f")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 100))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 102))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 2))
      "path"
      "path"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 100))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 102))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "protocol"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 100))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 102))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      "host"
      "protocol")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
