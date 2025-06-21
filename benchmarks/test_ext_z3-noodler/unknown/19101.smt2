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

(declare-sort var428 0)
(declare-sort var3837 0)
(declare-sort var2961 0)
(declare-sort var447 0)
(declare-sort var1090 0)
(declare-sort var910 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isAvailable/-2005661297 (var428) Bool)
(declare-fun var2961-init () var2961)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3837) String)
(declare-fun remote/-1507818110 (var1090) var447)
(declare-fun cast-from-var428-to-var1090 (var428) var1090)
(declare-fun cast-from-var447-to-var3837 (var447) var3837)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/2011950133 (var2961 var447 var447 String) void)
(declare-const null-var428 var428)
(declare-const null-var3837 var3837)
(declare-const null-NullType var910)
(declare-const null-var447 var447)
(declare-const var1226 var428) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient 
(assert (not (= var1226 null-var428)))
(declare-const var2094 var3837) ; Statement: r1 := @parameter0: java.lang.Object 
(assert (not (= var2094 null-var3837)))
(assert true)
(define-const var1853 Bool (isAvailable/-2005661297 var1226)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: boolean isAvailable()>() 
 ; Statement: if $z0 != 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: io.netty.channel.Channel getNettyChannel()>() 
(assert (not (not (= (ite var1853 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3541 var2961 var2961-init) ; Statement: $r4 = new org.apache.dubbo.remoting.RemotingException 
(define-const var2492 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2492)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2492!1 String)
(assert (= var2492!1 ""))
(assert true)
(define-const var841 String (append/672562846 var2492!1 "Failed to send request ")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send request ") 
(declare-const var2492!2 String)
(assert (= var2492!2 (str.++ var2492!1 "Failed to send request ")))
(assert true)
(define-const var2184 String (append/-1031950772 var841 var2094)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1) 
(declare-const var841!1 String)
(assert (str.prefixof var841 var841!1))
(assert true)
(define-const var2511 String (append/672562846 var2184 ", cause: The channel to ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The channel to ") 
(declare-const var2184!1 String)
(assert (= var2184!1 (str.++ var2184 ", cause: The channel to ")))
(define-const var218 var447 (remote/-1507818110 (cast-from-var428-to-var1090 var1226))) ; Statement: $r8 = r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: java.net.InetSocketAddress remote> 
(assert true)
(define-const var2796 String (append/-1031950772 var2511 (cast-from-var447-to-var3837 var218))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var2511!1 String)
(assert (str.prefixof var2511 var2511!1))
(assert true)
(define-const var796 String (append/672562846 var2796 " is closed!")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!") 
(declare-const var2796!1 String)
(assert (= var2796!1 (str.++ var2796 " is closed!")))
(assert true)
(define-const var1283 String (toString/-2075883882 var796)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/2011950133 var3541 null-var447 null-var447 var1283)) ; Statement: specialinvoke $r4.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>(null, null, $r12) 

(declare-const var3541!1 var2961)
(declare-const var3765 var910)
(declare-const var3765!1 var910)
(declare-const var1283!1 String)
 ; Statement: throw $r4 
(check-sat)
; {isAvailable/-2005661297=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient], boolean), var2961-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), remote/-1507818110=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], java.net.InetSocketAddress), cast-from-var428-to-var1090=([org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient], org.apache.dubbo.remoting.api.connection.AbstractConnectionClient), cast-from-var447-to-var3837=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/2011950133=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String], void)}
; {var428=org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient, var1226=r0, var3837=java.lang.Object, var2094=r1, var1853=$z0, var2961=org.apache.dubbo.remoting.RemotingException, var3541=$r4, var2492=$r5, var841=$r6, var2184=$r7, var2511=$r9, var447=java.net.InetSocketAddress, var1090=org.apache.dubbo.remoting.api.connection.AbstractConnectionClient, var218=$r8, var2796=$r10, var796=$r11, var1283=$r12, var3765=null, var910=null_type}
; {org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient=var428, r0=var1226, java.lang.Object=var3837, r1=var2094, $z0=var1853, org.apache.dubbo.remoting.RemotingException=var2961, $r4=var3541, $r5=var2492, $r6=var841, $r7=var2184, $r9=var2511, java.net.InetSocketAddress=var447, org.apache.dubbo.remoting.api.connection.AbstractConnectionClient=var1090, $r8=var218, $r10=var2796, $r11=var796, $r12=var1283, null=var3765, null_type=var910}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient;	r1 := @parameter0: java.lang.Object;	$z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: boolean isAvailable()>();	if $z0 != 0 goto $r2 = specialinvoke r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: io.netty.channel.Channel getNettyChannel()>();	$r4 = new org.apache.dubbo.remoting.RemotingException;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to send request ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r1);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: The channel to ");	$r8 = r0.<org.apache.dubbo.remoting.transport.netty4.AbstractNettyConnectionClient: java.net.InetSocketAddress remote>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is closed!");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r4.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String)>(null, null, $r12);	throw $r4
;block_num 2