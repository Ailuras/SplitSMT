(
  ;; universe for var2405:
  ;;   var2405!val!1 var2405!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2405!val!1 () var2405)
  (declare-fun var2405!val!0 () var2405)
  ;; cardinality constraint:
  (forall ((x var2405)) (or (= x var2405!val!1) (= x var2405!val!0)))
  ;; -----------
  (define-fun var2051 () String
    (var84_getSieves/-107895238 var1504))
  (define-fun var2774 () Int
    (let ((a!1 (re.++ (str.to_re ",")
                  (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!2 (num_splits_re (trim-right (trim-left (var84_getSieves/-107895238
                                                   var1504)))
                          a!1)))
  (ite (> (- 1) 0) (ite (< a!2 (- 1)) a!2 (- 1)) a!2))))
  (define-fun var3067 () String
    (trim-right (trim-left (var84_getSieves/-107895238 var1504))))
  (define-fun var1504 () var2405
    var2405!val!0)
  (define-fun var2393 () var876
    var876-init)
  (define-fun null-var2405 () var2405
    var2405!val!1)
  (define-fun var1630 () String
    (var84_getCurrentSieveForTrain/-1427544085 var1504))
  (define-fun var2670 () (Array Int String)
    var3464)
  (define-fun var87 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun var3464 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var876-init () var876
    var876!val!0)
  (define-fun var2393!1 () var876
    var876!val!0)
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
  (define-fun var84_getSieves/-107895238 ((x!0 var2405)) String
    "")
  (define-fun var84_getCurrentSieveForTrain/-1427544085 ((x!0 var2405)) String
    "")
  (define-fun <init>/-325640736 ((x!0 var876)) void
    void!val!0)
)
