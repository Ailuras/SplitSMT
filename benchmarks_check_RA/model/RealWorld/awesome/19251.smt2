(
  ;; universe for var2290:
  ;;   var2290!val!1 var2290!val!0 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2290!val!1 () var2290)
  (declare-fun var2290!val!0 () var2290)
  ;; cardinality constraint:
  (forall ((x var2290)) (or (= x var2290!val!1) (= x var2290!val!0)))
  ;; -----------
  (define-fun null-String () String
    "")
  (define-fun var2388 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2305 ",") (- 1)) (num_splits var2305 ",") (- 1))
     (num_splits var2305 ",")))
  (define-fun var1240 () var187
    var187-TEXT)
  (define-fun var923 () String
    (var306_getEncoding/-422666462 var818))
  (define-fun var1884 () String
    (var306_getTagSeparator/-1758988662 var818))
  (define-fun var3431 () var306
    var306-init)
  (define-fun var2305 () String
    ",")
  (define-fun var818 () var2290
    var2290!val!0)
  (define-fun null-var2290 () var2290
    var2290!val!1)
  (define-fun var1142!4 () var3589
    var3589!val!0)
  (define-fun var3431!1 () var306
    var306!val!0)
  (define-fun var1884!1 () String
    "")
  (define-fun null-var2475 () var2475
    var2475!val!0)
  (define-fun var187-TEXT () var187
    var187!val!0)
  (define-fun var1142!1 () var3589
    var3589!val!0)
  (define-fun var1240!1 () var187
    var187!val!0)
  (define-fun var923!1 () String
    "")
  (define-fun var1142!2 () var3589
    var3589!val!0)
  (define-fun null-var1915 () var1915
    var1915!val!0)
  (define-fun var2652 () Int
    0)
  (define-fun null-var3867 () var3867
    var3867!val!0)
  (define-fun var1142!3 () var3589
    var3589!val!0)
  (define-fun null-var3956 () var3956
    var3956!val!0)
  (define-fun null-NullType () var3589
    var3589!val!0)
  (define-fun var306-init () var306
    var306!val!0)
  (define-fun var2305!1 () String
    "")
  (define-fun var1142 () var3589
    var3589!val!0)
  (define-fun null-Int () Int
    0)
  (define-fun var1142!5 () var3589
    var3589!val!0)
  (define-fun var1142!6 () var3589
    var3589!val!0)
  (define-fun null-var3093 () var3093
    var3093!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun var306_getTagSeparator/-1758988662 ((x!0 var2290)) String
    "")
  (define-fun var306_getEncoding/-422666462 ((x!0 var2290)) String
    "")
  (define-fun <init>/921971027 ((x!0 var306)
   (x!1 String)
   (x!2 var187)
   (x!3 String)
   (x!4 String)
   (x!5 var3956)
   (x!6 var3093)
   (x!7 var1915)
   (x!8 var2475)
   (x!9 var3867)
   (x!10 Int)
   (x!11 Int)
   (x!12 Bool)) void
    void!val!0)
)
