(
  (define-fun log_entry () String
    "2023-12-25 14:30:45 INFO User login successful")
  (define-fun month () Int
    10)
  (define-fun hour () Int
    20)
  (define-fun delimiter_colon () String
    ":")
  (define-fun message () String
    "C")
  (define-fun valid_timestamp_format () Bool
    true)
  (define-fun timestamp () String
    "2022-10-22 20:28:24")
  (define-fun valid_log_level () Bool
    true)
  (define-fun day () Int
    22)
  (define-fun log_level () String
    "INFO")
  (define-fun year () Int
    2022)
  (define-fun overall_valid () Bool
    true)
  (define-fun second () Int
    24)
  (define-fun delimiter_space () String
    " ")
  (define-fun minute () Int
    28)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 50))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 53))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 53))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 73))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 70))
                         (seq.unit (_ Char 79))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 85))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))
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
                         (seq.unit (_ Char 108))))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "INFO"
      "2022-10-22 20:28:24"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
