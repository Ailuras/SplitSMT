(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2734 0)
(declare-sort var550 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2734 var2734)
(declare-const null-String String)
(declare-const var2253 var2734) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var2253 null-var2734)))
(declare-const var1659 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1659 null-String)))
; split operation: var2484 = var1659.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var85 Int (get_split_length var1659 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (= var85 1))) ; Cond: $i0 != 1 
(define-const var1674 String (get_split_element var1659 "/" -1 1)) ; Statement: $r5 = r1[1] 
(assert true) ; Non Conditional
; split operation: var2431 = var1674.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1937 Int (get_split_length var1674 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (not (= var1937 1)))) ; Negate: Cond: $i1 != 1  
 ; Statement: return $r5 
(check-sat)
; {}
; {var2734=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var2253=r4, var1659=r0, var550=null_type, var2484=r1, var85=$i0, var1674=$r5, var2431=$r3, var1937=$i1}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2734, r4=var2253, r0=var1659, null_type=var550, r1=var2484, $i0=var85, $r5=var1674, $r3=var2431, $i1=var1937}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r1[1];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	return $r5
;block_num 4