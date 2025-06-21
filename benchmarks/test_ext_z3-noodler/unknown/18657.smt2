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

(declare-sort var2027 0)
(declare-sort var3705 0)
(declare-sort var3293 0)
(declare-sort var425 0)
(declare-sort var227 0)
(declare-sort var1369 0)
(declare-sort var3667 0)
(declare-sort var1223 0)
(declare-sort var3490 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun send/1058595385 (var3293 var3705 Bool) void)
(declare-fun cast-from-var2027-to-var3293 (var2027) var3293)
(declare-fun channel/-724753453 (var2027) var227)
(declare-fun var2027_removeChannelIfDisconnected/-1652265511 (var227) void)
(declare-fun var1369-init () var1369)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3667_getRequestWithoutData/174916864 (var3705) var3705)
(declare-fun append/-1031950772 (String var3705) String)
(declare-fun getRemoteAddress/-353809998 (var2027) var1223)
(declare-fun cast-from-var1223-to-var3705 (var1223) var3705)
(declare-fun getMessage/849299655 (var425) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-294216989 (var1369 var3490 String var425) void)
(declare-fun cast-from-var2027-to-var3490 (var2027) var3490)
(declare-const null-var2027 var2027)
(declare-const null-var3705 var3705)
(declare-const null-Bool Bool)
(declare-const null-var425 var425)
(declare-const var1604 var2027) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyChannel 
(assert (not (= var1604 null-var2027)))
(declare-const var1807 var3705) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var1807 null-var3705)))
(declare-const var1674 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var1674 null-Bool)))
(assert true)
;(assert (send/1058595385 (cast-from-var2027-to-var3293 var1604) var1807 var1674)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractChannel: void send(java.lang.Object,boolean)>(r1, z0) 

(declare-const var1604!1 var2027)
(declare-const var1807!1 var3705)
(declare-const var1674!1 Bool)
(define-const var2145 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var1817 Int 0) ; Statement: i1 = 0 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1972 var425) ; Statement: $r24 := @caughtexception 
(assert (not (= var1972 null-var425)))
(define-const var229 var227 (channel/-724753453 var1604!1)) ; Statement: $r25 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: io.netty.channel.Channel channel> 
;(assert (var2027_removeChannelIfDisconnected/-1652265511 var229)) ; Statement: staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyChannel: void removeChannelIfDisconnected(io.netty.channel.Channel)>($r25) 

(declare-const var229!1 var227)
(define-const var1242 var1369 var1369-init) ; Statement: $r43 = new org.apache.dubbo.remoting.RemotingException 
(define-const var532 String String-init) ; Statement: $r42 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var532)) ; Statement: specialinvoke $r42.<java.lang.StringBuilder: void <init>()>() 
(declare-const var532!1 String)
(assert (= var532!1 ""))
(assert true)
(define-const var273 String (append/672562846 var532!1 "Failed to send message ")) ; Statement: $r29 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ") 
(declare-const var532!2 String)
(assert (= var532!2 (str.++ var532!1 "Failed to send message ")))
(define-const var1762 var3705 (var3667_getRequestWithoutData/174916864 var1807!1)) ; Statement: $r28 = staticinvoke <org.apache.dubbo.remoting.utils.PayloadDropper: java.lang.Object getRequestWithoutData(java.lang.Object)>(r1) 
(assert true)
(define-const var1815 String (append/-1031950772 var273 var1762)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r28) 
(declare-const var273!1 String)
(assert (str.prefixof var273 var273!1))
(assert true)
(define-const var3546 String (append/672562846 var1815 " to ")) ; Statement: $r32 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to ") 
(declare-const var1815!1 String)
(assert (= var1815!1 (str.++ var1815 " to ")))
(assert true)
(define-const var3375 var1223 (getRemoteAddress/-353809998 var1604!1)) ; Statement: $r31 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var3868 String (append/-1031950772 var3546 (cast-from-var1223-to-var3705 var3375))) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r31) 
(declare-const var3546!1 String)
(assert (str.prefixof var3546 var3546!1))
(assert true)
(define-const var541 String (append/672562846 var3868 ", cause: ")) ; Statement: $r35 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3868!1 String)
(assert (= var3868!1 (str.++ var3868 ", cause: ")))
(assert true)
(define-const var715 String (getMessage/849299655 var1972)) ; Statement: $r34 = virtualinvoke $r24.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1065 String (append/672562846 var541 var715)) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r34) 
(declare-const var541!1 String)
(assert (= var541!1 (str.++ var541 var715)))
(assert true)
(define-const var1462 String (toString/-2075883882 var1065)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-294216989 var1242 (cast-from-var2027-to-var3490 var1604!1) var1462 var1972)) ; Statement: specialinvoke $r43.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r0, $r37, $r24) 

