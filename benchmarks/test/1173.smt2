(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var356 0)
(declare-sort var3788 0)
(declare-sort var3301 0)
(declare-sort var3261 0)
(declare-sort var3674 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3261-init () var3261)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3674_getName/65518765 (var3301) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-630064361 (var3261 String) void)
(declare-const null-var356 var356)
(declare-const null-var3788 var3788)
(declare-const null-var3301 var3301)
(declare-const null-__Array__Int__var3788__ (Array Int var3788))
(declare-const var2481 var356) ; Statement: r8 := @this: org.apache.dubbo.common.bytecode.Proxy$1 
(assert (not (= var2481 null-var356)))
(declare-const var3471 var3788) ; Statement: r9 := @parameter0: java.lang.Object 
(assert (not (= var3471 null-var3788)))
(declare-const var464 var3301) ; Statement: r2 := @parameter1: java.lang.reflect.Method 
(assert (not (= var464 null-var3301)))
(declare-const var2379 (Array Int var3788)) ; Statement: r10 := @parameter2: java.lang.Object[] 
(assert (not (= var2379 null-__Array__Int__var3788__)))
(define-const var884 var3261 var3261-init) ; Statement: $r0 = new java.lang.UnsupportedOperationException 
(define-const var1349 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1349)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1349!1 String)
(assert (= var1349!1 ""))
(assert true)
(define-const var810 String (append/672562846 var1349!1 "Method [")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Method [") 
(declare-const var1349!2 String)
(assert (= var1349!2 (str.++ var1349!1 "Method [")))
(define-const var729 String (var3674_getName/65518765 var464)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.reflect.Method)>(r2) 
(assert true)
(define-const var2329 String (append/672562846 var810 var729)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var810!1 String)
(assert (= var810!1 (str.++ var810 var729)))
(assert true)
(define-const var1546 String (append/672562846 var2329 "] unimplemented.")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] unimplemented.") 
(declare-const var2329!1 String)
(assert (= var2329!1 (str.++ var2329 "] unimplemented.")))
(assert true)
(define-const var3616 String (toString/-2075883882 var1546)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-630064361 var884 var3616)) ; Statement: specialinvoke $r0.<java.lang.UnsupportedOperationException: void <init>(java.lang.String)>($r7) 

(declare-const var884!1 var3261)
(declare-const var3616!1 String)
 ; Statement: throw $r0 
(check-sat)
; {var3261-init=([], java.lang.UnsupportedOperationException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3674_getName/65518765=([java.lang.reflect.Method], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-630064361=([java.lang.UnsupportedOperationException, java.lang.String], void)}
; {var356=org.apache.dubbo.common.bytecode.Proxy$1, var2481=r8, var3788=java.lang.Object, var3471=r9, var3301=java.lang.reflect.Method, var464=r2, var2379=r10, var3261=java.lang.UnsupportedOperationException, var884=$r0, var1349=$r1, var810=$r4, var3674=org.apache.dubbo.common.utils.ReflectUtils, var729=$r3, var2329=$r5, var1546=$r6, var3616=$r7}
; {org.apache.dubbo.common.bytecode.Proxy$1=var356, r8=var2481, java.lang.Object=var3788, r9=var3471, java.lang.reflect.Method=var3301, r2=var464, r10=var2379, java.lang.UnsupportedOperationException=var3261, $r0=var884, $r1=var1349, $r4=var810, org.apache.dubbo.common.utils.ReflectUtils=var3674, $r3=var729, $r5=var2329, $r6=var1546, $r7=var3616}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r8 := @this: org.apache.dubbo.common.bytecode.Proxy$1;	r9 := @parameter0: java.lang.Object;	r2 := @parameter1: java.lang.reflect.Method;	r10 := @parameter2: java.lang.Object[];	$r0 = new java.lang.UnsupportedOperationException;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Method [");	$r3 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: java.lang.String getName(java.lang.reflect.Method)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] unimplemented.");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r0.<java.lang.UnsupportedOperationException: void <init>(java.lang.String)>($r7);	throw $r0
;block_num 1