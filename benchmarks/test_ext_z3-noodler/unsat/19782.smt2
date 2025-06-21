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

(declare-sort var138 0)
(declare-sort var197 0)
(declare-sort var562 0)
(declare-sort var2796 0)
(declare-sort var19 0)
(declare-sort var867 0)
(declare-sort var987 0)
(declare-sort var287 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2796-init () var2796)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var987_getRemoteAddress/1597111645 (var987) var867)
(declare-fun cast-from-var197-to-var987 (var197) var987)
(declare-fun append/-1031950772 (String var562) String)
(declare-fun cast-from-var867-to-var562 (var867) var562)
(declare-fun var287_getLocalAddress/2019899378 (var287) var867)
(declare-fun cast-from-var197-to-var287 (var197) var287)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-2142452957 (var2796 var987 String) void)
(declare-const null-var138 var138)
(declare-const null-var197 var197)
(declare-const null-var562 var562)
(declare-const null-String String)
(declare-const var1462 var138) ; Statement: r19 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1 
(assert (not (= var1462 null-var138)))
(declare-const var101 var197) ; Statement: r9 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel 
(assert (not (= var101 null-var197)))
(declare-const var1704 var562) ; Statement: r0 := @parameter1: java.lang.Object 
(assert (not (= var1704 null-var562)))
(define-const var3918 Bool false) ; Statement: $z0 = r0 instanceof org.apache.dubbo.rpc.Invocation 
 ; Statement: if $z0 != 0 goto r1 = (org.apache.dubbo.rpc.Invocation) r0 
(assert (not (not (= (ite var3918 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3586 var2796 var2796-init) ; Statement: $r44 = new org.apache.dubbo.remoting.RemotingException 
(define-const var1253 String String-init) ; Statement: $r45 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1253)) ; Statement: specialinvoke $r45.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1253!1 String)
(assert (= var1253!1 ""))
(assert true)
(define-const var3122 String (append/672562846 var1253!1 "Unsupported request: ")) ; Statement: $r52 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported request: ") 
(declare-const var1253!2 String)
(assert (= var1253!2 (str.++ var1253!1 "Unsupported request: ")))
 ; Statement: if r0 != null goto $r46 = new java.lang.StringBuilder 
(assert (not (not (= var1704 null-var562)))) ; Negate: Cond: r0 != null  
(define-const var1420 String null-String) ; Statement: $r61 = null 
 ; Statement: goto [?= $r53 = virtualinvoke $r52.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1144 String (append/672562846 var3122 var1420)) ; Statement: $r53 = virtualinvoke $r52.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61) 
(declare-const var3122!1 String)
(assert (= var3122!1 (str.++ var3122 var1420)))
(assert true)
(define-const var3873 String (append/672562846 var1144 ", channel: consumer: ")) ; Statement: $r55 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: consumer: ") 
(declare-const var1144!1 String)
(assert (= var1144!1 (str.++ var1144 ", channel: consumer: ")))
(define-const var463 var867 (var987_getRemoteAddress/1597111645 (cast-from-var197-to-var987 var101))) ; Statement: $r54 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var788 String (append/-1031950772 var3873 (cast-from-var867-to-var562 var463))) ; Statement: $r56 = virtualinvoke $r55.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r54) 
(declare-const var3873!1 String)
(assert (str.prefixof var3873 var3873!1))
(assert true)
(define-const var2002 String (append/672562846 var788 " --> provider: ")) ; Statement: $r58 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" --> provider: ") 
(declare-const var788!1 String)
(assert (= var788!1 (str.++ var788 " --> provider: ")))
(define-const var3682 var867 (var287_getLocalAddress/2019899378 (cast-from-var197-to-var287 var101))) ; Statement: $r57 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2445 String (append/-1031950772 var2002 (cast-from-var867-to-var562 var3682))) ; Statement: $r59 = virtualinvoke $r58.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r57) 
(declare-const var2002!1 String)
(assert (str.prefixof var2002 var2002!1))
(assert true)
(define-const var1330 String (toString/-2075883882 var2445)) ; Statement: $r60 = virtualinvoke $r59.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-2142452957 var3586 (cast-from-var197-to-var987 var101) var1330)) ; Statement: specialinvoke $r44.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r9, $r60) 

