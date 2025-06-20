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

(declare-sort var1209 0)
(declare-sort var804 0)
(declare-sort var2175 0)
(declare-sort var2484 0)
(declare-sort var3483 0)
(declare-sort var3010 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2175_getAttributes/-1941773635 (var2175) var2484)
(declare-fun var2484_get/1088891777 (var2484 var3483) var3483)
(declare-fun cast-from-var804-to-var3483 (var804) var3483)
(declare-fun cast-from-var3483-to-String (var3483) String)
(declare-fun var3010_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1209 var1209)
(declare-const null-var804 var804)
(declare-const null-var2175 var2175)
(declare-const var1086 var1209) ; Statement: r4 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance 
(assert (not (= var1086 null-var1209)))
(declare-const var1289 var804) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1289 null-var804)))
(declare-const var145 var2175) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var145 null-var2175)))
(define-const var1077 var2484 (var2175_getAttributes/-1941773635 var145)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
(define-const var871 var3483 (var2484_get/1088891777 var1077 (cast-from-var804-to-var3483 var1289))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1286 String (cast-from-var3483-to-String var871)) ; Statement: r6 = (java.lang.String) $r3 
(define-const var513 Bool (var3010_isNotEmpty/-1251449450 var1286)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z0 == 0 goto r7 = specialinvoke r4.<org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r0) 
(assert (not (= (ite var513 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r6 
(check-sat)
; {var2175_getAttributes/-1941773635=([org.apache.dubbo.rpc.Invocation], java.util.Map), var2484_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var804-to-var3483=([org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var3483-to-String=([java.lang.Object], java.lang.String), var3010_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1209=org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance, var1086=r4, var804=org.apache.dubbo.rpc.Invoker, var1289=r1, var2175=org.apache.dubbo.rpc.Invocation, var145=r0, var2484=java.util.Map, var1077=$r2, var3483=java.lang.Object, var871=$r3, var1286=r6, var3010=org.apache.dubbo.common.utils.StringUtils, var513=$z0}
; {org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance=var1209, r4=var1086, org.apache.dubbo.rpc.Invoker=var804, r1=var1289, org.apache.dubbo.rpc.Invocation=var2175, r0=var145, java.util.Map=var2484, $r2=var1077, java.lang.Object=var3483, $r3=var871, r6=var1286, org.apache.dubbo.common.utils.StringUtils=var3010, $z0=var513}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r6 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z0 == 0 goto r7 = specialinvoke r4.<org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r0);	return r6
;block_num 2