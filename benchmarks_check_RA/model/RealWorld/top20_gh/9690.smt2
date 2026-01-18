(
  ;; universe for var3829:
  ;;   var3829!val!0 var3829!val!1 
  ;; -----------
  ;; definitions for universe elements:
  (declare-fun var3829!val!0 () var3829)
  (declare-fun var3829!val!1 () var3829)
  ;; cardinality constraint:
  (forall ((x var3829)) (or (= x var3829!val!0) (= x var3829!val!1)))
  ;; -----------
  (define-fun var2368 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2901 ":") (- 1)) (num_splits var2901 ":") (- 1))
     (num_splits var2901 ":")))
  (define-fun var2901 () String
    ":")
  (define-fun var2408 () Int
    (let ((a!1 (ite (> (- 1) 0)
                (ite (< (num_splits var2901 ":") (- 1))
                     (num_splits var2901 ":")
                     (- 1))
                (num_splits var2901 ":"))))
  (mod a!1 2)))
  (define-fun null-var3829 () var3829
    var3829!val!1)
  (define-fun var2634 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2901 ":") (- 1)) (num_splits var2901 ":") (- 1))
     (num_splits var2901 ":")))
  (define-fun var1655 () var3829
    var3829!val!0)
  (define-fun var210 () var1738
    (var1024_stream/-1757820
  (cast-from-__Array__Int__String__-to-__Array__Int__var3137__ var1833)))
  (define-fun var2378 () Int
    (mod (size/-1863229846 var1655) 2))
  (define-fun var554 () var1251
    var2763_bootstrap$/1705390446)
  (define-fun null-String () String
    "")
  (define-fun var3309 () var1738
    (var1738_map/130902797
  (var1024_stream/-1757820
    (cast-from-__Array__Int__String__-to-__Array__Int__var3137__ var1833))
  var2763_bootstrap$/1705390446))
  (define-fun var817 () var3848
    (let ((a!1 (var1738_collect/-2050842585
             (var1738_map/130902797
               (var1024_stream/-1757820
                 (cast-from-__Array__Int__String__-to-__Array__Int__var3137__
                   var1833))
               var2763_bootstrap$/1705390446)
             var3609_toList/714215649)))
  (cast-from-var3137-to-var3848 a!1)))
  (define-fun var3268 () Int
    (size/-1863229846 var1655))
  (define-fun var3816 () var3435
    var3609_toList/714215649)
  (define-fun var851 () var3137
    (var1738_collect/-2050842585
  (var1738_map/130902797
    (var1024_stream/-1757820
      (cast-from-__Array__Int__String__-to-__Array__Int__var3137__ var1833))
    var2763_bootstrap$/1705390446)
  var3609_toList/714215649))
  (define-fun var1833 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var3609_toList/714215649 () var3435
    var3435!val!0)
  (define-fun var817!1 () var3848
    var3848!val!0)
  (define-fun var2763_bootstrap$/1705390446 () var1251
    var1251!val!0)
  (define-fun var1655!1 () var3829
    var3829!val!0)
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun size/-1863229846 ((x!0 var3829)) Int
    0)
  (define-fun cast-from-var3137-to-var3848 ((x!0 var3137)) var3848
    var3848!val!0)
  (define-fun cast-from-__Array__Int__String__-to-__Array__Int__var3137__ ((x!0
    (Array Int String))) (Array Int var3137)
    ((as const (Array Int var3137)) var3137!val!0))
  (define-fun var1738_collect/-2050842585 ((x!0 var1738) (x!1 var3435)) var3137
    var3137!val!0)
  (define-fun var1024_stream/-1757820 ((x!0 (Array Int var3137))) var1738
    var1738!val!0)
  (define-fun addAll/-313517534 ((x!0 var3829) (x!1 var3848)) Bool
    false)
  (define-fun var1738_map/130902797 ((x!0 var1738) (x!1 var1251)) var1738
    var1738!val!0)
)
