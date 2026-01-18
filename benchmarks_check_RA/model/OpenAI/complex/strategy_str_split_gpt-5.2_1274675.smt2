(
  (define-fun two_digits () RegLan
    (let ((a!1 (re.union (str.to_re "6")
                     (re.union (str.to_re "7")
                               (re.union (str.to_re "8") (str.to_re "9"))))))
(let ((a!2 (re.union (str.to_re "3")
                     (re.union (str.to_re "4") (re.union (str.to_re "5") a!1)))))
(let ((a!3 (re.union (str.to_re "0")
                     (re.union (str.to_re "1") (re.union (str.to_re "2") a!2)))))
  (re.++ a!3 a!3)))))
  (define-fun y () String
    "")
  (define-fun x () String
    "")
  (define-fun digit () RegLan
    (let ((a!1 (re.union (str.to_re "6")
                     (re.union (str.to_re "7")
                               (re.union (str.to_re "8") (str.to_re "9"))))))
(let ((a!2 (re.union (str.to_re "3")
                     (re.union (str.to_re "4") (re.union (str.to_re "5") a!1)))))
  (re.union (str.to_re "0")
            (re.union (str.to_re "1") (re.union (str.to_re "2") a!2))))))
  (define-fun logline () String
    "ABCDEGHJKL")
  (define-fun four_digits () RegLan
    (let ((a!1 (re.union (str.to_re "6")
                     (re.union (str.to_re "7")
                               (re.union (str.to_re "8") (str.to_re "9"))))))
(let ((a!2 (re.union (str.to_re "3")
                     (re.union (str.to_re "4") (re.union (str.to_re "5") a!1)))))
(let ((a!3 (re.union (str.to_re "0")
                     (re.union (str.to_re "1") (re.union (str.to_re "2") a!2)))))
  (re.++ a!3 (re.++ a!3 (re.++ a!3 a!3)))))))
  (define-fun kvpart () String
    "F")
  (define-fun ts () String
    " ")
  (define-fun month () String
    "01")
  (define-fun timepart () String
    "N")
  (define-fun key1 () String
    "baaa")
  (define-fun hour () String
    "13")
  (define-fun datepart () String
    "I")
  (define-fun message () String
    "=")
  (define-fun day () String
    "09")
  (define-fun year () String
    "2024")
  (define-fun level () String
    "INFO:")
  (define-fun second () String
    "42")
  (define-fun val1 () String
    "ok")
  (define-fun minute () String
    "37")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "=")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "ABCDEGHJKL") (= x!1 " ") (= x!2 1)) "INFO:"
    (ite (and (= x!0 "ABCDEGHJKL") (= x!1 " ") (= x!2 0)) " "
    (ite (and (= x!0 " ") (= x!1 " ") (= x!2 0)) "I"
    (ite (and (= x!0 "I") (= x!1 (seq.unit (_ Char 45))) (= x!2 0)) "2024"
    (ite (and (= x!0 "I") (= x!1 (seq.unit (_ Char 45))) (= x!2 1)) "01"
    (ite (and (= x!0 "I") (= x!1 (seq.unit (_ Char 45))) (= x!2 2)) "09"
    (ite (and (= x!0 " ") (= x!1 " ") (= x!2 1)) "N"
    (ite (and (= x!0 "N") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "13"
    (ite (and (= x!0 "N") (= x!1 (seq.unit (_ Char 58))) (= x!2 1)) "37"
    (ite (and (= x!0 "N") (= x!1 (seq.unit (_ Char 58))) (= x!2 2)) "42"
    (ite (and (= x!0 "=") (= x!1 " ") (= x!2 0)) "F"
    (ite (and (= x!0 "F") (= x!1 "=") (= x!2 0)) "baaa"
    (ite (and (= x!0 "F") (= x!1 "=") (= x!2 1)) "ok"
      "INFO:"))))))))))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "F") (= x!1 "=")) 2
      3))
)
