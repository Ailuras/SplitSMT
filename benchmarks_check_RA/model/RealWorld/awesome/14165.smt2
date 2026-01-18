(
  (define-fun var424 () String
    (str.++ "\u{1} to Locale" var1017))
  (define-fun var3690 () var3046
    var3046-init)
  (define-fun var1017 () String
    "-")
  (define-fun null-String () String
    "")
  (define-fun var3546 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1017 "-") (- 1)))))
  (ite a!1 (split_rest var1017 "-" (- (- 1) 1)) (split_at var1017 "-" 0))))
  (define-fun var85 () var2347
    var3002-log)
  (define-fun var1387 () Int
    (- 1))
  (define-fun var1499 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1017 "-") (- 1)) (num_splits var1017 "-") (- 1))
     (num_splits var1017 "-")))
  (define-fun var3046-init () var3046
    var3046!val!0)
  (define-fun var3690!1 () var3046
    var3046!val!0)
  (define-fun var3546!1 () String
    "")
  (define-fun var3002-log () var2347
    var2347!val!0)
  (define-fun var85!1 () var2347
    var2347!val!0)
  (define-fun var424!1 () String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun var2347_debug/594372212 ((x!0 var2347) (x!1 String)) void
    void!val!0)
  (define-fun <init>/-1053635008 ((x!0 var3046) (x!1 String)) void
    void!val!0)
)
