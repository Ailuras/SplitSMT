(
  ;; universe for var1174:
  ;;   var1174!val!0 var1174!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1174!val!0 () var1174)
  (declare-fun var1174!val!1 () var1174)
  ;; cardinality constraint:
  (forall ((x var1174)) (or (= x var1174!val!0) (= x var1174!val!1)))
  ;; -----------
  (define-fun null-var1174 () var1174
    var1174!val!1)
  (define-fun var3639 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1863 "/") (- 1)))))
  (ite a!1 (split_rest var1863 "/" (- (- 1) 1)) (split_at var1863 "/" 1))))
  (define-fun null-String () String
    ":")
  (define-fun var3955 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1863 "/") (- 1)) (num_splits var1863 "/") (- 1))
     (num_splits var1863 "/")))
  (define-fun var3616 () Int
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1863 "/") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1863 "/" (- (- 1) 1))
                (split_at var1863 "/" 1))))
  (ite (> (- 1) 0)
       (ite (< (num_splits a!2 ":") (- 1)) (num_splits a!2 ":") (- 1))
       (num_splits a!2 ":")))))
  (define-fun var2172 () var1174
    var1174!val!0)
  (define-fun var1863 () String
    "/")
  (define-fun var1595 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 1 (- (- 1) 1))
                (>= (num_splits var1863 "/") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest var1863 "/" (- (- 1) 1))
                (split_at var1863 "/" 1))))
(let ((a!3 (and (> (- 1) 0) (= 0 (- (- 1) 1)) (>= (num_splits a!2 ":") (- 1)))))
  (ite a!3 (split_rest a!2 ":" (- (- 1) 1)) (split_at a!2 ":" 0))))))
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ":") (= x!1 ":")) 3
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
