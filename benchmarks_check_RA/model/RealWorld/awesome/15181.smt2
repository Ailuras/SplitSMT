(
  ;; universe for var1890:
  ;;   var1890!val!0 var1890!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1890!val!0 () var1890)
  (declare-fun var1890!val!1 () var1890)
  ;; cardinality constraint:
  (forall ((x var1890)) (or (= x var1890!val!0) (= x var1890!val!1)))
  ;; -----------
  (define-fun var24 () Int
    0)
  (define-fun var3496 () var218
    (getContent/2060121830 (resultsSlot/506553339 var2261)))
  (define-fun var806 () var1690
    (resultsSlot/506553339 var2261))
  (define-fun var1497 () Bool
    (ite (= 1 1) true false))
  (define-fun null-String () String
    "")
  (define-fun null-var1890 () var1890
    var1890!val!1)
  (define-fun var1401 () String
    "\u{d}")
  (define-fun var2261 () var1890
    var1890!val!0)
  (define-fun var3064 () Int
    (let ((a!1 (< (num_splits_re var1401
                             (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))
              (- 1))))
(let ((a!2 (ite a!1
                (num_splits_re var1401
                               (re.union (str.to_re "\u{d}")
                                         (str.to_re "\u{a}")))
                (- 1))))
  (ite (> (- 1) 0)
       a!2
       (num_splits_re var1401
                      (re.union (str.to_re "\u{d}") (str.to_re "\u{a}")))))))
  (define-fun var3496!1 () var218
    var218!val!0)
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
  (define-fun getContent/2060121830 ((x!0 var1690)) var218
    var218!val!0)
  (define-fun resultsSlot/506553339 ((x!0 var1890)) var1690
    var1690!val!0)
  (define-fun var218_clear/2124191932 ((x!0 var218)) void
    void!val!0)
)