(declare-const var1242!1 var1369)
(declare-const var1604!2 var2027)
(declare-const var1462!1 String)
(declare-const var1972!1 var425)
 ; Statement: throw $r43 
(check-sat)
; {send/1058595385=([org.apache.dubbo.remoting.transport.AbstractChannel, java.lang.Object, boolean], void), cast-from-var2027-to-var3293=([org.apache.dubbo.remoting.transport.netty4.NettyChannel], org.apache.dubbo.remoting.transport.AbstractChannel), channel/-724753453=([org.apache.dubbo.remoting.transport.netty4.NettyChannel], io.netty.channel.Channel), var2027_removeChannelIfDisconnected/-1652265511=([io.netty.channel.Channel], void), var1369-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3667_getRequestWithoutData/174916864=([java.lang.Object], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), getRemoteAddress/-353809998=([org.apache.dubbo.remoting.transport.netty4.NettyChannel], java.net.InetSocketAddress), cast-from-var1223-to-var3705=([java.net.InetSocketAddress], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-294216989=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-var2027-to-var3490=([org.apache.dubbo.remoting.transport.netty4.NettyChannel], org.apache.dubbo.remoting.Channel)}
; {var2027=org.apache.dubbo.remoting.transport.netty4.NettyChannel, var1604=r0, var3705=java.lang.Object, var1807=r1, var1674=z0, var3293=org.apache.dubbo.remoting.transport.AbstractChannel, var2145=z2, var1817=i1, var425=java.lang.Throwable, var1972=$r24, var227=io.netty.channel.Channel, var229=$r25, var1369=org.apache.dubbo.remoting.RemotingException, var1242=$r43, var532=$r42, var273=$r29, var3667=org.apache.dubbo.remoting.utils.PayloadDropper, var1762=$r28, var1815=$r30, var3546=$r32, var1223=java.net.InetSocketAddress, var3375=$r31, var3868=$r33, var541=$r35, var715=$r34, var1065=$r36, var1462=$r37, var3490=org.apache.dubbo.remoting.Channel}
; {org.apache.dubbo.remoting.transport.netty4.NettyChannel=var2027, r0=var1604, java.lang.Object=var3705, r1=var1807, z0=var1674, org.apache.dubbo.remoting.transport.AbstractChannel=var3293, z2=var2145, i1=var1817, java.lang.Throwable=var425, $r24=var1972, io.netty.channel.Channel=var227, $r25=var229, org.apache.dubbo.remoting.RemotingException=var1369, $r43=var1242, $r42=var532, $r29=var273, org.apache.dubbo.remoting.utils.PayloadDropper=var3667, $r28=var1762, $r30=var1815, $r32=var3546, java.net.InetSocketAddress=var1223, $r31=var3375, $r33=var3868, $r35=var541, $r34=var715, $r36=var1065, $r37=var1462, org.apache.dubbo.remoting.Channel=var3490}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty4.NettyChannel;	r1 := @parameter0: java.lang.Object;	z0 := @parameter1: boolean;	specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractChannel: void send(java.lang.Object,boolean)>(r1, z0);	z2 = 1;	i1 = 0;	$r24 := @caughtexception;	$r25 = r0.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: io.netty.channel.Channel channel>;	staticinvoke <org.apache.dubbo.remoting.transport.netty4.NettyChannel: void removeChannelIfDisconnected(io.netty.channel.Channel)>($r25);	$r43 = new org.apache.dubbo.remoting.RemotingException;	$r42 = new java.lang.StringBuilder;	specialinvoke $r42.<java.lang.StringBuilder: void <init>()>();	$r29 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ");	$r28 = staticinvoke <org.apache.dubbo.remoting.utils.PayloadDropper: java.lang.Object getRequestWithoutData(java.lang.Object)>(r1);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r28);	$r32 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to ");	$r31 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: java.net.InetSocketAddress getRemoteAddress()>();	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r31);	$r35 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r34 = virtualinvoke $r24.<java.lang.Throwable: java.lang.String getMessage()>();	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r34);	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r43.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r0, $r37, $r24);	throw $r43
;block_num 2