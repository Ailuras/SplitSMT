(
  (define-fun csv_line_sat () String
    ",")
  (define-fun csv_line_unsat () String
    ",,")
  (define-fun rest2_sat () String
    "G,F")
  (define-fun rest3_sat () String
    "F")
  (define-fun u0 () String
    "D")
  (define-fun f3_sat () String
    "F")
  (define-fun f0_sat () String
    "E")
  (define-fun f1_sat () String
    "")
  (define-fun u2 () String
    "C")
  (define-fun f2_sat () String
    "G")
  (define-fun u1 () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 3))
      "F"
      "G,F"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "E"
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "G"
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 3))
      "F"
    (ite (and (= x!0 ",,") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) "C"
    (ite (and (= x!0 ",,") (= x!1 (seq.unit (_ Char 44))) (= x!2 0)) "D"
    (ite (and (= x!0 ",,") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "A"
      "")))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ",,") (= x!1 (seq.unit (_ Char 44)))) 3
      4))
)
