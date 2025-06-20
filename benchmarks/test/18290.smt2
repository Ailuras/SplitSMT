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

(declare-sort var2192 0)
(declare-sort var1807 0)
(declare-sort var3600 0)
(declare-sort var1419 0)
(declare-sort var3667 0)
(declare-sort var1508 0)
(declare-sort var1416 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1807_size/-959786421 (var1807) Int)
(declare-fun var1807_get/-1216255739 (var1807 Int) var1419)
(declare-fun cast-from-var1419-to-var3667 (var1419) var3667)
(declare-fun var3667_getRemoteAddress/1078536045 (var3667 var2192) var1508)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var3667_getProtocol/1810751446 (var3667) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var1416_toAddressString/-2067247090 (var1508) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2192 var2192)
(declare-const var3600-ACCESSORS var1807)
(declare-const null-var1508 var1508)
(declare-const var1445 var2192) ; Statement: r1 := @parameter0: io.netty.channel.Channel 
(assert (not (= var1445 null-var2192)))
(define-const var2672 Int 0) ; Statement: i1 = 0 
(define-const var364 var1807 var3600-ACCESSORS) ; Statement: $r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var2833 Int (var1807_size/-959786421 var364)) ; Statement: i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(assert (not (>= var2672 var2833))) ; Negate: Cond: i1 >= i0  
(define-const var2697 var1807 var3600-ACCESSORS) ; Statement: $r4 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var1217 var1419 (var1807_get/-1216255739 var2697 var2672)) ; Statement: $r5 = interfaceinvoke $r4.<java.util.List: java.lang.Object get(int)>(i1) 
(define-const var2751 var3667 (cast-from-var1419-to-var3667 var1217)) ; Statement: r6 = (org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor) $r5 
(define-const var10 var1508 (var3667_getRemoteAddress/1078536045 var2751 var1445)) ; Statement: r7 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.net.InetSocketAddress getRemoteAddress(io.netty.channel.Channel)>(r1) 
 ; Statement: if r7 == null goto i1 = i1 + 1 
(assert (not (= var10 null-var1508))) ; Negate: Cond: r7 == null  
(define-const var2134 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2134)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2134!1 String)
(assert (= var2134!1 ""))
(define-const var2082 String (var3667_getProtocol/1810751446 var2751)) ; Statement: $r9 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.lang.String getProtocol()>() 
(assert true)
(define-const var1554 String (append/672562846 var2134!1 var2082)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2134!2 String)
(assert (= var2134!2 (str.++ var2134!1 var2082)))
(assert true)
(define-const var838 String (append/-1166366385 var1554 32)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var1554!1 String)
(assert (str.prefixof var1554 var1554!1))
(define-const var2551 String (var1416_toAddressString/-2067247090 var10)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r7) 
(assert true)
(define-const var2630 String (append/672562846 var838 var2551)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var838!1 String)
(assert (= var838!1 (str.++ var838 var2551)))
(assert true)
(define-const var3241 String (toString/-2075883882 var2630)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {var1807_size/-959786421=([java.util.List], int), var1807_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var1419-to-var3667=([java.lang.Object], org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor), var3667_getRemoteAddress/1078536045=([org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor, io.netty.channel.Channel], java.net.InetSocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var3667_getProtocol/1810751446=([org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var1416_toAddressString/-2067247090=([java.net.InetSocketAddress], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2192=io.netty.channel.Channel, var1445=r1, var2672=i1, var1807=java.util.List, var3600=org.apache.dubbo.remoting.transport.netty4.AddressUtils, var364=$r0, var2833=i0, var2697=$r4, var1419=java.lang.Object, var1217=$r5, var3667=org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor, var2751=r6, var1508=java.net.InetSocketAddress, var10=r7, var2134=$r8, var2082=$r9, var1554=$r10, var838=$r12, var1416=org.apache.dubbo.common.utils.NetUtils, var2551=$r11, var2630=$r13, var3241=$r14}
; {io.netty.channel.Channel=var2192, r1=var1445, i1=var2672, java.util.List=var1807, org.apache.dubbo.remoting.transport.netty4.AddressUtils=var3600, $r0=var364, i0=var2833, $r4=var2697, java.lang.Object=var1419, $r5=var1217, org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor=var3667, r6=var2751, java.net.InetSocketAddress=var1508, r7=var10, $r8=var2134, $r9=var2082, $r10=var1554, $r12=var838, org.apache.dubbo.common.utils.NetUtils=var1416, $r11=var2551, $r13=var2630, $r14=var3241}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: io.netty.channel.Channel;	i1 = 0;	$r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	i0 = interfaceinvoke $r0.<java.util.List: int size()>();	if i1 >= i0 goto $r2 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	$r4 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	$r5 = interfaceinvoke $r4.<java.util.List: java.lang.Object get(int)>(i1);	r6 = (org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor) $r5;	r7 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.net.InetSocketAddress getRemoteAddress(io.netty.channel.Channel)>(r1);	if r7 == null goto i1 = i1 + 1;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.lang.String getProtocol()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r7);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 4