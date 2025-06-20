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

(declare-sort var3175 0)
(declare-sort var764 0)
(declare-sort var2779 0)
(declare-sort var1906 0)
(declare-sort var850 0)
(declare-sort var1392 0)
(declare-sort var601 0)
(declare-sort var2174 0)
(declare-sort var3231 0)
(declare-sort var302 0)
(declare-sort var1225 0)
(declare-sort var2157 0)
(declare-sort var2074 0)
(declare-sort var3104 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-1604619608 (var1906 var764 var2779) void)
(declare-fun cast-from-var3175-to-var1906 (var3175) var1906)
(declare-fun var850-init () var850)
(declare-fun <init>/882121004 (var850) void)
(declare-fun cast-from-var850-to-var1392 (var850) var1392)
(declare-fun executors/485699407 (var3175) var1392)
(declare-fun getOrDefaultApplicationModel/-1374397043 (var764) var601)
(declare-fun var2174_getInstance/1376797019 (var601) var2174)
(declare-fun executorRepository/485699407 (var3175) var2174)
(declare-fun getUrl/1588539622 (var3231) var764)
(declare-fun cast-from-var3175-to-var3231 (var3175) var3231)
(declare-fun toInetSocketAddress/806229023 (var764) var302)
(declare-fun localAddress/485699407 (var3175) var302)
(declare-fun getHost/-1506772130 (var764) String)
(declare-fun getParameter/506106603 (var764 String String) String)
(declare-fun getPort/20614931 (var764) Int)
(declare-fun getParameter/448702405 (var764 String Int) Int)
(declare-fun getParameter/2144001655 (var764 String Bool) Bool)
(declare-fun var302-init () var302)
(declare-fun <init>/481518073 (var302 String Int) void)
(declare-fun bindAddress/485699407 (var3175) var302)
(declare-fun accepts/485699407 (var3175) Int)
(declare-fun var2157-init () var2157)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getClass/1258963082 (var2074) ClassObject)
(declare-fun cast-from-var3175-to-var2074 (var3175) var2074)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun append/-1031950772 (String var2074) String)
(declare-fun cast-from-var302-to-var2074 (var302) var2074)
(declare-fun getMessage/849299655 (var1225) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1118340853 (var2157 var302 var302 String var1225) void)
(declare-const null-var3175 var3175)
(declare-const null-var764 var764)
(declare-const null-var2779 var2779)
(declare-const null-var1225 var1225)
(declare-const null-NullType var3104)
(declare-const null-var302 var302)
(declare-const var835 var3175) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.AbstractServer 
(assert (not (= var835 null-var3175)))
(declare-const var1140 var764) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1140 null-var764)))
(declare-const var1261 var2779) ; Statement: r2 := @parameter1: org.apache.dubbo.remoting.ChannelHandler 
(assert (not (= var1261 null-var2779)))
(assert true)
;(assert (<init>/-1604619608 (cast-from-var3175-to-var1906 var835) var1140 var1261)) ; Statement: specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractEndpoint: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>(r1, r2) 

(declare-const var835!1 var3175)
(declare-const var1140!1 var764)
(declare-const var1261!1 var2779)
(define-const var610 var850 var850-init) ; Statement: $r3 = new org.apache.dubbo.common.utils.ConcurrentHashSet 
(assert true)
;(assert (<init>/882121004 var610)) ; Statement: specialinvoke $r3.<org.apache.dubbo.common.utils.ConcurrentHashSet: void <init>()>() 

