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

(declare-sort var1727 0)
(declare-sort var3285 0)
(declare-sort var2915 0)
(declare-sort var1613 0)
(declare-sort var1193 0)
(declare-sort var222 0)
(declare-sort var923 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3285_size/-959786421 (var3285) Int)
(declare-fun var3285_get/-1216255739 (var3285 Int) var1613)
(declare-fun cast-from-var1613-to-var1193 (var1613) var1193)
(declare-fun var1193_getLocalAddress/-2128128226 (var1193 var1727) var222)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1193_getProtocol/1810751446 (var1193) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun var923_toAddressString/-2067247090 (var222) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1727 var1727)
(declare-const var2915-ACCESSORS var3285)
(declare-const null-var222 var222)
(declare-const var3854 var1727) ; Statement: r1 := @parameter0: io.netty.channel.Channel 
(assert (not (= var3854 null-var1727)))
(define-const var206 Int 0) ; Statement: i1 = 0 
(define-const var2408 var3285 var2915-ACCESSORS) ; Statement: $r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var1586 Int (var3285_size/-959786421 var2408)) ; Statement: i0 = interfaceinvoke $r0.<java.util.List: int size()>() 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>() 
(assert (not (>= var206 var1586))) ; Negate: Cond: i1 >= i0  
(define-const var152 var3285 var2915-ACCESSORS) ; Statement: $r4 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS> 
(define-const var1573 var1613 (var3285_get/-1216255739 var152 var206)) ; Statement: $r5 = interfaceinvoke $r4.<java.util.List: java.lang.Object get(int)>(i1) 
(define-const var71 var1193 (cast-from-var1613-to-var1193 var1573)) ; Statement: r6 = (org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor) $r5 
(define-const var2622 var222 (var1193_getLocalAddress/-2128128226 var71 var3854)) ; Statement: r7 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.net.InetSocketAddress getLocalAddress(io.netty.channel.Channel)>(r1) 
 ; Statement: if r7 == null goto i1 = i1 + 1 
(assert (not (= var2622 null-var222))) ; Negate: Cond: r7 == null  
(define-const var1791 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1791)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1791!1 String)
(assert (= var1791!1 ""))
(define-const var1870 String (var1193_getProtocol/1810751446 var71)) ; Statement: $r9 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.lang.String getProtocol()>() 
(assert true)
(define-const var2994 String (append/672562846 var1791!1 var1870)) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1791!2 String)
(assert (= var1791!2 (str.++ var1791!1 var1870)))
(assert true)
(define-const var2759 String (append/-1166366385 var2994 32)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var2994!1 String)
(assert (str.prefixof var2994 var2994!1))
(define-const var1040 String (var923_toAddressString/-2067247090 var2622)) ; Statement: $r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r7) 
(assert true)
(define-const var1357 String (append/672562846 var2759 var1040)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var2759!1 String)
(assert (= var2759!1 (str.++ var2759 var1040)))
(assert true)
(define-const var3613 String (toString/-2075883882 var1357)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {var3285_size/-959786421=([java.util.List], int), var3285_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var1613-to-var1193=([java.lang.Object], org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor), var1193_getLocalAddress/-2128128226=([org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor, io.netty.channel.Channel], java.net.InetSocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1193_getProtocol/1810751446=([org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), var923_toAddressString/-2067247090=([java.net.InetSocketAddress], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1727=io.netty.channel.Channel, var3854=r1, var206=i1, var3285=java.util.List, var2915=org.apache.dubbo.remoting.transport.netty4.AddressUtils, var2408=$r0, var1586=i0, var152=$r4, var1613=java.lang.Object, var1573=$r5, var1193=org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor, var71=r6, var222=java.net.InetSocketAddress, var2622=r7, var1791=$r8, var1870=$r9, var2994=$r10, var2759=$r12, var923=org.apache.dubbo.common.utils.NetUtils, var1040=$r11, var1357=$r13, var3613=$r14}
; {io.netty.channel.Channel=var1727, r1=var3854, i1=var206, java.util.List=var3285, org.apache.dubbo.remoting.transport.netty4.AddressUtils=var2915, $r0=var2408, i0=var1586, $r4=var152, java.lang.Object=var1613, $r5=var1573, org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor=var1193, r6=var71, java.net.InetSocketAddress=var222, r7=var2622, $r8=var1791, $r9=var1870, $r10=var2994, $r12=var2759, org.apache.dubbo.common.utils.NetUtils=var923, $r11=var1040, $r13=var1357, $r14=var3613}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: io.netty.channel.Channel;	i1 = 0;	$r0 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	i0 = interfaceinvoke $r0.<java.util.List: int size()>();	if i1 >= i0 goto r15 = interfaceinvoke r1.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>();	$r4 = <org.apache.dubbo.remoting.transport.netty4.AddressUtils: java.util.List ACCESSORS>;	$r5 = interfaceinvoke $r4.<java.util.List: java.lang.Object get(int)>(i1);	r6 = (org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor) $r5;	r7 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.net.InetSocketAddress getLocalAddress(io.netty.channel.Channel)>(r1);	if r7 == null goto i1 = i1 + 1;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r9 = interfaceinvoke r6.<org.apache.dubbo.remoting.transport.netty4.ChannelAddressAccessor: java.lang.String getProtocol()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r11 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String toAddressString(java.net.InetSocketAddress)>(r7);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 4