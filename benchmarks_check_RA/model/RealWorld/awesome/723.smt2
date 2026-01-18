(
  ;; universe for var1938:
  ;;   var1938!val!1 var1938!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1938!val!1 () var1938)
  (declare-fun var1938!val!0 () var1938)
  ;; cardinality constraint:
  (forall ((x var1938)) (or (= x var1938!val!1) (= x var1938!val!0)))
  ;; -----------
  (define-fun null-var1938 () var1938
    var1938!val!1)
  (define-fun var1315 () String
    (str.++ var1425!1 "Unexpected input (many fields): " var1985))
  (define-fun null-String () String
    "")
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var861 () var2949
    var2949-init)
  (define-fun var3499 () String
    (str.++ var1425!1 "Unexpected input (many fields): "))
  (define-fun var1985 () String
    " ")
  (define-fun var1425 () String
    String-init)
  (define-fun var2950 () Int
    (let ((a!1 (num_splits_re var1985
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var3233 () var1938
    var1938!val!0)
  (define-fun var156 () String
    (str.++ var1425!1 "Unexpected input (many fields): " var1985))
  (define-fun var1120 () var2962
    var2962-init)
  (define-fun var3499!1 () String
    "Unexpected input (many fields):  ")
  (define-fun var1425!2 () String
    "Unexpected input (many fields): ")
  (define-fun var1425!1 () String
    "")
  (define-fun var2962-init () var2962
    var2962!val!0)
  (define-fun var1315!1 () String
    "")
  (define-fun var2949-init () var2949
    var2949!val!0)
  (define-fun var861!1 () var2949
    var2949!val!0)
  (define-fun String-init () String
    "")
  (define-fun var1120!1 () var2962
    var2962!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    6)
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
  (define-fun <init>/598147663 ((x!0 var2949)) void
    void!val!0)
  (define-fun <init>/-1253962986 ((x!0 var2962) (x!1 String)) void
    void!val!0)
)
