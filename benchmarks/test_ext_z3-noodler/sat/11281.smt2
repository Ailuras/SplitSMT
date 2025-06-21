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

(declare-sort var2870 0)
(declare-sort var681 0)
(declare-sort var1150 0)
(declare-sort var3860 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var3860) String)
(declare-fun cast-from-var1150-to-var3860 (var1150) var3860)
(declare-fun addParameter/-180549847 (var2870 String String) var2870)
(declare-const null-var2870 var2870)
(declare-const null-String String)
(declare-const null-var1150 var1150)
(declare-const var2350 var2870) ; Statement: r1 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var2350 null-var2870)))
(declare-const var2076 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2076 null-String)))
(declare-const var44 var1150) ; Statement: r0 := @parameter1: java.lang.Number 
(assert (not (= var44 null-var1150)))
 ; Statement: if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var44 null-var1150))) ; Cond: r0 != null 
(define-const var2622 String (String_valueOf/-333372740 (cast-from-var1150-to-var3860 var44))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
(define-const var756 var2870 (addParameter/-180549847 var2350 var2076 var2622)) ; Statement: $r4 = virtualinvoke r1.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var1150-to-var3860=([java.lang.Number], java.lang.Object), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var2870=com.alibaba.dubbo.common.URL, var2350=r1, var2076=r2, var681=null_type, var1150=java.lang.Number, var44=r0, var3860=java.lang.Object, var2622=$r3, var756=$r4}
; {com.alibaba.dubbo.common.URL=var2870, r1=var2350, r2=var2076, null_type=var681, java.lang.Number=var1150, r0=var44, java.lang.Object=var3860, $r3=var2622, $r4=var756}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Number;	if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r4 = virtualinvoke r1.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2