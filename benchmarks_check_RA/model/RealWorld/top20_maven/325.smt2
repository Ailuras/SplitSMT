(
  (define-fun var2607 () Int
    (let ((a!1 (ite (< (num_splits (var1908_getProperty/258823597
                                 "org.mockito.inline.preload")
                               ",")
                   (- 1))
                (num_splits (var1908_getProperty/258823597
                              "org.mockito.inline.preload")
                            ",")
                (- 1))))
  (ite (> (- 1) 0)
       a!1
       (num_splits (var1908_getProperty/258823597 "org.mockito.inline.preload")
                   ","))))
  (define-fun var2824 () String
    (var1908_getProperty/258823597 "org.mockito.inline.preload"))
  (define-fun var1618 () Int
    0)
  (define-fun null-String () String
    ",")
  (define-fun var1908_getProperty/258823597 ((x!0 String)) String
    "o")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
