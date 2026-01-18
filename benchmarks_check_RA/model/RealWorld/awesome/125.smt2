(
  ;; universe for var3886:
  ;;   var3886!val!0 var3886!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3886!val!0 () var3886)
  (declare-fun var3886!val!1 () var3886)
  ;; cardinality constraint:
  (forall ((x var3886)) (or (= x var3886!val!0) (= x var3886!val!1)))
  ;; -----------
  (define-fun var326 () var3886
    var3886!val!0)
  (define-fun null-var3886 () var3886
    var3886!val!1)
  (define-fun var1828 () Int
    (let ((a!1 (ite (< (num_splits_re var3021 (str.to_re "?")) (- 1))
                (num_splits_re var3021 (str.to_re "?"))
                (- 1))))
  (ite (> (- 1) 0) a!1 (num_splits_re var3021 (str.to_re "?")))))
  (define-fun var3021 () String
    "?")
  (define-fun null-String () String
    "")
  (define-fun var326!1 () var3886
    var3886!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun <init>/-118428381 ((x!0 var3886)) void
    void!val!0)
)
