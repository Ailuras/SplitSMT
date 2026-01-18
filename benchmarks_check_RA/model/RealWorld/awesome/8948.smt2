(
  ;; universe for var2919:
  ;;   var2919!val!1 var2919!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2919!val!1 () var2919)
  (declare-fun var2919!val!0 () var2919)
  ;; cardinality constraint:
  (forall ((x var2919)) (or (= x var2919!val!1) (= x var2919!val!0)))
  ;; -----------
  (define-fun var693 () String
    "\u{d}")
  (define-fun var1306 () Int
    (let ((a!1 (< (num_splits_re var693
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var693
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var693 (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun var1307 () var2919
    var2919!val!0)
  (define-fun null-String () String
    "")
  (define-fun null-var2919 () var2919
    var2919!val!1)
  (define-fun var2504 () Int
    0)
  (define-fun null-Bool () Bool
    true)
  (define-fun var2786 () Bool
    false)
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
