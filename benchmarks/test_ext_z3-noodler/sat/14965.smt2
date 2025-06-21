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

(declare-sort var1607 0)
(declare-sort var2872 0)
(declare-sort var2222 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2222_isEmpty/-813097145 (String) Bool)
(declare-const null-var1607 var1607)
(declare-const null-String String)
(declare-const var2702 var1607) ; Statement: r1 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation 
(assert (not (= var2702 null-var1607)))
(declare-const var325 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var325 null-String)))
(define-const var2578 Bool (var2222_isEmpty/-813097145 var325)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: org.apache.dubbo.registry.support.RegistryManager registryManager> 
(assert (not (= (ite var2578 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {var2222_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1607=org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation, var2702=r1, var325=r0, var2872=null_type, var2222=org.apache.dubbo.common.utils.StringUtils, var2578=$z0}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation=var1607, r1=var2702, r0=var325, null_type=var2872, org.apache.dubbo.common.utils.StringUtils=var2222, $z0=var2578}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: org.apache.dubbo.registry.support.RegistryManager registryManager>;	return null
;block_num 2