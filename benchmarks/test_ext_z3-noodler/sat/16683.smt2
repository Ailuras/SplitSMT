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

(declare-sort var2995 0)
(declare-sort var2092 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2092_isOverPayload/-95001326 (Int Int) Bool)
(declare-const null-var2995 var2995)
(declare-const null-Int Int)
(declare-const var236 var2995) ; Statement: r6 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var236 null-var2995)))
(declare-const var2566 Int) ; Statement: i1 := @parameter1: int 
(assert (not (= var2566 null-Int)))
(declare-const var3009 Int) ; Statement: l0 := @parameter2: long 
(assert (not (= var3009 null-Int)))
 ; Statement: if i1 > 0 goto $z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0) 
(assert (> var2566 0)) ; Cond: i1 > 0 
(define-const var3572 Bool (var2092_isOverPayload/-95001326 var2566 var3009)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3572 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var2092_isOverPayload/-95001326=([int, long], boolean)}
; {var2995=org.apache.dubbo.remoting.Channel, var236=r6, var2566=i1, var3009=l0, var2092=org.apache.dubbo.remoting.transport.AbstractCodec, var3572=$z0}
; {org.apache.dubbo.remoting.Channel=var2995, r6=var236, i1=var2566, l0=var3009, org.apache.dubbo.remoting.transport.AbstractCodec=var2092, $z0=var3572}
;seq 
;cnt {}
;stmts r6 := @parameter0: org.apache.dubbo.remoting.Channel;	i1 := @parameter1: int;	l0 := @parameter2: long;	if i1 > 0 goto $z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0);	$z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i1, l0);	if $z0 == 0 goto return;	return
;block_num 3