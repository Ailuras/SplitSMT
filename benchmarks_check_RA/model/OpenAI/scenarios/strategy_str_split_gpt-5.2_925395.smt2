(
  (define-fun host_val_raw1 () String
    "s")
  (define-fun cl_line1 () String
    "P")
  (define-fun cl_val1 () String
    "b")
  (define-fun cl_line2 () String
    "i")
  (define-fun content_length1 () Int
    0)
  (define-fun host_line1 () String
    "/")
  (define-fun host1 () String
    "A")
  (define-fun request2 () String
    "POST /x HTTP/1.1\r\nContent-Length: 3\r\n\r\nWXYZ")
  (define-fun content_length2 () Int
    0)
  (define-fun headers2 () String
    "t")
  (define-fun cl_val2 () String
    "")
  (define-fun cl_key2 () String
    "1")
  (define-fun host_key1 () String
    " ")
  (define-fun body1 () String
    "")
  (define-fun headers1 () String
    "O")
  (define-fun cl_val_raw1 () String
    "m")
  (define-fun cl_key1 () String
    "T")
  (define-fun cl_val_raw2 () String
    "")
  (define-fun body2 () String
    "")
  (define-fun request1 () String
    "POST /submit HTTP/1.1\r\nHost: example.com\r\nContent-Length: 5\r\n\r\nabcde")
  (define-fun host_val1 () String
    "A")
  (define-fun lower ((x!0 String)) String
    (ite (= x!0 "u") "s"
    (ite (= x!0 "Host") "s"
      "Host")))
  (define-fun find_header_value ((x!0 String) (x!1 String)) String
    (ite (and (= x!0 "O") (= x!1 "Host")) "/"
    (ite (and (= x!0 "t")
              (= x!1
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
                         (seq.unit (_ Char 104)))))
      "i"
      "P")))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "/") (= x!1 ":") (= x!2 1)) "s"
    (ite (and (= x!0 "P") (= x!1 ":") (= x!2 1)) "m"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "P") (= x!1 ":") (= x!2 0)) "T"
    (ite (and (= x!0 "/") (= x!1 ":") (= x!2 0)) " "
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
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 87))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 89))
                         (seq.unit (_ Char 90))))
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
    (ite (and (= x!0 "i") (= x!1 ":") (= x!2 0)) "1"
      "O")))))
  (define-fun to_int ((x!0 String)) Int
    0)
  (define-fun trim ((x!0 String)) String
    (ite (= x!0 " ") "u"
    (ite (= x!0 "s") "A"
    (ite (= x!0 "m") "b"
    (ite (= x!0 "1") "H"
    (ite (= x!0 "") ""
      "S"))))))
)
