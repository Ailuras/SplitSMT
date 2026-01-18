(
  (define-fun csv_line () String
    ",")
  (define-fun f2 () String
    "-")
  (define-fun digit_re () RegLan
    (let ((a!1 (re.union (str.to_re "6")
                     (re.union (str.to_re "7")
                               (re.union (str.to_re "8") (str.to_re "9"))))))
(let ((a!2 (re.union (str.to_re "3")
                     (re.union (str.to_re "4") (re.union (str.to_re "5") a!1)))))
  (re.union (str.to_re "0")
            (re.union (str.to_re "1") (re.union (str.to_re "2") a!2))))))
  (define-fun rest3 () String
    "B")
  (define-fun f3 () String
    "C")
  (define-fun rest2 () String
    "B")
  (define-fun f0 () String
    "id")
  (define-fun n () Int
    4)
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "9")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 0)) "id"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 1)) "9"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 2)) "-"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 3)) "C"
      "id")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
