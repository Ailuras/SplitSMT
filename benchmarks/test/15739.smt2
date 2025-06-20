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

(declare-sort var3027 0)
(declare-sort var1124 0)
(declare-sort var3908 0)
(declare-sort var507 0)
(declare-sort var532 0)
(declare-sort var2841 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isAdminProtocol/-1981932562 (var3027 var1124) Bool)
(declare-fun originToAggregateListener/-1481231732 (var3027) var507)
(declare-fun var507_get/1088891777 (var507 var532) var532)
(declare-fun cast-from-var1124-to-var532 (var1124) var532)
(declare-fun cast-from-var532-to-var507 (var532) var507)
(declare-fun arr-var532-init () (Array Int var532))
(declare-fun String_format/1339386452 (String (Array Int var532)) String)
(declare-fun var2841_warn/1431914100 (var2841 String String String String) void)
(declare-const null-var3027 var3027)
(declare-const null-var1124 var1124)
(declare-const null-var3908 var3908)
(declare-const null-var507 var507)
(declare-const var3027-logger var2841)
(declare-const null-__Array__Int__var532__ (Array Int var532))
(declare-const var3390 var3027) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var3390 null-var3027)))
(declare-const var1004 var1124) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1004 null-var1124)))
(declare-const var1586 var3908) ; Statement: r5 := @parameter1: org.apache.dubbo.registry.NotifyListener 
(assert (not (= var1586 null-var3908)))
(assert true)
(define-const var3560 Bool (isAdminProtocol/-1981932562 var3390 var1004)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.nacos.NacosRegistry: boolean isAdminProtocol(org.apache.dubbo.common.URL)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.registry.nacos.NacosRegistry: java.util.Map originToAggregateListener> 
(assert (= (ite var3560 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3445 var507 (originToAggregateListener/-1481231732 var3390)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.nacos.NacosRegistry: java.util.Map originToAggregateListener> 
(define-const var40 var532 (var507_get/1088891777 var3445 (cast-from-var1124-to-var532 var1004))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var1395 var507 (cast-from-var532-to-var507 var40)) ; Statement: r4 = (java.util.Map) $r3 
 ; Statement: if r4 != null goto $r6 = interfaceinvoke r4.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r5) 
(assert (not (not (= var1395 null-var507)))) ; Negate: Cond: r4 != null  
(define-const var2072 var2841 var3027-logger) ; Statement: $r11 = <org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1654 (Array Int var532) arr-var532-init) ; Statement: $r10 = newarray (java.lang.Object)[1] 
(declare-const var1654!1 (Array Int var532))
(assert (not (= var1654!1 null-__Array__Int__var532__)))
(assert (= (select var1654!1 0) (cast-from-var1124-to-var532 var1004))) ; Statement: $r10[0] = r1 
(define-const var1964 String (String_format/1339386452 "No aggregate listener found for url %s, this service might have already been unsubscribed." var1654!1)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("No aggregate listener found for url %s, this service might have already been unsubscribed.", $r10) 
;(assert (var2841_warn/1431914100 var2072 "1-37" "" "" var1964)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-37", "", "", $r12) 

(declare-const var2072!1 var2841)
(declare-const var1133 String)
(declare-const var1377 String)
(declare-const var1377!1 String)
(declare-const var1964!1 String)
 ; Statement: return 
(check-sat)
; {isAdminProtocol/-1981932562=([org.apache.dubbo.registry.nacos.NacosRegistry, org.apache.dubbo.common.URL], boolean), originToAggregateListener/-1481231732=([org.apache.dubbo.registry.nacos.NacosRegistry], java.util.Map), var507_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1124-to-var532=([org.apache.dubbo.common.URL], java.lang.Object), cast-from-var532-to-var507=([java.lang.Object], java.util.Map), arr-var532-init=([], java.lang.Object[]), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), var2841_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var3027=org.apache.dubbo.registry.nacos.NacosRegistry, var3390=r0, var1124=org.apache.dubbo.common.URL, var1004=r1, var3908=org.apache.dubbo.registry.NotifyListener, var1586=r5, var3560=$z0, var507=java.util.Map, var3445=$r2, var532=java.lang.Object, var40=$r3, var1395=r4, var2841=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2072=$r11, var1654=$r10, var1964=$r12, var1133="1-37", var1377=""}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var3027, r0=var3390, org.apache.dubbo.common.URL=var1124, r1=var1004, org.apache.dubbo.registry.NotifyListener=var3908, r5=var1586, $z0=var3560, java.util.Map=var507, $r2=var3445, java.lang.Object=var532, $r3=var40, r4=var1395, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2841, $r11=var2072, $r10=var1654, $r12=var1964, "1-37"=var1133, ""=var1377}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	r5 := @parameter1: org.apache.dubbo.registry.NotifyListener;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.nacos.NacosRegistry: boolean isAdminProtocol(org.apache.dubbo.common.URL)>(r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.registry.nacos.NacosRegistry: java.util.Map originToAggregateListener>;	$r2 = r0.<org.apache.dubbo.registry.nacos.NacosRegistry: java.util.Map originToAggregateListener>;	$r3 = interfaceinvoke $r2.<java.util.Map: java.lang.Object get(java.lang.Object)>(r1);	r4 = (java.util.Map) $r3;	if r4 != null goto $r6 = interfaceinvoke r4.<java.util.Map: java.lang.Object remove(java.lang.Object)>(r5);	$r11 = <org.apache.dubbo.registry.nacos.NacosRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = newarray (java.lang.Object)[1];	$r10[0] = r1;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("No aggregate listener found for url %s, this service might have already been unsubscribed.", $r10);	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-37", "", "", $r12);	return
;block_num 3