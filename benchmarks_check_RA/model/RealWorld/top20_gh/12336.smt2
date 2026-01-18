(
  ;; universe for var1168:
  ;;   var1168!val!0 var1168!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1168!val!0 () var1168)
  (declare-fun var1168!val!1 () var1168)
  ;; cardinality constraint:
  (forall ((x var1168)) (or (= x var1168!val!0) (= x var1168!val!1)))
  ;; -----------
  (define-fun var1988 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2917 "/") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var2917 "/" (- (- 1) 1))
                (split_at var2917 "/" 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!2 ":") (- 1)) (num_splits a!2 ":") (- 1))
       (num_splits a!2 ":")))))
  (define-fun null-var1168 () var1168
    var1168!val!1)
  (define-fun var2917 () String
    "/")
  (define-fun null-String () String
    ":")
  (define-fun var434 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2917 "/") (- 1)) (num_splits var2917 "/") (- 1))
     (num_splits var2917 "/")))
  (define-fun var2702 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var2917 "/") (- 1)))))
  (ite a!1 (split_rest var2917 "/" (- (- 1) 1)) (split_at var2917 "/" 1))))
  (define-fun var1477 () var1168
    var1168!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ":") (= x!1 ":")) 1
      2))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    ":")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
