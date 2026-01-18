(
  (define-fun x () String
    "112233!!))")
  (define-fun rest1 () String
    "")
  (define-fun s0 () String
    "112233")
  (define-fun s1 () String
    "G")
  (define-fun d () String
    "!!))")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "112233!!))")
              (= x!1
                 (str.++ (seq.unit (_ Char 33))
                         (seq.unit (_ Char 33))
                         (seq.unit (_ Char 41))
                         (seq.unit (_ Char 41))))
              (= x!2 1))
      "G"
      "112233"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
