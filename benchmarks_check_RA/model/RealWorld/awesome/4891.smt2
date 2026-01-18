(
  (define-fun var1969 () var3564
    var3564-init)
  (define-fun var1108 () Int
    (let ((a!1 (num_splits_re (trim-right (trim-left (var568_stringFromFile/-1519934906
                                                   var600)))
                          (re.++ (str.to_re "\u{a}") (str.to_re "\u{a}")))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var72 () String
    (var568_stringFromFile/-1519934906 var600))
  (define-fun var425 () String
    (trim-right (trim-left (var568_stringFromFile/-1519934906 var600))))
  (define-fun var600 () String
    "")
  (define-fun null-String () String
    "A")
  (define-fun var3392 () Int
    0)
  (define-fun var1969!1 () var3564
    var3564!val!0)
  (define-fun var3564-init () var3564
    var3564!val!0)
  (define-fun var568_stringFromFile/-1519934906 ((x!0 String)) String
    "")
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
  (define-fun <init>/-325640736 ((x!0 var3564)) void
    void!val!0)
)
