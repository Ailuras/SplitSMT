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

(declare-sort var663 0)
(declare-sort var3301 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-987357574 (Float64) String)
(declare-fun addParameter/-180549847 (var663 String String) var663)
(declare-const null-var663 var663)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const var1983 var663) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var1983 null-var663)))
(declare-const var1936 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1936 null-String)))
(declare-const var1691 Float64) ; Statement: d0 := @parameter1: double 
(assert (not (= var1691 null-Float64)))
(define-const var3739 String (String_valueOf/-987357574 var1691)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(double)>(d0) 
(assert true)
(define-const var3713 var663 (addParameter/-180549847 var1983 var1936 var3739)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-987357574=([double], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var663=com.alibaba.dubbo.common.URL, var1983=r0, var1936=r1, var3301=null_type, var1691=d0, var3739=$r2, var3713=$r3}
; {com.alibaba.dubbo.common.URL=var663, r0=var1983, r1=var1936, null_type=var3301, d0=var1691, $r2=var3739, $r3=var3713}
;seq <java.lang.String: java.lang.String valueOf(double)>
;cnt {"<java.lang.String: java.lang.String valueOf(double)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	d0 := @parameter1: double;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(double)>(d0);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1