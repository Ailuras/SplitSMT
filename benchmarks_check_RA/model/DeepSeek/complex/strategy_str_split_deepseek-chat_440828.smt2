(
  (define-fun header () String
    "n")
  (define-fun key2 () String
    "n")
  (define-fun key1 () String
    "Content-Length")
  (define-fun value2 () String
    "")
  (define-fun content_length_val () Int
    2)
  (define-fun first_line () String
    "\")
  (define-fun content_length_str () String
    "\")
  (define-fun value1 () String
    "2")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\") (= x!1 (seq.unit (_ Char 58))) (= x!2 0))
      "Content-Length"
    (ite (and (= x!0 "\") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "2"
    (ite (and (= x!0 "n")
              (= x!1 (str.++ (seq.unit (_ Char 92)) (seq.unit (_ Char 110))))
              (= x!2 2))
      "n:"
    (ite (and (= x!0 "n:") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "n"
    (ite (and (= x!0 "n:") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) ""
      "\"))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "n")
              (= x!1 (str.++ (seq.unit (_ Char 92)) (seq.unit (_ Char 110)))))
      3
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
