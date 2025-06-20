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

(declare-sort var1345 0)
(declare-sort var3357 0)
(declare-sort var2251 0)
(declare-sort var2550 0)
(declare-sort var597 0)
(declare-sort var2257 0)
(declare-sort var391 0)
(declare-sort var3519 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3357_getAttribute/-229173065 (var3357 String) var2251)
(declare-fun cast-from-var2251-to-String (var2251) String)
(declare-fun var3357_getRemoteAddress/1597111645 (var3357) var2550)
(declare-fun var2257_getUrl/938756954 (var2257) var597)
(declare-fun cast-from-var3357-to-var2257 (var3357) var2257)
(declare-fun getPort/20614931 (var597) Int)
(declare-fun getPort/-1397617271 (var2550) Int)
(declare-fun getIp/-49850945 (var597) String)
(declare-fun var391_filterLocalHost/-157582254 (String) String)
(declare-fun getAddress/1707481140 (var2550) var3519)
(declare-fun getHostAddress/1493983505 (var3519) String)
(declare-fun var3357_setAttribute/1308417157 (var3357 String var2251) void)
(declare-fun cast-from-String-to-var2251 (String) var2251)
(declare-const null-var1345 var1345)
(declare-const null-var3357 var3357)
(declare-const var3380 var1345) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var3380 null-var1345)))
(declare-const var616 var3357) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var616 null-var3357)))
(define-const var1792 var2251 (var3357_getAttribute/-229173065 var616 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var2050 String (cast-from-var2251-to-String var1792)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var1319 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var3765 Bool (= var1319 var2050)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var3765 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2778 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var2683 Bool (= var2778 var2050)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (= (ite var2683 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2164 var2550 (var3357_getRemoteAddress/1597111645 var616)) ; Statement: r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(define-const var2634 var597 (var2257_getUrl/938756954 (cast-from-var3357-to-var2257 var616))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var417 Int (getPort/20614931 var2634)) ; Statement: $i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var2004 Int (getPort/-1397617271 var2164)) ; Statement: $i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>() 
 ; Statement: if $i1 != $i0 goto $z6 = 0 
(assert (not (not (= var417 var2004)))) ; Negate: Cond: $i1 != $i0  
(assert true)
(define-const var575 String (getIp/-49850945 var2634)) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>() 
(define-const var79 String (var391_filterLocalHost/-157582254 var575)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7) 
(assert true)
(define-const var339 var3519 (getAddress/1707481140 var2164)) ; Statement: $r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var3530 String (getHostAddress/1493983505 var339)) ; Statement: $r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var2729 String (var391_filterLocalHost/-157582254 var3530)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9) 
(assert true)
(define-const var483 Bool (= var79 var2729)) ; Statement: $z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10) 
 ; Statement: if $z3 == 0 goto $z6 = 0 
(assert (= (ite var483 1 0) 0)) ; Cond: $z3 == 0 
(define-const var3342 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(define-const var2719 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var2999 Bool var3342) ; Statement: z2 = $z6 
 ; Statement: if $z5 == 0 goto $r13 = "server" 
(assert (not (= (ite var2719 1 0) 0))) ; Negate: Cond: $z5 == 0  
(define-const var1536 String "client") ; Statement: $r13 = "client" 
 ; Statement: goto [?= interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13)] 
(assert true) ; Non Conditional
;(assert (var3357_setAttribute/1308417157 var616 "side" (cast-from-String-to-var2251 var1536))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13) 

(declare-const var616!1 var3357)
(declare-const var3588 String)
(declare-const var1536!1 String)
 ; Statement: return z2 
(check-sat)
; {var3357_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var2251-to-String=([java.lang.Object], java.lang.String), var3357_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), var2257_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3357-to-var2257=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/20614931=([org.apache.dubbo.common.URL], int), getPort/-1397617271=([java.net.InetSocketAddress], int), getIp/-49850945=([org.apache.dubbo.common.URL], java.lang.String), var391_filterLocalHost/-157582254=([java.lang.String], java.lang.String), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), var3357_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-String-to-var2251=([java.lang.String], java.lang.Object)}
; {var1345=org.apache.dubbo.remoting.transport.AbstractCodec, var3380=r12, var3357=org.apache.dubbo.remoting.Channel, var616=r0, var2251=java.lang.Object, var1792=$r1, var2050=r2, var1319=$r3, var3765=$z0, var2778=$r4, var2683=$z1, var2550=java.net.InetSocketAddress, var2164=r5, var597=org.apache.dubbo.common.URL, var2257=org.apache.dubbo.remoting.Endpoint, var2634=r6, var417=$i1, var2004=$i0, var575=$r7, var391=org.apache.dubbo.common.utils.NetUtils, var79=$r11, var3519=java.net.InetAddress, var339=$r8, var3530=$r9, var2729=$r10, var483=$z3, var3342=$z6, var2719=$z5, var2999=z2, var1536=$r13, var3588="side"}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var1345, r12=var3380, org.apache.dubbo.remoting.Channel=var3357, r0=var616, java.lang.Object=var2251, $r1=var1792, r2=var2050, $r3=var1319, $z0=var3765, $r4=var2778, $z1=var2683, java.net.InetSocketAddress=var2550, r5=var2164, org.apache.dubbo.common.URL=var597, org.apache.dubbo.remoting.Endpoint=var2257, r6=var2634, $i1=var417, $i0=var2004, $r7=var575, org.apache.dubbo.common.utils.NetUtils=var391, $r11=var79, java.net.InetAddress=var3519, $r8=var339, $r9=var3530, $r10=var2729, $z3=var483, $z6=var3342, $z5=var2719, z2=var2999, $r13=var1536, "side"=var3588}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 3}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>();	$i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>();	if $i1 != $i0 goto $z6 = 0;	$r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>();	$r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7);	$r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9);	$z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10);	if $z3 == 0 goto $z6 = 0;	$z6 = 0;	$z5 = 0;	z2 = $z6;	if $z5 == 0 goto $r13 = "server";	$r13 = "client";	goto [?= interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13)];	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13);	return z2
;block_num 8