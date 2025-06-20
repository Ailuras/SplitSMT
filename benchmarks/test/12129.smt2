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

(declare-sort var1352 0)
(declare-sort var3833 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1352 var1352)
(declare-const null-String String)
(declare-const var3126 var1352) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var3126 null-var1352)))
(declare-const var2652 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2652 null-String)))
; split operation: var2864 = var2652.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1013 Int (get_split_length var2652 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (= var1013 1))) ; Cond: $i0 != 1 
(define-const var1648 String (get_split_element var2652 "/" -1 1)) ; Statement: $r5 = r1[1] 
(assert true) ; Non Conditional
; split operation: var1444 = var1648.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var3499 Int (get_split_length var1648 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (not (= var3499 1)))) ; Negate: Cond: $i1 != 1  
 ; Statement: return $r5 
(check-sat)
; {}
; {var1352=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var3126=r4, var2652=r0, var3833=null_type, var2864=r1, var1013=$i0, var1648=$r5, var1444=$r3, var3499=$i1}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var1352, r4=var3126, r0=var2652, null_type=var3833, r1=var2864, $i0=var1013, $r5=var1648, $r3=var1444, $i1=var3499}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r1[1];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	return $r5
;block_num 4