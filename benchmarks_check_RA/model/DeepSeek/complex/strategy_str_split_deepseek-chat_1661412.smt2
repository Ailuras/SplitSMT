(
  (define-fun header () String
    "Content-Length:D\n")
  (define-fun key () String
    ":")
  (define-fun value () String
    "A")
  (define-fun after_content_length () String
    "")
  (define-fun content_length_val () Int
    2)
  (define-fun first_line () String
    ":")
  (define-fun content_length_str () String
    "2")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ":") (= x!1 ":") (= x!2 1)) "A"
    (ite (and (= x!0 "") (= x!1 "\n") (= x!2 0)) "2"
      ":")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ":") (= x!1 ":")) 2
      3))
)
