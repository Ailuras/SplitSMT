(
  ;; universe for var870:
  ;;   var870!val!0 var870!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var870!val!0 () var870)
  (declare-fun var870!val!1 () var870)
  ;; cardinality constraint:
  (forall ((x var870)) (or (= x var870!val!0) (= x var870!val!1)))
  ;; -----------
  ;; universe for var3350:
  ;;   var3350!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3350!val!0 () var3350)
  ;; cardinality constraint:
  (forall ((x var3350)) (= x var3350!val!0))
  ;; -----------
  ;; universe for var2264:
  ;;   var2264!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2264!val!0 () var2264)
  ;; cardinality constraint:
  (forall ((x var2264)) (= x var2264!val!0))
  ;; -----------
  (define-fun null-var870 () var870
    var870!val!1)
  (define-fun var962 () var870
    var870!val!0)
  (define-fun null-String () String
    "")
  (define-fun var2113 () var3350
    var3350-init)
  (define-fun var2050 () Bool
    (var2264_isEmpty/-153543822 (cast-from-var3350-to-var2264 var2113!1)))
  (define-fun var2232 () String
    ",")
  (define-fun var2113!1 () var3350
    var3350!val!0)
  (define-fun var2128 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2232 ",") (- 1)) (num_splits var2232 ",") (- 1))
     (num_splits var2232 ",")))
  (define-fun var448 () Int
    0)
  (define-fun var3350-init () var3350
    var3350!val!0)
  (define-fun var2264_isEmpty/-153543822 ((x!0 var2264)) Bool
    false)
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
  (define-fun cast-from-var3350-to-var2264 ((x!0 var3350)) var2264
    var2264!val!0)
  (define-fun <init>/-325640736 ((x!0 var3350)) void
    void!val!0)
)
