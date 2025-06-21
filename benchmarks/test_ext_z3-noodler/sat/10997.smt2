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

(declare-sort var3525 0)
(declare-sort var3091 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/-180549847 (var3525 String String) var3525)
(declare-const null-var3525 var3525)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2073 var3525) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var2073 null-var3525)))
(declare-const var404 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var404 null-String)))
(declare-const var2683 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2683 null-Int)))
(define-const var1507 String (String_valueOf/1240665136 var2683)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert true)
(define-const var1185 var3525 (addParameter/-180549847 var2073 var404 var1507)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/1240665136=([int], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var3525=com.alibaba.dubbo.common.URL, var2073=r0, var404=r1, var3091=null_type, var2683=i0, var1507=$r2, var1185=$r3}
; {com.alibaba.dubbo.common.URL=var3525, r0=var2073, r1=var404, null_type=var3091, i0=var2683, $r2=var1507, $r3=var1185}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1