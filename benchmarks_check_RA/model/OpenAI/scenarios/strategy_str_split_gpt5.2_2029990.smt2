(
  (define-fun rest3_sat () String
    "D")
  (define-fun rest2_sat () String
    "0,D")
  (define-fun rest1_sat () String
    ",0,D")
  (define-fun u0 () String
    "")
  (define-fun f3_sat () String
    "D")
  (define-fun f0_sat () String
    "C")
  (define-fun u3 () String
    "E")
  (define-fun f1_sat () String
    "")
  (define-fun u2 () String
    "")
  (define-fun f2_sat () String
    "0")
  (define-fun u1 () String
    "")
  (define-fun csv_line_sat () String
    "alice,,42,NY")
  (define-fun csv_line_unsat () String
    "A,,B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 2))
      "0,D"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 3))
      "D"
      ",0,D")))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 0))
      "C"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 2))
      "0"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 3))
      "D"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 65))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 66))))
              (= x!1 ",")
              (= x!2 3))
      "E"
      "")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
