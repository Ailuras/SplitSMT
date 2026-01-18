(
  (define-fun domain_re () RegLan
    (let ((a!1 (re.* (re.union (re.range "a" "z")
                           (re.union (re.range "0" "9") (str.to_re "-"))))))
(let ((a!2 (re.++ (re.++ (re.union (re.range "a" "z") (re.range "0" "9")) a!1)
                  (re.union (re.range "a" "z") (re.range "0" "9")))))
  (re.++ a!2 (re.* (re.++ (str.to_re ".") a!2))))))
  (define-fun email_bad () String
    "a@b.c")
  (define-fun domain_bad () String
    "o")
  (define-fun email_ok () String
    "john.doe+1@sub.example.com")
  (define-fun first_label_ok () String
    "a@b.c")
  (define-fun tld_ok () String
    "cp")
  (define-fun domain_ok () String
    "3-9x")
  (define-fun local_bad () String
    "0")
  (define-fun tld_bad () String
    "@A")
  (define-fun domain_label_re () RegLan
    (let ((a!1 (re.* (re.union (re.range "a" "z")
                           (re.union (re.range "0" "9") (str.to_re "-"))))))
  (re.++ (re.++ (re.union (re.range "a" "z") (re.range "0" "9")) a!1)
         (re.union (re.range "a" "z") (re.range "0" "9")))))
  (define-fun sld_ok () String
    "0")
  (define-fun local_ok () String
    "0")
  (define-fun rest_labels_ok () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 106))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 100))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 49))
                         (seq.unit (_ Char 64))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 46))
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
              (= x!1 "@")
              (= x!2 1))
      "3-9x"
    (ite (and (= x!0 "3-9x") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "a@b.c"
    (ite (and (= x!0 "3-9x") (= x!1 (seq.unit (_ Char 46))) (= x!2 12280)) "cp"
    (ite (and (= x!0 "a@b.c") (= x!1 "@") (= x!2 1)) "o"
    (ite (and (= x!0 "o") (= x!1 (seq.unit (_ Char 46))) (= x!2 13506)) "@A"
      "0"))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "3-9x") (= x!1 (seq.unit (_ Char 46)))) 12281
    (ite (and (= x!0 "o") (= x!1 (seq.unit (_ Char 46)))) 13507
      2)))
)