(declare-const var3586!1 var2796)
(declare-const var101!1 var197)
(declare-const var1330!1 String)
 ; Statement: throw $r44 
(check-sat)
; {var2796-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var987_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), cast-from-var197-to-var987=([org.apache.dubbo.remoting.exchange.ExchangeChannel], org.apache.dubbo.remoting.Channel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var867-to-var562=([java.net.InetSocketAddress], java.lang.Object), var287_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var197-to-var287=([org.apache.dubbo.remoting.exchange.ExchangeChannel], org.apache.dubbo.remoting.Endpoint), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-2142452957=([org.apache.dubbo.remoting.RemotingException, org.apache.dubbo.remoting.Channel, java.lang.String], void)}
; {var138=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1, var1462=r19, var197=org.apache.dubbo.remoting.exchange.ExchangeChannel, var101=r9, var562=java.lang.Object, var1704=r0, var3918=$z0, var2796=org.apache.dubbo.remoting.RemotingException, var3586=$r44, var1253=$r45, var3122=$r52, var19=null_type, var1420=$r61, var1144=$r53, var3873=$r55, var867=java.net.InetSocketAddress, var987=org.apache.dubbo.remoting.Channel, var463=$r54, var788=$r56, var2002=$r58, var287=org.apache.dubbo.remoting.Endpoint, var3682=$r57, var2445=$r59, var1330=$r60}
; {org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1=var138, r19=var1462, org.apache.dubbo.remoting.exchange.ExchangeChannel=var197, r9=var101, java.lang.Object=var562, r0=var1704, $z0=var3918, org.apache.dubbo.remoting.RemotingException=var2796, $r44=var3586, $r45=var1253, $r52=var3122, null_type=var19, $r61=var1420, $r53=var1144, $r55=var3873, java.net.InetSocketAddress=var867, org.apache.dubbo.remoting.Channel=var987, $r54=var463, $r56=var788, $r58=var2002, org.apache.dubbo.remoting.Endpoint=var287, $r57=var3682, $r59=var2445, $r60=var1330}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r19 := @this: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol$1;	r9 := @parameter0: org.apache.dubbo.remoting.exchange.ExchangeChannel;	r0 := @parameter1: java.lang.Object;	$z0 = r0 instanceof org.apache.dubbo.rpc.Invocation;	if $z0 != 0 goto r1 = (org.apache.dubbo.rpc.Invocation) r0;	$r44 = new org.apache.dubbo.remoting.RemotingException;	$r45 = new java.lang.StringBuilder;	specialinvoke $r45.<java.lang.StringBuilder: void <init>()>();	$r52 = virtualinvoke $r45.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unsupported request: ");	if r0 != null goto $r46 = new java.lang.StringBuilder;	$r61 = null;	goto [?= $r53 = virtualinvoke $r52.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61)];	$r53 = virtualinvoke $r52.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r61);	$r55 = virtualinvoke $r53.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: consumer: ");	$r54 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getRemoteAddress()>();	$r56 = virtualinvoke $r55.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r54);	$r58 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" --> provider: ");	$r57 = interfaceinvoke r9.<org.apache.dubbo.remoting.exchange.ExchangeChannel: java.net.InetSocketAddress getLocalAddress()>();	$r59 = virtualinvoke $r58.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r57);	$r60 = virtualinvoke $r59.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r44.<org.apache.dubbo.remoting.RemotingException: void <init>(org.apache.dubbo.remoting.Channel,java.lang.String)>(r9, $r60);	throw $r44
;block_num 4