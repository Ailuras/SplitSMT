(
  (define-fun request () String
    "\r\n")
  (define-fun http_version () String
    "HTTP/1.1")
  (define-fun body_len () Int
    5)
  (define-fun uri () String
    "/submit")
  (define-fun method () String
    "POST")
  (define-fun make_unsat () Bool
    false)
  (define-fun cl_len () Int
    5)
  (define-fun cl_value () String
    "5")
  (define-fun cl_line () String
    "\n")
  (define-fun cl_key () String
    "Content-Length")
  (define-fun ua_key () String
    "User-Agent")
  (define-fun ua_line () String
    "r\n")
  (define-fun host_value () String
    "example.com")
  (define-fun ua_value () String
    "curl/8.0")
  (define-fun body () String
    "abcde")
  (define-fun host_line () String
    "n")
  (define-fun request_line () String
    "r")
  (define-fun header_block () String
    "\")
  (define-fun host_key () String
    "Host")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
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
      "abcde"
    (ite (and (= x!0 "n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "example.com"
    (ite (and (= x!0 "\n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "5"
    (ite (and (= x!0 "r\n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "curl/8.0"
      "abcde")))))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "r"
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "POST"
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "/submit"
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 32))) (= x!2 2)) "HTTP/1.1"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "n"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "\n"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 3))
      "r\n"
    (ite (and (= x!0 "n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 0))
      "Host"
    (ite (and (= x!0 "\n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 0))
      "Content-Length"
    (ite (and (= x!0 "r\n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 0))
      "User-Agent"
      "\")))))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      4
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 32)))) 3
      2)))
)
