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

(declare-sort var435 0)
(declare-sort var786 0)
(declare-sort var167 0)
(declare-sort var1063 0)
(declare-sort var2396 0)
(declare-sort var1423 0)
(declare-sort var724 0)
(declare-sort var2556 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2396-init () var2396)
(declare-fun var786_localAddress/1290099742 (var786) var1423)
(declare-fun cast-from-var1423-to-var724 (var1423) var724)
(declare-fun var786_remoteAddress/-1514271323 (var786) var1423)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2556_getRequestWithoutData/174916864 (var167) var167)
(declare-fun append/-1031950772 (String var167) String)
(declare-fun toString/-522406933 (var167) String)
(declare-fun cast-from-var1423-to-var167 (var1423) var167)
(declare-fun getMessage/849299655 (var1063) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1118340853 (var2396 var724 var724 String var1063) void)
(declare-const null-var435 var435)
(declare-const null-var786 var786)
(declare-const null-var167 var167)
(declare-const null-var1063 var1063)
(declare-const var1584 var435) ; Statement: r38 := @this: org.apache.dubbo.qos.command.impl.CountTelnet 
(assert (not (= var1584 null-var435)))
(declare-const var1601 var786) ; Statement: r0 := @parameter0: io.netty.channel.Channel 
(assert (not (= var1601 null-var786)))
(declare-const var665 var167) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var665 null-var167)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2888 var1063) ; Statement: $r20 := @caughtexception 
(assert (not (= var2888 null-var1063)))
(define-const var3366 var2396 var2396-init) ; Statement: $r21 = new org.apache.dubbo.remoting.RemotingException 
(define-const var3083 var1423 (var786_localAddress/1290099742 var1601)) ; Statement: $r22 = interfaceinvoke r0.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>() 
(define-const var1911 var724 (cast-from-var1423-to-var724 var3083)) ; Statement: $r37 = (java.net.InetSocketAddress) $r22 
(define-const var2723 var1423 (var786_remoteAddress/-1514271323 var1601)) ; Statement: $r23 = interfaceinvoke r0.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(define-const var961 var724 (cast-from-var1423-to-var724 var2723)) ; Statement: $r36 = (java.net.InetSocketAddress) $r23 
(define-const var2918 String String-init) ; Statement: $r24 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2918)) ; Statement: specialinvoke $r24.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2918!1 String)
(assert (= var2918!1 ""))
(assert true)
(define-const var2539 String (append/672562846 var2918!1 "Failed to send message ")) ; Statement: $r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ") 
(declare-const var2918!2 String)
(assert (= var2918!2 (str.++ var2918!1 "Failed to send message ")))
(define-const var77 var167 (var2556_getRequestWithoutData/174916864 var665)) ; Statement: $r25 = staticinvoke <org.apache.dubbo.remoting.utils.PayloadDropper: java.lang.Object getRequestWithoutData(java.lang.Object)>(r1) 
(assert true)
(define-const var2382 String (append/-1031950772 var2539 var77)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var2539!1 String)
(assert (str.prefixof var2539 var2539!1))
(assert true)
(define-const var3369 String (append/672562846 var2382 " to ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to ") 
(declare-const var2382!1 String)
(assert (= var2382!1 (str.++ var2382 " to ")))
(define-const var214 var1423 (var786_remoteAddress/-1514271323 var1601)) ; Statement: $r28 = interfaceinvoke r0.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>() 
(assert true)
(define-const var848 String (toString/-522406933 (cast-from-var1423-to-var167 var214))) ; Statement: $r29 = virtualinvoke $r28.<java.lang.Object: java.lang.String toString()>() 
(assert true)
(define-const var1241 String (append/672562846 var3369 var848)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r29) 
(declare-const var3369!1 String)
(assert (= var3369!1 (str.++ var3369 var848)))
(assert true)
(define-const var1312 String (append/672562846 var1241 ", cause: ")) ; Statement: $r33 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1241!1 String)
(assert (= var1241!1 (str.++ var1241 ", cause: ")))
(assert true)
(define-const var2089 String (getMessage/849299655 var2888)) ; Statement: $r32 = virtualinvoke $r20.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var2251 String (append/672562846 var1312 var2089)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r32) 
(declare-const var1312!1 String)
(assert (= var1312!1 (str.++ var1312 var2089)))
(assert true)
(define-const var2686 String (toString/-2075883882 var2251)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1118340853 var3366 var1911 var961 var2686 var2888)) ; Statement: specialinvoke $r21.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String,java.lang.Throwable)>($r37, $r36, $r35, $r20) 

