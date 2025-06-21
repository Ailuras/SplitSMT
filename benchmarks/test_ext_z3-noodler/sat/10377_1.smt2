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

(declare-sort var1215 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun serviceInterface/1102404120 (var1215) String)
(declare-const null-var1215 var1215)
(declare-const var3109 var1215) ; Statement: r0 := @this: org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier 
(assert (not (= var3109 null-var1215)))
(define-const var276 String "*") ; Statement: $r2 = "*" 
(define-const var3474 String (serviceInterface/1102404120 var3109)) ; Statement: $r1 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface> 
(assert true)
(define-const var2742 Bool (= var276 var3474)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface> 
(assert (not (= (ite var2742 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return "" 
(check-sat)
; {serviceInterface/1102404120=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier], java.lang.String)}
; {var1215=org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, var3109=r0, var276=$r2, var3474=$r1, var2742=$z0}
; {org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier=var1215, r0=var3109, $r2=var276, $r1=var3474, $z0=var2742}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier;	$r2 = "*";	$r1 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier: java.lang.String serviceInterface>;	return ""
;block_num 2