(
  ;; universe for var2503:
  ;;   var2503!val!0 var2503!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2503!val!0 () var2503)
  (declare-fun var2503!val!1 () var2503)
  ;; cardinality constraint:
  (forall ((x var2503)) (or (= x var2503!val!0) (= x var2503!val!1)))
  ;; -----------
  (define-fun var1690 () Bool
    (ite (= 1 1) true false))
  (define-fun var2043 () Int
    (- 1))
  (define-fun null-String () String
    "")
  (define-fun var3297 () Int
    (let ((a!1 (< (num_splits_re var3301
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var3301
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var3301
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun var238 () Int
    0)
  (define-fun var3301 () String
    "\u{d}")
  (define-fun null-var2503 () var2503
    var2503!val!1)
  (define-fun var1004 () var2503
    var2503!val!0)
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
