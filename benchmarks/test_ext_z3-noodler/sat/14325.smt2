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

(declare-sort var392 0)
(declare-sort var72 0)
(declare-sort var976 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSide/-520240817 (var72) String)
(declare-fun acceptable/-1931755004 (var976 var72) Bool)
(declare-fun cast-from-var392-to-var976 (var392) var976)
(declare-const null-var392 var392)
(declare-const null-var72 var72)
(declare-const var1838 var392) ; Statement: r3 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry 
(assert (not (= var1838 null-var392)))
(declare-const var166 var72) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var166 null-var72)))
(assert true)
(define-const var883 String (getSide/-520240817 var166)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(define-const var110 String "provider") ; Statement: $r2 = "provider" 
(assert true)
(define-const var11 Bool (= var110 var883)) ; Statement: z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if z0 != 0 goto $z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0) 
(assert (not (= (ite var11 1 0) 0))) ; Cond: z0 != 0 
(assert true)
(define-const var2473 Bool (acceptable/-1931755004 (cast-from-var392-to-var976 var1838) var166)) ; Statement: $z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: if $z2 != 0 goto return z0 
(assert (not (= (ite var2473 1 0) 0))) ; Cond: $z2 != 0 
 ; Statement: return z0 
(check-sat)
; {getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), acceptable/-1931755004=([org.apache.dubbo.registry.support.AbstractRegistry, org.apache.dubbo.common.URL], boolean), cast-from-var392-to-var976=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry], org.apache.dubbo.registry.support.AbstractRegistry)}
; {var392=org.apache.dubbo.registry.client.ServiceDiscoveryRegistry, var1838=r3, var72=org.apache.dubbo.common.URL, var166=r0, var883=r1, var110=$r2, var11=z0, var976=org.apache.dubbo.registry.support.AbstractRegistry, var2473=$z2}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistry=var392, r3=var1838, org.apache.dubbo.common.URL=var72, r0=var166, r1=var883, $r2=var110, z0=var11, org.apache.dubbo.registry.support.AbstractRegistry=var976, $z2=var2473}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$r2 = "provider";	z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if z0 != 0 goto $z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0);	$z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0);	if $z2 != 0 goto return z0;	return z0
;block_num 3