(
  ;; universe for var345:
  ;;   var345!val!0 var345!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var345!val!0 () var345)
  (declare-fun var345!val!1 () var345)
  ;; cardinality constraint:
  (forall ((x var345)) (or (= x var345!val!0) (= x var345!val!1)))
  ;; -----------
  (define-fun var2328 () String
    (trim-right (trim-left var1928)))
  (define-fun var595 () var345
    var345!val!0)
  (define-fun var3080 () Int
    (let ((a!1 (< (num_splits_re (trim-right (trim-left var1928))
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (trim-right (trim-left var1928))
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (trim-right (trim-left var1928))
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun null-var345 () var345
    var345!val!1)
  (define-fun var1928 () String
    "")
  (define-fun null-String () String
    "A")
  (define-fun var756 () String
    (splitRegex/-1299977600 var595))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    2)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun splitRegex/-1299977600 ((x!0 var345)) String
    "")
)
