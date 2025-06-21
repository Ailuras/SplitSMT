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

(declare-sort var3324 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun String_subSequence/-1087362312 (String Int Int) String)
(declare-fun String_toString/-1426662429 (String) String)
(declare-fun write/-583041360 (var3324 String) void)
(declare-const null-var3324 var3324)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var154 var3324) ; Statement: r1 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var154 null-var3324)))
(declare-const var3728 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var3728 null-String)))
(declare-const var2535 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2535 null-Int)))
(declare-const var2633 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var2633 null-Int)))
 ; Statement: if r0 != null goto $r4 = r0 
(assert (not (not (= var3728 null-String)))) ; Negate: Cond: r0 != null  
(define-const var3165 String (cast-from-String-to-String "null")) ; Statement: $r4 = "null" 
 ; Statement: goto [?= $r2 = interfaceinvoke $r4.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, i1)] 
(assert true) ; Non Conditional
(define-const var3456 String (String_subSequence/-1087362312 var3165 var2535 var2633)) ; Statement: $r2 = interfaceinvoke $r4.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, i1) 
(define-const var133 String (String_toString/-1426662429 var3456)) ; Statement: $r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true)
;(assert (write/-583041360 var154 var133)) ; Statement: virtualinvoke r1.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r3) 

(declare-const var154!1 var3324)
(declare-const var133!1 String)
 ; Statement: return r1 
(check-sat)
; {cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), String_subSequence/-1087362312=([java.lang.CharSequence, int, int], java.lang.CharSequence), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String), write/-583041360=([org.apache.dubbo.common.io.UnsafeStringWriter, java.lang.String], void)}
; {var3324=org.apache.dubbo.common.io.UnsafeStringWriter, var154=r1, var3728=r0, var2535=i0, var2633=i1, var3165=$r4, var3456=$r2, var133=$r3}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var3324, r1=var154, r0=var3728, i0=var2535, i1=var2633, $r4=var3165, $r2=var3456, $r3=var133}
;seq <java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>;	<java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>": 1,"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	r0 := @parameter0: java.lang.CharSequence;	i0 := @parameter1: int;	i1 := @parameter2: int;	if r0 != null goto $r4 = r0;	$r4 = "null";	goto [?= $r2 = interfaceinvoke $r4.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, i1)];	$r2 = interfaceinvoke $r4.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, i1);	$r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>();	virtualinvoke r1.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r3);	return r1
;block_num 3