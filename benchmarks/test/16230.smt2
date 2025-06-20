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

(declare-sort var1699 0)
(declare-sort var3026 0)
(declare-sort var1528 0)
(declare-sort var1209 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocolServiceKey/574559726 (var1699) String)
(declare-fun var3026_isEmpty/-813097145 (String) Bool)
(declare-fun getInstance/1071875566 (var1699) var1528)
(declare-fun var1528_getAllParams/-1673078572 (var1528) var1209)
(declare-const null-var1699 var1699)
(declare-const var395 var1699) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var395 null-var1699)))
(assert true)
(define-const var3448 String (getProtocolServiceKey/574559726 var395)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var2882 Bool (var3026_isEmpty/-813097145 var3448)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getOriginalServiceParameters(java.lang.String)>(r1) 
(assert (not (= (ite var2882 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1600 var1528 (getInstance/1071875566 var395)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance getInstance()>() 
(define-const var511 var1209 (var1528_getAllParams/-1673078572 var1600)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getAllParams()>() 
 ; Statement: return $r4 
(check-sat)
; {getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var3026_isEmpty/-813097145=([java.lang.String], boolean), getInstance/1071875566=([org.apache.dubbo.registry.client.InstanceAddressURL], org.apache.dubbo.registry.client.ServiceInstance), var1528_getAllParams/-1673078572=([org.apache.dubbo.registry.client.ServiceInstance], java.util.Map)}
; {var1699=org.apache.dubbo.registry.client.InstanceAddressURL, var395=r0, var3448=r1, var3026=org.apache.dubbo.common.utils.StringUtils, var2882=$z0, var1528=org.apache.dubbo.registry.client.ServiceInstance, var1600=$r3, var1209=java.util.Map, var511=$r4}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1699, r0=var395, r1=var3448, org.apache.dubbo.common.utils.StringUtils=var3026, $z0=var2882, org.apache.dubbo.registry.client.ServiceInstance=var1528, $r3=var1600, java.util.Map=var1209, $r4=var511}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getOriginalServiceParameters(java.lang.String)>(r1);	$r3 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: org.apache.dubbo.registry.client.ServiceInstance getInstance()>();	$r4 = interfaceinvoke $r3.<org.apache.dubbo.registry.client.ServiceInstance: java.util.Map getAllParams()>();	return $r4
;block_num 2