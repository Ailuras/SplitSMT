(
  (define-fun seg0 () String
    "c\\|8")
  (define-fun rest0 () String
    "c\\|8")
  (define-fun x () String
    "c\\|8")
  (define-fun d () String
    "\\|")
  (define-fun k () Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 99))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 124))
                         (seq.unit (_ Char 56))))
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 124))))
              (= x!2 0))
      "c\\|8"
      "c\\|8"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 99))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 124))
                         (seq.unit (_ Char 56))))
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 124))))
              (= x!2 0))
      "c\\|8"
      "c\\|8"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
)
