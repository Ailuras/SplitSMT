(
  (define-fun header () String
    "\nQContent-Length: WHost: R")
  (define-fun host () String
    "A")
  (define-fun path () String
    "/index.html")
  (define-fun method () String
    "GET")
  (define-fun content_length_val () Int
    2)
  (define-fun content_length_str () String
    "2")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "n")
              (= x!1 (str.++ (seq.unit (_ Char 58)) (seq.unit (_ Char 32))))
              (= x!2 1))
      "2"
      "A"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "GET /index.html")
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 0))
      "GET"
    (ite (and (= x!0 "GET /index.html")
              (= x!1 (seq.unit (_ Char 32)))
              (= x!2 1))
      "/index.html"
    (ite (and (= x!0 "\nQContent-Length: WHost: R")
              (= x!1 (str.++ (seq.unit (_ Char 92)) (seq.unit (_ Char 110))))
              (= x!2 1))
      "\"
    (ite (and (= x!0 "\nQContent-Length: WHost: R")
              (= x!1 (str.++ (seq.unit (_ Char 92)) (seq.unit (_ Char 110))))
              (= x!2 2))
      "n"
      "GET /index.html")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "\nQContent-Length: WHost: R")
              (= x!1 (str.++ (seq.unit (_ Char 92)) (seq.unit (_ Char 110)))))
      3
      2))
)
