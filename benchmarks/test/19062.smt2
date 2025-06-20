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

(declare-sort var3705 0)
(declare-sort var3794 0)
(declare-sort var3552 0)
(declare-sort var380 0)
(declare-sort var155 0)
(declare-sort var2120 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3794_getAttributes/-1941773635 (var3794) var3552)
(declare-fun var3794_getInvoker/-92063731 (var3794) var380)
(declare-fun var3552_get/1088891777 (var3552 var155) var155)
(declare-fun cast-from-var380-to-var155 (var380) var155)
(declare-fun cast-from-var155-to-String (var155) String)
(declare-fun var2120_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3705 var3705)
(declare-const null-var3794 var3794)
(declare-const var2695 var3705) ; Statement: r4 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter 
(assert (not (= var2695 null-var3705)))
(declare-const var2561 var3794) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2561 null-var3794)))
(define-const var294 var3552 (var3794_getAttributes/-1941773635 var2561)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
(define-const var1629 var380 (var3794_getInvoker/-92063731 var2561)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>() 
(define-const var3812 var155 (var3552_get/1088891777 var294 (cast-from-var380-to-var155 var1629))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r1) 
(define-const var2540 String (cast-from-var155-to-String var3812)) ; Statement: r7 = (java.lang.String) $r3 
(define-const var2122 Bool (var2120_isNotEmpty/-1251449450 var2540)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r7) 
 ; Statement: if $z0 == 0 goto r8 = specialinvoke r4.<org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invocation)>(r0) 
(assert (not (= (ite var2122 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r7 
(check-sat)
; {var3794_getAttributes/-1941773635=([org.apache.dubbo.rpc.Invocation], java.util.Map), var3794_getInvoker/-92063731=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Invoker), var3552_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var380-to-var155=([org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var155-to-String=([java.lang.Object], java.lang.String), var2120_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3705=org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter, var2695=r4, var3794=org.apache.dubbo.rpc.Invocation, var2561=r0, var3552=java.util.Map, var294=$r2, var380=org.apache.dubbo.rpc.Invoker, var1629=$r1, var155=java.lang.Object, var3812=$r3, var2540=r7, var2120=org.apache.dubbo.common.utils.StringUtils, var2122=$z0}
; {org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter=var3705, r4=var2695, org.apache.dubbo.rpc.Invocation=var3794, r0=var2561, java.util.Map=var3552, $r2=var294, org.apache.dubbo.rpc.Invoker=var380, $r1=var1629, java.lang.Object=var155, $r3=var3812, r7=var2540, org.apache.dubbo.common.utils.StringUtils=var2120, $z0=var2122}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter;	r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.Invoker getInvoker()>();	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>($r1);	r7 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r7);	if $z0 == 0 goto r8 = specialinvoke r4.<org.apache.dubbo.rpc.filter.AdaptiveLoadBalanceFilter: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invocation)>(r0);	return r7
;block_num 2