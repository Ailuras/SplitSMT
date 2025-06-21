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

(declare-sort var2225 0)
(declare-sort var2804 0)
(declare-sort var1492 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2225_readObject/-1178792251 (var2225) var2804)
(declare-fun cast-from-var2804-to-var1492 (var2804) var1492)
(declare-const null-var2225 var2225)
(declare-const var122 var2225) ; Statement: r0 := @this: org.apache.dubbo.common.serialize.ObjectInput 
(assert (not (= var122 null-var2225)))
(define-const var439 var2804 (var2225_readObject/-1178792251 var122)) ; Statement: r1 = interfaceinvoke r0.<org.apache.dubbo.common.serialize.ObjectInput: java.lang.Object readObject()>() 
(define-const var2824 Bool false) ; Statement: $z0 = r1 instanceof java.lang.Throwable 
 ; Statement: if $z0 != 0 goto $r2 = (java.lang.Throwable) r1 
(assert (not (= (ite var2824 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2336 var1492 (cast-from-var2804-to-var1492 var439)) ; Statement: $r2 = (java.lang.Throwable) r1 
 ; Statement: return $r2 
(check-sat)
; {var2225_readObject/-1178792251=([org.apache.dubbo.common.serialize.ObjectInput], java.lang.Object), cast-from-var2804-to-var1492=([java.lang.Object], java.lang.Throwable)}
; {var2225=org.apache.dubbo.common.serialize.ObjectInput, var122=r0, var2804=java.lang.Object, var439=r1, var2824=$z0, var1492=java.lang.Throwable, var2336=$r2}
; {org.apache.dubbo.common.serialize.ObjectInput=var2225, r0=var122, java.lang.Object=var2804, r1=var439, $z0=var2824, java.lang.Throwable=var1492, $r2=var2336}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.serialize.ObjectInput;	r1 = interfaceinvoke r0.<org.apache.dubbo.common.serialize.ObjectInput: java.lang.Object readObject()>();	$z0 = r1 instanceof java.lang.Throwable;	if $z0 != 0 goto $r2 = (java.lang.Throwable) r1;	$r2 = (java.lang.Throwable) r1;	return $r2
;block_num 2