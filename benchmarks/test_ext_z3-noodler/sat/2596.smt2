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

(declare-sort var2954 0)
(declare-sort var1493 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExceptionTypes/1420527167 (var1493) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-const null-var2954 var2954)
(declare-const null-var1493 var1493)
(declare-const var3428 var2954) ; Statement: r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator 
(assert (not (= var3428 null-var2954)))
(declare-const var3196 var1493) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3196 null-var1493)))
(assert true)
(define-const var1137 (Array Int ClassObject) (getExceptionTypes/1420527167 var3196)) ; Statement: r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getExceptionTypes()>() 
(define-const var2517 Int (getLength-Arr-ClassObject-1 var1137)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 0 goto return "" 
(assert (<= var2517 0)) ; Cond: $i0 <= 0 
 ; Statement: return "" 
(check-sat)
; {getExceptionTypes/1420527167=([java.lang.reflect.Method], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int)}
; {var2954=org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator, var3428=r10, var1493=java.lang.reflect.Method, var3196=r0, var1137=r1, var2517=$i0}
; {org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator=var2954, r10=var3428, java.lang.reflect.Method=var1493, r0=var3196, r1=var1137, $i0=var2517}
;seq 
;cnt {}
;stmts r10 := @this: org.apache.dubbo.common.extension.AdaptiveClassCodeGenerator;	r0 := @parameter0: java.lang.reflect.Method;	r1 = virtualinvoke r0.<java.lang.reflect.Method: java.lang.Class[] getExceptionTypes()>();	$i0 = lengthof r1;	if $i0 <= 0 goto return "";	return ""
;block_num 2