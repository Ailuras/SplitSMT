(
  ;; universe for var2667:
  ;;   var2667!val!0 var2667!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2667!val!0 () var2667)
  (declare-fun var2667!val!1 () var2667)
  ;; cardinality constraint:
  (forall ((x var2667)) (or (= x var2667!val!0) (= x var2667!val!1)))
  ;; -----------
  ;; universe for var900:
  ;;   var900!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var900!val!0 () var900)
  ;; cardinality constraint:
  (forall ((x var900)) (= x var900!val!0))
  ;; -----------
  (define-fun var3317 () Int
    (- 1))
  (define-fun null-String () String
    "!1!")
  (define-fun var585 () String
    var1730-SERVICE_NAME_SEPARATOR)
  (define-fun var642 () String
    "!4!")
  (define-fun var431 () var2667
    var2667!val!0)
  (define-fun var3145 () String
    "!2!")
  (define-fun var1950 () String
    "!3!")
  (define-fun null-var2667 () var2667
    var2667!val!1)
  (define-fun var1730-SERVICE_NAME_SEPARATOR () String
    "!5!")
  (define-fun var3382 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var642 var1730-SERVICE_NAME_SEPARATOR) (- 1)))))
  (ite a!1
       (split_rest var642 var1730-SERVICE_NAME_SEPARATOR (- (- 1) 1))
       (split_at var642 var1730-SERVICE_NAME_SEPARATOR 0))))
  (define-fun var2472 () Bool
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var642 var1730-SERVICE_NAME_SEPARATOR) (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var642 var1730-SERVICE_NAME_SEPARATOR (- (- 1) 1))
                (split_at var642 var1730-SERVICE_NAME_SEPARATOR 0))))
  (var2667_contains/-441121415 var431 (cast-from-String-to-var900 a!2)))))
  (define-fun var113 () String
    "!0!")
  (define-fun var2555 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var642 var1730-SERVICE_NAME_SEPARATOR) (- 1))
          (num_splits var642 var1730-SERVICE_NAME_SEPARATOR)
          (- 1))
     (num_splits var642 var1730-SERVICE_NAME_SEPARATOR)))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "!6!")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun cast-from-String-to-var900 ((x!0 String)) var900
    var900!val!0)
  (define-fun var2667_contains/-441121415 ((x!0 var2667) (x!1 var900)) Bool
    false)
)
