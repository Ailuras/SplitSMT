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

(declare-sort var2417 0)
(declare-sort var446 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2417 var2417)
(declare-const null-String String)
(declare-const var1128 var2417) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var1128 null-var2417)))
(declare-const var2748 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2748 null-String)))
; split operation: var3271 = var2748.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var542 Int (get_split_length var2748 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (not (= var542 1)))) ; Negate: Cond: $i0 != 1  
(define-const var663 String var2748) ; Statement: $r5 = r0 
 ; Statement: goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")] 
(assert true) ; Non Conditional
; split operation: var856 = var663.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1719 Int (get_split_length var663 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (not (= var1719 1)))) ; Negate: Cond: $i1 != 1  
 ; Statement: return $r5 
(check-sat)
; {}
; {var2417=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var1128=r4, var2748=r0, var446=null_type, var3271=r1, var542=$i0, var663=$r5, var856=$r3, var1719=$i1}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2417, r4=var1128, r0=var2748, null_type=var446, r1=var3271, $i0=var542, $r5=var663, $r3=var856, $i1=var1719}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r0;	goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	return $r5
;block_num 4