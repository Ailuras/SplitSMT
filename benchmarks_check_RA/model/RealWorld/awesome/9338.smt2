(
  ;; universe for var3290:
  ;;   var3290!val!0 var3290!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3290!val!0 () var3290)
  (declare-fun var3290!val!1 () var3290)
  ;; cardinality constraint:
  (forall ((x var3290)) (or (= x var3290!val!0) (= x var3290!val!1)))
  ;; -----------
  ;; universe for var2910:
  ;;   var2910!val!0 var2910!val!2 var2910!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2910!val!0 () var2910)
  (declare-fun var2910!val!2 () var2910)
  (declare-fun var2910!val!1 () var2910)
  ;; cardinality constraint:
  (forall ((x var2910))
          (or (= x var2910!val!0) (= x var2910!val!2) (= x var2910!val!1)))
  ;; -----------
  (define-fun var3491 () Bool
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (readLine/150542008 var2102!1) "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest (readLine/150542008 var2102!1) "\u{9}" (- (- 1) 1))
                (split_at (readLine/150542008 var2102!1) "\u{9}" 0))))
  (= a!2 "nodeFeatureIndicesMap.size()="))))
  (define-fun var2102!1 () var2910
    var2910!val!2)
  (define-fun var132 () String
    (readLine/150542008 var2102!1))
  (define-fun null-var2910 () var2910
    var2910!val!1)
  (define-fun null-var3290 () var3290
    var3290!val!1)
  (define-fun var1556 () var3290
    var3290!val!0)
  (define-fun var3235 () var459
    var459-init)
  (define-fun var2102 () var2910
    var2910!val!0)
  (define-fun var2030 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (readLine/150542008 var2102!1) "\u{9}") (- 1)))))
  (ite a!1
       (split_rest (readLine/150542008 var2102!1) "\u{9}" (- (- 1) 1))
       (split_at (readLine/150542008 var2102!1) "\u{9}" 0))))
  (define-fun var3501 () String
    "")
  (define-fun var1556!1 () var3290
    var3290!val!0)
  (define-fun var459-init () var459
    var459!val!0)
  (define-fun var3235!1 () var459
    var459!val!0)
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
  (define-fun readLine/150542008 ((x!0 var2910)) String
    (ite (= x!0 var2910!val!2) "\u{9}"
      "\u{9}"))
  (define-fun <init>/-1084991535 ((x!0 var459) (x!1 String)) void
    void!val!0)
  (define-fun loadTextClassifier/2023711293 ((x!0 var1398) (x!1 var2910)) void
    void!val!0)
  (define-fun cast-from-var3290-to-var1398 ((x!0 var3290)) var1398
    var1398!val!0)
)
