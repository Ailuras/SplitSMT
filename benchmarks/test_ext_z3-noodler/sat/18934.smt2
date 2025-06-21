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

(declare-sort var3789 0)
(declare-sort var2256 0)
(declare-sort var719 0)
(declare-sort var2748 0)
(declare-sort var438 0)
(declare-sort var2749 0)
(declare-sort var2670 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var2256_getInterface/-1171900879 (var2256) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2748_getMethodName/-516674313 (var719) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var438_contains/1636690605 (var438 var2749) Bool)
(declare-fun cast-from-String-to-var2749 (String) var2749)
(declare-fun var2256_invoke/-1860754555 (var2256 var719) var2670)
(declare-const null-var3789 var3789)
(declare-const null-var2256 var2256)
(declare-const null-var719 var719)
(declare-const var3789-LOGGED var438)
(declare-const var3796 var3789) ; Statement: r20 := @this: org.apache.dubbo.rpc.filter.DeprecatedFilter 
(assert (not (= var3796 null-var3789)))
(declare-const var3192 var2256) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3192 null-var2256)))
(declare-const var2971 var719) ; Statement: r5 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2971 null-var719)))
(define-const var2142 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2142)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2142!1 String)
(assert (= var2142!1 ""))
(define-const var2095 ClassObject (var2256_getInterface/-1171900879 var3192)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>() 
(assert true)
(define-const var3126 String (getName/-1958580599 var2095)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2733 String (append/672562846 var2142!1 var3126)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2142!2 String)
(assert (= var2142!2 (str.++ var2142!1 var3126)))
(assert true)
(define-const var3432 String (append/672562846 var2733 ".")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var2733!1 String)
(assert (= var2733!1 (str.++ var2733 ".")))
(define-const var1058 String (var2748_getMethodName/-516674313 var2971)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r5) 
(assert true)
(define-const var940 String (append/672562846 var3432 var1058)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3432!1 String)
(assert (= var3432!1 (str.++ var3432 var1058)))
(assert true)
(define-const var3859 String (toString/-2075883882 var940)) ; Statement: r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2311 var438 var3789-LOGGED) ; Statement: $r10 = <org.apache.dubbo.rpc.filter.DeprecatedFilter: java.util.Set LOGGED> 
(define-const var350 Bool (var438_contains/1636690605 var2311 (cast-from-String-to-var2749 var3859))) ; Statement: $z0 = interfaceinvoke $r10.<java.util.Set: boolean contains(java.lang.Object)>(r9) 
 ; Statement: if $z0 != 0 goto $r28 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r5) 
(assert (not (= (ite var350 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2441 var2670 (var2256_invoke/-1860754555 var3192 var2971)) ; Statement: $r28 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r5) 
 ; Statement: return $r28 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var2256_getInterface/-1171900879=([org.apache.dubbo.rpc.Invoker], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2748_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var438_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var2749=([java.lang.String], java.lang.Object), var2256_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result)}
; {var3789=org.apache.dubbo.rpc.filter.DeprecatedFilter, var3796=r20, var2256=org.apache.dubbo.rpc.Invoker, var3192=r1, var719=org.apache.dubbo.rpc.Invocation, var2971=r5, var2142=$r0, var2095=$r2, var3126=$r3, var2733=$r4, var3432=$r7, var2748=org.apache.dubbo.rpc.support.RpcUtils, var1058=$r6, var940=$r8, var3859=r9, var438=java.util.Set, var2311=$r10, var2749=java.lang.Object, var350=$z0, var2670=org.apache.dubbo.rpc.Result, var2441=$r28}
; {org.apache.dubbo.rpc.filter.DeprecatedFilter=var3789, r20=var3796, org.apache.dubbo.rpc.Invoker=var2256, r1=var3192, org.apache.dubbo.rpc.Invocation=var719, r5=var2971, $r0=var2142, $r2=var2095, $r3=var3126, $r4=var2733, $r7=var3432, org.apache.dubbo.rpc.support.RpcUtils=var2748, $r6=var1058, $r8=var940, r9=var3859, java.util.Set=var438, $r10=var2311, java.lang.Object=var2749, $z0=var350, org.apache.dubbo.rpc.Result=var2670, $r28=var2441}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r20 := @this: org.apache.dubbo.rpc.filter.DeprecatedFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r5 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: java.lang.Class getInterface()>();	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r6 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	$r10 = <org.apache.dubbo.rpc.filter.DeprecatedFilter: java.util.Set LOGGED>;	$z0 = interfaceinvoke $r10.<java.util.Set: boolean contains(java.lang.Object)>(r9);	if $z0 != 0 goto $r28 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r5);	$r28 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r5);	return $r28
;block_num 2