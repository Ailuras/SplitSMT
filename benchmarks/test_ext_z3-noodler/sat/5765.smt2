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

(declare-sort var1828 0)
(declare-sort var2165 0)
(declare-sort var1383 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-const null-var1828 var1828)
(declare-const null-String String)
(declare-const var1383-EMPTY_CLASS_ARRAY (Array Int ClassObject))
(declare-const var3459 var1828) ; Statement: r7 := @parameter0: java.lang.ClassLoader 
(assert (not (= var3459 null-var1828)))
(declare-const var118 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var118 null-String)))
(assert true)
(define-const var3952 Int (length/-134980193 var118)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 != 0 goto $r1 = new java.util.ArrayList 
(assert (not (not (= var3952 0)))) ; Negate: Cond: $i0 != 0  
(define-const var68 (Array Int ClassObject) var1383-EMPTY_CLASS_ARRAY) ; Statement: $r10 = <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class[] EMPTY_CLASS_ARRAY> 
 ; Statement: return $r10 
(check-sat)
; {length/-134980193=([java.lang.String], int)}
; {var1828=java.lang.ClassLoader, var3459=r7, var118=r0, var2165=null_type, var3952=$i0, var1383=org.apache.dubbo.common.utils.ReflectUtils, var68=$r10}
; {java.lang.ClassLoader=var1828, r7=var3459, r0=var118, null_type=var2165, $i0=var3952, org.apache.dubbo.common.utils.ReflectUtils=var1383, $r10=var68}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r7 := @parameter0: java.lang.ClassLoader;	r0 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 != 0 goto $r1 = new java.util.ArrayList;	$r10 = <org.apache.dubbo.common.utils.ReflectUtils: java.lang.Class[] EMPTY_CLASS_ARRAY>;	return $r10
;block_num 2