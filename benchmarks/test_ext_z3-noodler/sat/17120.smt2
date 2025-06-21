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

(declare-sort var711 0)
(declare-sort var112 0)
(declare-sort var2740 0)
(declare-sort var1183 0)
(declare-sort var3746 0)
(declare-sort var2073 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var112_getAttribute/-229173065 (var112 String) var2740)
(declare-fun cast-from-var2740-to-String (var2740) String)
(declare-fun var112_getRemoteAddress/1597111645 (var112) var1183)
(declare-fun var2073_getUrl/938756954 (var2073) var3746)
(declare-fun cast-from-var112-to-var2073 (var112) var2073)
(declare-fun getPort/20614931 (var3746) Int)
(declare-fun getPort/-1397617271 (var1183) Int)
(declare-fun var112_setAttribute/1308417157 (var112 String var2740) void)
(declare-fun cast-from-String-to-var2740 (String) var2740)
(declare-const null-var711 var711)
(declare-const null-var112 var112)
(declare-const var2011 var711) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var2011 null-var711)))
(declare-const var1593 var112) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1593 null-var112)))
(define-const var2489 var2740 (var112_getAttribute/-229173065 var1593 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var3810 String (cast-from-var2740-to-String var2489)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2185 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var3565 Bool (= var2185 var3810)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var3565 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3327 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var3500 Bool (= var3327 var3810)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (= (ite var3500 1 0) 0)) ; Cond: $z1 == 0 
(define-const var175 var1183 (var112_getRemoteAddress/1597111645 var1593)) ; Statement: r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(define-const var259 var3746 (var2073_getUrl/938756954 (cast-from-var112-to-var2073 var1593))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1542 Int (getPort/20614931 var259)) ; Statement: $i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var3150 Int (getPort/-1397617271 var175)) ; Statement: $i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>() 
 ; Statement: if $i1 != $i0 goto $z6 = 0 
(assert (not (= var1542 var3150))) ; Cond: $i1 != $i0 
(define-const var3044 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(define-const var2165 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var2752 Bool var3044) ; Statement: z2 = $z6 
 ; Statement: if $z5 == 0 goto $r13 = "server" 
(assert (= (ite var2165 1 0) 0)) ; Cond: $z5 == 0 
(define-const var3588 String "server") ; Statement: $r13 = "server" 
(assert true) ; Non Conditional
;(assert (var112_setAttribute/1308417157 var1593 "side" (cast-from-String-to-var2740 var3588))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13) 

(declare-const var1593!1 var112)
(declare-const var2611 String)
(declare-const var3588!1 String)
 ; Statement: return z2 
(check-sat)
; {var112_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var2740-to-String=([java.lang.Object], java.lang.String), var112_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), var2073_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var112-to-var2073=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/20614931=([org.apache.dubbo.common.URL], int), getPort/-1397617271=([java.net.InetSocketAddress], int), var112_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-String-to-var2740=([java.lang.String], java.lang.Object)}
; {var711=org.apache.dubbo.remoting.transport.AbstractCodec, var2011=r12, var112=org.apache.dubbo.remoting.Channel, var1593=r0, var2740=java.lang.Object, var2489=$r1, var3810=r2, var2185=$r3, var3565=$z0, var3327=$r4, var3500=$z1, var1183=java.net.InetSocketAddress, var175=r5, var3746=org.apache.dubbo.common.URL, var2073=org.apache.dubbo.remoting.Endpoint, var259=r6, var1542=$i1, var3150=$i0, var3044=$z6, var2165=$z5, var2752=z2, var3588=$r13, var2611="side"}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var711, r12=var2011, org.apache.dubbo.remoting.Channel=var112, r0=var1593, java.lang.Object=var2740, $r1=var2489, r2=var3810, $r3=var2185, $z0=var3565, $r4=var3327, $z1=var3500, java.net.InetSocketAddress=var1183, r5=var175, org.apache.dubbo.common.URL=var3746, org.apache.dubbo.remoting.Endpoint=var2073, r6=var259, $i1=var1542, $i0=var3150, $z6=var3044, $z5=var2165, z2=var2752, $r13=var3588, "side"=var2611}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>();	$i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>();	if $i1 != $i0 goto $z6 = 0;	$z6 = 0;	$z5 = 0;	z2 = $z6;	if $z5 == 0 goto $r13 = "server";	$r13 = "server";	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13);	return z2
;block_num 7