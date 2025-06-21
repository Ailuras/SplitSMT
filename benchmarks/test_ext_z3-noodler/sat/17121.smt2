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

(declare-sort var3591 0)
(declare-sort var3778 0)
(declare-sort var3787 0)
(declare-sort var2541 0)
(declare-sort var3366 0)
(declare-sort var205 0)
(declare-sort var3603 0)
(declare-sort var3667 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3778_getAttribute/-229173065 (var3778 String) var3787)
(declare-fun cast-from-var3787-to-String (var3787) String)
(declare-fun var3778_getRemoteAddress/1597111645 (var3778) var2541)
(declare-fun var205_getUrl/938756954 (var205) var3366)
(declare-fun cast-from-var3778-to-var205 (var3778) var205)
(declare-fun getPort/20614931 (var3366) Int)
(declare-fun getPort/-1397617271 (var2541) Int)
(declare-fun getIp/-49850945 (var3366) String)
(declare-fun var3603_filterLocalHost/-157582254 (String) String)
(declare-fun getAddress/1707481140 (var2541) var3667)
(declare-fun getHostAddress/1493983505 (var3667) String)
(declare-fun var3778_setAttribute/1308417157 (var3778 String var3787) void)
(declare-fun cast-from-String-to-var3787 (String) var3787)
(declare-const null-var3591 var3591)
(declare-const null-var3778 var3778)
(declare-const var2391 var3591) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var2391 null-var3591)))
(declare-const var1861 var3778) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1861 null-var3778)))
(define-const var137 var3787 (var3778_getAttribute/-229173065 var1861 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var2253 String (cast-from-var3787-to-String var137)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2512 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var3627 Bool (= var2512 var2253)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var3627 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2896 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var3256 Bool (= var2896 var2253)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (= (ite var3256 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1957 var2541 (var3778_getRemoteAddress/1597111645 var1861)) ; Statement: r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(define-const var3129 var3366 (var205_getUrl/938756954 (cast-from-var3778-to-var205 var1861))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3312 Int (getPort/20614931 var3129)) ; Statement: $i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var2567 Int (getPort/-1397617271 var1957)) ; Statement: $i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>() 
 ; Statement: if $i1 != $i0 goto $z6 = 0 
(assert (not (not (= var3312 var2567)))) ; Negate: Cond: $i1 != $i0  
(assert true)
(define-const var1843 String (getIp/-49850945 var3129)) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>() 
(define-const var1446 String (var3603_filterLocalHost/-157582254 var1843)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7) 
(assert true)
(define-const var1663 var3667 (getAddress/1707481140 var1957)) ; Statement: $r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var393 String (getHostAddress/1493983505 var1663)) ; Statement: $r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var664 String (var3603_filterLocalHost/-157582254 var393)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9) 
(assert true)
(define-const var339 Bool (= var1446 var664)) ; Statement: $z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10) 
 ; Statement: if $z3 == 0 goto $z6 = 0 
(assert (not (= (ite var339 1 0) 0))) ; Negate: Cond: $z3 == 0  
(define-const var3746 Bool (ite (= 1 1) true false)) ; Statement: $z6 = 1 
(define-const var3477 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
 ; Statement: goto [?= z2 = $z6] 
(assert true) ; Non Conditional
(define-const var1542 Bool var3746) ; Statement: z2 = $z6 
 ; Statement: if $z5 == 0 goto $r13 = "server" 
(assert (not (= (ite var3477 1 0) 0))) ; Negate: Cond: $z5 == 0  
(define-const var2916 String "client") ; Statement: $r13 = "client" 
 ; Statement: goto [?= interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13)] 
(assert true) ; Non Conditional
;(assert (var3778_setAttribute/1308417157 var1861 "side" (cast-from-String-to-var3787 var2916))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13) 

(declare-const var1861!1 var3778)
(declare-const var3828 String)
(declare-const var2916!1 String)
 ; Statement: return z2 
(check-sat)
; {var3778_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var3787-to-String=([java.lang.Object], java.lang.String), var3778_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), var205_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var3778-to-var205=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/20614931=([org.apache.dubbo.common.URL], int), getPort/-1397617271=([java.net.InetSocketAddress], int), getIp/-49850945=([org.apache.dubbo.common.URL], java.lang.String), var3603_filterLocalHost/-157582254=([java.lang.String], java.lang.String), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), var3778_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-String-to-var3787=([java.lang.String], java.lang.Object)}
; {var3591=org.apache.dubbo.remoting.transport.AbstractCodec, var2391=r12, var3778=org.apache.dubbo.remoting.Channel, var1861=r0, var3787=java.lang.Object, var137=$r1, var2253=r2, var2512=$r3, var3627=$z0, var2896=$r4, var3256=$z1, var2541=java.net.InetSocketAddress, var1957=r5, var3366=org.apache.dubbo.common.URL, var205=org.apache.dubbo.remoting.Endpoint, var3129=r6, var3312=$i1, var2567=$i0, var1843=$r7, var3603=org.apache.dubbo.common.utils.NetUtils, var1446=$r11, var3667=java.net.InetAddress, var1663=$r8, var393=$r9, var664=$r10, var339=$z3, var3746=$z6, var3477=$z5, var1542=z2, var2916=$r13, var3828="side"}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var3591, r12=var2391, org.apache.dubbo.remoting.Channel=var3778, r0=var1861, java.lang.Object=var3787, $r1=var137, r2=var2253, $r3=var2512, $z0=var3627, $r4=var2896, $z1=var3256, java.net.InetSocketAddress=var2541, r5=var1957, org.apache.dubbo.common.URL=var3366, org.apache.dubbo.remoting.Endpoint=var205, r6=var3129, $i1=var3312, $i0=var2567, $r7=var1843, org.apache.dubbo.common.utils.NetUtils=var3603, $r11=var1446, java.net.InetAddress=var3667, $r8=var1663, $r9=var393, $r10=var664, $z3=var339, $z6=var3746, $z5=var3477, z2=var1542, $r13=var2916, "side"=var3828}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 3}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>();	$i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>();	if $i1 != $i0 goto $z6 = 0;	$r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>();	$r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7);	$r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9);	$z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10);	if $z3 == 0 goto $z6 = 0;	$z6 = 1;	$z5 = 1;	goto [?= z2 = $z6];	z2 = $z6;	if $z5 == 0 goto $r13 = "server";	$r13 = "client";	goto [?= interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13)];	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13);	return z2
;block_num 8