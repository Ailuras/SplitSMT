(
  (define-fun rest_after_reqline () String
    "n")
  (define-fun rest_after_headers () String
    "F]GIJ[_")
  (define-fun sat_cl_int () Int
    11)
  (define-fun sat_cl_val () String
    "11")
  (define-fun request () String
    "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\nUser-Agent: TestAgent/1.0\r\n\r\nABCDE")
  (define-fun ua_key () String
    "User-Agent")
  (define-fun host_val () String
    ".")
  (define-fun ua_line () String
    "r\n")
  (define-fun cl_int () Int
    6)
  (define-fun cl_val_raw () String
    " 4")
  (define-fun request_unsat () String
    "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\nUser-Agent: TestAgent/1.0\r\n\r\nABCDE")
  (define-fun body () String
    "F]GIJ[_")
  (define-fun host_val_raw () String
    " .")
  (define-fun unsat_cl_int () Int
    6)
  (define-fun ua_val () String
    "4")
  (define-fun request_line () String
    "POST  HTTP/1.1")
  (define-fun host_key () String
    "Host")
  (define-fun cl_line () String
    "r")
  (define-fun cl_key () String
    "Content-Length")
  (define-fun unsat_cl_val () String
    "4")
  (define-fun sat_case () Bool
    false)
  (define-fun cl_val () String
    "4")
  (define-fun headers_block () String
    "\")
  (define-fun sat_body () String
    "hello=world")
  (define-fun ua_val_raw () String
    " 4")
  (define-fun host_line () String
    "\n")
  (define-fun unsat_body () String
    "ABCDE")
  (define-fun request_sat () String
    "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 11\r\nUser-Agent: TestAgent/1.0\r\n\r\nhello=world")
  (define-fun parse_int ((x!0 String)) Int
    (ite (= x!0 (str.++ (seq.unit (_ Char 49)) (seq.unit (_ Char 49)))) 11
      6))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "n")
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
      "F]GIJ[_"
    (ite (and (= x!0
                 "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\nUser-Agent: TestAgent/1.0\r\n\r\nABCDE")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "n"
    (ite (and (= x!0 "\n") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) " ."
      " 4"))))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "r"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "\n"
    (ite (and (= x!0 "\n") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "Host"
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 58))) (= x!2 0))
      "Content-Length"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "r\n"
    (ite (and (= x!0 "r\n") (= x!1 (seq.unit (_ Char 58))) (= x!2 0))
      "User-Agent"
    (ite (and (= x!0
                 "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 4\r\nUser-Agent: TestAgent/1.0\r\n\r\nABCDE")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "POST  HTTP/1.1"
      "\"))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
      2))
)
