(
  ;; universe for var40:
  ;;   var40!val!1 var40!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var40!val!1 () var40)
  (declare-fun var40!val!0 () var40)
  ;; cardinality constraint:
  (forall ((x var40)) (or (= x var40!val!1) (= x var40!val!0)))
  ;; -----------
  (define-fun var1437 () Bool
    false)
  (define-fun var2212 () String
    (trim-right (trim-left var1202)))
  (define-fun var661 () Int
    0)
  (define-fun null-String () String
    "A")
  (define-fun null-Bool () Bool
    true)
  (define-fun var1202 () String
    "")
  (define-fun var1356 () var40
    var40!val!0)
  (define-fun var2299 () (Array Int String)
    var1214)
  (define-fun null-var40 () var40
    var40!val!1)
  (define-fun var1252 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re ","))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (< (num_splits_re (trim-right (trim-left var1202)) a!2) (- 1))))
(let ((a!4 (ite a!3 (num_splits_re (trim-right (trim-left var1202)) a!2) (- 1))))
  (ite (> (- 1) 0) a!4 (num_splits_re (trim-right (trim-left var1202)) a!2)))))))
  (define-fun var1214 () (Array Int String)
    ((as const (Array Int String)) ""))
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
)
