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

(declare-sort var233 0)
(declare-sort var2866 0)
(declare-sort var1475 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun result/-749791579 (var233) var2866)
(declare-fun String_valueOf/-333372740 (var1475) String)
(declare-fun cast-from-var2866-to-var1475 (var2866) var1475)
(declare-const null-var233 var233)
(declare-const var2861 var233) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException 
(assert (not (= var2861 null-var233)))
(define-const var637 var2866 (result/-749791579 var2861)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException: org.apache.dubbo.remoting.http12.HttpResult result> 
(define-const var1484 String (String_valueOf/-333372740 (cast-from-var2866-to-var1475 var637))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1) 
 ; Statement: return $r2 
(check-sat)
; {result/-749791579=([org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException], org.apache.dubbo.remoting.http12.HttpResult), String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var2866-to-var1475=([org.apache.dubbo.remoting.http12.HttpResult], java.lang.Object)}
; {var233=org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException, var2861=r0, var2866=org.apache.dubbo.remoting.http12.HttpResult, var637=$r1, var1475=java.lang.Object, var1484=$r2}
; {org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException=var233, r0=var2861, org.apache.dubbo.remoting.http12.HttpResult=var2866, $r1=var637, java.lang.Object=var1475, $r2=var1484}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException;	$r1 = r0.<org.apache.dubbo.remoting.http12.exception.HttpResultPayloadException: org.apache.dubbo.remoting.http12.HttpResult result>;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>($r1);	return $r2
;block_num 1