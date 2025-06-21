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

(declare-sort var121 0)
(declare-sort var1580 0)
(declare-sort var675 0)
(declare-sort var474 0)
(declare-sort var2488 0)
(declare-sort var3126 0)
(declare-sort var3769 0)
(declare-sort var3097 0)
(declare-sort var2066 0)
(declare-sort var2119 0)
(declare-sort var1653 0)
(declare-sort var2912 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1580_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var121) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var675-init () var675)
(declare-fun <init>/-1862704206 (var675 String) void)
(declare-fun var474-init () var474)
(declare-fun start/-456130081 (var121) Int)
(declare-fun <init>/593337323 (var474 Int) void)
(declare-fun format/215566421 (var2488 var474) String)
(declare-fun cast-from-var675-to-var2488 (var675) var2488)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var121) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var3769_isDebugEnabled/-823448366 (var3769) Bool)
(declare-fun cast-from-var3126-to-var3769 (var3126) var3769)
(declare-fun request/-456130081 (var121) var3097)
(declare-fun append/-1031950772 (String var2066) String)
(declare-fun cast-from-var3097-to-var2066 (var3097) var2066)
(declare-fun channel/-456130081 (var121) var2119)
(declare-fun var2912_getLocalAddress/2019899378 (var2912) var1653)
(declare-fun cast-from-var2119-to-var2912 (var2119) var2912)
(declare-fun cast-from-var1653-to-var2066 (var1653) var2066)
(declare-fun var2119_getRemoteAddress/1597111645 (var2119) var1653)
(declare-const null-var121 var121)
(declare-const null-Bool Bool)
(declare-const var121-logger var3126)
(declare-const var2347 var121) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var2347 null-var121)))
(declare-const var989 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var989 null-Bool)))
(define-const var700 Int var1580_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var785 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var785)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var785!1 String)
(assert (= var785!1 ""))
(define-const var373 Int (sent/-456130081 var2347)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var806 Int (ite (> var373 0) 1 (ite (< var373 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var1583 Int (cast-from-Int-to-Int var806)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var1583 0)) ; Cond: $i20 <= 0 
(define-const var1908 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var1546 String (append/672562846 var785!1 var1908)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var785!2 String)
(assert (= var785!2 (str.++ var785!1 var1908)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (= (ite var989 1 0) 0)) ; Cond: z0 == 0 
(define-const var3160 String "") ; Statement: $r40 = "" 
(assert true) ; Non Conditional
(assert true)
(define-const var1961 String (append/672562846 var1546 var3160)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var1546!1 String)
(assert (= var1546!1 (str.++ var1546 var3160)))
(assert true)
(define-const var99 String (append/672562846 var1961 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var1961!1 String)
(assert (= var1961!1 (str.++ var1961 ". start time: ")))
(define-const var2146 var675 var675-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var2146 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var2146!1 var675)
(declare-const var3141 String)
(define-const var1958 var474 var474-init) ; Statement: $r45 = new java.util.Date 
(define-const var3881 Int (start/-456130081 var2347)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var1958 var3881)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var1958!1 var474)
(declare-const var3881!1 Int)
(assert true)
(define-const var1223 String (format/215566421 (cast-from-var675-to-var2488 var2146!1) var1958!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var530 String (append/672562846 var99 var1223)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var99!1 String)
(assert (= var99!1 (str.++ var99 var1223)))
(assert true)
(define-const var3717 String (append/672562846 var530 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var530!1 String)
(assert (= var530!1 (str.++ var530 ", end time: ")))
(define-const var2386 var675 var675-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var2386 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var2386!1 var675)
(declare-const var3141!1 String)
(define-const var1576 var474 var474-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var1576 var700)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var1576!1 var474)
(declare-const var700!1 Int)
(assert true)
(define-const var3343 String (format/215566421 (cast-from-var675-to-var2488 var2386!1) var1576!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var2734 String (append/672562846 var3717 var3343)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3717!1 String)
(assert (= var3717!1 (str.++ var3717 var3343)))
(assert true)
(define-const var861 String (append/672562846 var2734 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var2734!1 String)
(assert (= var2734!1 (str.++ var2734 ",")))
(define-const var3610 Int (sent/-456130081 var2347)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var3650 Int (ite (> var3610 0) 1 (ite (< var3610 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var870 Int (cast-from-Int-to-Int var3650)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (<= var870 0)) ; Cond: $i22 <= 0 
(define-const var3773 String String-init) ; Statement: $r49 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3773)) ; Statement: specialinvoke $r49.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3773!1 String)
(assert (= var3773!1 ""))
(assert true)
(define-const var1721 String (append/672562846 var3773!1 " elapsed: ")) ; Statement: $r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ") 
(declare-const var3773!2 String)
(assert (= var3773!2 (str.++ var3773!1 " elapsed: ")))
(define-const var1040 Int (start/-456130081 var2347)) ; Statement: $l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var2656 Int (- var700!1 var1040)) ; Statement: $l7 = l0 - $l6 
(assert true)
(define-const var2834 String (append/-901862667 var1721 var2656)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var1721!1 String)
(assert (str.prefixof var1721 var1721!1))
(assert true)
(define-const var3428 String (toString/-2075883882 var2834)) ; Statement: $r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var408 String (append/672562846 var861 var3428)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var861!1 String)
(assert (= var861!1 (str.++ var861 var3428)))
(assert true)
(define-const var905 String (append/672562846 var408 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var408!1 String)
(assert (= var408!1 (str.++ var408 " ms, timeout: ")))
(define-const var3248 Int (timeout/-456130081 var2347)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var3038 String (append/-1001720160 var905 var3248)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var905!1 String)
(assert (str.prefixof var905 var905!1))
(assert true)
(define-const var1807 String (append/672562846 var3038 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var3038!1 String)
(assert (= var3038!1 (str.++ var3038 " ms, request: ")))
(define-const var3366 var3126 var121-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var843 Bool (var3769_isDebugEnabled/-823448366 (cast-from-var3126-to-var3769 var3366))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (not (= (ite var843 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2526 var3097 (request/-456130081 var2347)) ; Statement: $r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
 ; Statement: goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)] 
(assert true) ; Non Conditional
(assert true)
(define-const var48 String (append/-1031950772 var1807 (cast-from-var3097-to-var2066 var2526))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var1807!1 String)
(assert (str.prefixof var1807 var1807!1))
(assert true)
(define-const var3686 String (append/672562846 var48 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var48!1 String)
(assert (= var48!1 (str.++ var48 ", channel: ")))
(define-const var2148 var2119 (channel/-456130081 var2347)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var912 var1653 (var2912_getLocalAddress/2019899378 (cast-from-var2119-to-var2912 var2148))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3212 String (append/-1031950772 var3686 (cast-from-var1653-to-var2066 var912))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var3686!1 String)
(assert (str.prefixof var3686 var3686!1))
(assert true)
(define-const var3219 String (append/672562846 var3212 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3212!1 String)
(assert (= var3212!1 (str.++ var3212 " -> ")))
(define-const var3170 var2119 (channel/-456130081 var2347)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var825 var1653 (var2119_getRemoteAddress/1597111645 var3170)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var292 String (append/-1031950772 var3219 (cast-from-var1653-to-var2066 var825))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var3219!1 String)
(assert (str.prefixof var3219 var3219!1))
(assert true)
(define-const var1790 String (toString/-2075883882 var292)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var1580_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var675-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var474-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var675-to-var2488=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var3769_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var3126-to-var3769=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3097-to-var2066=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var2912_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var2119-to-var2912=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var1653-to-var2066=([java.net.InetSocketAddress], java.lang.Object), var2119_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var121=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var2347=r0, var989=z0, var1580=java.lang.System, var700=l0, var785=$r43, var373=$l1, var806=$b2, var1583=$i20, var1908=$r39, var1546=$r1, var3160=$r40, var1961=$r2, var99=$r6, var675=java.text.SimpleDateFormat, var2146=$r44, var3141="yyyy-MM-dd HH:mm:ss.SSS", var474=java.util.Date, var1958=$r45, var3881=$l3, var2488=java.text.DateFormat, var1223=$r5, var530=$r7, var3717=$r11, var2386=$r46, var1576=$r47, var3343=$r10, var2734=$r12, var861=$r16, var3610=$l4, var3650=$b5, var870=$i22, var3773=$r49, var1721=$r14, var1040=$l6, var2656=$l7, var2834=$r15, var3428=$r41, var408=$r17, var905=$r18, var3248=$i8, var3038=$r19, var1807=$r22, var3126=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3366=$r20, var3769=org.apache.dubbo.common.logger.Logger, var843=$z1, var3097=org.apache.dubbo.remoting.exchange.Request, var2526=$r42, var2066=java.lang.Object, var48=$r23, var3686=$r26, var2119=org.apache.dubbo.remoting.Channel, var2148=$r24, var1653=java.net.InetSocketAddress, var2912=org.apache.dubbo.remoting.Endpoint, var912=$r25, var3212=$r27, var3219=$r30, var3170=$r28, var825=$r29, var292=$r31, var1790=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var121, r0=var2347, z0=var989, java.lang.System=var1580, l0=var700, $r43=var785, $l1=var373, $b2=var806, $i20=var1583, $r39=var1908, $r1=var1546, $r40=var3160, $r2=var1961, $r6=var99, java.text.SimpleDateFormat=var675, $r44=var2146, "yyyy-MM-dd HH:mm:ss.SSS"=var3141, java.util.Date=var474, $r45=var1958, $l3=var3881, java.text.DateFormat=var2488, $r5=var1223, $r7=var530, $r11=var3717, $r46=var2386, $r47=var1576, $r10=var3343, $r12=var2734, $r16=var861, $l4=var3610, $b5=var3650, $i22=var870, $r49=var3773, $r14=var1721, $l6=var1040, $l7=var2656, $r15=var2834, $r41=var3428, $r17=var408, $r18=var905, $i8=var3248, $r19=var3038, $r22=var1807, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3126, $r20=var3366, org.apache.dubbo.common.logger.Logger=var3769, $z1=var843, org.apache.dubbo.remoting.exchange.Request=var3097, $r42=var2526, java.lang.Object=var2066, $r23=var48, $r26=var3686, org.apache.dubbo.remoting.Channel=var2119, $r24=var2148, java.net.InetSocketAddress=var1653, org.apache.dubbo.remoting.Endpoint=var2912, $r25=var912, $r27=var3212, $r30=var3219, $r28=var3170, $r29=var825, $r31=var292, $r32=var1790}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 13,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = "";	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r49 = new java.lang.StringBuilder;	specialinvoke $r49.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ");	$l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l7 = l0 - $l6;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)];	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9