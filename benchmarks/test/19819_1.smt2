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

(declare-sort var2014 0)
(declare-sort var2844 0)
(declare-sort var800 0)
(declare-sort var3103 0)
(declare-sort var1361 0)
(declare-sort var2131 0)
(declare-sort var3234 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3103-init () var3103)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var800) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun append/-1031950772 (String var800) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2131_getRemoteAddress/1597111645 (var2131) var1361)
(declare-fun cast-from-var2844-to-var2131 (var2844) var2131)
(declare-fun cast-from-var1361-to-var800 (var1361) var800)
(declare-fun var3234_getLocalAddress/2019899378 (var3234) var1361)
(declare-fun cast-from-var2844-to-var3234 (var2844) var3234)
(declare-fun <init>/-2142452957 (var3103 var2131 String) void)
(declare-const null-var2014 var2014)
(declare-const null-var2844 var2844)
(declare-const null-var800 var800)
(declare-const var1823 var2014) ; Statement: r19 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1 
(assert (not (= var1823 null-var2014)))
(declare-const var666 var2844) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel 
(assert (not (= var666 null-var2844)))
(declare-const var1232 var800) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1232 null-var800)))
(define-const var1996 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.Invocation 
 ; Statement: if $z0 != 0 goto r1 = (org.apache.dubbo.rpc.Invocation) r0 
(assert (not (not (= (ite var1996 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1768 var3103 var3103-init) ; Statement: $r44 = new org.apache.dubbo.remoting.RemotingException 
(define-const var1027 String String-init) ; Statement: $r45 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1027)) ; Statement: specialinvoke $r45.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1027!1 String)
(assert (= var1027!1 ""))
(assert true)
(define-const var34 String (append/672562846 var1027!1 "Unsupported request: ")) ; Statement: $r52 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported request: ") 
(declare-const var1027!2 String)
(assert (= var1027!2 (str.++ var1027!1 "Unsupported request: ")))
 ; Statement: if r0 != null goto $r46 = new java.lang.StringBuilder 
(assert (not (= var1232 null-var800))) ; Cond: r0 != null 
(define-const var3631 String String-init) ; Statement: $r46 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3631)) ; Statement: specialinvoke $r46.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3631!1 String)
(assert (= var3631!1 ""))
(assert true)
(define-const var3680 ClassObject (getClass/1258963082 var1232)) ; Statement: $r47 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1836 String (getName/-1958580599 var3680)) ; Statement: $r48 = virtualinvoke $r47.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1956 String (append/672562846 var3631!1 var1836)) ; Statement: $r49 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r48) 
(declare-const var3631!2 String)
(assert (= var3631!2 (str.++ var3631!1 var1836)))
(assert true)
(define-const var2337 String (append/672562846 var1956 ": ")) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": ") 
(declare-const var1956!1 String)
(assert (= var1956!1 (str.++ var1956 ": ")))
(assert true)
(define-const var1968 String (append/-1031950772 var2337 var1232)) ; Statement: $r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2337!1 String)
(assert (str.prefixof var2337 var2337!1))
(assert true)
(define-const var3459 String (toString/-2075883882 var1968)) ; Statement: $r61 = virtualinvoke $r51.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var2812 String (append/672562846 var34 var3459)) ; Statement: $r53 = virtualinvoke $r52.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var34!1 String)
(assert (= var34!1 (str.++ var34 var3459)))
(assert true)
(define-const var2567 String (append/672562846 var2812 ", channel: consumer: ")) ; Statement: $r55 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: consumer: ") 
(declare-const var2812!1 String)
(assert (= var2812!1 (str.++ var2812 ", channel: consumer: ")))
(define-const var1807 var1361 (var2131_getRemoteAddress/1597111645 (cast-from-var2844-to-var2131 var666))) ; Statement: $r54 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1066 String (append/-1031950772 var2567 (cast-from-var1361-to-var800 var1807))) ; Statement: $r56 = virtualinvoke $r55.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r54) 
(declare-const var2567!1 String)
(assert (str.prefixof var2567 var2567!1))
(assert true)
(define-const var657 String (append/672562846 var1066 " --> provider: ")) ; Statement: $r58 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" --> provider: ") 
(declare-const var1066!1 String)
(assert (= var1066!1 (str.++ var1066 " --> provider: ")))
(define-const var1646 var1361 (var3234_getLocalAddress/2019899378 (cast-from-var2844-to-var3234 var666))) ; Statement: $r57 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3786 String (append/-1031950772 var657 (cast-from-var1361-to-var800 var1646))) ; Statement: $r59 = virtualinvoke $r58.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r57) 
(declare-const var657!1 String)
(assert (str.prefixof var657 var657!1))
(assert true)
(define-const var3986 String (toString/-2075883882 var3786)) ; Statement: $r60 = virtualinvoke $r59.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2142452957 var1768 (cast-from-var2844-to-var2131 var666) var3986)) ; Statement: specialinvoke $r44.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r9, $r60) 

