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

(declare-sort var3422 0)
(declare-sort var1789 0)
(declare-sort var3807 0)
(declare-sort var1478 0)
(declare-sort var1606 0)
(declare-sort var323 0)
(declare-sort var621 0)
(declare-sort var2909 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1789_getAttribute/-229173065 (var1789 String) var3807)
(declare-fun cast-from-var3807-to-String (var3807) String)
(declare-fun var1789_getRemoteAddress/1597111645 (var1789) var1478)
(declare-fun var323_getUrl/938756954 (var323) var1606)
(declare-fun cast-from-var1789-to-var323 (var1789) var323)
(declare-fun getPort/20614931 (var1606) Int)
(declare-fun getPort/-1397617271 (var1478) Int)
(declare-fun getIp/-49850945 (var1606) String)
(declare-fun var621_filterLocalHost/-157582254 (String) String)
(declare-fun getAddress/1707481140 (var1478) var2909)
(declare-fun getHostAddress/1493983505 (var2909) String)
(declare-fun var1789_setAttribute/1308417157 (var1789 String var3807) void)
(declare-fun cast-from-String-to-var3807 (String) var3807)
(declare-const null-var3422 var3422)
(declare-const null-var1789 var1789)
(declare-const var1368 var3422) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var1368 null-var3422)))
(declare-const var3264 var1789) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3264 null-var1789)))
(define-const var2564 var3807 (var1789_getAttribute/-229173065 var3264 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var3745 String (cast-from-var3807-to-String var2564)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var1468 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var1700 Bool (= var1468 var3745)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var1700 1 0) 0)) ; Cond: $z0 == 0 
(define-const var290 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var1392 Bool (= var290 var3745)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (= (ite var1392 1 0) 0)) ; Cond: $z1 == 0 
(define-const var817 var1478 (var1789_getRemoteAddress/1597111645 var3264)) ; Statement: r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(define-const var1503 var1606 (var323_getUrl/938756954 (cast-from-var1789-to-var323 var3264))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2077 Int (getPort/20614931 var1503)) ; Statement: $i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var806 Int (getPort/-1397617271 var817)) ; Statement: $i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>() 
 ; Statement: if $i1 != $i0 goto $z6 = 0 
(assert (not (not (= var2077 var806)))) ; Negate: Cond: $i1 != $i0  
(assert true)
(define-const var1334 String (getIp/-49850945 var1503)) ; Statement: $r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>() 
(define-const var2521 String (var621_filterLocalHost/-157582254 var1334)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7) 
(assert true)
(define-const var3825 var2909 (getAddress/1707481140 var817)) ; Statement: $r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>() 
(assert true)
(define-const var3206 String (getHostAddress/1493983505 var3825)) ; Statement: $r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>() 
(define-const var1874 String (var621_filterLocalHost/-157582254 var3206)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9) 
(assert true)
(define-const var1819 Bool (= var2521 var1874)) ; Statement: $z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10) 
 ; Statement: if $z3 == 0 goto $z6 = 0 
(assert (not (= (ite var1819 1 0) 0))) ; Negate: Cond: $z3 == 0  
(define-const var1383 Bool (ite (= 1 1) true false)) ; Statement: $z6 = 1 
(define-const var2534 Bool (ite (= 1 1) true false)) ; Statement: $z5 = 1 
 ; Statement: goto [?= z2 = $z6] 
(assert true) ; Non Conditional
(define-const var1259 Bool var1383) ; Statement: z2 = $z6 
 ; Statement: if $z5 == 0 goto $r13 = "server" 
(assert (= (ite var2534 1 0) 0)) ; Cond: $z5 == 0 
(define-const var1600 String "server") ; Statement: $r13 = "server" 
(assert true) ; Non Conditional
;(assert (var1789_setAttribute/1308417157 var3264 "side" (cast-from-String-to-var3807 var1600))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13) 

(declare-const var3264!1 var1789)
(declare-const var692 String)
(declare-const var1600!1 String)
 ; Statement: return z2 
(check-sat)
; {var1789_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var3807-to-String=([java.lang.Object], java.lang.String), var1789_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), var323_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var1789-to-var323=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/20614931=([org.apache.dubbo.common.URL], int), getPort/-1397617271=([java.net.InetSocketAddress], int), getIp/-49850945=([org.apache.dubbo.common.URL], java.lang.String), var621_filterLocalHost/-157582254=([java.lang.String], java.lang.String), getAddress/1707481140=([java.net.InetSocketAddress], java.net.InetAddress), getHostAddress/1493983505=([java.net.InetAddress], java.lang.String), var1789_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-String-to-var3807=([java.lang.String], java.lang.Object)}
; {var3422=org.apache.dubbo.remoting.transport.AbstractCodec, var1368=r12, var1789=org.apache.dubbo.remoting.Channel, var3264=r0, var3807=java.lang.Object, var2564=$r1, var3745=r2, var1468=$r3, var1700=$z0, var290=$r4, var1392=$z1, var1478=java.net.InetSocketAddress, var817=r5, var1606=org.apache.dubbo.common.URL, var323=org.apache.dubbo.remoting.Endpoint, var1503=r6, var2077=$i1, var806=$i0, var1334=$r7, var621=org.apache.dubbo.common.utils.NetUtils, var2521=$r11, var2909=java.net.InetAddress, var3825=$r8, var3206=$r9, var1874=$r10, var1819=$z3, var1383=$z6, var2534=$z5, var1259=z2, var1600=$r13, var692="side"}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var3422, r12=var1368, org.apache.dubbo.remoting.Channel=var1789, r0=var3264, java.lang.Object=var3807, $r1=var2564, r2=var3745, $r3=var1468, $z0=var1700, $r4=var290, $z1=var1392, java.net.InetSocketAddress=var1478, r5=var817, org.apache.dubbo.common.URL=var1606, org.apache.dubbo.remoting.Endpoint=var323, r6=var1503, $i1=var2077, $i0=var806, $r7=var1334, org.apache.dubbo.common.utils.NetUtils=var621, $r11=var2521, java.net.InetAddress=var2909, $r8=var3825, $r9=var3206, $r10=var1874, $z3=var1819, $z6=var1383, $z5=var2534, z2=var1259, $r13=var1600, "side"=var692}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 3}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>();	$i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>();	if $i1 != $i0 goto $z6 = 0;	$r7 = virtualinvoke r6.<org.apache.dubbo.common.URL: java.lang.String getIp()>();	$r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r7);	$r8 = virtualinvoke r5.<java.net.InetSocketAddress: java.net.InetAddress getAddress()>();	$r9 = virtualinvoke $r8.<java.net.InetAddress: java.lang.String getHostAddress()>();	$r10 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String filterLocalHost(java.lang.String)>($r9);	$z3 = virtualinvoke $r11.<java.lang.String: boolean equals(java.lang.Object)>($r10);	if $z3 == 0 goto $z6 = 0;	$z6 = 1;	$z5 = 1;	goto [?= z2 = $z6];	z2 = $z6;	if $z5 == 0 goto $r13 = "server";	$r13 = "server";	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13);	return z2
;block_num 8