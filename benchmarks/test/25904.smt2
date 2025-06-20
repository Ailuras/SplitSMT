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

(declare-sort var2450 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun path/453503808 (var2450) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var2450 var2450)
(declare-const var1789 var2450) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression 
(assert (not (= var1789 null-var2450)))
(define-const var710 String (path/453503808 var1789)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path> 
(assert true)
(define-const var1590 Int (hashCode/-467973558 var710)) ; Statement: $i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>() 
 ; Statement: return $i0 
(check-sat)
; {path/453503808=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var2450=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression, var1789=r0, var710=$r1, var1590=$i0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression=var2450, r0=var1789, $r1=var710, $i0=var1590}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathExpression: java.lang.String path>;	$i0 = virtualinvoke $r1.<java.lang.String: int hashCode()>();	return $i0
;block_num 1