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

(declare-sort var1446 0)
(declare-sort var1158 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1158_getPayload/1230319912 (var1446) Int)
(declare-fun var1158_isOverPayload/-95001326 (Int Int) Bool)
(declare-const null-var1446 var1446)
(declare-const null-Int Int)
(declare-const var125 var1446) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var125 null-var1446)))
(declare-const var879 Int) ; Statement: l1 := @parameter1: long 
(assert (not (= var879 null-Int)))
(define-const var1950 Int (var1158_getPayload/1230319912 var125)) ; Statement: i0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: int getPayload(org.apache.dubbo.remoting.Channel)>(r0) 
(define-const var1120 Bool (var1158_isOverPayload/-95001326 var1950 var879)) ; Statement: z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i0, l1) 
 ; Statement: if z0 == 0 goto return 
(assert (= (ite var1120 1 0) 0)) ; Cond: z0 == 0 
 ; Statement: return 
(check-sat)
; {var1158_getPayload/1230319912=([org.apache.dubbo.remoting.Channel], int), var1158_isOverPayload/-95001326=([int, long], boolean)}
; {var1446=org.apache.dubbo.remoting.Channel, var125=r0, var879=l1, var1158=org.apache.dubbo.remoting.transport.AbstractCodec, var1950=i0, var1120=z0}
; {org.apache.dubbo.remoting.Channel=var1446, r0=var125, l1=var879, org.apache.dubbo.remoting.transport.AbstractCodec=var1158, i0=var1950, z0=var1120}
;seq 
;cnt {}
;stmts r0 := @parameter0: org.apache.dubbo.remoting.Channel;	l1 := @parameter1: long;	i0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: int getPayload(org.apache.dubbo.remoting.Channel)>(r0);	z0 = staticinvoke <org.apache.dubbo.remoting.transport.AbstractCodec: boolean isOverPayload(int,long)>(i0, l1);	if z0 == 0 goto return;	return
;block_num 2