(
  (define-fun headers_unsat () String
    "\n")
  (define-fun headers_sat () String
    "\r\n")
  (define-fun cl_val_unsat () String
    " 4")
  (define-fun version_unsat () String
    "HTTP/1.1")
  (define-fun body_unsat () String
    "abc")
  (define-fun request_line_sat () String
    "\")
  (define-fun cl_val_sat () String
    " 5")
  (define-fun host_val_sat () String
    " example.com")
  (define-fun request_line_unsat () String
    "r\n")
  (define-fun host_line_unsat () String
    "POST")
  (define-fun cl_line_unsat () String
    "\r\n")
  (define-fun host_key_sat () String
    "Host")
  (define-fun path_sat () String
    "/")
  (define-fun cl_int_unsat () Int
    3)
  (define-fun path_unsat () String
    "/")
  (define-fun cl_key_sat () String
    "Content-Length")
  (define-fun method_unsat () String
    "POST")
  (define-fun method_sat () String
    "POST")
  (define-fun body_sat () String
    "hello")
  (define-fun req_unsat () String
    "\n\r\n\r\nabc")
  (define-fun version_sat () String
    "HTTP/1.1")
  (define-fun host_line_sat () String
    "r")
  (define-fun req_sat () String
    "\r\n\r\n\r\nhello")
  (define-fun cl_int_sat () Int
    5)
  (define-fun cl_line_sat () String
    "n")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
    (ite (and (= x!0 "\n")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
      2)))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 58))) (= x!2 1))
      " example.com"
    (ite (and (= x!0 "n") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) " 5"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      " 4"
      " example.com"))))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "\"
    (ite (and (= x!0 "\") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "POST"
    (ite (and (= x!0 "\") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "/"
    (ite (and (= x!0 "\") (= x!1 (seq.unit (_ Char 32))) (= x!2 2)) "HTTP/1.1"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "r"
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "Host"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "n"
    (ite (and (= x!0 "n") (= x!1 (seq.unit (_ Char 58))) (= x!2 0))
      "Content-Length"
    (ite (and (= x!0 "\n")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "r\n"
    (ite (and (= x!0 "r\n") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "POST"
    (ite (and (= x!0 "r\n") (= x!1 (seq.unit (_ Char 32))) (= x!2 1)) "/"
    (ite (and (= x!0 "r\n") (= x!1 (seq.unit (_ Char 32))) (= x!2 2)) "HTTP/1.1"
    (ite (and (= x!0 "\n")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "\r\n"
      "POST"))))))))))))))
  (define-fun parse_int ((x!0 String)) Int
    (ite (= x!0 (str.++ (seq.unit (_ Char 32)) (seq.unit (_ Char 52)))) 3
      5))
)
