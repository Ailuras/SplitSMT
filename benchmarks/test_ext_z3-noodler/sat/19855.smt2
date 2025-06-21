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

(declare-sort var1471 0)
(declare-sort var32 0)
(declare-sort var496 0)
(declare-sort var3003 0)
(declare-sort var1054 0)
(declare-sort var3758 0)
(declare-sort var581 0)
(declare-sort var2320 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var32_removeAttribute/-1356724306 (var32 String) void)
(declare-fun var496_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var581_get/1088891777 (var581 var3758) var3758)
(declare-fun cast-from-var3003-to-var581 (var3003) var581)
(declare-fun cast-from-String-to-var3758 (String) var3758)
(declare-fun cast-from-var3758-to-var2320 (var3758) var2320)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var32 var32)
(declare-const var1054-TRACERS var3003)
(declare-const null-var2320 var2320)
(declare-const var1792 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var1792 null-ClassObject)))
(declare-const var2021 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2021 null-String)))
(declare-const var2046 var32) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.Channel 
(assert (not (= var2046 null-var32)))
;(assert (var32_removeAttribute/-1356724306 var2046 "trace.max")) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.max") 

(declare-const var2046!1 var32)
(declare-const var3448 String)
;(assert (var32_removeAttribute/-1356724306 var2046!1 "trace.count")) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.count") 

(declare-const var2046!2 var32)
(declare-const var217 String)
(define-const var3560 Bool (var496_isNotEmpty/-1251449450 var2021)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r11 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert (= (ite var3560 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var458 String (getName/-1958580599 var1792)) ; Statement: $r11 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert true) ; Non Conditional
(define-const var486 var3003 var1054-TRACERS) ; Statement: $r3 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS> 
(define-const var266 var3758 (var581_get/1088891777 (cast-from-var3003-to-var581 var486) (cast-from-String-to-var3758 var458))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r11) 
(define-const var2619 var2320 (cast-from-var3758-to-var2320 var266)) ; Statement: $r10 = (java.util.Set) $r4 
 ; Statement: if $r10 == null goto return 
(assert (= var2619 null-var2320)) ; Cond: $r10 == null 
 ; Statement: return 
(check-sat)
; {var32_removeAttribute/-1356724306=([org.apache.dubbo.remoting.Channel, java.lang.String], void), var496_isNotEmpty/-1251449450=([java.lang.String], boolean), getName/-1958580599=([java.lang.Class], java.lang.String), var581_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3003-to-var581=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var3758=([java.lang.String], java.lang.Object), cast-from-var3758-to-var2320=([java.lang.Object], java.util.Set)}
; {var1792=r2, var2021=r1, var1471=null_type, var32=org.apache.dubbo.remoting.Channel, var2046=r0, var3448="trace.max", var217="trace.count", var496=org.apache.dubbo.common.utils.StringUtils, var3560=$z0, var458=$r11, var3003=java.util.concurrent.ConcurrentMap, var1054=org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter, var486=$r3, var3758=java.lang.Object, var581=java.util.Map, var266=$r4, var2320=java.util.Set, var2619=$r10}
; {r2=var1792, r1=var2021, null_type=var1471, org.apache.dubbo.remoting.Channel=var32, r0=var2046, "trace.max"=var3448, "trace.count"=var217, org.apache.dubbo.common.utils.StringUtils=var496, $z0=var3560, $r11=var458, java.util.concurrent.ConcurrentMap=var3003, org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter=var1054, $r3=var486, java.lang.Object=var3758, java.util.Map=var581, $r4=var266, java.util.Set=var2320, $r10=var2619}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r2 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.String;	r0 := @parameter2: org.apache.dubbo.remoting.Channel;	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.max");	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.count");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r11 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r11 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r3 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>;	$r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r11);	$r10 = (java.util.Set) $r4;	if $r10 == null goto return;	return
;block_num 4