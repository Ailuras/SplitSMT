(
  ;; universe for var901:
  ;;   var901!val!1 var901!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var901!val!1 () var901)
  (declare-fun var901!val!0 () var901)
  ;; cardinality constraint:
  (forall ((x var901)) (or (= x var901!val!1) (= x var901!val!0)))
  ;; -----------
  (define-fun var375 () var901
    var901!val!0)
  (define-fun var3772 () var3475
    var3475-init)
  (define-fun var452 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun var2576 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1341 " ") (- 1)) (num_splits var1341 " ") (- 1))
     (num_splits var1341 " ")))
  (define-fun null-var901 () var901
    var901!val!1)
  (define-fun var1341 () String
    " ")
  (define-fun var1163 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1341 " ") (- 1)) (num_splits var1341 " ") (- 1))
     (num_splits var1341 " ")))
  (define-fun var3500 () Int
    0)
  (define-fun var1163!1 () Int
    0)
  (define-fun var3475-init () var3475
    var3475!val!0)
  (define-fun var3772!1 () var3475
    var3475!val!0)
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
  (define-fun <init>/1228603609 ((x!0 var3475) (x!1 Int)) void
    void!val!0)
)
