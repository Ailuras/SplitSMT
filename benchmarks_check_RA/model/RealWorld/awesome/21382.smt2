(
  ;; universe for var1098:
  ;;   var1098!val!1 var1098!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1098!val!1 () var1098)
  (declare-fun var1098!val!0 () var1098)
  ;; cardinality constraint:
  (forall ((x var1098)) (or (= x var1098!val!1) (= x var1098!val!0)))
  ;; -----------
  ;; universe for var2080:
  ;;   var2080!val!1 var2080!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2080!val!1 () var2080)
  (declare-fun var2080!val!0 () var2080)
  ;; cardinality constraint:
  (forall ((x var2080)) (or (= x var2080!val!1) (= x var2080!val!0)))
  ;; -----------
  ;; universe for var3002:
  ;;   var3002!val!0 var3002!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3002!val!0 () var3002)
  (declare-fun var3002!val!1 () var3002)
  ;; cardinality constraint:
  (forall ((x var3002)) (or (= x var3002!val!0) (= x var3002!val!1)))
  ;; -----------
  ;; universe for var3010:
  ;;   var3010!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3010!val!0 () var3010)
  ;; cardinality constraint:
  (forall ((x var3010)) (= x var3010!val!0))
  ;; -----------
  (define-fun var1889 () var1098
    var1098!val!0)
  (define-fun null-var1098 () var1098
    var1098!val!1)
  (define-fun var2772 () var3002
    var3002!val!0)
  (define-fun null-var2080 () var2080
    var2080!val!1)
  (define-fun var1986 () Float64
    (fp #b0 #b00000010000 #x0000000000001))
  (define-fun var2585 () Bool
    (var2080_containsKey/1421819118 var3981 (cast-from-var3002-to-var3010 var2772)))
  (define-fun null-var3002 () var3002
    var3002!val!1)
  (define-fun null-Float64 () Float64
    (fp #b1 #b00000000000 #x0000000000800))
  (define-fun var1172 () String
    (getPhrase/-292787131 var2772))
  (define-fun var3981 () var2080
    var2080!val!0)
  (define-fun var1276 () Int
    (let ((a!1 (num_splits_re (getPhrase/-292787131 var2772)
                          (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun var2080_containsKey/1421819118 ((x!0 var2080) (x!1 var3010)) Bool
    false)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun getPhrase/-292787131 ((x!0 var3002)) String
    "!0!")
  (define-fun cast-from-var3002-to-var3010 ((x!0 var3002)) var3010
    var3010!val!0)
)
