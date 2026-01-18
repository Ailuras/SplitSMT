(
  (define-fun rest1_sat () String
    "C")
  (define-fun f3_sat () String
    "B")
  (define-fun f0_sat () String
    "A")
  (define-fun g0_unsat () String
    "")
  (define-fun f2_sat () String
    "")
  (define-fun g3_unsat () String
    ",")
  (define-fun empty_count_sat () Int
    1)
  (define-fun csv_line_unsat () String
    "a,b,c,d")
  (define-fun g2_unsat () String
    ",")
  (define-fun empty_count_unsat () Int
    1)
  (define-fun f1_sat () String
    "C")
  (define-fun g1_unsat () String
    ",")
  (define-fun csv_line_sat () String
    "alpha,,gamma,delta")
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))))
              (= x!1 ",")
              (= x!2 0))
      "A"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))))
              (= x!1 ",")
              (= x!2 1))
      "C"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))))
              (= x!1 ",")
              (= x!2 2))
      ""
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))))
              (= x!1 ",")
              (= x!2 3))
      "B"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 100))))
              (= x!1 ",")
              (= x!2 0))
      ""
      ","))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
