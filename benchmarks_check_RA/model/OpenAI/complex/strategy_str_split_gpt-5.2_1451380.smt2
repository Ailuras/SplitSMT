(
  (define-fun X () String
    ",")
  (define-fun f2 () String
    "")
  (define-fun hasEmpty () Bool
    true)
  (define-fun rest2 () String
    "")
  (define-fun f0 () String
    "A")
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "A"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
