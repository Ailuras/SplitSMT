(
  (define-fun email_bad () String
    "bob@example.com")
  (define-fun domain_parts_bad () Int
    3)
  (define-fun domain_bad () String
    "i")
  (define-fun email_ok () String
    "alice.smith+tag@example.co.uk")
  (define-fun tld_ok () String
    "uk")
  (define-fun domain_ok () String
    "")
  (define-fun label0_ok () String
    "l")
  (define-fun rest_after_at_ok () String
    "")
  (define-fun local_bad () String
    "@")
  (define-fun domain_parts_ok () Int
    2)
  (define-fun local_ok () String
    "e")
  (define-fun is_nonempty ((x!0 String)) Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun is_tld ((x!0 String)) Bool
    true)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "i") (= x!1 (seq.unit (_ Char 46)))) 3
      2))
  (define-fun is_ascii_atom ((x!0 String)) Bool
    true)
  (define-fun is_domain_label ((x!0 String)) Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 115))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 43))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 64))
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
                         (seq.unit (_ Char 46))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 107))))
              (= x!1 "@")
              (= x!2 0))
      "e"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "l"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 3)) "uk"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "a"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 2)) "c"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 98))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 64))
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
              (= x!2 0))
      "@"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 98))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 64))
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
      "i"
      ""))))))))
)
