(
  (define-fun header () String
    "\n")
  (define-fun content_line () String
    "Content-Length:")
  (define-fun host () String
    "A")
  (define-fun second_line () String
    "Host:")
  (define-fun method () String
    "GET")
  (define-fun path () String
    "/")
  (define-fun content_length_str () String
    "9")
  (define-fun request_line () String
    "GET")
  (define-fun content_length_val () Int
    9)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "Host:") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "A"
      "9"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\n") (= x!1 "\n") (= x!2 1)) "Host:"
    (ite (and (= x!0 "\n") (= x!1 "\n") (= x!2 2)) "Content-Length:"
    (ite (and (= x!0 "GET") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "/"
      "GET"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
