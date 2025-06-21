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

(declare-sort var1196 0)
(declare-sort var2124 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1196 var1196)
(declare-const null-String String)
(declare-const var3917 var1196) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder 
(assert (not (= var3917 null-var1196)))
(declare-const var1131 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1131 null-String)))
(define-const var3573 String "true") ; Statement: $r1 = "true" 
(assert true)
(define-const var2680 Bool (= var3573 var1131)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = "false" 
(assert (= (ite var2680 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1788 String "false") ; Statement: $r2 = "false" 
(assert true)
(define-const var2447 Bool (= var1788 var1131)) ; Statement: $z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z1 == 0 goto return r3 
(assert (= (ite var2447 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r3 
(check-sat)
; {}
; {var1196=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder, var3917=r3, var1131=r0, var2124=null_type, var3573=$r1, var2680=$z0, var1788=$r2, var2447=$z1}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder=var1196, r3=var3917, r0=var1131, null_type=var2124, $r1=var3573, $z0=var2680, $r2=var1788, $z1=var2447}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.CorsMeta$Builder;	r0 := @parameter0: java.lang.String;	$r1 = "true";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto $r2 = "false";	$r2 = "false";	$z1 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z1 == 0 goto return r3;	return r3
;block_num 3