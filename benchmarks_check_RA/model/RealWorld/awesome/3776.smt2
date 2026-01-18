(
  ;; universe for var3435:
  ;;   var3435!val!0 var3435!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3435!val!0 () var3435)
  (declare-fun var3435!val!1 () var3435)
  ;; cardinality constraint:
  (forall ((x var3435)) (or (= x var3435!val!0) (= x var3435!val!1)))
  ;; -----------
  (define-fun var97 () String
    "\u{d}")
  (define-fun null-var3435 () var3435
    var3435!val!1)
  (define-fun null-String () String
    "")
  (define-fun var888 () Int
    (let ((a!1 (< (num_splits_re var97
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var97
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var97 (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun var318 () var3435
    var3435!val!0)
  (define-fun var817 () Int
    0)
  (define-fun var2545 () Bool
    false)
  (define-fun null-Bool () Bool
    true)
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
