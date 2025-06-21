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

(declare-sort var1925 0)
(declare-sort var325 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun destroyed/91014847 (var1925) var325)
(declare-fun get/2135855162 (var325) Bool)
(declare-const null-var1925 var1925)
(declare-const var111 var1925) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol 
(assert (not (= var111 null-var1925)))
(define-const var2657 var325 (destroyed/91014847 var111)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.concurrent.atomic.AtomicBoolean destroyed> 
(assert true)
(define-const var638 Bool (get/2135855162 var2657)) ; Statement: $z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var638 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {destroyed/91014847=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], java.util.concurrent.atomic.AtomicBoolean), get/2135855162=([java.util.concurrent.atomic.AtomicBoolean], boolean)}
; {var1925=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var111=r0, var325=java.util.concurrent.atomic.AtomicBoolean, var2657=$r1, var638=$z0}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var1925, r0=var111, java.util.concurrent.atomic.AtomicBoolean=var325, $r1=var2657, $z0=var638}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol;	$r1 = r0.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.concurrent.atomic.AtomicBoolean destroyed>;	$z0 = virtualinvoke $r1.<java.util.concurrent.atomic.AtomicBoolean: boolean get()>();	if $z0 == 0 goto return;	return
;block_num 2