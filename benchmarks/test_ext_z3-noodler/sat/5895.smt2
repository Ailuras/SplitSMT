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

(declare-sort var452 0)
(declare-sort var483 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun getMethod/1303228849 (ClassObject String (Array Int ClassObject)) var483)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3315 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var3315 null-ClassObject)))
(declare-const var2639 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2639 null-String)))
(declare-const var3507 (Array Int String)) ; Statement: r0 := @parameter2: java.lang.String[] 
(assert (not (= var3507 null-__Array__Int__String__)))
 ; Statement: if r0 != null goto $i0 = lengthof r0 
(assert (not (= var3507 null-__Array__Int__String__))) ; Cond: r0 != null 
(define-const var2201 Int (getLength-Arr-String-1 var3507)) ; Statement: $i0 = lengthof r0 
(define-const var1320 (Array Int ClassObject) arr-ClassObject-init) ; Statement: r23 = newarray (java.lang.Class)[$i0] 
(define-const var3995 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(define-const var3343 Int (getLength-Arr-String-1 var3507)) ; Statement: $i1 = lengthof r0 
 ; Statement: if i6 >= $i1 goto r22 = virtualinvoke r1.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r23) 
(assert (>= var3995 var3343)) ; Cond: i6 >= $i1 
(assert true)
(define-const var3369 var483 (getMethod/1303228849 var3315 var2639 var1320)) ; Statement: r22 = virtualinvoke r1.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r23) 
(assert true) ; Non Conditional
 ; Statement: return r22 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int), arr-ClassObject-init=([], java.lang.Class[]), getMethod/1303228849=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method)}
; {var3315=r1, var2639=r2, var452=null_type, var3507=r0, var2201=$i0, var1320=r23, var3995=i6, var3343=$i1, var483=java.lang.reflect.Method, var3369=r22}
; {r1=var3315, r2=var2639, null_type=var452, r0=var3507, $i0=var2201, r23=var1320, i6=var3995, $i1=var3343, java.lang.reflect.Method=var483, r22=var3369}
;seq 
;cnt {}
;stmts r1 := @parameter0: java.lang.Class;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.String[];	if r0 != null goto $i0 = lengthof r0;	$i0 = lengthof r0;	r23 = newarray (java.lang.Class)[$i0];	i6 = 0;	$i1 = lengthof r0;	if i6 >= $i1 goto r22 = virtualinvoke r1.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r23);	r22 = virtualinvoke r1.<java.lang.Class: java.lang.reflect.Method getMethod(java.lang.String,java.lang.Class[])>(r2, r23);	return r22
;block_num 5