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

(declare-sort var1675 0)
(declare-sort var805 0)
(declare-sort var214 0)
(declare-sort var3392 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun type/434063243 (var1675) var805)
(declare-fun ordinal/-291641772 (var214) Int)
(declare-fun cast-from-var805-to-var214 (var805) var214)
(declare-fun value/434063243 (var1675) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-const null-var1675 var1675)
(declare-const null-String String)
(declare-const var3322 var1675) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment 
(assert (not (= var3322 null-var1675)))
(define-const var1636 var805 (type/434063243 var3322)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type type> 
(assert true)
(define-const var1796 Int (ordinal/-291641772 (cast-from-var805-to-var214 var1636))) ; Statement: $i1 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type: int ordinal()>() 
(define-const var2299 String (value/434063243 var3322)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value> 
 ; Statement: if $r2 != null goto $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value> 
(assert (not (= var2299 null-String))) ; Cond: $r2 != null 
(define-const var971 String (value/434063243 var3322)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value> 
(assert true)
(define-const var2224 Int (hashCode/-467973558 var971)) ; Statement: $i0 = virtualinvoke $r3.<java.lang.String: int hashCode()>() 
(define-const var3663 Int (* var2224 (to_int (^ 2 3)))) ; Statement: $i3 = $i0 << 3 
(assert true) ; Non Conditional
(define-const var1620 Int (bv2nat (bvor ((_ int2bv 64) var1796) ((_ int2bv 64) var3663)))) ; Statement: $i2 = $i1 | $i3 
 ; Statement: return $i2 
(check-sat)
; {type/434063243=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type), ordinal/-291641772=([java.lang.Enum], int), cast-from-var805-to-var214=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type], java.lang.Enum), value/434063243=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment], java.lang.String), hashCode/-467973558=([java.lang.String], int)}
; {var1675=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment, var3322=r0, var805=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type, var1636=$r1, var214=java.lang.Enum, var1796=$i1, var2299=$r2, var3392=null_type, var971=$r3, var2224=$i0, var3663=$i3, var1620=$i2}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment=var1675, r0=var3322, org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type=var805, $r1=var1636, java.lang.Enum=var214, $i1=var1796, $r2=var2299, null_type=var3392, $r3=var971, $i0=var2224, $i3=var3663, $i2=var1620}
;seq <java.lang.String: int hashCode()>
;cnt {"<java.lang.String: int hashCode()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type type>;	$i1 = virtualinvoke $r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment$Type: int ordinal()>();	$r2 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value>;	if $r2 != null goto $r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value>;	$r3 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.PathSegment: java.lang.String value>;	$i0 = virtualinvoke $r3.<java.lang.String: int hashCode()>();	$i3 = $i0 << 3;	$i2 = $i1 | $i3;	return $i2
;block_num 3