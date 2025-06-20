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

(declare-sort var2328 0)
(declare-sort var3667 0)
(declare-sort var743 0)
(declare-sort var91 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocolServiceKey/574559726 (var2328) String)
(declare-fun var3667_isEmpty/-813097145 (String) Bool)
(declare-fun getInstance/1071875566 (var2328) var743)
(declare-fun var743_getAllParams/-1673078572 (var743) var91)
(declare-const null-var2328 var2328)
(declare-const var114 var2328) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var114 null-var2328)))
(assert true)
(define-const var3615 String (getProtocolServiceKey/574559726 var114)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var215 Bool (var3667_isEmpty/-813097145 var3615)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getServiceParameters(java.lang.String)>(r1) 
(assert (not (= (ite var215 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2068 var743 (getInstance/1071875566 var114)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance getInstance()>() 
(define-const var1579 var91 (var743_getAllParams/-1673078572 var2068)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getAllParams()>() 
 ; Statement: return $r4 
(check-sat)
; {getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3667_isEmpty/-813097145=([java.lang.String], boolean), getInstance/1071875566=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.registry.client.ServiceInstance), var743_getAllParams/-1673078572=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map)}
; {var2328=org.apache.dubbo.registry.client.InstanceAddressURL, var114=r0, var3615=r1, var3667=org.apache.dubbo.common.utils.StringUtils, var215=$z0, var743=org.apache.dubbo.registry.client.ServiceInstance, var2068=$r3, var91=java.util.Map, var1579=$r4}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2328, r0=var114, r1=var3615, org.apache.dubbo.common.utils.StringUtils=var3667, $z0=var215, org.apache.dubbo.registry.client.ServiceInstance=var743, $r3=var2068, java.util.Map=var91, $r4=var1579}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getServiceParameters(java.lang.String)>(r1);	$r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance getInstance()>();	$r4 = interfaceinvoke $r3.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getAllParams()>();	return $r4
;block_num 2