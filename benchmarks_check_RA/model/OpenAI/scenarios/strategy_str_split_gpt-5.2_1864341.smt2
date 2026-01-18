(
  (define-fun csv_unsat () String
    "A,B,C,D")
  (define-fun digits_re () RegLan
    (re.++ (re.range "0" "9") (re.* (re.range "0" "9"))))
  (define-fun rest2_sat () String
    "gamma,delta")
  (define-fun digit_re () RegLan
    (re.range "0" "9"))
  (define-fun mrest1 () String
    ",ok")
  (define-fun u0 () String
    "A")
  (define-fun f3_sat () String
    "delta")
  (define-fun f0_sat () String
    "alpha")
  (define-fun u3 () String
    "D")
  (define-fun u2 () String
    "C")
  (define-fun f2_sat () String
    "gamma")
  (define-fun m1 () String
    "")
  (define-fun u1 () String
    "B")
  (define-fun csv_mixed () String
    "42,,ok")
  (define-fun int_re () RegLan
    (let ((a!1 (re.++ (str.to_re "-")
                  (re.++ (re.range "0" "9") (re.* (re.range "0" "9"))))))
  (re.union (re.++ (re.range "0" "9") (re.* (re.range "0" "9"))) a!1)))
  (define-fun m0 () String
    "42")
  (define-fun f1_sat () String
    "")
  (define-fun csv_sat () String
    "alpha,,gamma,delta")
  (define-fun delim () String
    ",")
  (define-fun m2 () String
    "ok")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "gamma,delta"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 107))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      ",ok"
      "gamma,delta")))
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "alpha"
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "gamma"
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 3))
      "delta"
    (ite (and (= x!0 "A,B,C,D") (= x!1 (seq.unit (_ Char 44))) (= x!2 0)) "A"
    (ite (and (= x!0 "A,B,C,D") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "B"
    (ite (and (= x!0 "A,B,C,D") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) "C"
    (ite (and (= x!0 "A,B,C,D") (= x!1 (seq.unit (_ Char 44))) (= x!2 3)) "D"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 107))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "42"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 107))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "ok"
      ""))))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
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
              (= x!1 (seq.unit (_ Char 44))))
      4
      3))
)
