(
  (define-fun var_0xINPUT_10301 () String
    "\r\n")
  (define-fun T_1 () Bool
    true)
  (define-fun host_value () String
    "A")
  (define-fun host_line () String
    "r")
  (define-fun cl_line () String
    "n")
  (define-fun cl_value () String
    "0")
  (define-fun T_2 () Bool
    true)
  (define-fun content_length () Int
    42)
  (define-fun headers () String
    "\")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "A"
      "0"))
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
              (= x!2 2))
      "n"
    (ite (and (= x!0 "r") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "Host"
    (ite (and (= x!0 "n") (= x!1 (seq.unit (_ Char 58))) (= x!2 0))
      "Content-Length"
      "\")))))
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
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      1
    (ite (and (= x!0 "\")
              (= x!1
                 (str.++ (seq.unit (_ Char 92))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 92))
                         (seq.unit (_ Char 110)))))
      3
      2)))
)
