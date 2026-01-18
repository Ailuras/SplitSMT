(
  ;; universe for var1877:
  ;;   var1877!val!0 var1877!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var1877!val!0 () var1877)
  (declare-fun var1877!val!1 () var1877)
  ;; cardinality constraint:
  (forall ((x var1877)) (or (= x var1877!val!0) (= x var1877!val!1)))
  ;; -----------
  (define-fun var1234 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3045 ",") (- 1)) (num_splits var3045 ",") (- 1))
     (num_splits var3045 ",")))
  (define-fun var1571 () var363
    null-var363)
  (define-fun null-var1877 () var1877
    var1877!val!1)
  (define-fun var1919 () Bool
    (ite (= 1 0) true false))
  (define-fun var3045 () String
    ",")
  (define-fun var2063 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3045 ",") (- 1))
                     (num_splits var3045 ",")
                     (- 1))
                (num_splits var3045 ","))))
  (- a!1 1)))
  (define-fun var1075 () var1901
    null-var1901)
  (define-fun var283 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3045 ",") (- 1)) (num_splits var3045 ",") (- 1))
     (num_splits var3045 ",")))
  (define-fun var2524 () Int
    (getLength-Arr-String-1 var1116!1))
  (define-fun var1116 () (Array Int String)
    arr-String-init)
  (define-fun var2242 () String
    (select var2247!1 (- (getLength-Arr-String-1 var2247!1) 1)))
  (define-fun var3723 () Int
    (- (getLength-Arr-String-1 var2247!1) 1))
  (define-fun var2014 () Int
    (getLength-Arr-String-1 var2247!1))
  (define-fun var2495 () Int
    0)
  (define-fun var1116!1 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var3474 () Int
    null-Int)
  (define-fun var2745 () String
    (var900_getEncoding/-422666462 var2055))
  (define-fun var720 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var3045 ",") (- 1))
                     (num_splits var3045 ",")
                     (- 1))
                (num_splits var3045 ","))))
  (- a!1 1)))
  (define-fun var209 () var3082
    null-var3082)
  (define-fun var2799 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3045 ",") (- 1)) (num_splits var3045 ",") (- 1))
     (num_splits var3045 ",")))
  (define-fun var2653 () var900
    var900-init)
  (define-fun null-String () String
    "")
  (define-fun var2489 () String
    (var900_getTagSeparator/-1758988662 var2055))
  (define-fun var1060 () Int
    null-Int)
  (define-fun var2055 () var1877
    var1877!val!0)
  (define-fun var3090 () var1295
    null-var1295)
  (define-fun var3442 () var996
    var996-TEXT)
  (define-fun var993 () var3296
    null-var3296)
  (define-fun var2745!1 () String
    "")
  (define-fun null-var3296 () var3296
    var3296!val!0)
  (define-fun var720!1 () Int
    0)
  (define-fun var993!1 () var3296
    var3296!val!0)
  (define-fun var1571!1 () var363
    var363!val!0)
  (define-fun null-var3082 () var3082
    var3082!val!0)
  (define-fun var996-TEXT () var996
    var996!val!0)
  (define-fun null-var1295 () var1295
    var1295!val!0)
  (define-fun var1919!1 () Bool
    false)
  (define-fun var2489!1 () String
    "")
  (define-fun var1075!1 () var1901
    var1901!val!0)
  (define-fun var1091!1 () Int
    0)
  (define-fun var3442!1 () var996
    var996!val!0)
  (define-fun var900-init () var900
    var900!val!0)
  (define-fun var1060!1 () Int
    0)
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun null-var1901 () var1901
    var1901!val!0)
  (define-fun var2247!1 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var209!1 () var3082
    var3082!val!0)
  (define-fun null-var363 () var363
    var363!val!0)
  (define-fun var2653!1 () var900
    var900!val!0)
  (define-fun var3474!1 () Int
    0)
  (define-fun var3090!1 () var1295
    var1295!val!0)
  (define-fun null-Int () Int
    0)
  (define-fun var2242!1 () String
    "")
  (define-fun var1091 () Int
    0)
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun var900_getTagSeparator/-1758988662 ((x!0 var1877)) String
    "")
  (define-fun var527_arraycopy/-325913181 ((x!0 var3561)
   (x!1 Int)
   (x!2 var3561)
   (x!3 Int)
   (x!4 Int)) void
    void!val!0)
  (define-fun var900_getEncoding/-422666462 ((x!0 var1877)) String
    "")
  (define-fun cast-from-__Array__Int__String__-to-var3561 ((x!0
    (Array Int String))) var3561
    var3561!val!0)
  (define-fun <init>/921971027 ((x!0 var900)
   (x!1 String)
   (x!2 var996)
   (x!3 String)
   (x!4 String)
   (x!5 var3296)
   (x!6 var1295)
   (x!7 var363)
   (x!8 var1901)
   (x!9 var3082)
   (x!10 Int)
   (x!11 Int)
   (x!12 Bool)) void
    void!val!0)
)
