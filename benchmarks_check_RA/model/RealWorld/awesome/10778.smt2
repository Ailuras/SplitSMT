(
  (define-fun var1444 () String
    String-init)
  (define-fun var2890 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var3654 "/") (- 1)) (num_splits var3654 "/") (- 1))
     (num_splits var3654 "/")))
  (define-fun <init>/1968657023 () String
    "")
  (define-fun var2986 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1378 "/") (- 1)) (num_splits var1378 "/") (- 1))
     (num_splits var1378 "/")))
  (define-fun var3654 () String
    "")
  (define-fun var1043 () (Array Int String)
    arr-String-init)
  (define-fun var1378 () String
    "")
  (define-fun var3565 () Int
    0)
  (define-fun var796 () Int
    0)
  (define-fun null-String () String
    "/")
  (define-fun var2032 () Int
    (var2169_size/-649653377 var3865_newHashSet/99871946))
  (define-fun var660 () String
    var1444!1)
  (define-fun var1043!2 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var2776 () Int
    (getLength-Arr-String-1 var1043!2))
  (define-fun var2996 () var2169
    var3865_newHashSet/99871946)
  (define-fun var3842 () Int
    0)
  (define-fun var1444!1 () String
    "")
  (define-fun var2996!1 () var2169
    var2169!val!0)
  (define-fun arr-String-init () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var1043!1 () (Array Int String)
    ((as const (Array Int String)) ""))
  (define-fun var3865_newHashSet/99871946 () var2169
    var2169!val!0)
  (define-fun String-init () String
    "")
  (define-fun getLength-Arr-String-1 ((x!0 (Array Int String))) Int
    0)
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
  (define-fun var137_sort/-2094180924 ((x!0 (Array Int var1804))) void
    void!val!0)
  (define-fun cast-from-__Array__Int__String__-to-__Array__Int__var1804__ ((x!0
    (Array Int String))) (Array Int var1804)
    ((as const (Array Int var1804)) var1804!val!0))
  (define-fun var2169_toArray/-250983565 ((x!0 var2169) (x!1 (Array Int var1804))) (Array Int
         var1804)
    ((as const (Array Int var1804)) var1804!val!0))
  (define-fun var2169_size/-649653377 ((x!0 var2169)) Int
    0)
)
