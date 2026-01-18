(
  ;; universe for var522:
  ;;   var522!val!1 var522!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var522!val!1 () var522)
  (declare-fun var522!val!0 () var522)
  ;; cardinality constraint:
  (forall ((x var522)) (or (= x var522!val!1) (= x var522!val!0)))
  ;; -----------
  ;; universe for var1299:
  ;;   var1299!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1299!val!0 () var1299)
  ;; cardinality constraint:
  (forall ((x var1299)) (= x var1299!val!0))
  ;; -----------
  ;; universe for var655:
  ;;   var655!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var655!val!0 () var655)
  ;; cardinality constraint:
  (forall ((x var655)) (= x var655!val!0))
  ;; -----------
  (define-fun var38 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1705!1 ":-") (- 1)))))
  (ite a!1 (split_rest var1705!1 ":-" (- (- 1) 1)) (split_at var1705!1 ":-" 0))))
  (define-fun var1705 () String
    "A")
  (define-fun var585 () Int
    (- 1))
  (define-fun var2476 () var1370
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1705!1 ":-") (- 1))))
      (a!3 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1705!1 ":-") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1705!1 ":-" (- (- 1) 1))
                (split_at var1705!1 ":-" 0)))
      (a!4 (ite a!3
                (split_rest var1705!1 ":-" (- (- 1) 1))
                (split_at var1705!1 ":-" 1))))
  (resolve/784746797
    var1223
    (trim-right (trim-left a!2))
    (trim-right (trim-left a!4))))))
  (define-fun var545 () Bool
    (isLoggable/-616065502 var522-log var655-FINEST))
  (define-fun var2707 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var1705!1 ":-") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1705!1 ":-" (- (- 1) 1))
                (split_at var1705!1 ":-" 0))))
  (trim-right (trim-left a!2)))))
  (define-fun null-var522 () var522
    var522!val!1)
  (define-fun var655-FINEST () var655
    var655!val!0)
  (define-fun var522-log () var1299
    var1299!val!0)
  (define-fun var3147 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1705!1 ":-") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1705!1 ":-" (- (- 1) 1))
                (split_at var1705!1 ":-" 1))))
  (trim-right (trim-left a!2)))))
  (define-fun null-String () String
    "")
  (define-fun var1223 () var522
    var522!val!0)
  (define-fun var335 () Int
    (str.indexof var1705!1 ":-" 0))
  (define-fun var2645 () var1299
    var522-log)
  (define-fun var3400 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1705!1 ":-") (- 1)))))
  (ite a!1 (split_rest var1705!1 ":-" (- (- 1) 1)) (split_at var1705!1 ":-" 1))))
  (define-fun var3193 () var655
    var655-FINEST)
  (define-fun var1705!1 () String
    ":-:-")
  (define-fun isLoggable/-616065502 ((x!0 var1299) (x!1 var655)) Bool
    false)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun var979_requireNonNull/-961817614 ((x!0 var1253)) var1253
    var1253!val!0)
  (define-fun resolve/784746797 ((x!0 var522) (x!1 String) (x!2 String)) var1370
    var1370!val!0)
  (define-fun cast-from-String-to-var1253 ((x!0 String)) var1253
    var1253!val!0)
)
