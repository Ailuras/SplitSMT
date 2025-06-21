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

(declare-sort var1354 0)
(declare-sort var2082 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getProtocol/491749358 (var2082) String)
(declare-const null-var1354 var1354)
(declare-const null-var2082 var2082)
(declare-const var466 var1354) ; Statement: r6 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var466 null-var1354)))
(declare-const var3373 var2082) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3373 null-var2082)))
(define-const var272 String "service-discovery-registry") ; Statement: $r2 = "service-discovery-registry" 
(assert true)
(define-const var3399 String (getProtocol/491749358 var3373)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert true)
(define-const var3918 Bool (= var272 var3399)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(assert (not (= (ite var3918 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r0 
(check-sat)
; {getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1354=org.apache.dubbo.registry.integration.RegistryProtocol, var466=r6, var2082=org.apache.dubbo.common.URL, var3373=r0, var272=$r2, var3399=$r1, var3918=$z0}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var1354, r6=var466, org.apache.dubbo.common.URL=var2082, r0=var3373, $r2=var272, $r1=var3399, $z0=var3918}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "service-discovery-registry";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	return r0
;block_num 2