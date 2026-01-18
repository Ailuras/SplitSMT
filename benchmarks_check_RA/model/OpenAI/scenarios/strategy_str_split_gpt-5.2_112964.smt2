(
  (define-fun csv_line_unsat () String
    ",xB,")
  (define-fun rest2_sat () String
    ",")
  (define-fun rest1_sat () String
    ",")
  (define-fun u0 () String
    "")
  (define-fun f3_sat () String
    "F")
  (define-fun f0_sat () String
    "id,name,age")
  (define-fun u2 () String
    "G")
  (define-fun f2_sat () String
    "E")
  (define-fun u1 () String
    "")
  (define-fun rest3_sat () String
    "A")
  (define-fun header_line () String
    "id,name,age")
  (define-fun h0 () String
    "J")
  (define-fun f1_sat () String
    "")
  (define-fun comma () String
    ",")
  (define-fun h1 () String
    "H")
  (define-fun csv_line_sat () String
    "alpha,,gamma,delta")
  (define-fun h2 () String
    "I")
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
              (= x!1 ",")
              (= x!2 3))
      "A"
      ","))
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
      "id,name,age"
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
      "E"
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
      "F"
    (ite (and (= x!0 ",xB,") (= x!1 ",") (= x!2 2)) "G"
    (ite (and (= x!0 "id,name,age") (= x!1 ",") (= x!2 0)) "J"
    (ite (and (= x!0 "id,name,age") (= x!1 ",") (= x!2 1)) "H"
    (ite (and (= x!0 "id,name,age") (= x!1 ",") (= x!2 2)) "I"
      ""))))))))
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
              (= x!1 ","))
      4
      3))
)
