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

(declare-sort var481 0)
(declare-sort var3363 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var481 var481)
(declare-const null-String String)
(declare-const var1143 var481) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var1143 null-var481)))
(declare-const var3547 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3547 null-String)))
; split operation: var1257 = var3547.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var545 Int (get_split_length var3547 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (= var545 1))) ; Cond: $i0 != 1 
(define-const var576 String (get_split_element var3547 "/" -1 1)) ; Statement: $r5 = r1[1] 
(assert true) ; Non Conditional
; split operation: var3209 = var576.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var487 Int (get_split_length var576 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (= var487 1))) ; Cond: $i1 != 1 
(define-const var866 String (get_split_element var576 ":" -1 0)) ; Statement: $r2 = $r3[0] 
 ; Statement: return $r2 
(check-sat)
; {}
; {var481=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var1143=r4, var3547=r0, var3363=null_type, var1257=r1, var545=$i0, var576=$r5, var3209=$r3, var487=$i1, var866=$r2}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var481, r4=var1143, r0=var3547, null_type=var3363, r1=var1257, $i0=var545, $r5=var576, $r3=var3209, $i1=var487, $r2=var866}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r1[1];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	$r2 = $r3[0];	return $r2
;block_num 4