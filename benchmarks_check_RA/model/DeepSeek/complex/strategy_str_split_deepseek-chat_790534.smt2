(error "line 19 column 26: invalid option value")
(error "line 32 column 26: invalid option value")
sat
(
  (define-fun log_entry () String
    "12:34:56 INFO Server started successfully")
  (define-fun message () String
    "B")
  (define-fun log_level () String
    "ERROR")
  (define-fun timestamp () String
    "fully")
  (define-fun space_segments () Int
    0)
  (define-fun colon_segments () Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 53))
                         (seq.unit (_ Char 54))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 73))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 70))
                         (seq.unit (_ Char 79))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 83))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 118))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 102))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 121))))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "ERROR"
      "fully"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "fully") (= x!1 (seq.unit (_ Char 58)))) 2
      3))
)
