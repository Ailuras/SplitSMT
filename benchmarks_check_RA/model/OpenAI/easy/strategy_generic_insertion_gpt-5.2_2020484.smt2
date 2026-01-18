(
  (define-fun key2 () String
    "transfer-encoding")
  (define-fun key1 () String
    "transfer-encoding")
  (define-fun key1_namespace () String
    "trailers")
  (define-fun key1_name () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 116))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 103))))
              (= x!1 (seq.unit (_ Char 45)))
              (= x!2 0))
      "trailers"
      "trailers"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
