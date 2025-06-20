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

(declare-sort var1049 0)
(declare-sort var2585 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/-180549847 (var1049 String String) var1049)
(declare-const null-var1049 var1049)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2157 var1049) ; Statement: r0 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var2157 null-var1049)))
(declare-const var187 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var187 null-String)))
(declare-const var2845 Int) ; Statement: b0 := @parameter1: byte 
(assert (not (= var2845 null-Int)))
(define-const var2200 Int (cast-from-Int-to-Int var2845)) ; Statement: $i1 = (int) b0 
(define-const var2727 String (String_valueOf/1240665136 var2200)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var281 var1049 (addParameter/-180549847 var2157 var187 var2727)) ; Statement: $r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([byte], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/-180549847=([com.alibaba.dubbo.common.URL, java.lang.String, java.lang.String], com.alibaba.dubbo.common.URL)}
; {var1049=com.alibaba.dubbo.common.URL, var2157=r0, var187=r1, var2585=null_type, var2845=b0, var2200=$i1, var2727=$r2, var281=$r3}
; {com.alibaba.dubbo.common.URL=var1049, r0=var2157, r1=var187, null_type=var2585, b0=var2845, $i1=var2200, $r2=var2727, $r3=var281}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: com.alibaba.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	b0 := @parameter1: byte;	$i1 = (int) b0;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r3 = virtualinvoke r0.<com.alibaba.dubbo.common.URL: com.alibaba.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1