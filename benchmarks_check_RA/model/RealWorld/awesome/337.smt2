(
  ;; universe for var2917:
  ;;   var2917!val!1 var2917!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2917!val!1 () var2917)
  (declare-fun var2917!val!0 () var2917)
  ;; cardinality constraint:
  (forall ((x var2917)) (or (= x var2917!val!1) (= x var2917!val!0)))
  ;; -----------
  (define-fun null-var2917 () var2917
    var2917!val!1)
  (define-fun var3917 () Int
    1)
  (define-fun var1888 () var1752
    (commander/-2133873678 var651))
  (define-fun null-String () String
    " ")
  (define-fun var570 () Int
    (getColumnSize/-165698927 (commander/-2133873678 var651)))
  (define-fun var3755 () String
    "")
  (define-fun var1696 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3755 " ") (- 1)) (num_splits var3755 " ") (- 1))
     (num_splits var3755 " ")))
  (define-fun var839 () Int
    var2654)
  (define-fun var651 () var2917
    var2917!val!0)
  (define-fun var1047 () String
    "")
  (define-fun var2654 () Int
    1)
  (define-fun var518 () Int
    0)
  (define-fun null-Int () Int
    0)
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
  (define-fun commander/-2133873678 ((x!0 var2917)) var1752
    var1752!val!0)
  (define-fun getColumnSize/-165698927 ((x!0 var1752)) Int
    0)
)
