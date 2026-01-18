(
  ;; universe for var2302:
  ;;   var2302!val!1 var2302!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2302!val!1 () var2302)
  (declare-fun var2302!val!0 () var2302)
  ;; cardinality constraint:
  (forall ((x var2302)) (or (= x var2302!val!1) (= x var2302!val!0)))
  ;; -----------
  (define-fun var2711 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1669 ";") (- 1)) (num_splits var1669 ";") (- 1))
     (num_splits var1669 ";")))
  (define-fun var3790 () var3169
    var3169-init)
  (define-fun var3210 () Int
    0)
  (define-fun null-String () String
    "")
  (define-fun null-var2302 () var2302
    var2302!val!1)
  (define-fun var1669 () String
    ";")
  (define-fun var1024 () var2302
    var2302!val!0)
  (define-fun var3169-init () var3169
    var3169!val!0)
  (define-fun var3790!1 () var3169
    var3169!val!0)
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
  (define-fun <init>/-325640736 ((x!0 var3169)) void
    void!val!0)
)
