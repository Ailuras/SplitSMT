(
  (define-fun log_entry () String
    "DGHJK ")
  (define-fun hour () String
    "B")
  (define-fun colon_segments () Int
    2)
  (define-fun message () String
    "CLMP:")
  (define-fun log_level () String
    "INFO")
  (define-fun timestamp () String
    "CLMP:")
  (define-fun space_segments () Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "CLMP:")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "CLMP:") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "B"
    (ite (and (= x!0 "DGHJK ") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "INFO"
      "CLMP:")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "CLMP:") (= x!1 (seq.unit (_ Char 58)))) 2
      3))
)
