(
  (define-fun unsat_witness () Bool
    false)
  (define-fun X () String
    "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 0\r\n\r\n")
  (define-fun headers_block () String
    "y")
  (define-fun host_value () String
    "\.")
  (define-fun body () String
    "AB")
  (define-fun sat_example () String
    "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 0\r\n\r\n")
  (define-fun cl_value () String
    " [0-9]+")
  (define-fun host_line () String
    "w")
  (define-fun cl_line () String
    "a")
  (define-fun cl_key () String
    "Content-Length")
  (define-fun request_line () String
    "m")
  (define-fun host_key () String
    "Host")
  (define-fun parsed_len () Int
    2)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 0\r\n\r\n")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
    (ite (and (= x!0 "m") (= x!1 (seq.unit (_ Char 32)))) 3
      2)))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "a") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) " [0-9]+"
    (ite (and (= x!0 "w") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "\."
    (ite (and (= x!0
                 "GET / HTTP/1.1\r\nHost: example.com\r\nContent-Length: 0\r\n\r\n")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "AB"
      "y"))))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "m") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "GET"
    (ite (and (= x!0 "m") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "/"
    (ite (and (= x!0 "m") (= x!1 (seq.unit (_ Char 32))) (= x!2 2)) "HTTP/1.1"
    (ite (and (= x!0 "y")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "w"
    (ite (and (= x!0 "y")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "a"
    (ite (and (= x!0 "w") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "Host"
    (ite (and (= x!0 "a") (= x!1 (seq.unit (_ Char 58))) (= x!2 0))
      "Content-Length"
      "m"))))))))
  (define-fun parse_int ((x!0 String)) Int
    2)
)
