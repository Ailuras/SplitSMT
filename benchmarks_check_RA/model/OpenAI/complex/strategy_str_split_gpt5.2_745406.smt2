(
  (define-fun X () String
    "\u{a}")
  (define-fun parsed_len () Int
    42)
  (define-fun header_name0 () String
    "Host")
  (define-fun header_value0 () String
    " 4A-311")
  (define-fun content_length_line () String
    "Content-Length:0")
  (define-fun header_line0 () String
    "Host:a")
  (define-fun content_length_value () String
    "42")
  (define-fun host_line () String
    "Host:a")
  (define-fun ua_line () String
    "User-Agent:etbuviaebe/eqv.bvv")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "Content-Length:0") (= x!1 ":") (= x!2 1)) "42"
      " 4A-311"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 10)))
              (= x!1 (seq.unit (_ Char 10)))
              (= x!2 2))
      "User-Agent:etbuviaebe/eqv.bvv"
    (ite (and (= x!0 (seq.unit (_ Char 10)))
              (= x!1 (seq.unit (_ Char 10)))
              (= x!2 0))
      "Host:a"
    (ite (and (= x!0 (seq.unit (_ Char 10)))
              (= x!1 (seq.unit (_ Char 10)))
              (= x!2 1))
      "Content-Length:0"
    (ite (and (= x!0 "Host:a") (= x!1 ":") (= x!2 0)) "Host"
    (ite (and (= x!0 "Content-Length:0") (= x!1 ":") (= x!2 0)) "Content-Length"
    (ite (and (= x!0 (seq.unit (_ Char 10)))
              (= x!1 (seq.unit (_ Char 10)))
              (= x!2 3))
      ""
      "User-Agent:etbuviaebe/eqv.bvv")))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 10))) (= x!1 (seq.unit (_ Char 10)))) 4
      2))
)