(declare-const var1768!1 var3103)
(declare-const var666!1 var2844)
(declare-const var3986!1 String)
 ; Statement: throw $r44 
(check-sat)
; {var3103-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2131_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), cast-from-var2844-to-var2131=([org.apache.dubbo.remoting.exchange.ExchangeChannel], org.apache.dubbo.remoting.Channel), cast-from-var1361-to-var800=([java.net.InetSocketAddress], java.lang.Object), var3234_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var2844-to-var3234=([org.apache.dubbo.remoting.exchange.ExchangeChannel], org.apache.dubbo.remoting.Endpoint), <init>/-2142452957=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String], void)}
; {var2014=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1, var1823=r19, var2844=org.apache.dubbo.remoting.exchange.ExchangeChannel, var666=r9, var800=java.lang.Object, var1232=r0, var1996=$z0, var3103=org.apache.dubbo.remoting.RemotingException, var1768=$r44, var1027=$r45, var34=$r52, var3631=$r46, var3680=$r47, var1836=$r48, var1956=$r49, var2337=$r50, var1968=$r51, var3459=$r61, var2812=$r53, var2567=$r55, var1361=java.net.InetSocketAddress, var2131=org.apache.dubbo.remoting.Channel, var1807=$r54, var1066=$r56, var657=$r58, var3234=org.apache.dubbo.remoting.Endpoint, var1646=$r57, var3786=$r59, var3986=$r60}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1=var2014, r19=var1823, org.apache.dubbo.remoting.exchange.ExchangeChannel=var2844, r9=var666, java.lang.Object=var800, r0=var1232, $z0=var1996, org.apache.dubbo.remoting.RemotingException=var3103, $r44=var1768, $r45=var1027, $r52=var34, $r46=var3631, $r47=var3680, $r48=var1836, $r49=var1956, $r50=var2337, $r51=var1968, $r61=var3459, $r53=var2812, $r55=var2567, java.net.InetSocketAddress=var1361, org.apache.dubbo.remoting.Channel=var2131, $r54=var1807, $r56=var1066, $r58=var657, org.apache.dubbo.remoting.Endpoint=var3234, $r57=var1646, $r59=var3786, $r60=var3986}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r19 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1;	r9 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel;	r0 := @parameter1: java.lang.Object;	$z0 = r0 instanceof org.apache.dubbo.rpc.Invocation;	if $z0 != 0 goto r1 = (org.apache.dubbo.rpc.Invocation) r0;	$r44 = new org.apache.dubbo.remoting.RemotingException;	$r45 = new java.lang.StringBuilder;	specialinvoke $r45.<java.lang.StringBuilder: void <init>()>();	$r52 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported request: ");	if r0 != null goto $r46 = new java.lang.StringBuilder;	$r46 = new java.lang.StringBuilder;	specialinvoke $r46.<java.lang.StringBuilder: void <init>()>();	$r47 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r48 = virtualinvoke $r47.<java.lang.Class: java.lang.String getName()>();	$r49 = virtualinvoke $r46.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r48);	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": ");	$r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r61 = virtualinvoke $r51.<java.lang.StringBuilder: java.lang.String toString()>();	$r53 = virtualinvoke $r52.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r55 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: consumer: ");	$r54 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getRemoteAddress()>();	$r56 = virtualinvoke $r55.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r54);	$r58 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" --> provider: ");	$r57 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getLocalAddress()>();	$r59 = virtualinvoke $r58.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r57);	$r60 = virtualinvoke $r59.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r44.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r9, $r60);	throw $r44
;block_num 4