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

(declare-sort var3504 0)
(declare-sort var2732 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun scheme/852510100 (var2732) String)
(declare-fun cast-from-var3504-to-var2732 (var3504) var2732)
(declare-const null-var3504 var3504)
(declare-const var424 var3504) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter 
(assert (not (= var424 null-var3504)))
(define-const var3629 String "https") ; Statement: $r2 = "https" 
(assert true)
(define-const var3381 String (scheme/852510100 (cast-from-var3504-to-var2732 var424))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String scheme()>() 
(assert true)
(define-const var407 Bool (= var3629 var3381)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {scheme/852510100=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), cast-from-var3504-to-var2732=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest)}
; {var3504=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter, var424=r0, var3629=$r2, var2732=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var3381=$r1, var407=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter=var3504, r0=var424, $r2=var3629, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var2732, $r1=var3381, $z0=var407}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter;	$r2 = "https";	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.jakarta.ServletHttpRequestAdapter: java.lang.String scheme()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	return $z0
;block_num 1