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

(declare-sort var3089 0)
(declare-sort var577 0)
(declare-sort var3744 0)
(declare-sort var1149 0)
(declare-sort var151 0)
(declare-sort var1292 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun instance/507655048 (var3089) var3744)
(declare-fun var3744_getMetadata/1968437424 (var3744) var1149)
(declare-fun var1149_get/1088891777 (var1149 var151) var151)
(declare-fun cast-from-String-to-var151 (String) var151)
(declare-fun cast-from-var151-to-String (var151) String)
(declare-fun var1292_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3089 var3089)
(declare-const null-String String)
(declare-const var1024 var3089) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var1024 null-var3089)))
(declare-const var233 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var233 null-String)))
(define-const var3611 var3744 (instance/507655048 var1024)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance> 
(define-const var1011 var1149 (var3744_getMetadata/1968437424 var3611)) ; Statement: $r3 = interfaceinvoke $r1.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>() 
(define-const var312 var151 (var1149_get/1088891777 var1011 (cast-from-String-to-var151 var233))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var2913 String (cast-from-var151-to-String var312)) ; Statement: r5 = (java.lang.String) $r4 
(define-const var480 Bool (var1292_isNotEmpty/-1251449450 var2913)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5) 
 ; Statement: if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance> 
(assert (not (= (ite var480 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r5 
(check-sat)
; {instance/507655048=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.registry.client.ServiceInstance), var3744_getMetadata/1968437424=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map), var1149_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var151=([java.lang.String], java.lang.Object), cast-from-var151-to-String=([java.lang.Object], java.lang.String), var1292_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3089=org.apache.dubbo.registry.client.InstanceAddressURL, var1024=r0, var233=r2, var577=null_type, var3744=org.apache.dubbo.registry.client.ServiceInstance, var3611=$r1, var1149=java.util.Map, var1011=$r3, var151=java.lang.Object, var312=$r4, var2913=r5, var1292=org.apache.dubbo.common.utils.StringUtils, var480=$z0}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var3089, r0=var1024, r2=var233, null_type=var577, org.apache.dubbo.registry.client.ServiceInstance=var3744, $r1=var3611, java.util.Map=var1149, $r3=var1011, java.lang.Object=var151, $r4=var312, r5=var2913, org.apache.dubbo.common.utils.StringUtils=var1292, $z0=var480}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance>;	$r3 = interfaceinvoke $r1.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getMetadata()>();	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	r5 = (java.lang.String) $r4;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r5);	if $z0 == 0 goto $r6 = r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance instance>;	return r5
;block_num 2