(
  ;; universe for var2514:
  ;;   var2514!val!1 var2514!val!0 var2514!val!2 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2514!val!1 () var2514)
  (declare-fun var2514!val!0 () var2514)
  (declare-fun var2514!val!2 () var2514)
  ;; cardinality constraint:
  (forall ((x var2514))
          (or (= x var2514!val!1) (= x var2514!val!0) (= x var2514!val!2)))
  ;; -----------
  ;; universe for var1792:
  ;;   var1792!val!0 var1792!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1792!val!0 () var1792)
  (declare-fun var1792!val!1 () var1792)
  ;; cardinality constraint:
  (forall ((x var1792)) (or (= x var1792!val!0) (= x var1792!val!1)))
  ;; -----------
  (define-fun null-String () String
    "")
  (define-fun var814 () var1792
    var1792!val!0)
  (define-fun var1845 () String
    "\u{a}")
  (define-fun null-var1792 () var1792
    var1792!val!1)
  (define-fun null-var2514 () var2514
    var2514!val!1)
  (define-fun var1871 () var2514
    var2514!val!2)
  (define-fun var2979 () var2514
    var2514!val!0)
  (define-fun var2223 () var2514
    var1615_getCapabilitiesByName/-679790978)
  (define-fun var2743 () Int
    1)
  (define-fun var3083 () Int
    (let ((a!1 (ite (< (num_splits_re var1845 (str.to_re "\u{a}")) (- 1))
                (num_splits_re var1845 (str.to_re "\u{a}"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var1845 (str.to_re "\u{a}")))))
  (define-fun var1615_getCapabilitiesByName/-679790978 () var2514
    var2514!val!1)
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
)
