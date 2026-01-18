(
  (define-fun header1 () String
    "\r\n")
  (define-fun header2 () String
    "\")
  (define-fun h2_line1 () String
    "Host: a")
  (define-fun line1_3 () String
    "X-Note: hello")
  (define-fun line1_2 () String
    "Content-Length: 5")
  (define-fun clen_kv1 () String
    "Content-Length: 5")
  (define-fun h2_line2 () String
    "Content-Length: 4")
  (define-fun content_length1 () Int
    5)
  (define-fun h2_blank () String
    "")
  (define-fun clen_key1 () String
    "Content-Length")
  (define-fun line1_4 () String
    "")
  (define-fun content_length2 () Int
    3)
  (define-fun line1_1 () String
    "Host: example.com")
  (define-fun request_line1 () String
    "POST /submit HTTP/1.1")
  (define-fun request_line2 () String
    "POST /data HTTP/1.1")
  (define-fun clen_val1 () String
    "5")
  (define-fun body1 () String
    "abcde")
  (define-fun clen_val2 () String
    "3")
  (define-fun host_key1 () String
    "Host")
  (define-fun body2 () String
    "XYZ")
  (define-fun host_kv1 () String
    "Host: example.com")
  (define-fun clen_kv2 () String
    "Content-Length: 4")
  (define-fun host_val1 () String
    "example.com")
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
                         (seq.unit (_ Char 110))))
              (= x!2 5))
      "abcde"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 4))
      "XYZ"
      "abcde")))
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
      "POST /submit HTTP/1.1"
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
      "Host: example.com"
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
      "Content-Length: 5"
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
              (= x!2 3))
      "X-Note: hello"
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
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
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
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
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
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
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
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "5"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "POST /data HTTP/1.1"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "Host: a"
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "Content-Length: 4"
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
                         (seq.unit (_ Char 52))))
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "3"
      "")))))))))))))
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
      6
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      5
      2)))
)
