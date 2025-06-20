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

(declare-sort var1810 0)
(declare-sort var1813 0)
(declare-sort var364 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRevision/973979446 (var1813) String)
(declare-fun var364_isEmpty/-813097145 (String) Bool)
(declare-const null-var1810 var1810)
(declare-const null-var1813 var1813)
(declare-const var2153 var1810) ; Statement: r2 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2 
(assert (not (= var2153 null-var1810)))
(declare-const var1579 var1813) ; Statement: r0 := @parameter0: org.apache.dubbo.metadata.MetadataRequest 
(assert (not (= var1579 null-var1813)))
(assert true)
(define-const var2063 String (getRevision/973979446 var1579)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: java.lang.String getRevision()>() 
(define-const var1623 Bool (var364_isEmpty/-813097145 var2063)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.registry.support.RegistryManager registryManager> 
(assert (not (= (ite var1623 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {getRevision/973979446=([org.apache.dubbo.metadata.MetadataRequest], java.lang.String), var364_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1810=org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2, var2153=r2, var1813=org.apache.dubbo.metadata.MetadataRequest, var1579=r0, var2063=r1, var364=org.apache.dubbo.common.utils.StringUtils, var1623=$z0}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2=var1810, r2=var2153, org.apache.dubbo.metadata.MetadataRequest=var1813, r0=var1579, r1=var2063, org.apache.dubbo.common.utils.StringUtils=var364, $z0=var1623}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2;	r0 := @parameter0: org.apache.dubbo.metadata.MetadataRequest;	r1 = virtualinvoke r0.<org.apache.dubbo.metadata.MetadataRequest: java.lang.String getRevision()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r2.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegationV2: org.apache.dubbo.registry.support.RegistryManager registryManager>;	return null
;block_num 2