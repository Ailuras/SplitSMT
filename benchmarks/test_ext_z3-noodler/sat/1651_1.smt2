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

(declare-sort var815 0)
(declare-sort var1612 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMethodNames/-333225172 (var815) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-const null-var815 var815)
(declare-const null-String String)
(declare-const var1810 var815) ; Statement: r0 := @this: org.apache.dubbo.common.bytecode.Wrapper 
(assert (not (= var1810 null-var815)))
(declare-const var939 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var939 null-String)))
(assert true)
(define-const var2151 (Array Int String) (getMethodNames/-333225172 var1810)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.bytecode.Wrapper: java.lang.String[] getMethodNames()>() 
(define-const var514 Int (getLength-Arr-String-1 var2151)) ; Statement: i0 = lengthof r1 
(define-const var2784 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return 0 
(assert (not (>= var2784 var514))) ; Negate: Cond: i1 >= i0  
(define-const var1791 String (select var2151 var2784)) ; Statement: r2 = r1[i1] 
(assert true)
(define-const var1533 Bool (= var1791 var939)) ; Statement: $z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>(r3) 
 ; Statement: if $z0 == 0 goto i1 = i1 + 1 
(assert (not (= (ite var1533 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 1 
(check-sat)
; {getMethodNames/-333225172=([org.apache.dubbo.common.bytecode.Wrapper], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int)}
; {var815=org.apache.dubbo.common.bytecode.Wrapper, var1810=r0, var939=r3, var1612=null_type, var2151=r1, var514=i0, var2784=i1, var1791=r2, var1533=$z0}
; {org.apache.dubbo.common.bytecode.Wrapper=var815, r0=var1810, r3=var939, null_type=var1612, r1=var2151, i0=var514, i1=var2784, r2=var1791, $z0=var1533}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.bytecode.Wrapper;	r3 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.bytecode.Wrapper: java.lang.String[] getMethodNames()>();	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto return 0;	r2 = r1[i1];	$z0 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>(r3);	if $z0 == 0 goto i1 = i1 + 1;	return 1
;block_num 4