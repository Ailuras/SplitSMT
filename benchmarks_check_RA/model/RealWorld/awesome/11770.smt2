(
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var1968 () (Array Int String)
    ((as const (Array Int String)) ","))
  (define-fun var223 () var466
    var3261-logger)
  (define-fun var1535 () String
    (str.++ var2638!1 "Making result printers from " var1437))
  (define-fun var240 () String
    (trim-right (trim-left var1437)))
  (define-fun var71 () Int
    (let ((a!1 (re.++ (str.to_re ",")
                  (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!2 (< (num_splits_re (trim-right (trim-left var1437)) a!1) (- 1))))
(let ((a!3 (ite a!2 (num_splits_re (trim-right (trim-left var1437)) a!1) (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (trim-right (trim-left var1437)) a!1))))))
  (define-fun var407 () var1750
    var1750-init)
  (define-fun null-String () String
    ",")
  (define-fun var1437 () String
    "")
  (define-fun var118 () String
    (str.++ var2638!1 "Making result printers from " var1437))
  (define-fun null-__Array__Int__String__ () (Array Int String)
    ((as const (Array Int String)) " "))
  (define-fun var2638 () String
    String-init)
  (define-fun var683 () String
    (str.++ var2638!1 "Making result printers from "))
  (define-fun var3363 () Int
    0)
  (define-fun var683!1 () String
    "Making result printers from ")
  (define-fun var2638!2 () String
    "Making result printers from ")
  (define-fun var2638!1 () String
    "")
  (define-fun var407!1 () var1750
    var1750!val!0)
  (define-fun var118!1 () String
    "")
  (define-fun var3261-logger () var466
    var466!val!0)
  (define-fun var223!1 () var466
    var466!val!0)
  (define-fun var1750-init () var1750
    var1750!val!0)
  (define-fun String-init () String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun <init>/451842749 ((x!0 var1750)) void
    void!val!0)
  (define-fun info/114590825 ((x!0 var466) (x!1 String)) void
    void!val!0)
)
