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

(declare-sort var2032 0)
(declare-sort var1367 0)
(declare-sort var2423 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1367_printToString/802674845 (var2423) String)
(declare-fun cast-from-var2032-to-var2423 (var2032) var2423)
(declare-const null-var2032 var2032)
(declare-const var2066 var2032) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.ErrorResponse 
(assert (not (= var2066 null-var2032)))
(define-const var760 String (var1367_printToString/802674845 (cast-from-var2032-to-var2423 var2066))) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.utils.ToStringUtils: java.lang.String printToString(java.lang.Object)>(r0) 
 ; Statement: return $r1 
(check-sat)
; {var1367_printToString/802674845=([java.lang.Object], java.lang.String), cast-from-var2032-to-var2423=([org.apache.dubbo.remoting.http12.ErrorResponse], java.lang.Object)}
; {var2032=org.apache.dubbo.remoting.http12.ErrorResponse, var2066=r0, var1367=org.apache.dubbo.common.utils.ToStringUtils, var2423=java.lang.Object, var760=$r1}
; {org.apache.dubbo.remoting.http12.ErrorResponse=var2032, r0=var2066, org.apache.dubbo.common.utils.ToStringUtils=var1367, java.lang.Object=var2423, $r1=var760}
;seq <org.apache.dubbo.common.utils.ToStringUtils: java.lang.String printToString(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.ToStringUtils: java.lang.String printToString(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.ErrorResponse;	$r1 = staticinvoke <org.apache.dubbo.common.utils.ToStringUtils: java.lang.String printToString(java.lang.Object)>(r0);	return $r1
;block_num 1