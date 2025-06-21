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

(declare-sort var1630 0)
(declare-sort var1843 0)
(declare-sort var3798 0)
(declare-sort var1952 0)
(declare-sort var448 0)
(declare-sort var270 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3798_getAttributes/-1941773635 (var3798) var1952)
(declare-fun var1952_get/1088891777 (var1952 var448) var448)
(declare-fun cast-from-var1843-to-var448 (var1843) var448)
(declare-fun cast-from-var448-to-String (var448) String)
(declare-fun var270_isNotEmpty/-1251449450 (String) Bool)
(declare-fun buildServiceKey/-758897257 (var1630 var1843 var3798) String)
(declare-fun var1952_put/1464166817 (var1952 var448 var448) var448)
(declare-fun cast-from-String-to-var448 (String) var448)
(declare-const null-var1630 var1630)
(declare-const null-var1843 var1843)
(declare-const null-var3798 var3798)
(declare-const var473 var1630) ; Statement: r4 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance 
(assert (not (= var473 null-var1630)))
(declare-const var1236 var1843) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var1236 null-var1843)))
(declare-const var410 var3798) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var410 null-var3798)))
(define-const var1199 var1952 (var3798_getAttributes/-1941773635 var410)) ; Statement: $r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
(define-const var2291 var448 (var1952_get/1088891777 var1199 (cast-from-var1843-to-var448 var1236))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var2026 String (cast-from-var448-to-String var2291)) ; Statement: r6 = (java.lang.String) $r3 
(define-const var3760 Bool (var270_isNotEmpty/-1251449450 var2026)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6) 
 ; Statement: if $z0 == 0 goto r7 = specialinvoke r4.<org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r0) 
(assert (= (ite var3760 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var611 String (buildServiceKey/-758897257 var473 var1236 var410)) ; Statement: r7 = specialinvoke r4.<org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r0) 
(define-const var3283 var1952 (var3798_getAttributes/-1941773635 var410)) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>() 
;(assert (var1952_put/1464166817 var3283 (cast-from-var1843-to-var448 var1236) (cast-from-String-to-var448 var611))) ; Statement: interfaceinvoke $r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r7) 

(declare-const var3283!1 var1952)
(declare-const var1236!1 var1843)
(declare-const var611!1 String)
 ; Statement: return r7 
(check-sat)
; {var3798_getAttributes/-1941773635=([org.apache.dubbo.rpc.Invocation], java.util.Map), var1952_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1843-to-var448=([org.apache.dubbo.rpc.Invoker], java.lang.Object), cast-from-var448-to-String=([java.lang.Object], java.lang.String), var270_isNotEmpty/-1251449450=([java.lang.String], boolean), buildServiceKey/-758897257=([org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance, org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], java.lang.String), var1952_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var448=([java.lang.String], java.lang.Object)}
; {var1630=org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance, var473=r4, var1843=org.apache.dubbo.rpc.Invoker, var1236=r1, var3798=org.apache.dubbo.rpc.Invocation, var410=r0, var1952=java.util.Map, var1199=$r2, var448=java.lang.Object, var2291=$r3, var2026=r6, var270=org.apache.dubbo.common.utils.StringUtils, var3760=$z0, var611=r7, var3283=$r5}
; {org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance=var1630, r4=var473, org.apache.dubbo.rpc.Invoker=var1843, r1=var1236, org.apache.dubbo.rpc.Invocation=var3798, r0=var410, java.util.Map=var1952, $r2=var1199, java.lang.Object=var448, $r3=var2291, r6=var2026, org.apache.dubbo.common.utils.StringUtils=var270, $z0=var3760, r7=var611, $r5=var3283}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r2 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r6 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r6);	if $z0 == 0 goto r7 = specialinvoke r4.<org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r0);	r7 = specialinvoke r4.<org.apache.dubbo.rpc.cluster.loadbalance.AdaptiveLoadBalance: java.lang.String buildServiceKey(org.apache.dubbo.rpc.Invoker,org.apache.dubbo.rpc.Invocation)>(r1, r0);	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getAttributes()>();	interfaceinvoke $r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, r7);	return r7
;block_num 2