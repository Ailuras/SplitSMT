(
  ;; universe for var850:
  ;;   var850!val!0 var850!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var850!val!0 () var850)
  (declare-fun var850!val!1 () var850)
  ;; cardinality constraint:
  (forall ((x var850)) (or (= x var850!val!0) (= x var850!val!1)))
  ;; -----------
  ;; universe for var1974:
  ;;   var1974!val!0 var1974!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1974!val!0 () var1974)
  (declare-fun var1974!val!1 () var1974)
  ;; cardinality constraint:
  (forall ((x var1974)) (or (= x var1974!val!0) (= x var1974!val!1)))
  ;; -----------
  (define-fun var628 () String
    (toString/-512974245 var2403))
  (define-fun var1635 () String
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var2403) a!2) (- 1)))))
  (ite a!3
       (split_rest_re (toString/-512974245 var2403) a!2 (- (- 1) 1))
       (split_at_re (toString/-512974245 var2403) a!2 0))))))
  (define-fun var703 () var850
    var850!val!0)
  (define-fun var629 () Bool
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits_re (toString/-512974245 var2403) a!2) (- 1)))))
(let ((a!4 (ite a!3
                (split_rest_re (toString/-512974245 var2403) a!2 (- (- 1) 1))
                (split_at_re (toString/-512974245 var2403) a!2 0))))
  (var3849_isNotBlank/-616714458 a!4))))))
  (define-fun var2403 () var1974
    var1974!val!0)
  (define-fun null-var850 () var850
    var850!val!1)
  (define-fun var2610 () Int
    0)
  (define-fun var2610!1 () Int
    (+ 0 1))
  (define-fun null-var1974 () var1974
    var1974!val!1)
  (define-fun var3017 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var2403) a!2) (- 1))
                (num_splits_re (toString/-512974245 var2403) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var2403) a!2))))))
  (define-fun var388 () Int
    (let ((a!1 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
                  (str.to_re "/"))))
(let ((a!2 (re.++ a!1 (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!3 (ite (< (num_splits_re (toString/-512974245 var2403) a!2) (- 1))
                (num_splits_re (toString/-512974245 var2403) a!2)
                (- 1))))
  (ite (> (- 1) 0) a!3 (num_splits_re (toString/-512974245 var2403) a!2))))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    1)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    " ")
  (define-fun toString/-512974245 ((x!0 var1974)) String
    " ")
  (define-fun var3849_isNotBlank/-616714458 ((x!0 String)) Bool
    false)
)