(declare-const var610!1 var850)
(declare-const var835!2 var3175)
(assert (not (= var835!2 null-var3175)))
(assert (= (executors/485699407 var835!2) (cast-from-var850-to-var1392 var610!1))) ; Statement: r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.util.Set executors> = $r3 
(assert true)
(define-const var2340 var601 (getOrDefaultApplicationModel/-1374397043 var1140!1)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>() 
(define-const var2834 var2174 (var2174_getInstance/1376797019 var2340)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: org.apache.dubbo.common.threadpool.manager.ExecutorRepository getInstance(org.apache.dubbo.rpc.model.ApplicationModel)>($r4) 
(declare-const var835!3 var3175)
(assert (not (= var835!3 null-var3175)))
(assert (= (executorRepository/485699407 var835!3) var2834)) ; Statement: r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.threadpool.manager.ExecutorRepository executorRepository> = $r5 
(assert true)
(define-const var3310 var764 (getUrl/1588539622 (cast-from-var3175-to-var3231 var835!3))) ; Statement: $r6 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1029 var302 (toInetSocketAddress/806229023 var3310)) ; Statement: $r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.net.InetSocketAddress toInetSocketAddress()>() 
(declare-const var835!4 var3175)
(assert (not (= var835!4 null-var3175)))
(assert (= (localAddress/485699407 var835!4) var1029)) ; Statement: r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.net.InetSocketAddress localAddress> = $r7 
(assert true)
(define-const var2909 var764 (getUrl/1588539622 (cast-from-var3175-to-var3231 var835!4))) ; Statement: $r10 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2352 var764 (getUrl/1588539622 (cast-from-var3175-to-var3231 var835!4))) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1982 String (getHost/-1506772130 var2352)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert true)
(define-const var3486 String (getParameter/506106603 var2909 "bind.ip" var1982)) ; Statement: r45 = virtualinvoke $r10.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("bind.ip", $r9) 
(assert true)
(define-const var800 var764 (getUrl/1588539622 (cast-from-var3175-to-var3231 var835!4))) ; Statement: $r12 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3102 var764 (getUrl/1588539622 (cast-from-var3175-to-var3231 var835!4))) ; Statement: $r11 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3114 Int (getPort/20614931 var3102)) ; Statement: $i0 = virtualinvoke $r11.<org.apache.dubbo.common.URL: int getPort()>() 
(assert true)
(define-const var811 Int (getParameter/448702405 var800 "bind.port" var3114)) ; Statement: i1 = virtualinvoke $r12.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0) 
(assert true)
(define-const var1715 Bool (getParameter/2144001655 var1140!1 "anyhost" (ite (= 1 0) true false))) ; Statement: $z0 = virtualinvoke r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("anyhost", 0) 
 ; Statement: if $z0 != 0 goto r45 = "0.0.0.0" 
(assert (not (= (ite var1715 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3486!1 String "0.0.0.0") ; Statement: r45 = "0.0.0.0" 
(assert true) ; Non Conditional
(define-const var2802 var302 var302-init) ; Statement: $r46 = new java.net.InetSocketAddress 
(assert true)
;(assert (<init>/481518073 var2802 var3486!1 var811)) ; Statement: specialinvoke $r46.<java.net.InetSocketAddress: void <init>(java.lang.String,int)>(r45, i1) 

(declare-const var2802!1 var302)
(declare-const var3486!2 String)
(declare-const var811!1 Int)
(declare-const var835!5 var3175)
(assert (not (= var835!5 null-var3175)))
(assert (= (bindAddress/485699407 var835!5) var2802!1)) ; Statement: r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.net.InetSocketAddress bindAddress> = $r46 
(assert true)
(define-const var2087 Int (getParameter/448702405 var1140!1 "accepts" 0)) ; Statement: $i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("accepts", 0) 
(declare-const var835!6 var3175)
(assert (not (= var835!6 null-var3175)))
(assert (= (accepts/485699407 var835!6) var2087)) ; Statement: r0.<org.apache.dubbo.remoting.transport.AbstractServer: int accepts> = $i2 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3912 var1225) ; Statement: $r30 := @caughtexception 
(assert (not (= var3912 null-var1225)))
(define-const var637 var2157 var2157-init) ; Statement: $r31 = new org.apache.dubbo.remoting.RemotingException 
(assert true)
(define-const var2439 var302 (toInetSocketAddress/806229023 var1140!1)) ; Statement: $r44 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.net.InetSocketAddress toInetSocketAddress()>() 
(define-const var94 String String-init) ; Statement: $r32 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var94)) ; Statement: specialinvoke $r32.<java.lang.StringBuilder: void <init>()>() 
(declare-const var94!1 String)
(assert (= var94!1 ""))
(assert true)
(define-const var2641 String (append/672562846 var94!1 "Failed to bind ")) ; Statement: $r35 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to bind ") 
(declare-const var94!2 String)
(assert (= var94!2 (str.++ var94!1 "Failed to bind ")))
(assert true)
(define-const var3088 ClassObject (getClass/1258963082 (cast-from-var3175-to-var2074 var835!6))) ; Statement: $r33 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1837 String (getSimpleName/-390194377 var3088)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var1763 String (append/672562846 var2641 var1837)) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r34) 
(declare-const var2641!1 String)
(assert (= var2641!1 (str.++ var2641 var1837)))
(assert true)
(define-const var2777 String (append/672562846 var1763 " on ")) ; Statement: $r38 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on ") 
(declare-const var1763!1 String)
(assert (= var1763!1 (str.++ var1763 " on ")))
(define-const var1362 var302 (bindAddress/485699407 var835!6)) ; Statement: $r37 = r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.net.InetSocketAddress bindAddress> 
(assert true)
(define-const var1036 String (append/-1031950772 var2777 (cast-from-var302-to-var2074 var1362))) ; Statement: $r39 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r37) 
(declare-const var2777!1 String)
(assert (str.prefixof var2777 var2777!1))
(assert true)
(define-const var341 String (append/672562846 var1036 ", cause: ")) ; Statement: $r41 = virtualinvoke $r39.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1036!1 String)
(assert (= var1036!1 (str.++ var1036 ", cause: ")))
(assert true)
(define-const var2756 String (getMessage/849299655 var3912)) ; Statement: $r40 = virtualinvoke $r30.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3029 String (append/672562846 var341 var2756)) ; Statement: $r42 = virtualinvoke $r41.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var341!1 String)
(assert (= var341!1 (str.++ var341 var2756)))
(assert true)
(define-const var1412 String (toString/-2075883882 var3029)) ; Statement: $r43 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1118340853 var637 var2439 null-var302 var1412 var3912)) ; Statement: specialinvoke $r31.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String,java.lang.Throwable)>($r44, null, $r43, $r30) 

