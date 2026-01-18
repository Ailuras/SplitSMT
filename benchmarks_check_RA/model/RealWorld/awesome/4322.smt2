(
  ;; universe for var2200:
  ;;   var2200!val!0 var2200!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2200!val!0 () var2200)
  (declare-fun var2200!val!1 () var2200)
  ;; cardinality constraint:
  (forall ((x var2200)) (or (= x var2200!val!0) (= x var2200!val!1)))
  ;; -----------
  (define-fun var2220 () String
    (trim-right (trim-left var2878)))
  (define-fun var3122 () Int
    0)
  (define-fun var3588 () var2200
    var2200!val!0)
  (define-fun var2014 () Int
    (let ((a!1 (re.++ (str.to_re ",")
                  (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!2 (< (num_splits_re (trim-right (trim-left var2878)) a!1) (- 1))))
(let ((a!3 (ite a!2 (num_splits_re (trim-right (trim-left var2878)) a!1) (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (trim-right (trim-left var2878)) a!1))))))
  (define-fun null-String () String
    "A")
  (define-fun var2878 () String
    "")
  (define-fun null-var2200 () var2200
    var2200!val!1)
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
