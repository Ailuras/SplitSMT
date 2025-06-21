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

(declare-sort var1420 0)
(declare-sort var2743 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun addParameter/-180549847 (var1420 String String) var1420)
(declare-const null-var1420 var1420)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3318 var1420) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var3318 null-var1420)))
(declare-const var2879 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2879 null-String)))
(declare-const var3109 Int) ; Statement: l0 := @parameter1: long 
(assert (not (= var3109 null-Int)))
(define-const var3061 String (String_valueOf/-107395227 var3109)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l0) 
(assert true)
(define-const var1161 var1420 (addParameter/-180549847 var3318 var2879 var3061)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-107395227=([long], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var1420=com.alibaba.dubbo.common.URL, var3318=r0, var2879=r1, var2743=null_type, var3109=l0, var3061=$r2, var1161=$r3}
; {com.alibaba.dubbo.common.URL=var1420, r0=var3318, r1=var2879, null_type=var2743, l0=var3109, $r2=var3061, $r3=var1161}
;seq <java.lang.String: java.lang.String valueOf(long)>
;cnt {"<java.lang.String: java.lang.String valueOf(long)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	l0 := @parameter1: long;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l0);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1