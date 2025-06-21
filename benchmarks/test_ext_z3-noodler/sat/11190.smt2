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

(declare-sort var381 0)
(declare-sort var3629 0)
(declare-sort var3640 0)
(declare-sort var848 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var848) String)
(declare-fun cast-from-var3640-to-var848 (var3640) var848)
(declare-fun addParameter/-180549847 (var381 String String) var381)
(declare-const null-var381 var381)
(declare-const null-String String)
(declare-const null-var3640 var3640)
(declare-const var825 var381) ; Statement: r1 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var825 null-var381)))
(declare-const var2586 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2586 null-String)))
(declare-const var120 var3640) ; Statement: r0 := @parameter1: java.lang.Enum 
(assert (not (= var120 null-var3640)))
 ; Statement: if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var120 null-var3640))) ; Cond: r0 != null 
(define-const var1765 String (String_valueOf/-333372740 (cast-from-var3640-to-var848 var120))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
(define-const var1796 var381 (addParameter/-180549847 var825 var2586 var1765)) ; Statement: $r4 = virtualinvoke r1.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var3640-to-var848=([java.lang.Enum], java.lang.Object), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var381=com.alibaba.dubbo.common.URL, var825=r1, var2586=r2, var3629=null_type, var3640=java.lang.Enum, var120=r0, var848=java.lang.Object, var1765=$r3, var1796=$r4}
; {com.alibaba.dubbo.common.URL=var381, r1=var825, r2=var2586, null_type=var3629, java.lang.Enum=var3640, r0=var120, java.lang.Object=var848, $r3=var1765, $r4=var1796}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Enum;	if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r4 = virtualinvoke r1.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2