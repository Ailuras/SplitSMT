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

(declare-sort var1358 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_subSequence/-1087362312 (String Int Int) String)
(declare-fun String_toString/-1426662429 (String) String)
(declare-fun write/-583041360 (var1358 String) void)
(declare-const null-var1358 var1358)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1684 var1358) ; Statement: r1 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var1684 null-var1358)))
(declare-const var1774 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var1774 null-String)))
(declare-const var2170 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2170 null-Int)))
(declare-const var3430 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var3430 null-Int)))
 ; Statement: if r0 != null goto $r4 = r0 
(assert (not (= var1774 null-String))) ; Cond: r0 != null 
(define-const var3684 String var1774) ; Statement: $r4 = r0 
(assert true) ; Non Conditional
(define-const var3146 String (String_subSequence/-1087362312 var3684 var2170 var3430)) ; Statement: $r2 = interfaceinvoke $r4.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, i1) 
(define-const var1683 String (String_toString/-1426662429 var3146)) ; Statement: $r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true)
;(assert (write/-583041360 var1684 var1683)) ; Statement: virtualinvoke r1.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r3) 

(declare-const var1684!1 var1358)
(declare-const var1683!1 String)
 ; Statement: return r1 
(check-sat)
; {String_subSequence/-1087362312=([java.lang.CharSequence, int, int], java.lang.CharSequence), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String), write/-583041360=([org.apache.dubbo.common.io.UnsafeStringWriter, java.lang.String], void)}
; {var1358=org.apache.dubbo.common.io.UnsafeStringWriter, var1684=r1, var1774=r0, var2170=i0, var3430=i1, var3684=$r4, var3146=$r2, var1683=$r3}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var1358, r1=var1684, r0=var1774, i0=var2170, i1=var3430, $r4=var3684, $r2=var3146, $r3=var1683}
;seq <java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>;	<java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>": 1,"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	r0 := @parameter0: java.lang.CharSequence;	i0 := @parameter1: int;	i1 := @parameter2: int;	if r0 != null goto $r4 = r0;	$r4 = r0;	$r2 = interfaceinvoke $r4.<java.lang.CharSequence: java.lang.CharSequence subSequence(int,int)>(i0, i1);	$r3 = interfaceinvoke $r2.<java.lang.CharSequence: java.lang.String toString()>();	virtualinvoke r1.<org.apache.dubbo.common.io.UnsafeStringWriter: void write(java.lang.String)>($r3);	return r1
;block_num 3