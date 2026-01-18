(
  ;; universe for var1216:
  ;;   var1216!val!1 var1216!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1216!val!1 () var1216)
  (declare-fun var1216!val!0 () var1216)
  ;; cardinality constraint:
  (forall ((x var1216)) (or (= x var1216!val!1) (= x var1216!val!0)))
  ;; -----------
  (define-fun var3181 () String
    "!2!")
  (define-fun var2810-SERVICE_NAME_SEPARATOR () String
    "!5!")
  (define-fun var1413 () var1216
    var1216!val!0)
  (define-fun null-String () String
    "!1!")
  (define-fun var3878 () String
    "!4!")
  (define-fun var3914 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3878 var2810-SERVICE_NAME_SEPARATOR) (- 1))
          (num_splits var3878 var2810-SERVICE_NAME_SEPARATOR)
          (- 1))
     (num_splits var3878 var2810-SERVICE_NAME_SEPARATOR)))
  (define-fun null-var1216 () var1216
    var1216!val!1)
  (define-fun var170 () String
    "!0!")
  (define-fun var2986 () String
    "!3!")
  (define-fun var3821 () Int
    (- 1))
  (define-fun var564 () String
    var2810-SERVICE_NAME_SEPARATOR)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
