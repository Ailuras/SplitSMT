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

(declare-sort var3585 0)
(declare-sort var2235 0)
(declare-sort var309 0)
(declare-sort var1674 0)
(declare-sort var87 0)
(declare-sort var1963 0)
(declare-sort var1546 0)
(declare-sort var1571 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun send/1058595385 (var309 var2235 Bool) void)
(declare-fun cast-from-var3585-to-var309 (var3585) var309)
(declare-fun var87-init () var87)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1963_getRequestWithoutData/174916864 (var2235) var2235)
(declare-fun append/-1031950772 (String var2235) String)
(declare-fun getRemoteAddress/-620541842 (var3585) var1546)
(declare-fun cast-from-var1546-to-var2235 (var1546) var2235)
(declare-fun getMessage/849299655 (var1674) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-294216989 (var87 var1571 String var1674) void)
(declare-fun cast-from-var3585-to-var1571 (var3585) var1571)
(declare-const null-var3585 var3585)
(declare-const null-var2235 var2235)
(declare-const null-Bool Bool)
(declare-const null-var1674 var1674)
(declare-const var3495 var3585) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty.NettyChannel 
(assert (not (= var3495 null-var3585)))
(declare-const var2276 var2235) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var2276 null-var2235)))
(declare-const var56 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var56 null-Bool)))
(assert true)
;(assert (send/1058595385 (cast-from-var3585-to-var309 var3495) var2276 var56)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractChannel: void send(java.lang.Object,boolean)>(r1, z0) 

(declare-const var3495!1 var3585)
(declare-const var2276!1 var2235)
(declare-const var56!1 Bool)
(define-const var2269 Bool (ite (= 1 1) true false)) ; Statement: z1 = 1 
(define-const var3234 Int 0) ; Statement: i1 = 0 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3341 var1674) ; Statement: $r17 := @caughtexception 
(assert (not (= var3341 null-var1674)))
(define-const var547 var87 var87-init) ; Statement: $r18 = new org.apache.dubbo.remoting.RemotingException 
(define-const var3262 String String-init) ; Statement: $r19 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3262)) ; Statement: specialinvoke $r19.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3262!1 String)
(assert (= var3262!1 ""))
(assert true)
(define-const var2031 String (append/672562846 var3262!1 "Failed to send message ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ") 
(declare-const var3262!2 String)
(assert (= var3262!2 (str.++ var3262!1 "Failed to send message ")))
(define-const var2445 var2235 (var1963_getRequestWithoutData/174916864 var2276!1)) ; Statement: $r20 = staticinvoke <org.apache.dubbo.remoting.utils.PayloadDropper: java.lang.Object getRequestWithoutData(java.lang.Object)>(r1) 
(assert true)
(define-const var2003 String (append/-1031950772 var2031 var2445)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var2031!1 String)
(assert (str.prefixof var2031 var2031!1))
(assert true)
(define-const var136 String (append/672562846 var2003 " to ")) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to ") 
(declare-const var2003!1 String)
(assert (= var2003!1 (str.++ var2003 " to ")))
(assert true)
(define-const var3488 var1546 (getRemoteAddress/-620541842 var3495!1)) ; Statement: $r23 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty.NettyChannel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var3440 String (append/-1031950772 var136 (cast-from-var1546-to-var2235 var3488))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var136!1 String)
(assert (str.prefixof var136 var136!1))
(assert true)
(define-const var1775 String (append/672562846 var3440 ", cause: ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3440!1 String)
(assert (= var3440!1 (str.++ var3440 ", cause: ")))
(assert true)
(define-const var2281 String (getMessage/849299655 var3341)) ; Statement: $r26 = virtualinvoke $r17.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3292 String (append/672562846 var1775 var2281)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26) 
(declare-const var1775!1 String)
(assert (= var1775!1 (str.++ var1775 var2281)))
(assert true)
(define-const var1118 String (toString/-2075883882 var3292)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-294216989 var547 (cast-from-var3585-to-var1571 var3495!1) var1118 var3341)) ; Statement: specialinvoke $r18.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r0, $r29, $r17) 

(declare-const var547!1 var87)
(declare-const var3495!2 var3585)
(declare-const var1118!1 String)
(declare-const var3341!1 var1674)
 ; Statement: throw $r18 
(check-sat)
; {send/1058595385=([org.apache.dubbo.remoting.transport.AbstractChannel, java.lang.Object, boolean], void), cast-from-var3585-to-var309=([org.apache.dubbo.remoting.transport.netty.NettyChannel], org.apache.dubbo.remoting.transport.AbstractChannel), var87-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1963_getRequestWithoutData/174916864=([java.lang.Object], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), getRemoteAddress/-620541842=([org.apache.dubbo.remoting.transport.netty.NettyChannel], java.net.InetSocketAddress), cast-from-var1546-to-var2235=([java.net.InetSocketAddress], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-294216989=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void), cast-from-var3585-to-var1571=([org.apache.dubbo.remoting.transport.netty.NettyChannel], org.apache.dubbo.remoting.Channel)}
; {var3585=org.apache.dubbo.remoting.transport.netty.NettyChannel, var3495=r0, var2235=java.lang.Object, var2276=r1, var56=z0, var309=org.apache.dubbo.remoting.transport.AbstractChannel, var2269=z1, var3234=i1, var1674=java.lang.Throwable, var3341=$r17, var87=org.apache.dubbo.remoting.RemotingException, var547=$r18, var3262=$r19, var2031=$r21, var1963=org.apache.dubbo.remoting.utils.PayloadDropper, var2445=$r20, var2003=$r22, var136=$r24, var1546=java.net.InetSocketAddress, var3488=$r23, var3440=$r25, var1775=$r27, var2281=$r26, var3292=$r28, var1118=$r29, var1571=org.apache.dubbo.remoting.Channel}
; {org.apache.dubbo.remoting.transport.netty.NettyChannel=var3585, r0=var3495, java.lang.Object=var2235, r1=var2276, z0=var56, org.apache.dubbo.remoting.transport.AbstractChannel=var309, z1=var2269, i1=var3234, java.lang.Throwable=var1674, $r17=var3341, org.apache.dubbo.remoting.RemotingException=var87, $r18=var547, $r19=var3262, $r21=var2031, org.apache.dubbo.remoting.utils.PayloadDropper=var1963, $r20=var2445, $r22=var2003, $r24=var136, java.net.InetSocketAddress=var1546, $r23=var3488, $r25=var3440, $r27=var1775, $r26=var2281, $r28=var3292, $r29=var1118, org.apache.dubbo.remoting.Channel=var1571}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty.NettyChannel;	r1 := @parameter0: java.lang.Object;	z0 := @parameter1: boolean;	specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractChannel: void send(java.lang.Object,boolean)>(r1, z0);	z1 = 1;	i1 = 0;	$r17 := @caughtexception;	$r18 = new org.apache.dubbo.remoting.RemotingException;	$r19 = new java.lang.StringBuilder;	specialinvoke $r19.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ");	$r20 = staticinvoke <org.apache.dubbo.remoting.utils.PayloadDropper: java.lang.Object getRequestWithoutData(java.lang.Object)>(r1);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to ");	$r23 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty.NettyChannel: java.net.InetSocketAddress getRemoteAddress()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r26 = virtualinvoke $r17.<java.lang.Throwable: java.lang.String getMessage()>();	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r26);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r18.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r0, $r29, $r17);	throw $r18
;block_num 2