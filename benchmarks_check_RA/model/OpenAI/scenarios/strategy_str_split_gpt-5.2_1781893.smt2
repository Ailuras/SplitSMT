(
  (define-fun req_sat () String
    "\r\n")
  (define-fun req_unsat () String
    "r")
  (define-fun line_cl_sat () String
    "Content-Length: 5")
  (define-fun line_cl_unsat () String
    "Content-Length: 10")
  (define-fun body_unsat () String
    "DATA")
  (define-fun line_host_sat () String
    "Host: example.com")
  (define-fun cl_value_unsat () String
    "4")
  (define-fun cl_value_unsat_int () Int
    4)
  (define-fun host_key_sat () String
    "Host")
  (define-fun headers_unsat () String
    "n")
  (define-fun cl_value_sat () String
    "5")
  (define-fun cl_key_sat () String
    "Content-Length")
  (define-fun host_value_sat () String
    "example.com")
  (define-fun body_sat () String
    "Hello")
  (define-fun headers_sat () String
    "\")
  (define-fun cl_value_sat_int () Int
    5)
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
      "Hello"
    (ite (and (= x!0 "r")
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
      "DATA"
      "Hello")))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "Host: example.com"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "Content-Length: 5"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 72))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "Host"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 72))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 109))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      "example.com"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 67))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 76))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 53))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "Content-Length"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 67))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 76))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 53))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      "5"
    (ite (and (= x!0 "r")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "n"
    (ite (and (= x!0 "n")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "Content-Length: 10"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 67))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 76))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 48))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      "4"
      "\"))))))))))
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
