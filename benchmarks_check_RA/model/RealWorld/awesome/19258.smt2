(
  ;; universe for var2319:
  ;;   var2319!val!0 var2319!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var2319!val!0 () var2319)
  (declare-fun var2319!val!1 () var2319)
  ;; cardinality constraint:
  (forall ((x var2319)) (or (= x var2319!val!0) (= x var2319!val!1)))
  ;; -----------
  (define-fun var3971 () String
    (select var3524!1 0))
  (define-fun var2448 () Int
    (let ((a!1 (ite (< (num_splits (select var3524!1 0) "=") 2)
                (num_splits (select var3524!1 0) "=")
                2)))
  (ite (> 2 0) a!1 (num_splits (select var3524!1 0) "="))))
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var1176 () Int
    null-Int)
  (define-fun var1699 () String
    (var3215_getTagSeparator/-1758988662 var3507))
  (define-fun var1112 () Int
    (getLength-Arr-String-1 var3524!1))
  (define-fun var3524!1 () (Array Int String)
    ((as const (Array Int String)) "="))
  (define-fun var423 () String
    (select var793!1 (- (getLength-Arr-String-1 var793!1) 1)))
  (define-fun var2913 () var3504
    null-var3504)
  (define-fun var3410 () String
    (var3215_getEncoding/-422666462 var3507))
  (define-fun var2561 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var448 ",") (- 1)) (num_splits var448 ",") (- 1))
     (num_splits var448 ",")))
  (define-fun var2222 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var448 ",") (- 1))
                     (num_splits var448 ",")
                     (- 1))
                (num_splits var448 ","))))
  (- a!1 1)))
  (define-fun var3682 () Int
    (- (getLength-Arr-String-1 var793!1) 1))
  (define-fun var483 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var448 ",") (- 1))
                     (num_splits var448 ",")
                     (- 1))
                (num_splits var448 ","))))
  (- a!1 1)))
  (define-fun var1103 () String
    (str.++ var3596!1 "TaggedFileRecord argument " (select var3524!1 0)))
  (define-fun var2087 () Int
    0)
  (define-fun var963 () String
    (str.++ var3596!1
        "TaggedFileRecord argument "
        (select var3524!1 0)
        " has an unexpected number of =s"))
  (define-fun var3543 () var800
    null-var800)
  (define-fun var1552 () String
    (str.++ var3596!1 "TaggedFileRecord argument "))
  (define-fun var448 () String
    ",")
  (define-fun var696 () Int
    (getLength-Arr-String-1 var793!1))
  (define-fun var251 () var3250
    var3250-TEXT)
  (define-fun var578 () var3837
    null-var3837)
  (define-fun var3685 () Bool
    (ite (= 1 0) true false))
  (define-fun var2440 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var448 ",") (- 1)) (num_splits var448 ",") (- 1))
     (num_splits var448 ",")))
  (define-fun var1717 () Int
    null-Int)
  (define-fun var2293 () var1794
    null-var1794)
  (define-fun null-var2319 () var2319
    var2319!val!1)
  (define-fun null-String () String
    "=")
  (define-fun var3507 () var2319
    var2319!val!0)
  (define-fun var3596 () String
    String-init)
  (define-fun var2812 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var448 ",") (- 1)) (num_splits var448 ",") (- 1))
     (num_splits var448 ",")))
  (define-fun var3713 () var2750
    null-var2750)
  (define-fun var1251 () String
    (str.++ var3596!1
        "TaggedFileRecord argument "
        (select var3524!1 0)
        " has an unexpected number of =s"))
  (define-fun var3524 () (Array Int String)
    arr-String-init)
  (define-fun var2929 () var3950
    var3950-init)
  (define-fun var3596!1 () String
    "")
  (define-fun var3596!2 () String
    "TaggedFileRecord argument ")
  (define-fun var1103!1 () String
    "TaggedFileRecord argument = has an unexpected number of =s")
  (define-fun var1552!1 () String
    "TaggedFileRecord argument =")
  (define-fun var483!1 () Int
    0)
  (define-fun var2032!1 () Int
    0)
  (define-fun var3950-init () var3950
    var3950!val!0)
  (define-fun null-var800 () var800
    var800!val!0)
  (define-fun var3250-TEXT () var3250
    var3250!val!0)
  (define-fun var793!1 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var963!1 () String
    "")
  (define-fun null-var2750 () var2750
    var2750!val!0)
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var2032 () Int
    0)
  (define-fun null-var3837 () var3837
    var3837!val!0)
  (define-fun null-var3504 () var3504
    var3504!val!0)
  (define-fun var2929!1 () var3950
    var3950!val!0)
  (define-fun String-init () String
    "")
  (define-fun null-var1794 () var1794
    var1794!val!0)
  (define-fun null-Int () Int
    0)
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    1)
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "=") (= x!1 "=")) 0
      3))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun var3215_getTagSeparator/-1758988662 ((x!0 var2319)) String
    "")
  (define-fun <init>/875830710 ((x!0 var3950) (x!1 String)) void
    void!val!0)
  (define-fun cast-from-__Array__Int__String__-to-var1620 ((x!0
    (Array Int String))) var1620
    var1620!val!0)
  (define-fun var3215_getEncoding/-422666462 ((x!0 var2319)) String
    "")
  (define-fun var1573_arraycopy/-325913181 ((x!0 var1620)
   (x!1 Int)
   (x!2 var1620)
   (x!3 Int)
   (x!4 Int)) void
    void!val!0)
)
