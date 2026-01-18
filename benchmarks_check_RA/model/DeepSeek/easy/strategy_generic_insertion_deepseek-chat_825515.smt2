(
  (define-fun X () String
    "")
  (define-fun segment0 () String
    "wowokay")
  (define-fun delimiter () String
    "://")
  (define-fun total_segments () Int
    2)
  (define-fun segment1 () String
    "FTP")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "")
              (= x!1
                 (str.++ (seq.unit (_ Char 58))
                         (seq.unit (_ Char 47))
                         (seq.unit (_ Char 47))))
              (= x!2 1))
      "FTP"
      "wowokay"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
