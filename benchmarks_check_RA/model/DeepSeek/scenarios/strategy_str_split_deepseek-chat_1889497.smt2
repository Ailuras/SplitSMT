(
  (define-fun request () String
    "Content-Length")
  (define-fun key () String
    "\")
  (define-fun value () String
    "\")
  (define-fun header_line () String
    "\")
  (define-fun content_length () Int
    2)
  (define-fun content_length_str () String
    "2")
  (define-fun num_headers () Int
    3)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (let ((a!1 (or (and (= x!0 "\") (= x!1 ":") (<= 1 x!2) (not (<= 2 x!2)))
                   (and (= x!0 "\") (= x!1 ":") (not (<= 1 x!2)))
                   (and (= x!0 "Content-Length") (= x!1 "\n") (not (<= 1 x!2))))))
    (let ((a!2 (ite (and (= x!0 "Content-Length")
                         (= x!1 "\n")
                         (<= 1 x!2)
                         (not (<= 2 x!2)))
                    "Content-Length"
                    (ite a!1 "\" "!0!"))))
      (ite (and (= x!0 "Content-Length")
                (= x!1 ":")
                (<= 1 x!2)
                (not (<= 2 x!2)))
           "2"
           a!2))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "Content-Length")
              (= x!1 (str.++ (seq.unit (_ Char 92)) (seq.unit (_ Char 110)))))
      3
    (ite (and (= x!0 "\") (= x!1 (seq.unit (_ Char 58)))) 2
    (ite (and (= x!0 "Content-Length") (= x!1 (seq.unit (_ Char 58)))) 2
      19))))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
