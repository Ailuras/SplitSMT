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

(declare-sort var1717 0)
(declare-sort var1681 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/-180549847 (var1717 String String) var1717)
(declare-const null-var1717 var1717)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var29 var1717) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var29 null-var1717)))
(declare-const var883 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var883 null-String)))
(declare-const var680 Int) ; Statement: s0 := @parameter1: short 
(assert (not (= var680 null-Int)))
(define-const var2729 Int (cast-from-Int-to-Int var680)) ; Statement: $i1 = (int) s0 
(define-const var553 String (String_valueOf/1240665136 var2729)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var3727 var1717 (addParameter/-180549847 var29 var883 var553)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([short], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var1717=com.alibaba.dubbo.common.URL, var29=r0, var883=r1, var1681=null_type, var680=s0, var2729=$i1, var553=$r2, var3727=$r3}
; {com.alibaba.dubbo.common.URL=var1717, r0=var29, r1=var883, null_type=var1681, s0=var680, $i1=var2729, $r2=var553, $r3=var3727}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	s0 := @parameter1: short;	$i1 = (int) s0;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1