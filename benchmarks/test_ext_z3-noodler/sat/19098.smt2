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

(declare-sort var3023 0)
(declare-sort var1656 0)
(declare-sort var3685 0)
(declare-sort var1558 0)
(declare-sort var2530 0)
(declare-sort var2533 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1656_getAttributes/-1941773635 (var1656) var3685)
(declare-fun var1656_getInvoker/-92063731 (var1656) var1558)
(declare-fun var3685_get/1088891777 (var3685 var2530) var2530)
(declare-fun cast-from-var1558-to-var2530 (var1558) var2530)
(declare-fun cast-from-var2530-to-String (var2530) String)
(declare-fun var2533_isNotEmpty/-1251449450 (String) Bool)
(declare-fun buildServiceKey/1888433988 (var3023 var1656) String)
(declare-fun var3685_put/1464166817 (var3685 var2530 var2530) var2530)
(declare-fun cast-from-String-to-var2530 (String) var2530)
(declare-const null-var3023 var3023)
(declare-const null-var1656 var1656)
(declare-const var3057 var3023) ; Statement: r4 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter 
(assert (not (= var3057 null-var3023)))
(declare-const var1434 var1656) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1434 null-var1656)))
(define-const var83 var3685 (var1656_getAttributes/-1941773635 var1434)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
(define-const var251 var1558 (var1656_getInvoker/-92063731 var1434)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var2088 var2530 (var3685_get/1088891777 var83 (cast-from-var1558-to-var2530 var251))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r1) 
(define-const var3907 String (cast-from-var2530-to-String var2088)) ; Statement: r7 = (java.lang.String) $r3 
(define-const var671 Bool (var2533_isNotEmpty/-1251449450 var3907)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto r8 = specialinvoke r4.<org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (= (ite var671 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1341 String (buildServiceKey/1888433988 var3057 var1434)) ; Statement: r8 = specialinvoke r4.<org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invocation)>(r0) 
(define-const var3113 var3685 (var1656_getAttributes/-1941773635 var1434)) ; Statement: $r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
(define-const var2838 var1558 (var1656_getInvoker/-92063731 var1434)) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
;(assert (var3685_put/1464166817 var3113 (cast-from-var1558-to-var2530 var2838) (cast-from-String-to-var2530 var1341))) ; Statement: interfaceinvoke $r6.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r5, r8) 

(declare-const var3113!1 var3685)
(declare-const var2838!1 var1558)
(declare-const var1341!1 String)
 ; Statement: return r8 
(check-sat)
; {var1656_getAttributes/-1941773635=([org.apache.dubbo.rpc.Invocation], java.util.Map), var1656_getInvoker/-92063731=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Invoker), var3685_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1558-to-var2530=([org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var2530-to-String=([java.lang.Object], java.lang.String), var2533_isNotEmpty/-1251449450=([java.lang.String], boolean), buildServiceKey/1888433988=([org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter, org.apache.dubbo.rpc.Invocation], java.lang.String), var3685_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2530=([java.lang.String], java.lang.Object)}
; {var3023=org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter, var3057=r4, var1656=org.apache.dubbo.rpc.Invocation, var1434=r0, var3685=java.util.Map, var83=$r2, var1558=org.apache.dubbo.rpc.Invoker, var251=$r1, var2530=java.lang.Object, var2088=$r3, var3907=r7, var2533=org.apache.dubbo.common.utils.StringUtils, var671=$z0, var1341=r8, var3113=$r6, var2838=$r5}
; {org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter=var3023, r4=var3057, org.apache.dubbo.rpc.Invocation=var1656, r0=var1434, java.util.Map=var3685, $r2=var83, org.apache.dubbo.rpc.Invoker=var1558, $r1=var251, java.lang.Object=var2530, $r3=var2088, r7=var3907, org.apache.dubbo.common.utils.StringUtils=var2533, $z0=var671, r8=var1341, $r6=var3113, $r5=var2838}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r1);	r7 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r7);	if $z0 == 0 goto r8 = specialinvoke r4.<org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invocation)>(r0);	r8 = specialinvoke r4.<org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invocation)>(r0);	$r6 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	interfaceinvoke $r6.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r5, r8);	return r8
;block_num 2