(declare-const var637!1 var2157)
(declare-const var2439!1 var302)
(declare-const var2416 var3104)
(declare-const var1412!1 String)
(declare-const var3912!1 var1225)
 ; Statement: throw $r31 
(check-sat)
; {<init>/-1604619608=([org.apache.dubbo.remoting.transport.AbstractEndpoint, org.apache.dubbo.common.URL, org.apache.dubbo.remoting.ChannelHandler], void), cast-from-var3175-to-var1906=([org.apache.dubbo.remoting.transport.AbstractServer], org.apache.dubbo.remoting.transport.AbstractEndpoint), var850-init=([], org.apache.dubbo.common.utils.ConcurrentHashSet), <init>/882121004=([org.apache.dubbo.common.utils.ConcurrentHashSet], void), cast-from-var850-to-var1392=([org.apache.dubbo.common.utils.ConcurrentHashSet], java.util.Set), executors/485699407=([org.apache.dubbo.remoting.transport.AbstractServer], java.util.Set), getOrDefaultApplicationModel/-1374397043=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ApplicationModel), var2174_getInstance/1376797019=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.common.threadpool.manager.ExecutorRepository), executorRepository/485699407=([org.apache.dubbo.remoting.transport.AbstractServer], org.apache.dubbo.common.threadpool.manager.ExecutorRepository), getUrl/1588539622=([org.apache.dubbo.remoting.transport.AbstractPeer], org.apache.dubbo.common.URL), cast-from-var3175-to-var3231=([org.apache.dubbo.remoting.transport.AbstractServer], org.apache.dubbo.remoting.transport.AbstractPeer), toInetSocketAddress/806229023=([org.apache.dubbo.common.URL], java.net.InetSocketAddress), localAddress/485699407=([org.apache.dubbo.remoting.transport.AbstractServer], java.net.InetSocketAddress), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), getPort/20614931=([org.apache.dubbo.common.URL], int), getParameter/448702405=([org.apache.dubbo.common.URL, java.lang.String, int], int), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), var302-init=([], java.net.InetSocketAddress), <init>/481518073=([java.net.InetSocketAddress, java.lang.String, int], void), bindAddress/485699407=([org.apache.dubbo.remoting.transport.AbstractServer], java.net.InetSocketAddress), accepts/485699407=([org.apache.dubbo.remoting.transport.AbstractServer], int), var2157-init=([], org.apache.dubbo.remoting.RemotingException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3175-to-var2074=([org.apache.dubbo.remoting.transport.AbstractServer], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var302-to-var2074=([java.net.InetSocketAddress], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1118340853=([org.apache.dubbo.remoting.RemotingException, java.net.InetSocketAddress, java.net.InetSocketAddress, java.lang.String, java.lang.Throwable], void)}
; {var3175=org.apache.dubbo.remoting.transport.AbstractServer, var835=r0, var764=org.apache.dubbo.common.URL, var1140=r1, var2779=org.apache.dubbo.remoting.ChannelHandler, var1261=r2, var1906=org.apache.dubbo.remoting.transport.AbstractEndpoint, var850=org.apache.dubbo.common.utils.ConcurrentHashSet, var610=$r3, var1392=java.util.Set, var601=org.apache.dubbo.rpc.model.ApplicationModel, var2340=$r4, var2174=org.apache.dubbo.common.threadpool.manager.ExecutorRepository, var2834=$r5, var3231=org.apache.dubbo.remoting.transport.AbstractPeer, var3310=$r6, var302=java.net.InetSocketAddress, var1029=$r7, var2909=$r10, var2352=$r8, var1982=$r9, var3486=r45, var800=$r12, var3102=$r11, var3114=$i0, var811=i1, var1715=$z0, var2802=$r46, var2087=$i2, var1225=java.lang.Throwable, var3912=$r30, var2157=org.apache.dubbo.remoting.RemotingException, var637=$r31, var2439=$r44, var94=$r32, var2641=$r35, var2074=java.lang.Object, var3088=$r33, var1837=$r34, var1763=$r36, var2777=$r38, var1362=$r37, var1036=$r39, var341=$r41, var2756=$r40, var3029=$r42, var1412=$r43, var2416=null, var3104=null_type}
; {org.apache.dubbo.remoting.transport.AbstractServer=var3175, r0=var835, org.apache.dubbo.common.URL=var764, r1=var1140, org.apache.dubbo.remoting.ChannelHandler=var2779, r2=var1261, org.apache.dubbo.remoting.transport.AbstractEndpoint=var1906, org.apache.dubbo.common.utils.ConcurrentHashSet=var850, $r3=var610, java.util.Set=var1392, org.apache.dubbo.rpc.model.ApplicationModel=var601, $r4=var2340, org.apache.dubbo.common.threadpool.manager.ExecutorRepository=var2174, $r5=var2834, org.apache.dubbo.remoting.transport.AbstractPeer=var3231, $r6=var3310, java.net.InetSocketAddress=var302, $r7=var1029, $r10=var2909, $r8=var2352, $r9=var1982, r45=var3486, $r12=var800, $r11=var3102, $i0=var3114, i1=var811, $z0=var1715, $r46=var2802, $i2=var2087, java.lang.Throwable=var1225, $r30=var3912, org.apache.dubbo.remoting.RemotingException=var2157, $r31=var637, $r44=var2439, $r32=var94, $r35=var2641, java.lang.Object=var2074, $r33=var3088, $r34=var1837, $r36=var1763, $r38=var2777, $r37=var1362, $r39=var1036, $r41=var341, $r40=var2756, $r42=var3029, $r43=var1412, null=var2416, null_type=var3104}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.AbstractServer;	r1 := @parameter0: org.apache.dubbo.common.URL;	r2 := @parameter1: org.apache.dubbo.remoting.ChannelHandler;	specialinvoke r0.<org.apache.dubbo.remoting.transport.AbstractEndpoint: void <init>(org.apache.dubbo.common.URL,org.apache.dubbo.remoting.ChannelHandler)>(r1, r2);	$r3 = new org.apache.dubbo.common.utils.ConcurrentHashSet;	specialinvoke $r3.<org.apache.dubbo.common.utils.ConcurrentHashSet: void <init>()>();	r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.util.Set executors> = $r3;	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ApplicationModel getOrDefaultApplicationModel()>();	$r5 = staticinvoke <org.apache.dubbo.common.threadpool.manager.ExecutorRepository: org.apache.dubbo.common.threadpool.manager.ExecutorRepository getInstance(org.apache.dubbo.rpc.model.ApplicationModel)>($r4);	r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.threadpool.manager.ExecutorRepository executorRepository> = $r5;	$r6 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>();	$r7 = virtualinvoke $r6.<org.apache.dubbo.common.URL: java.net.InetSocketAddress toInetSocketAddress()>();	r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.net.InetSocketAddress localAddress> = $r7;	$r10 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>();	$r8 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>();	$r9 = virtualinvoke $r8.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	r45 = virtualinvoke $r10.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("bind.ip", $r9);	$r12 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>();	$r11 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.URL getUrl()>();	$i0 = virtualinvoke $r11.<org.apache.dubbo.common.URL: int getPort()>();	i1 = virtualinvoke $r12.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("bind.port", $i0);	$z0 = virtualinvoke r1.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("anyhost", 0);	if $z0 != 0 goto r45 = "0.0.0.0";	r45 = "0.0.0.0";	$r46 = new java.net.InetSocketAddress;	specialinvoke $r46.<java.net.InetSocketAddress: void <init>(java.lang.String,int)>(r45, i1);	r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.net.InetSocketAddress bindAddress> = $r46;	$i2 = virtualinvoke r1.<org.apache.dubbo.common.URL: int getParameter(java.lang.String,int)>("accepts", 0);	r0.<org.apache.dubbo.remoting.transport.AbstractServer: int accepts> = $i2;	$r30 := @caughtexception;	$r31 = new org.apache.dubbo.remoting.RemotingException;	$r44 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.net.InetSocketAddress toInetSocketAddress()>();	$r32 = new java.lang.StringBuilder;	specialinvoke $r32.<java.lang.StringBuilder: void <init>()>();	$r35 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to bind ");	$r33 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r34 = virtualinvoke $r33.<java.lang.Class: java.lang.String getSimpleName()>();	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r34);	$r38 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" on ");	$r37 = r0.<org.apache.dubbo.remoting.transport.AbstractServer: java.net.InetSocketAddress bindAddress>;	$r39 = virtualinvoke $r38.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r37);	$r41 = virtualinvoke $r39.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r40 = virtualinvoke $r30.<java.lang.Throwable: java.lang.String getMessage()>();	$r42 = virtualinvoke $r41.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r43 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r31.<org.apache.dubbo.remoting.RemotingException: void <init>(java.net.InetSocketAddress,java.net.InetSocketAddress,java.lang.String,java.lang.Throwable)>($r44, null, $r43, $r30);	throw $r31
;block_num 4