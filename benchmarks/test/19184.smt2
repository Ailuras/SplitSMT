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

(declare-sort var2480 0)
(declare-sort var479 0)
(declare-sort var3416 0)
(declare-sort var2107 0)
(declare-sort var731 0)
(declare-sort var3381 0)
(declare-sort var3863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2107_getAttributes/-1941773635 (var2107) var731)
(declare-fun var731_get/1088891777 (var731 var3381) var3381)
(declare-fun cast-from-String-to-var3381 (String) var3381)
(declare-fun cast-from-var3381-to-String (var3381) String)
(declare-fun var3863_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2480 var2480)
(declare-const null-var479 var479)
(declare-const null-var3416 var3416)
(declare-const null-var2107 var2107)
(declare-const var2500 var2480) ; Statement: r5 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter 
(assert (not (= var2500 null-var2480)))
(declare-const var592 var479) ; Statement: r8 := @parameter0: java.lang.Throwable 
(assert (not (= var592 null-var479)))
(declare-const var645 var3416) ; Statement: r9 := @parameter1: org.apache.dubbo.rpc.Invoker 
(assert (not (= var645 null-var3416)))
(declare-const var303 var2107) ; Statement: r0 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var303 null-var2107)))
(define-const var2594 var731 (var2107_getAttributes/-1941773635 var303)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
(define-const var988 var3381 (var731_get/1088891777 var2594 (cast-from-String-to-var3381 "loadbalance"))) ; Statement: $r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("loadbalance") 
(define-const var2731 String (cast-from-var3381-to-String var988)) ; Statement: r3 = (java.lang.String) $r2 
(define-const var423 Bool (var3863_isNotEmpty/-1251449450 var2731)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var423 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var2107_getAttributes/-1941773635=([org.apache.dubbo.rpc.Invocation], java.util.Map), var731_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3381=([java.lang.String], java.lang.Object), cast-from-var3381-to-String=([java.lang.Object], java.lang.String), var3863_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2480=org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter, var2500=r5, var479=java.lang.Throwable, var592=r8, var3416=org.apache.dubbo.rpc.Invoker, var645=r9, var2107=org.apache.dubbo.rpc.Invocation, var303=r0, var731=java.util.Map, var2594=$r1, var3381=java.lang.Object, var988=$r2, var2731=r3, var3863=org.apache.dubbo.common.utils.StringUtils, var423=$z0}
; {org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter=var2480, r5=var2500, java.lang.Throwable=var479, r8=var592, org.apache.dubbo.rpc.Invoker=var3416, r9=var645, org.apache.dubbo.rpc.Invocation=var2107, r0=var303, java.util.Map=var731, $r1=var2594, java.lang.Object=var3381, $r2=var988, r3=var2731, org.apache.dubbo.common.utils.StringUtils=var3863, $z0=var423}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r5 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter;	r8 := @parameter0: java.lang.Throwable;	r9 := @parameter1: org.apache.dubbo.rpc.Invoker;	r0 := @parameter2: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	$r2 = interfaceinvoke $r1.<java.util.Map: java.lang.Object get(java.lang.Object)>("loadbalance");	r3 = (java.lang.String) $r2;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r3);	if $z0 == 0 goto return;	return
;block_num 2