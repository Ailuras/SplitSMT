(
  ;; universe for var2720:
  ;;   var2720!val!1 var2720!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2720!val!1 () var2720)
  (declare-fun var2720!val!0 () var2720)
  ;; cardinality constraint:
  (forall ((x var2720)) (or (= x var2720!val!1) (= x var2720!val!0)))
  ;; -----------
  (define-fun var1392 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2561 ":") (- 1)) (num_splits var2561 ":") (- 1))
     (num_splits var2561 ":")))
  (define-fun var3283 () String
    var2561)
  (define-fun var3082 () var2720
    var2720!val!0)
  (define-fun null-var2720 () var2720
    var2720!val!1)
  (define-fun null-String () String
    ":")
  (define-fun var2844 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits var2561 ":") (- 1)))))
  (ite a!1 (split_rest var2561 ":" (- (- 1) 1)) (split_at var2561 ":" 0))))
  (define-fun var3054 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2561 "/") (- 1)) (num_splits var2561 "/") (- 1))
     (num_splits var2561 "/")))
  (define-fun var2561 () String
    "/")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 (seq.unit (_ Char 47))) (= x!1 (seq.unit (_ Char 58)))) 2
      1))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
