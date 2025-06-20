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

(declare-sort var768 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_toString/-1426662429 (String) String)
(declare-fun write/-583041360 (var768 String) void)
(declare-const null-var768 var768)
(declare-const null-String String)
(declare-const var1033 var768) ; Statement: r1 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var1033 null-var768)))
(declare-const var880 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var880 null-String)))
 ; Statement: if r0 != null goto $r2 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.String toString()>() 
(assert (not (= var880 null-String))) ; Cond: r0 != null 
(define-const var588 String (String_toString/-1426662429 var880)) ; Statement: $r2 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true)
;(assert (write/-583041360 var1033 var588)) ; Statement: virtualinvoke r1.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r2) 

(declare-const var1033!1 var768)
(declare-const var588!1 String)
(assert true) ; Non Conditional
 ; Statement: return r1 
(check-sat)
; {String_toString/-1426662429=([java.lang.CharSequence], java.lang.String), write/-583041360=([org.apache.dubbo.common.io.UnsafeStringWriter, java.lang.String], void)}
; {var768=org.apache.dubbo.common.io.UnsafeStringWriter, var1033=r1, var880=r0, var588=$r2}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var768, r1=var1033, r0=var880, $r2=var588}
;seq <java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	r0 := @parameter0: java.lang.CharSequence;	if r0 != null goto $r2 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.String toString()>();	$r2 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.String toString()>();	virtualinvoke r1.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r2);	return r1
;block_num 3