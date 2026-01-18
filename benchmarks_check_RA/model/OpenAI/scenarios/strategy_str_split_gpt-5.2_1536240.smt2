(
  (define-fun time_sat () String
    "6")
  (define-fun time_unsat () String
    "2")
  (define-fun ts_unsat () String
    "2026-01-09T12:34:56")
  (define-fun msg_sat () String
    "user=Jaction=")
  (define-fun date_unsat () String
    "2")
  (define-fun date_sat () String
    "0")
  (define-fun yyyy_sat () String
    "2026")
  (define-fun ts_sat () String
    "2")
  (define-fun level_colon_sat () String
    "-")
  (define-fun hh_sat () String
    "12")
  (define-fun log_line_unsat () String
    "2026-01-09T12:34:56 INFO: something")
  (define-fun level_colon_unsat () String
    "2")
  (define-fun level_sat () String
    "INFO")
  (define-fun log_line_sat () String
    "2026-01-09 12:34:56 INFO: user=jdoe action=login")
  (define-fun mm_sat () String
    "01")
  (define-fun ss_sat () String
    "56")
  (define-fun mi_sat () String
    "34")
  (define-fun dd_sat () String
    "09")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "user=Jaction=")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "2") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "0"
    (ite (and (= x!0 "0") (= x!1 "-") (= x!2 0)) "2026"
    (ite (and (= x!0 "0") (= x!1 "-") (= x!2 1)) "01"
    (ite (and (= x!0 "0") (= x!1 "-") (= x!2 2)) "09"
    (ite (and (= x!0 "2") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "6"
    (ite (and (= x!0 "6") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "12"
    (ite (and (= x!0 "6") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "34"
    (ite (and (= x!0 "6") (= x!1 (seq.unit (_ Char 58))) (= x!2 2)) "56"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 50))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 54))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 49))
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
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 61))
                         (seq.unit (_ Char 106))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 61))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "-"
    (ite (and (= x!0 "-") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "INFO"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 50))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 54))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 84))
                         (seq.unit (_ Char 49))
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
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 103))))
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 0))
      "2026-01-09T12:34:56"
      "2"))))))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "2") (= x!1 (seq.unit (_ Char 32)))) 2
    (ite (and (= x!0 "-") (= x!1 (seq.unit (_ Char 58)))) 2
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 50))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 54))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 84))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 53))
                         (seq.unit (_ Char 54))))
              (= x!1 (seq.unit (_ Char 32))))
      2
      3))))
)