(declare-const var3366!1 var2396)
(declare-const var1911!1 var724)
(declare-const var961!1 var724)
(declare-const var2686!1 String)
(declare-const var2888!1 var1063)
 ; Statement: throw $r21 
(check-sat)
; {var2396-init=([], org.apache.dubbo.remoting.RemotingException), var786_localAddress/1290099742=([io.netty.channel.Channel], java.net.SocketAddress), cast-from-var1423-to-var724=([java.net.SocketAddress], java.net.InetSocketAddress), var786_remoteAddress/-1514271323=([io.netty.channel.Channel], java.net.SocketAddress), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2556_getRequestWithoutData/174916864=([java.lang.Object], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-522406933=([java.lang.Object], java.lang.String), cast-from-var1423-to-var167=([java.net.SocketAddress], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1118340853=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String, java.lang.Throwable], void)}
; {var435=org.apache.dubbo.qos.command.impl.CountTelnet, var1584=r38, var786=io.netty.channel.Channel, var1601=r0, var167=java.lang.Object, var665=r1, var1063=java.lang.Throwable, var2888=$r20, var2396=org.apache.dubbo.remoting.RemotingException, var3366=$r21, var1423=java.net.SocketAddress, var3083=$r22, var724=java.net.InetSocketAddress, var1911=$r37, var2723=$r23, var961=$r36, var2918=$r24, var2539=$r26, var2556=org.apache.dubbo.remoting.utils.PayloadDropper, var77=$r25, var2382=$r27, var3369=$r30, var214=$r28, var848=$r29, var1241=$r31, var1312=$r33, var2089=$r32, var2251=$r34, var2686=$r35}
; {org.apache.dubbo.qos.command.impl.CountTelnet=var435, r38=var1584, io.netty.channel.Channel=var786, r0=var1601, java.lang.Object=var167, r1=var665, java.lang.Throwable=var1063, $r20=var2888, org.apache.dubbo.remoting.RemotingException=var2396, $r21=var3366, java.net.SocketAddress=var1423, $r22=var3083, java.net.InetSocketAddress=var724, $r37=var1911, $r23=var2723, $r36=var961, $r24=var2918, $r26=var2539, org.apache.dubbo.remoting.utils.PayloadDropper=var2556, $r25=var77, $r27=var2382, $r30=var3369, $r28=var214, $r29=var848, $r31=var1241, $r33=var1312, $r32=var2089, $r34=var2251, $r35=var2686}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r38 := @this: org.apache.dubbo.qos.command.impl.CountTelnet;	r0 := @parameter0: io.netty.channel.Channel;	r1 := @parameter1: java.lang.Object;	$r20 := @caughtexception;	$r21 = new org.apache.dubbo.remoting.RemotingException;	$r22 = interfaceinvoke r0.<io.netty.channel.Channel: java.net.SocketAddress localAddress()>();	$r37 = (java.net.InetSocketAddress) $r22;	$r23 = interfaceinvoke r0.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	$r36 = (java.net.InetSocketAddress) $r23;	$r24 = new java.lang.StringBuilder;	specialinvoke $r24.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send message ");	$r25 = staticinvoke <org.apache.dubbo.remoting.utils.PayloadDropper: java.lang.Object getRequestWithoutData(java.lang.Object)>(r1);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to ");	$r28 = interfaceinvoke r0.<io.netty.channel.Channel: java.net.SocketAddress remoteAddress()>();	$r29 = virtualinvoke $r28.<java.lang.Object: java.lang.String toString()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r29);	$r33 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r32 = virtualinvoke $r20.<java.lang.Throwable: java.lang.String getMessage()>();	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r32);	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r21.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String,java.lang.Throwable)>($r37, $r36, $r35, $r20);	throw $r21
;block_num 2