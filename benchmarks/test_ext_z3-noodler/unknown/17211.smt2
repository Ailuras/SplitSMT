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

(declare-sort var3967 0)
(declare-sort var2593 0)
(declare-sort var3670 0)
(declare-sort var893 0)
(declare-sort var3107 0)
(declare-sort var3254 0)
(declare-sort var596 0)
(declare-sort var828 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isTwoWay/505863693 (var3670) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun url/-1222735057 (var3967) var3107)
(declare-fun getIp/-49850945 (var3107) String)
(declare-fun getPort/20614931 (var3107) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getMessage/849299655 (var893) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3254-init () var3254)
(declare-fun getId/-1251157979 (var3670) Int)
(declare-fun getVersion/440990027 (var3670) String)
(declare-fun <init>/1624423151 (var3254 Int String) void)
(declare-fun setStatus/-969168820 (var3254 Int) void)
(declare-fun setErrorMessage/1202863900 (var3254 String) void)
(declare-fun var596_send/1695952248 (var596 var828) void)
(declare-fun cast-from-var2593-to-var596 (var2593) var596)
(declare-fun cast-from-var3254-to-var828 (var3254) var828)
(declare-const null-var3967 var3967)
(declare-const null-var2593 var2593)
(declare-const null-var3670 var3670)
(declare-const null-var893 var893)
(declare-const var2016 var3967) ; Statement: r2 := @this: org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler 
(assert (not (= var2016 null-var3967)))
(declare-const var1326 var2593) ; Statement: r17 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1326 null-var2593)))
(declare-const var505 var3670) ; Statement: r0 := @parameter1: org.apache.dubbo.remoting.exchange.Request 
(assert (not (= var505 null-var3670)))
(declare-const var344 var893) ; Statement: r10 := @parameter2: java.lang.Throwable 
(assert (not (= var344 null-var893)))
(assert true)
(define-const var1360 Bool (isTwoWay/505863693 var505)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.Request: boolean isTwoWay()>() 
 ; Statement: if $z0 != 0 goto $r1 = new java.lang.StringBuilder 
(assert (not (= (ite var1360 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1928 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1928)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1928!1 String)
(assert (= var1928!1 ""))
(assert true)
(define-const var1438 String (append/672562846 var1928!1 "Server side(")) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Server side(") 
(declare-const var1928!2 String)
(assert (= var1928!2 (str.++ var1928!1 "Server side(")))
(define-const var911 var3107 (url/-1222735057 var2016)) ; Statement: $r3 = r2.<org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var3954 String (getIp/-49850945 var911)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getIp()>() 
(assert true)
(define-const var859 String (append/672562846 var1438 var3954)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1438!1 String)
(assert (= var1438!1 (str.++ var1438 var3954)))
(assert true)
(define-const var3577 String (append/672562846 var859 ",")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var859!1 String)
(assert (= var859!1 (str.++ var859 ",")))
(define-const var2885 var3107 (url/-1222735057 var2016)) ; Statement: $r7 = r2.<org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler: org.apache.dubbo.common.URL url> 
(assert true)
(define-const var2452 Int (getPort/20614931 var2885)) ; Statement: $i0 = virtualinvoke $r7.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var3897 String (append/-1001720160 var3577 var2452)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3577!1 String)
(assert (str.prefixof var3577 var3577!1))
(assert true)
(define-const var1897 String (append/672562846 var3897 ") thread pool is exhausted, detail msg:")) ; Statement: $r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") thread pool is exhausted, detail msg:") 
(declare-const var3897!1 String)
(assert (= var3897!1 (str.++ var3897 ") thread pool is exhausted, detail msg:")))
(assert true)
(define-const var1114 String (getMessage/849299655 var344)) ; Statement: $r11 = virtualinvoke r10.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1472 String (append/672562846 var1897 var1114)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var1897!1 String)
(assert (= var1897!1 (str.++ var1897 var1114)))
(assert true)
(define-const var983 String (toString/-2075883882 var1472)) ; Statement: r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1713 var3254 var3254-init) ; Statement: $r15 = new org.apache.dubbo.remoting.exchange.Response 
(assert true)
(define-const var1348 Int (getId/-1251157979 var505)) ; Statement: $l1 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.Request: long getId()>() 
(assert true)
(define-const var91 String (getVersion/440990027 var505)) ; Statement: $r16 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>() 
(assert true)
;(assert (<init>/1624423151 var1713 var1348 var91)) ; Statement: specialinvoke $r15.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l1, $r16) 

(declare-const var1713!1 var3254)
(declare-const var1348!1 Int)
(declare-const var91!1 String)
(assert true)
;(assert (setStatus/-969168820 var1713!1 100)) ; Statement: virtualinvoke $r15.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(100) 

