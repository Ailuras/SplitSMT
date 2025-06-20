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

(declare-sort var1714 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun subType/1926907315 (var1714) String)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1714 var1714)
(declare-const var3706 var1714) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression 
(assert (not (= var3706 null-var1714)))
(define-const var2531 String (subType/1926907315 var3706)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType> 
(assert true)
(define-const var841 Int (lastIndexOf/-1292097097 var2531 43)) ; Statement: i0 = virtualinvoke $r1.<java.lang.String: int lastIndexOf(int)>(43) 
(define-const var2410 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
 ; Statement: if i0 == $i3 goto return null 
(assert (= var841 var2410)) ; Cond: i0 == $i3 
 ; Statement: return null 
(check-sat)
; {subType/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], java.lang.String), lastIndexOf/-1292097097=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int)}
; {var1714=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression, var3706=r0, var2531=$r1, var841=i0, var2410=$i3}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression=var1714, r0=var3706, $r1=var2531, i0=var841, $i3=var2410}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String subType>;	i0 = virtualinvoke $r1.<java.lang.String: int lastIndexOf(int)>(43);	$i3 = (int) -1;	if i0 == $i3 goto return null;	return null
;block_num 2