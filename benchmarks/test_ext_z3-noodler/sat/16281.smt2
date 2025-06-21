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

(declare-sort var2721 0)
(declare-sort var1520 0)
(declare-sort var1116 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocolServiceKey/574559726 (var2721) String)
(declare-fun var1520_isEmpty/-813097145 (String) Bool)
(declare-fun getServiceParameters/598450403 (var2721 String) var1116)
(declare-const null-var2721 var2721)
(declare-const var176 var2721) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var176 null-var2721)))
(assert true)
(define-const var3533 String (getProtocolServiceKey/574559726 var176)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var1546 Bool (var1520_isEmpty/-813097145 var3533)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getServiceParameters(java.lang.String)>(r1) 
(assert (= (ite var1546 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2130 var1116 (getServiceParameters/598450403 var176 var3533)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getServiceParameters(java.lang.String)>(r1) 
 ; Statement: return $r2 
(check-sat)
; {getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var1520_isEmpty/-813097145=([java.lang.String], boolean), getServiceParameters/598450403=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], java.util.Map)}
; {var2721=org.apache.dubbo.registry.client.InstanceAddressURL, var176=r0, var3533=r1, var1520=org.apache.dubbo.common.utils.StringUtils, var1546=$z0, var1116=java.util.Map, var2130=$r2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var2721, r0=var176, r1=var3533, org.apache.dubbo.common.utils.StringUtils=var1520, $z0=var1546, java.util.Map=var1116, $r2=var2130}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getServiceParameters(java.lang.String)>(r1);	$r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getServiceParameters(java.lang.String)>(r1);	return $r2
;block_num 2