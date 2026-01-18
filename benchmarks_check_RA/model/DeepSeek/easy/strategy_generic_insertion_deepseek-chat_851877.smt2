(
  (define-fun var0 () String
    "2379bbejjjn")
  (define-fun segment0 () String
    "A")
  (define-fun rest_string () String
    "")
  (define-fun delimiter () String
    ":")
  (define-fun total_segments () Int
    2)
  (define-fun segment1 () String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "2379bbejjjn") (= x!1 (seq.unit (_ Char 58))) (= x!2 1))
      "B"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
