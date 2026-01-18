(
  ;; universe for var292:
  ;;   var292!val!0 var292!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var292!val!0 () var292)
  (declare-fun var292!val!1 () var292)
  ;; cardinality constraint:
  (forall ((x var292)) (or (= x var292!val!0) (= x var292!val!1)))
  ;; -----------
  (define-fun var966 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (var130_getSieves/-107895238 var2909)
                                (var130_getCurrentSieveForTrain/-1427544085
                                  var2909))
                    (- 1)))))
  (ite a!1
       (split_rest (var130_getSieves/-107895238 var2909)
                   (var130_getCurrentSieveForTrain/-1427544085 var2909)
                   (- (- 1) 1))
       (split_at (var130_getSieves/-107895238 var2909)
                 (var130_getCurrentSieveForTrain/-1427544085 var2909)
                 0))))
  (define-fun var2722 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (var130_getSieves/-107895238 var2909)
                                (var130_getCurrentSieveForTrain/-1427544085
                                  var2909))
                    (- 1)))))
(let ((a!2 (ite a!1
                (split_rest (var130_getSieves/-107895238 var2909)
                            (var130_getCurrentSieveForTrain/-1427544085 var2909)
                            (- (- 1) 1))
                (split_at (var130_getSieves/-107895238 var2909)
                          (var130_getCurrentSieveForTrain/-1427544085 var2909)
                          0))))
  (trim-right (trim-left a!2)))))
  (define-fun null-var292 () var292
    var292!val!1)
  (define-fun null-String () String
    "A")
  (define-fun var1308 () var3722
    var3722-init)
  (define-fun var386 () Int
    0)
  (define-fun var1073 () (Array Int String)
    var1817)
  (define-fun var1452 () String
    (var130_getSieves/-107895238 var2909))
  (define-fun var1642 () String
    (var130_getCurrentSieveForTrain/-1427544085 var2909))
  (define-fun var3817 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (var130_getSieves/-107895238 var2909)
                                (var130_getCurrentSieveForTrain/-1427544085
                                  var2909))
                    (- 1))))
      (a!3 (re.++ (str.to_re ",")
                  (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))))))
(let ((a!2 (ite a!1
                (split_rest (var130_getSieves/-107895238 var2909)
                            (var130_getCurrentSieveForTrain/-1427544085 var2909)
                            (- (- 1) 1))
                (split_at (var130_getSieves/-107895238 var2909)
                          (var130_getCurrentSieveForTrain/-1427544085 var2909)
                          0))))
(let ((a!4 (< (num_splits_re (trim-right (trim-left a!2)) a!3) (- 1))))
(let ((a!5 (ite a!4 (num_splits_re (trim-right (trim-left a!2)) a!3) (- 1))))
  (ite (> (- 1) 0) a!5 (num_splits_re (trim-right (trim-left a!2)) a!3)))))))
  (define-fun var2909 () var292
    var292!val!0)
  (define-fun var3722-init () var3722
    var3722!val!0)
  (define-fun var1308!1 () var3722
    var3722!val!0)
  (define-fun var1817 () (Array Int String)
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
  (define-fun var130_getCurrentSieveForTrain/-1427544085 ((x!0 var292)) String
    "")
  (define-fun var130_getSieves/-107895238 ((x!0 var292)) String
    "")
  (define-fun <init>/-325640736 ((x!0 var3722)) void
    void!val!0)
)
