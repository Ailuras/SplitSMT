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

(declare-sort var1825 0)
(declare-sort var72 0)
(declare-sort var3175 0)
(declare-sort var958 0)
(declare-sort var2196 0)
(declare-sort var1190 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var72_getAttribute/-229173065 (var72 String) var3175)
(declare-fun cast-from-var3175-to-String (var3175) String)
(declare-fun var72_getRemoteAddress/1597111645 (var72) var958)
(declare-fun var1190_getUrl/938756954 (var1190) var2196)
(declare-fun cast-from-var72-to-var1190 (var72) var1190)
(declare-fun getPort/20614931 (var2196) Int)
(declare-fun getPort/-1397617271 (var958) Int)
(declare-fun var72_setAttribute/1308417157 (var72 String var3175) void)
(declare-fun cast-from-String-to-var3175 (String) var3175)
(declare-const null-var1825 var1825)
(declare-const null-var72 var72)
(declare-const var3035 var1825) ; Statement: r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec 
(assert (not (= var3035 null-var1825)))
(declare-const var431 var72) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var431 null-var72)))
(define-const var3077 var3175 (var72_getAttribute/-229173065 var431 "side")) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side") 
(define-const var331 String (cast-from-var3175-to-String var3077)) ; Statement: r2 = (java.lang.String) $r1 
(define-const var2334 String "client") ; Statement: $r3 = "client" 
(assert true)
(define-const var353 Bool (= var2334 var331)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto $r4 = "server" 
(assert (= (ite var353 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3693 String "server") ; Statement: $r4 = "server" 
(assert true)
(define-const var3753 Bool (= var3693 var331)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert (= (ite var3753 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2645 var958 (var72_getRemoteAddress/1597111645 var431)) ; Statement: r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(define-const var1069 var2196 (var1190_getUrl/938756954 (cast-from-var72-to-var1190 var431))) ; Statement: r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1305 Int (getPort/20614931 var1069)) ; Statement: $i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var1568 Int (getPort/-1397617271 var2645)) ; Statement: $i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>() 
 ; Statement: if $i1 != $i0 goto $z6 = 0 
(assert (not (= var1305 var1568))) ; Cond: $i1 != $i0 
(define-const var3669 Bool (ite (= 1 0) true false)) ; Statement: $z6 = 0 
(define-const var3964 Bool (ite (= 1 0) true false)) ; Statement: $z5 = 0 
(assert true) ; Non Conditional
(define-const var1356 Bool var3669) ; Statement: z2 = $z6 
 ; Statement: if $z5 == 0 goto $r13 = "server" 
(assert (not (= (ite var3964 1 0) 0))) ; Negate: Cond: $z5 == 0  
(define-const var1724 String "client") ; Statement: $r13 = "client" 
 ; Statement: goto [?= interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13)] 
(assert true) ; Non Conditional
;(assert (var72_setAttribute/1308417157 var431 "side" (cast-from-String-to-var3175 var1724))) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13) 

(declare-const var431!1 var72)
(declare-const var3994 String)
(declare-const var1724!1 String)
 ; Statement: return z2 
(check-sat)
; {var72_getAttribute/-229173065=([org.apache.dubbo.remoting.Channel, java.lang.String], java.lang.Object), cast-from-var3175-to-String=([java.lang.Object], java.lang.String), var72_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), var1190_getUrl/938756954=([org.apache.dubbo.remoting.Endpoint], org.apache.dubbo.common.URL), cast-from-var72-to-var1190=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), getPort/20614931=([org.apache.dubbo.common.URL], int), getPort/-1397617271=([java.net.InetSocketAddress], int), var72_setAttribute/1308417157=([org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Object], void), cast-from-String-to-var3175=([java.lang.String], java.lang.Object)}
; {var1825=org.apache.dubbo.remoting.transport.AbstractCodec, var3035=r12, var72=org.apache.dubbo.remoting.Channel, var431=r0, var3175=java.lang.Object, var3077=$r1, var331=r2, var2334=$r3, var353=$z0, var3693=$r4, var3753=$z1, var958=java.net.InetSocketAddress, var2645=r5, var2196=org.apache.dubbo.common.URL, var1190=org.apache.dubbo.remoting.Endpoint, var1069=r6, var1305=$i1, var1568=$i0, var3669=$z6, var3964=$z5, var1356=z2, var1724=$r13, var3994="side"}
; {org.apache.dubbo.remoting.transport.AbstractCodec=var1825, r12=var3035, org.apache.dubbo.remoting.Channel=var72, r0=var431, java.lang.Object=var3175, $r1=var3077, r2=var331, $r3=var2334, $z0=var353, $r4=var3693, $z1=var3753, java.net.InetSocketAddress=var958, r5=var2645, org.apache.dubbo.common.URL=var2196, org.apache.dubbo.remoting.Endpoint=var1190, r6=var1069, $i1=var1305, $i0=var1568, $z6=var3669, $z5=var3964, z2=var1356, $r13=var1724, "side"=var3994}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r12 := @this: org.apache.dubbo.remoting.transport.AbstractCodec;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r1 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.lang.Object getAttribute(java.lang.String)>("side");	r2 = (java.lang.String) $r1;	$r3 = "client";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto $r4 = "server";	$r4 = "server";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z1 == 0 goto r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r5 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	r6 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: org.apache.dubbo.common.URL getUrl()>();	$i1 = virtualinvoke r6.<org.apache.dubbo.common.URL: int getPort()>();	$i0 = virtualinvoke r5.<java.net.InetSocketAddress: int getPort()>();	if $i1 != $i0 goto $z6 = 0;	$z6 = 0;	$z5 = 0;	z2 = $z6;	if $z5 == 0 goto $r13 = "server";	$r13 = "client";	goto [?= interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13)];	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void setAttribute(java.lang.String,java.lang.Object)>("side", $r13);	return z2
;block_num 7