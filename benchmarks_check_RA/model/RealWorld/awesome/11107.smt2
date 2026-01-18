(
  ;; universe for var3242:
  ;;   var3242!val!0 var3242!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3242!val!0 () var3242)
  (declare-fun var3242!val!1 () var3242)
  ;; cardinality constraint:
  (forall ((x var3242)) (or (= x var3242!val!0) (= x var3242!val!1)))
  ;; -----------
  ;; universe for var2858:
  ;;   var2858!val!1 var2858!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2858!val!1 () var2858)
  (declare-fun var2858!val!0 () var2858)
  ;; cardinality constraint:
  (forall ((x var2858)) (or (= x var2858!val!1) (= x var2858!val!0)))
  ;; -----------
  (define-fun var2898 () Bool
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (readLine/150542008 var3484) "\u{9}") (- 1)))))
(let ((a!2 (ite a!1
                (split_rest (readLine/150542008 var3484) "\u{9}" (- (- 1) 1))
                (split_at (readLine/150542008 var3484) "\u{9}" 0))))
  (= a!2 "labelIndices.length="))))
  (define-fun var1492 () String
    (readLine/150542008 var3484))
  (define-fun var3484 () var2858
    var2858!val!0)
  (define-fun null-var2858 () var2858
    var2858!val!1)
  (define-fun var1133 () String
    (let ((a!1 (and (> (- 1) 0)
                (= 0 (- (- 1) 1))
                (>= (num_splits (readLine/150542008 var3484) "\u{9}") (- 1)))))
  (ite a!1
       (split_rest (readLine/150542008 var3484) "\u{9}" (- (- 1) 1))
       (split_at (readLine/150542008 var3484) "\u{9}" 0))))
  (define-fun var3799 () var3242
    var3242!val!0)
  (define-fun null-var3242 () var3242
    var3242!val!1)
  (define-fun var2345 () var751
    var751-init)
  (define-fun var2345!1 () var751
    var751!val!0)
  (define-fun var751-init () var751
    var751!val!0)
  (define-fun var3520 () String
    "")
  (define-fun readLine/150542008 ((x!0 var2858)) String
    (ite (= x!0 var2858!val!0) "\u{9}"
      "\u{9}"))
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
  (define-fun <init>/-1084991535 ((x!0 var751) (x!1 String)) void
    void!val!0)
)
