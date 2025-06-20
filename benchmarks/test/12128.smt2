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

(declare-sort var2232 0)
(declare-sort var959 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2232 var2232)
(declare-const null-String String)
(declare-const var2637 var2232) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var2637 null-var2232)))
(declare-const var2098 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2098 null-String)))
; split operation: var1464 = var2098.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1108 Int (get_split_length var2098 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (not (= var1108 1)))) ; Negate: Cond: $i0 != 1  
(define-const var771 String var2098) ; Statement: $r5 = r0 
 ; Statement: goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")] 
(assert true) ; Non Conditional
; split operation: var3992 = var771.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1300 Int (get_split_length var771 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (= var1300 1))) ; Cond: $i1 != 1 
(define-const var403 String (get_split_element var771 ":" -1 0)) ; Statement: $r2 = $r3[0] 
 ; Statement: return $r2 
(check-sat)
; {}
; {var2232=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var2637=r4, var2098=r0, var959=null_type, var1464=r1, var1108=$i0, var771=$r5, var3992=$r3, var1300=$i1, var403=$r2}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2232, r4=var2637, r0=var2098, null_type=var959, r1=var1464, $i0=var1108, $r5=var771, $r3=var3992, $i1=var1300, $r2=var403}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r0;	goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	$r2 = $r3[0];	return $r2
;block_num 4