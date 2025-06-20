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

(declare-sort var1893 0)
(declare-sort var860 0)
(declare-sort var1607 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocolServiceKey/574559726 (var1893) String)
(declare-fun var860_isEmpty/-813097145 (String) Bool)
(declare-fun getOriginalServiceParameters/786762324 (var1893 String) var1607)
(declare-const null-var1893 var1893)
(declare-const var2917 var1893) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var2917 null-var1893)))
(assert true)
(define-const var3783 String (getProtocolServiceKey/574559726 var2917)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var1328 Bool (var860_isEmpty/-813097145 var3783)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getOriginalServiceParameters(java.lang.String)>(r1) 
(assert (= (ite var1328 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1537 var1607 (getOriginalServiceParameters/786762324 var2917 var3783)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getOriginalServiceParameters(java.lang.String)>(r1) 
 ; Statement: return $r2 
(check-sat)
; {getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var860_isEmpty/-813097145=([java.lang.String], boolean), getOriginalServiceParameters/786762324=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], java.util.Map)}
; {var1893=org.apache.dubbo.registry.client.InstanceAddressURL, var2917=r0, var3783=r1, var860=org.apache.dubbo.common.utils.StringUtils, var1328=$z0, var1607=java.util.Map, var1537=$r2}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1893, r0=var2917, r1=var3783, org.apache.dubbo.common.utils.StringUtils=var860, $z0=var1328, java.util.Map=var1607, $r2=var1537}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r1 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getOriginalServiceParameters(java.lang.String)>(r1);	$r2 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.util.Map getOriginalServiceParameters(java.lang.String)>(r1);	return $r2
;block_num 2