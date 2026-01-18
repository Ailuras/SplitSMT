(
  (define-fun req () String
    "c")
  (define-fun X () String
    "c")
  (define-fun headers_block () String
    "o")
  (define-fun host_value () String
    ".")
  (define-fun body () String
    "")
  (define-fun host_line () String
    "m")
  (define-fun cl_line () String
    "s")
  (define-fun cl_value () String
    "0")
  (define-fun start_line () String
    "GET /index.html HTTP/1.1")
  (define-fun cl_int () Int
    0)
  (define-fun ua_line () String
    "U")
  (define-fun ua_value () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "U")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "B"
    (ite (and (= x!0 "s")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "0"
    (ite (and (= x!0 "c")
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
      ""
      "."))))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "o")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 0))
      "GET /index.html HTTP/1.1"
    (ite (and (= x!0 "o")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 1))
      "m"
    (ite (and (= x!0 "o")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 2))
      "U"
    (ite (and (= x!0 "o")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110))))
              (= x!2 3))
      "s"
    (ite (and (= x!0 "m")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 0))
      "Host"
    (ite (and (= x!0 "U")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 0))
      "User-Agent"
    (ite (and (= x!0 "s")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 0))
      "Content-Length"
      "o"))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "o")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
      2))
)
