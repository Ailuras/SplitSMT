(
  (define-fun u_has_empty () Bool
    false)
  (define-fun f2 () String
    "E")
  (define-fun u0 () String
    "D")
  (define-fun csv_line () String
    "alpha,,gamma")
  (define-fun u3 () String
    "A")
  (define-fun has_empty () Bool
    true)
  (define-fun u2 () String
    "B")
  (define-fun u1 () String
    "C")
  (define-fun total_fields () Int
    3)
  (define-fun rest2 () String
    "E")
  (define-fun csv_line_u () String
    "a,,c")
  (define-fun comma () String
    ",")
  (define-fun f0 () String
    "a,,c")
  (define-fun u_total_fields () Int
    4)
  (define-fun f1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "E")
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
                         (seq.unit (_ Char 97))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "a,,c"
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
                         (seq.unit (_ Char 97))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "E"
    (ite (and (= x!0 "a,,c") (= x!1 (seq.unit (_ Char 44))) (= x!2 0)) "D"
    (ite (and (= x!0 "a,,c") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "C"
    (ite (and (= x!0 "a,,c") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) "B"
    (ite (and (= x!0 "a,,c") (= x!1 (seq.unit (_ Char 44))) (= x!2 3)) "A"
      "")))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "a,,c") (= x!1 (seq.unit (_ Char 44)))) 4
      3))
)
