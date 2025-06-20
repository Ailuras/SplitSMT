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

(declare-sort var2227 0)
(declare-sort var3953 0)
(declare-sort var2844 0)
(declare-sort var1106 0)
(declare-sort var3925 0)
(declare-sort var912 0)
(declare-sort var1121 0)
(declare-sort var2501 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3953_getAttribute/-229173065 (var3953 String) var2844)
(declare-fun cast-from-var2844-to-String (var2844) String)
(declare-fun var3953_getRemoteAddress/1597111645 (var3953) var1106)
(declare-fun var912_getUrl/938756954 (var912) var3925)
(declare-fun cast-from-var3953-to-var912 (var3953) var912)
(declare-fun getPort/20614931 (var3925) Int)
(declare-fun getPort/-1397617271 (var1106) Int)
(declare-fun getIp/-49850945 (var3925) String)
(declare-fun var1121_filterLocalHost/-157582254 (String) String)
(declare-fun getAddress/1707481140 (var1106) var2501)
(declare-fun getHostAddress/1493983505 (var2501) String)
(declare-fun var3953_setAttribute/1308417157 (var3953 String var2844) void)
(declare-fun cast-from-String-to-var2844 (String) var2844)
(declare-const null-var2227 var2227)
(declare-const null-var3953 var3953)
(declare-const var844 var2227) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var844 null-var2227)))
(declare-const var343 var3953) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var343 null-var3953)))
(define-const var435 var2844 (var3953_getAttribute/-229173065 var343 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var2111 String (cast-from-var2844-to-String var435)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var376 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var2733 Bool (= var376 var2111)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var2733 1 0) 0)) ; Cond: $z0 == 0 
(define-const var871 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var1387 Bool (= var871 var2111)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (= (ite var1387 1 0) 0)) ; Cond: $z1 == 0 
(define-const var935 var1106 (var3953_getRemoteAddress/1597111645 var343)) ; Statement: r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(define-const var857 var3925 (var912_getUrl/938756954 (cast-from-var3953-to-var912 var343))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var427 Int (getPort/20614931 var857)) ; Statement: $i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var2098 Int (getPort/-1397617271 var935)) ; Statement: $i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>() 
 ; Statement: if $i1 != $i0 goto $z6 = 0 
(assert (not (not (= var427 var2098)))) ; Negate: Cond: $i1 != $i0  
(assert true)
(define-const var2852 String (getIp/-49850945 var857)) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>() 
(define-const var967 String (var1121_filterLocalHost/-157582254 var2852)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7) 
(assert true)
(define-const var3280 var2501 (getAddress/1707481140 var935)) ; Statement: $r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var489 String (getHostAddress/1493983505 var3280)) ; Statement: $r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var2394 String (var1121_filterLocalHost/-157582254 var489)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9) 
(assert true)
(define-const var420 Bool (= var967 var2394)) ; Statement: $z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10) 
 ; Statement: if $z3 == 0 goto $z6 = 0 
(assert (= (ite var420 1 0) 0)) ; Cond: $z3 == 0 
(define-const var189 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(define-const var2833 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var2608 Bool var189) ; Statement: z2 = $z6 
 ; Statement: if $z5 == 0 goto $r13 = "server" 
(assert (= (ite var2833 1 0) 0)) ; Cond: $z5 == 0 
(define-const var899 String "server") ; Statement: $r13 = "server" 
(assert true) ; Non Conditional
;(assert (var3953_setAttribute/1308417157 var343 "side" (cast-from-String-to-var2844 var899))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13) 

(declare-const var343!1 var3953)
(declare-const var1845 String)
(declare-const var899!1 String)
 ; Statement: return z2 
(check-sat)
; {var3953_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var2844-to-String=([java.lang.Object], java.lang.String), var3953_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), var912_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3953-to-var912=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/20614931=([org.apache.dubbo.common.URL], int), getPort/-1397617271=([java.net.InetSocketAddress], int), getIp/-49850945=([org.apache.dubbo.common.URL], java.lang.String), var1121_filterLocalHost/-157582254=([java.lang.String], java.lang.String), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), var3953_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-String-to-var2844=([java.lang.String], java.lang.Object)}
; {var2227=org.apache.dubbo.remoting.transport.AbstractCodec, var844=r12, var3953=org.apache.dubbo.remoting.Channel, var343=r0, var2844=java.lang.Object, var435=$r1, var2111=r2, var376=$r3, var2733=$z0, var871=$r4, var1387=$z1, var1106=java.net.InetSocketAddress, var935=r5, var3925=org.apache.dubbo.common.URL, var912=org.apache.dubbo.remoting.Endpoint, var857=r6, var427=$i1, var2098=$i0, var2852=$r7, var1121=org.apache.dubbo.common.utils.NetUtils, var967=$r11, var2501=java.net.InetAddress, var3280=$r8, var489=$r9, var2394=$r10, var420=$z3, var189=$z6, var2833=$z5, var2608=z2, var899=$r13, var1845="side"}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var2227, r12=var844, org.apache.dubbo.remoting.Channel=var3953, r0=var343, java.lang.Object=var2844, $r1=var435, r2=var2111, $r3=var376, $z0=var2733, $r4=var871, $z1=var1387, java.net.InetSocketAddress=var1106, r5=var935, org.apache.dubbo.common.URL=var3925, org.apache.dubbo.remoting.Endpoint=var912, r6=var857, $i1=var427, $i0=var2098, $r7=var2852, org.apache.dubbo.common.utils.NetUtils=var1121, $r11=var967, java.net.InetAddress=var2501, $r8=var3280, $r9=var489, $r10=var2394, $z3=var420, $z6=var189, $z5=var2833, z2=var2608, $r13=var899, "side"=var1845}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 3}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>();	$i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>();	if $i1 != $i0 goto $z6 = 0;	$r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>();	$r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7);	$r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9);	$z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10);	if $z3 == 0 goto $z6 = 0;	$z6 = 0;	$z5 = 0;	z2 = $z6;	if $z5 == 0 goto $r13 = "server";	$r13 = "server";	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13);	return z2
;block_num 8