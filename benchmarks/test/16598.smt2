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

(declare-sort var3423 0)
(declare-sort var3716 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun remotePort/-1743271474 (var3716) Int)
(declare-fun cast-from-var3423-to-var3716 (var3423) var3716)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var3423 var3423)
(declare-const var2622 var3423) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter 
(assert (not (= var2622 null-var3423)))
(assert true)
(define-const var3619 Int (remotePort/-1743271474 (cast-from-var3423-to-var3716 var2622))) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: int remotePort()>() 
(define-const var2569 String (String_valueOf/1240665136 var3619)) ; Statement: $r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
 ; Statement: return $r1 
(check-sat)
; {remotePort/-1743271474=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], int), cast-from-var3423-to-var3716=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest), String_valueOf/1240665136=([int], java.lang.String)}
; {var3423=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter, var2622=r0, var3716=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3619=$i0, var2569=$r1}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter=var3423, r0=var2622, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var3716, $i0=var3619, $r1=var2569}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter;	$i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: int remotePort()>();	$r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	return $r1
;block_num 1