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

(declare-sort var551 0)
(declare-sort var3665 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3665-to-var551 (var3665) var551)
(declare-fun name/2041112302 (var551) String)
(declare-const null-var551 var551)
(declare-const null-var3665 var3665)
(declare-const var949 var551) ; Statement: r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key 
(assert (not (= var949 null-var551)))
(declare-const var753 var3665) ; Statement: r0 := @parameter0: java.lang.Object 
(assert (not (= var753 null-var3665)))
(define-const var3654 var551 (cast-from-var3665-to-var551 var753)) ; Statement: r1 = (org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key) r0 
(define-const var3349 String (name/2041112302 var949)) ; Statement: $r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name> 
(define-const var1412 String (name/2041112302 var3654)) ; Statement: $r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name> 
(assert true)
(define-const var2195 Bool (= var3349 var1412)) ; Statement: $z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3) 
 ; Statement: if $z0 == 0 goto $z2 = 0 
(assert (= (ite var2195 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2431 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {cast-from-var3665-to-var551=([java.lang.Object], org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key), name/2041112302=([org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key], java.lang.String)}
; {var551=org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key, var949=r2, var3665=java.lang.Object, var753=r0, var3654=r1, var3349=$r4, var1412=$r3, var2195=$z0, var2431=$z2}
; {org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key=var551, r2=var949, java.lang.Object=var3665, r0=var753, r1=var3654, $r4=var3349, $r3=var1412, $z0=var2195, $z2=var2431}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key;	r0 := @parameter0: java.lang.Object;	r1 = (org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key) r0;	$r4 = r2.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name>;	$r3 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.util.MethodWalker$Key: java.lang.String name>;	$z0 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>($r3);	if $z0 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 3