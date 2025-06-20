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

(declare-sort var783 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun mBuffer/-1735303467 (var783) String)
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun append/-1748486345 (String (Array Int Int) Int Int) String)
(declare-const null-var783 var783)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1642 var783) ; Statement: r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter 
(assert (not (= var1642 null-var783)))
(declare-const var2024 (Array Int Int)) ; Statement: r1 := @parameter0: char[] 
(assert (not (= var2024 null-__Array__Int__Int__)))
(define-const var2813 String (mBuffer/-1735303467 var1642)) ; Statement: $r2 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer> 
(define-const var1370 Int (getLength-Arr-Int-1 var2024)) ; Statement: $i0 = lengthof r1 
(assert true)
;(assert (append/-1748486345 var2813 var2024 0 var1370)) ; Statement: virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char[],int,int)>(r1, 0, $i0) 
(declare-const var2813!1 String)
(assert (str.prefixof var2813 var2813!1))
 ; Statement: return 
(check-sat)
; {mBuffer/-1735303467=([org.apache.dubbo.common.io.UnsafeStringWriter], java.lang.StringBuilder), getLength-Arr-Int-1=([char[]], int), append/-1748486345=([java.lang.StringBuilder, char[], int, int], java.lang.StringBuilder)}
; {var783=org.apache.dubbo.common.io.UnsafeStringWriter, var1642=r0, var2024=r1, var2813=$r2, var1370=$i0}
; {org.apache.dubbo.common.io.UnsafeStringWriter=var783, r0=var1642, r1=var2024, $r2=var2813, $i0=var1370}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(char[],int,int)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(char[],int,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.io.UnsafeStringWriter;	r1 := @parameter0: char[];	$r2 = r0.<org.apache.dubbo.common.io.UnsafeStringWriter: java.lang.StringBuilder mBuffer>;	$i0 = lengthof r1;	virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(char[],int,int)>(r1, 0, $i0);	return
;block_num 1