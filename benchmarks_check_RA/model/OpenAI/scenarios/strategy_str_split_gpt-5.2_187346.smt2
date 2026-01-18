(
  (define-fun val0_sat () String
    "m")
  (define-fun line1_unsat () String
    "H")
  (define-fun key2_sat () String
    "s")
  (define-fun request_line_sat () String
    "P")
  (define-fun line2_sat () String
    "S")
  (define-fun line0_sat () String
    "POSTIJHTTP/1.1")
  (define-fun body_unsat () String
    "")
  (define-fun cl_int_unsat () Int
    0)
  (define-fun line3_sat () String
    "T")
  (define-fun key1_unsat () String
    "1")
  (define-fun line1_sat () String
    "O")
  (define-fun headers_unsat () String
    "t")
  (define-fun cl_val_trim_sat () String
    "b")
  (define-fun val1_unsat () String
    ".")
  (define-fun key1_sat () String
    "/")
  (define-fun cl_val_str_sat () String
    "u")
  (define-fun val2_sat () String
    "i")
  (define-fun req_unsat () String
    "POST /x HTTP/1.1\r\nHost: a.b\r\nContent-Length: 10\r\n\r\nxyz")
  (define-fun body_sat () String
    "")
  (define-fun val1_sat () String
    "u")
  (define-fun headers_sat () String
    "P")
  (define-fun cl_val_trim_unsat () String
    "\")
  (define-fun req_sat () String
    "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\nUser-Agent: test\r\n\r\nabcde")
  (define-fun cl_int_sat () Int
    0)
  (define-fun key0_sat () String
    " ")
  (define-fun blankline_sat () String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "P")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      4
    (ite (and (= x!0 "t")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
      2)))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "S") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "u"
    (ite (and (= x!0 "O") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "m"
    (ite (and (= x!0 "T") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "i"
    (ite (and (= x!0 "H") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "."
      "")))))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "P")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "POSTIJHTTP/1.1"
    (ite (and (= x!0 "P")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "O"
    (ite (and (= x!0 "P")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "S"
    (ite (and (= x!0 "P")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 3))
      "T"
    (ite (and (= x!0 "O") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) " "
    (ite (and (= x!0 "S") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "/"
    (ite (and (= x!0 "T") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "s"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 80))
                         (seq.unit (_ Char 79))
                         (seq.unit (_ Char 83))
                         (seq.unit (_ Char 84))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 47))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 84))
                         (seq.unit (_ Char 84))
                         (seq.unit (_ Char 80))
                         (seq.unit (_ Char 47))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 72))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 58))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 67))
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
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 122))))
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
      "t"
    (ite (and (= x!0 "t")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "H"
    (ite (and (= x!0 "H") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "1"
      "P")))))))))))
  (define-fun to_int ((x!0 String)) Int
    0)
  (define-fun trim ((x!0 String)) String
    (ite (= x!0 " ") "Host"
    (ite (= x!0 "/") "Content-Length"
    (ite (= x!0 "s") "User-Agent"
    (ite (= x!0 "u") "b"
    (ite (= x!0 "m") "."
    (ite (= x!0 "i") "B"
    (ite (= x!0 "1") "Content-Length"
    (ite (= x!0 ".") "\"
      "Content-Length")))))))))
)
