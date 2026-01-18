(
  ;; universe for var3379:
  ;;   var3379!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3379!val!0 () var3379)
  ;; cardinality constraint:
  (forall ((x var3379)) (= x var3379!val!0))
  ;; -----------
  ;; universe for var3781:
  ;;   var3781!val!0 var3781!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3781!val!0 () var3781)
  (declare-fun var3781!val!1 () var3781)
  ;; cardinality constraint:
  (forall ((x var3781)) (or (= x var3781!val!0) (= x var3781!val!1)))
  ;; -----------
  ;; universe for var620:
  ;;   var620!val!1 var620!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var620!val!1 () var620)
  (declare-fun var620!val!0 () var620)
  ;; cardinality constraint:
  (forall ((x var620)) (or (= x var620!val!1) (= x var620!val!0)))
  ;; -----------
  (define-fun var2040 () var3781
    var3781!val!0)
  (define-fun var3729 () Bool
    (omitComments/-1276310728 var3438))
  (define-fun null-var620 () var620
    var620!val!1)
  (define-fun var678 () String
    var1859)
  (define-fun var515 () String
    var620-EOL)
  (define-fun var3438 () var620
    var620!val!0)
  (define-fun var1859 () String
    "")
  (define-fun var3362 () var3379
    var3379-init)
  (define-fun null-var3781 () var3781
    var3781!val!1)
  (define-fun var3590 () Int
    (let ((a!1 (< (num_splits_re (toString/138175384 var3362!2)
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re (toString/138175384 var3362!2)
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re (toString/138175384 var3362!2)
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun null-String () String
    "A")
  (define-fun var907 () Int
    0)
  (define-fun var3362!2 () var3379
    var3379!val!0)
  (define-fun var2013 () String
    (toString/138175384 var3362!2))
  (define-fun var620-EOL () String
    "")
  (define-fun var3362!1 () var3379
    var3379!val!0)
  (define-fun var3379-init () var3379
    var3379!val!0)
  (define-fun var3438!1 () var620
    var620!val!1)
  (define-fun var678!1 () String
    "")
  (define-fun omitComments/-1276310728 ((x!0 var620)) Bool
    false)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun toString/138175384 ((x!0 var3379)) String
    "")
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
  (define-fun cast-from-var620-to-var505 ((x!0 var620)) var505
    var505!val!0)
  (define-fun cast-from-var3379-to-var3781 ((x!0 var3379)) var3781
    var3781!val!0)
  (define-fun <init>/358169345 ((x!0 var3379)) void
    void!val!0)
  (define-fun store/-1111572071 ((x!0 var505) (x!1 var3781) (x!2 String)) void
    void!val!0)
)
