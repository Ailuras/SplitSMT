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

(declare-sort var2140 0)
(declare-sort var508 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var508_getSerializationById/-696791859 (Int) var2140)
(declare-const null-Int Int)
(declare-const null-var2140 var2140)
(declare-const var591 Int) ; Statement: r0 := @parameter0: java.lang.Byte 
(assert (not (= var591 null-Int)))
(define-const var461 var2140 (var508_getSerializationById/-696791859 var591)) ; Statement: r1 = staticinvoke <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.serialize.Serialization getSerializationById(java.lang.Byte)>(r0) 
 ; Statement: if r1 != null goto return r1 
(assert (not (= var461 null-var2140))) ; Cond: r1 != null 
 ; Statement: return r1 
(check-sat)
; {var508_getSerializationById/-696791859=([java.lang.Byte], org.apache.dubbo.common.serialize.Serialization)}
; {var591=r0, var2140=org.apache.dubbo.common.serialize.Serialization, var508=org.apache.dubbo.remoting.transport.CodecSupport, var461=r1}
; {r0=var591, org.apache.dubbo.common.serialize.Serialization=var2140, org.apache.dubbo.remoting.transport.CodecSupport=var508, r1=var461}
;seq 
;cnt {}
;stmts r0 := @parameter0: java.lang.Byte;	r1 = staticinvoke <org.apache.dubbo.remoting.transport.CodecSupport: org.apache.dubbo.common.serialize.Serialization getSerializationById(java.lang.Byte)>(r0);	if r1 != null goto return r1;	return r1
;block_num 2