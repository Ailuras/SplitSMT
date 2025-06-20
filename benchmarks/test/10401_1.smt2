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

(declare-sort var3757 0)
(declare-sort var515 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun serviceInterface/1102404120 (var3757) String)
(declare-fun var515_encode/1794151917 (String) String)
(declare-const null-var3757 var3757)
(declare-const var264 var3757) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier 
(assert (not (= var264 null-var3757)))
(define-const var3063 String "*") ; Statement: $r2 = "*" 
(define-const var2306 String (serviceInterface/1102404120 var264)) ; Statement: $r1 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface> 
(assert true)
(define-const var2439 Bool (= var3063 var2306)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface> 
(assert (= (ite var2439 1 0) 0)) ; Cond: $z0 == 0 
(define-const var94 String (serviceInterface/1102404120 var264)) ; Statement: $r3 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface> 
(define-const var372 String (var515_encode/1794151917 var94)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>($r3) 
 ; Statement: return $r4 
(check-sat)
; {serviceInterface/1102404120=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier], java.lang.String), var515_encode/1794151917=([java.lang.String], java.lang.String)}
; {var3757=org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, var264=r0, var3063=$r2, var2306=$r1, var2439=$z0, var94=$r3, var515=org.apache.dubbo.common.URL, var372=$r4}
; {org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier=var3757, r0=var264, $r2=var3063, $r1=var2306, $z0=var2439, $r3=var94, org.apache.dubbo.common.URL=var515, $r4=var372}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier;	$r2 = "*";	$r1 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface>;	$r3 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface>;	$r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String encode(java.lang.String)>($r3);	return $r4
;block_num 2