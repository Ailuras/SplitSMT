(
  (define-fun segment0 () String
    "6")
  (define-fun delimiter () String
    "at")
  (define-fun x () String
    "6atPZ2")
  (define-fun total_segments () Int
    2)
  (define-fun segment1 () String
    "PZ2")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 54))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 80))
                         (seq.unit (_ Char 90))
                         (seq.unit (_ Char 50))))
              (= x!1 (str.++ (seq.unit (_ Char 97)) (seq.unit (_ Char 116))))
              (= x!2 1))
      "PZ2"
      "6"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
