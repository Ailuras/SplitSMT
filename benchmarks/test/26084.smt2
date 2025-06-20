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

(declare-sort var2783 0)
(declare-sort var2060 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun paths/1289445235 (var2783) var2060)
(declare-fun var2060_hashCode/539623333 (var2060) Int)
(declare-fun contextPath/1289445235 (var2783) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var2783 var2783)
(declare-const var3840 var2783) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition 
(assert (not (= var3840 null-var2783)))
(define-const var177 var2060 (paths/1289445235 var3840)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: java.util.Set paths> 
(define-const var2874 Int (var2060_hashCode/539623333 var177)) ; Statement: $i0 = interfaceinvoke $r1.<java.util.Set: int hashCode()>() 
(define-const var3813 Int (* 31 var2874)) ; Statement: $i2 = 31 * $i0 
(define-const var3050 String (contextPath/1289445235 var3840)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: java.lang.String contextPath> 
(assert true)
(define-const var475 Int (hashCode/-467973558 var3050)) ; Statement: $i1 = virtualinvoke $r2.<java.lang.String: int hashCode()>() 
(define-const var3905 Int (+ var3813 var475)) ; Statement: $i3 = $i2 + $i1 
 ; Statement: return $i3 
(check-sat)
; {paths/1289445235=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition], java.util.Set), var2060_hashCode/539623333=([java.util.Set], int), contextPath/1289445235=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var2783=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition, var3840=r0, var2060=java.util.Set, var177=$r1, var2874=$i0, var3813=$i2, var3050=$r2, var475=$i1, var3905=$i3}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition=var2783, r0=var3840, java.util.Set=var2060, $r1=var177, $i0=var2874, $i2=var3813, $r2=var3050, $i1=var475, $i3=var3905}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: java.util.Set paths>;	$i0 = interfaceinvoke $r1.<java.util.Set: int hashCode()>();	$i2 = 31 * $i0;	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathCondition: java.lang.String contextPath>;	$i1 = virtualinvoke $r2.<java.lang.String: int hashCode()>();	$i3 = $i2 + $i1;	return $i3
;block_num 1