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

(declare-sort var1206 0)
(declare-sort var2319 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun scheme/852510100 (var2319) String)
(declare-fun cast-from-var1206-to-var2319 (var1206) var2319)
(declare-const null-var1206 var1206)
(declare-const var1613 var1206) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter 
(assert (not (= var1613 null-var1206)))
(define-const var3330 String "https") ; Statement: $r2 = "https" 
(assert true)
(define-const var2450 String (scheme/852510100 (cast-from-var1206-to-var2319 var1613))) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String scheme()>() 
(assert true)
(define-const var1556 Bool (= var3330 var2450)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {scheme/852510100=([org.apache.dubbo.remoting.http12.message.DefaultHttpRequest], java.lang.String), cast-from-var1206-to-var2319=([org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter], org.apache.dubbo.remoting.http12.message.DefaultHttpRequest)}
; {var1206=org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter, var1613=r0, var3330=$r2, var2319=org.apache.dubbo.remoting.http12.message.DefaultHttpRequest, var2450=$r1, var1556=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter=var1206, r0=var1613, $r2=var3330, org.apache.dubbo.remoting.http12.message.DefaultHttpRequest=var2319, $r1=var2450, $z0=var1556}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter;	$r2 = "https";	$r1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.support.servlet.ServletHttpRequestAdapter: java.lang.String scheme()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	return $z0
;block_num 1