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

(declare-sort var3466 0)
(declare-sort var3133 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun remotePort/-1743271474 (var3133) Int)
(declare-fun cast-from-var3466-to-var3133 (var3466) var3133)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-const null-var3466 var3466)
(declare-const var805 var3466) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter 
(assert (not (= var805 null-var3466)))
(assert true)
(define-const var1858 Int (remotePort/-1743271474 (cast-from-var3466-to-var3133 var805))) ; Statement: $i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: int remotePort()>() 
(define-const var3570 String (String_valueOf/1240665136 var1858)) ; Statement: $r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0) 
 ; Statement: return $r1 
(check-sat)
; {remotePort/-1743271474=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], int), cast-from-var3466-to-var3133=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest), String_valueOf/1240665136=([int], java.lang.String)}
; {var3466=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter, var805=r0, var3133=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var1858=$i0, var3570=$r1}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter=var3466, r0=var805, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var3133, $i0=var1858, $r1=var3570}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter;	$i0 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: int remotePort()>();	$r1 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i0);	return $r1
;block_num 1