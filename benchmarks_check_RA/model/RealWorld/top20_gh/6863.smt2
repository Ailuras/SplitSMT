(
  ;; universe for var989:
  ;;   var989!val!1 var989!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var989!val!1 () var989)
  (declare-fun var989!val!0 () var989)
  ;; cardinality constraint:
  (forall ((x var989)) (or (= x var989!val!1) (= x var989!val!0)))
  ;; -----------
  ;; universe for var160:
  ;;   var160!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var160!val!0 () var160)
  ;; cardinality constraint:
  (forall ((x var160)) (= x var160!val!0))
  ;; -----------
  ;; universe for var3902:
  ;;   var3902!val!0 var3902!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3902!val!0 () var3902)
  (declare-fun var3902!val!1 () var3902)
  ;; cardinality constraint:
  (forall ((x var3902)) (or (= x var3902!val!0) (= x var3902!val!1)))
  ;; -----------
  (define-fun null-var3902 () var3902
    var3902!val!1)
  (define-fun var1834 () String
    "")
  (define-fun var2444 () String
    (toString/138175384 var3816!2))
  (define-fun var1532 () Int
    0)
  (define-fun var3816 () var160
    var160-init)
  (define-fun var2803 () Int
    (let ((a!1 (< (num_splits_re (toString/138175384 var3816!2)
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (toString/138175384 var3816!2)
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (toString/138175384 var3816!2)
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun null-String () String
    "A")
  (define-fun var1924 () Bool
    (omitComments/-1276310728 var2844))
  (define-fun var3120 () String
    var3902-EOL)
  (define-fun var2844 () var3902
    var3902!val!0)
  (define-fun null-var989 () var989
    var989!val!1)
  (define-fun var3816!2 () var160
    var160!val!0)
  (define-fun var3073 () var989
    var989!val!0)
  (define-fun var2776 () String
    null-String)
  (define-fun var3902-EOL () String
    "")
  (define-fun var2776!1 () String
    "")
  (define-fun var2844!1 () var3902
    var3902!val!0)
  (define-fun var3816!1 () var160
    var160!val!0)
  (define-fun var160-init () var160
    var160!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun omitComments/-1276310728 ((x!0 var3902)) Bool
    true)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun toString/138175384 ((x!0 var160)) String
    "")
  (define-fun cast-from-var160-to-var989 ((x!0 var160)) var989
    var989!val!1)
  (define-fun <init>/358169345 ((x!0 var160)) void
    void!val!0)
  (define-fun store/-1111572071 ((x!0 var397) (x!1 var989) (x!2 String)) void
    void!val!0)
  (define-fun cast-from-var3902-to-var397 ((x!0 var3902)) var397
    var397!val!0)
)
