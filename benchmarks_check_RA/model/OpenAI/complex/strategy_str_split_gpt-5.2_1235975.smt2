(
  (define-fun X () String
    "L@")
  (define-fun tld () String
    "\u{10000}")
  (define-fun secondLabel () String
    "P")
  (define-fun tldSecond () String
    "ak")
  (define-fun local () String
    "L")
  (define-fun tldFirst () String
    "P")
  (define-fun firstLabel () String
    "h")
  (define-fun domain () String
    "")
  (define-fun plusTag () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 2)) "\u{10000}"
      ""))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "L@") (= x!1 "@") (= x!2 0)) "L"
    (ite (and (= x!0 "L@") (= x!1 "@") (= x!2 1)) ""
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "h"
    (ite (and (= x!0 "\u{10000}") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "ak"
      "P")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46)))) 3
      2))
)
