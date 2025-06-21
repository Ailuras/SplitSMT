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

(declare-sort var2364 0)
(declare-sort var3413 0)
(declare-sort var53 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3413_getAttribute/-229173065 (var3413 String) var53)
(declare-fun cast-from-var53-to-String (var53) String)
(declare-const null-var2364 var2364)
(declare-const null-var3413 var3413)
(declare-const var3951 var2364) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var3951 null-var2364)))
(declare-const var3083 var3413) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3083 null-var3413)))
(define-const var1615 var53 (var3413_getAttribute/-229173065 var3083 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var1704 String (cast-from-var53-to-String var1615)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2169 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var319 Bool (= var2169 var1704)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var319 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2768 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var3108 Bool (= var2768 var1704)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (not (= (ite var3108 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return 0 
(check-sat)
; {var3413_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var53-to-String=([java.lang.Object], java.lang.String)}
; {var2364=org.apache.dubbo.remoting.transport.AbstractCodec, var3951=r12, var3413=org.apache.dubbo.remoting.Channel, var3083=r0, var53=java.lang.Object, var1615=$r1, var1704=r2, var2169=$r3, var319=$z0, var2768=$r4, var3108=$z1}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var2364, r12=var3951, org.apache.dubbo.remoting.Channel=var3413, r0=var3083, java.lang.Object=var53, $r1=var1615, r2=var1704, $r3=var2169, $z0=var319, $r4=var2768, $z1=var3108}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	return 0
;block_num 3