(declare-const var1713!2 var3254)
(declare-const var3012 Int)
(assert true)
;(assert (setErrorMessage/1202863900 var1713!2 var983)) ; Statement: virtualinvoke $r15.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>(r14) 

(declare-const var1713!3 var3254)
(declare-const var983!1 String)
;(assert (var596_send/1695952248 (cast-from-var2593-to-var596 var1326) (cast-from-var3254-to-var828 var1713!3))) ; Statement: interfaceinvoke r17.<org.apache.dubbo.remoting.Channel: void send(java.lang.Object)>($r15) 

(declare-const var1326!1 var2593)
(declare-const var1713!4 var3254)
 ; Statement: return 
(check-sat)
; {isTwoWay/505863693=([org.apache.dubbo.remoting.exchange.Request], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), url/-1222735057=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler], org.apache.dubbo.common.URL), getIp/-49850945=([org.apache.dubbo.common.URL], java.lang.String), getPort/20614931=([org.apache.dubbo.common.URL], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3254-init=([], org.apache.dubbo.remoting.exchange.Response), getId/-1251157979=([org.apache.dubbo.remoting.exchange.Request], long), getVersion/440990027=([org.apache.dubbo.remoting.exchange.Request], java.lang.String), <init>/1624423151=([org.apache.dubbo.remoting.exchange.Response, long, java.lang.String], void), setStatus/-969168820=([org.apache.dubbo.remoting.exchange.Response, byte], void), setErrorMessage/1202863900=([org.apache.dubbo.remoting.exchange.Response, java.lang.String], void), var596_send/1695952248=([org.apache.dubbo.remoting.Endpoint, java.lang.Object], void), cast-from-var2593-to-var596=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var3254-to-var828=([org.apache.dubbo.remoting.exchange.Response], java.lang.Object)}
; {var3967=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var2016=r2, var2593=org.apache.dubbo.remoting.Channel, var1326=r17, var3670=org.apache.dubbo.remoting.exchange.Request, var505=r0, var893=java.lang.Throwable, var344=r10, var1360=$z0, var1928=$r1, var1438=$r5, var3107=org.apache.dubbo.common.URL, var911=$r3, var3954=$r4, var859=$r6, var3577=$r8, var2885=$r7, var2452=$i0, var3897=$r9, var1897=$r12, var1114=$r11, var1472=$r13, var983=r14, var3254=org.apache.dubbo.remoting.exchange.Response, var1713=$r15, var1348=$l1, var91=$r16, var3012=100, var596=org.apache.dubbo.remoting.Endpoint, var828=java.lang.Object}
; {org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var3967, r2=var2016, org.apache.dubbo.remoting.Channel=var2593, r17=var1326, org.apache.dubbo.remoting.exchange.Request=var3670, r0=var505, java.lang.Throwable=var893, r10=var344, $z0=var1360, $r1=var1928, $r5=var1438, org.apache.dubbo.common.URL=var3107, $r3=var911, $r4=var3954, $r6=var859, $r8=var3577, $r7=var2885, $i0=var2452, $r9=var3897, $r12=var1897, $r11=var1114, $r13=var1472, r14=var983, org.apache.dubbo.remoting.exchange.Response=var3254, $r15=var1713, $l1=var1348, $r16=var91, 100=var3012, org.apache.dubbo.remoting.Endpoint=var596, java.lang.Object=var828}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler;	r17 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: org.apache.dubbo.remoting.exchange.Request;	r10 := @parameter2: java.lang.Throwable;	$z0 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.Request: boolean isTwoWay()>();	if $z0 != 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Server side(");	$r3 = r2.<org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler: org.apache.dubbo.common.URL url>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getIp()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$r7 = r2.<org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler: org.apache.dubbo.common.URL url>;	$i0 = virtualinvoke $r7.<org.apache.dubbo.common.URL: int getPort()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r12 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") thread pool is exhausted, detail msg:");	$r11 = virtualinvoke r10.<java.lang.Throwable: java.lang.String getMessage()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	$r15 = new org.apache.dubbo.remoting.exchange.Response;	$l1 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.Request: long getId()>();	$r16 = virtualinvoke r0.<org.apache.dubbo.remoting.exchange.Request: java.lang.String getVersion()>();	specialinvoke $r15.<org.apache.dubbo.remoting.exchange.Response: void <init>(long,java.lang.String)>($l1, $r16);	virtualinvoke $r15.<org.apache.dubbo.remoting.exchange.Response: void setStatus(byte)>(100);	virtualinvoke $r15.<org.apache.dubbo.remoting.exchange.Response: void setErrorMessage(java.lang.String)>(r14);	interfaceinvoke r17.<org.apache.dubbo.remoting.Channel: void send(java.lang.Object)>($r15);	return
;block_num 2