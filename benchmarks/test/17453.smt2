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

(declare-sort var1677 0)
(declare-sort var1538 0)
(declare-sort var3788 0)
(declare-sort var164 0)
(declare-sort var595 0)
(declare-sort var567 0)
(declare-sort var3186 0)
(declare-sort var1806 0)
(declare-sort var3710 0)
(declare-sort var470 0)
(declare-sort var1928 0)
(declare-sort var229 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1538_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var1677) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3788-init () var3788)
(declare-fun <init>/-1862704206 (var3788 String) void)
(declare-fun var164-init () var164)
(declare-fun start/-456130081 (var1677) Int)
(declare-fun <init>/593337323 (var164 Int) void)
(declare-fun format/215566421 (var595 var164) String)
(declare-fun cast-from-var3788-to-var595 (var3788) var595)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var1677) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var3186_isDebugEnabled/-823448366 (var3186) Bool)
(declare-fun cast-from-var567-to-var3186 (var567) var3186)
(declare-fun request/-456130081 (var1677) var1806)
(declare-fun copyWithoutData/-674215476 (var1806) var1806)
(declare-fun append/-1031950772 (String var3710) String)
(declare-fun cast-from-var1806-to-var3710 (var1806) var3710)
(declare-fun channel/-456130081 (var1677) var470)
(declare-fun var229_getLocalAddress/2019899378 (var229) var1928)
(declare-fun cast-from-var470-to-var229 (var470) var229)
(declare-fun cast-from-var1928-to-var3710 (var1928) var3710)
(declare-fun var470_getRemoteAddress/1597111645 (var470) var1928)
(declare-const null-var1677 var1677)
(declare-const null-Bool Bool)
(declare-const var1677-logger var567)
(declare-const var1558 var1677) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var1558 null-var1677)))
(declare-const var2379 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var2379 null-Bool)))
(define-const var385 Int var1538_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var3905 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3905)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3905!1 String)
(assert (= var3905!1 ""))
(define-const var2245 Int (sent/-456130081 var1558)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var2325 Int (ite (> var2245 0) 1 (ite (< var2245 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var3975 Int (cast-from-Int-to-Int var2325)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var3975 0)) ; Cond: $i20 <= 0 
(define-const var2041 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var3291 String (append/672562846 var3905!1 var2041)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var3905!2 String)
(assert (= var3905!2 (str.++ var3905!1 var2041)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (= (ite var2379 1 0) 0)) ; Cond: z0 == 0 
(define-const var2156 String "") ; Statement: $r40 = "" 
(assert true) ; Non Conditional
(assert true)
(define-const var3028 String (append/672562846 var3291 var2156)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var3291!1 String)
(assert (= var3291!1 (str.++ var3291 var2156)))
(assert true)
(define-const var734 String (append/672562846 var3028 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var3028!1 String)
(assert (= var3028!1 (str.++ var3028 ". start time: ")))
(define-const var3207 var3788 var3788-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3207 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var3207!1 var3788)
(declare-const var2022 String)
(define-const var2030 var164 var164-init) ; Statement: $r45 = new java.util.Date 
(define-const var915 Int (start/-456130081 var1558)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var2030 var915)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var2030!1 var164)
(declare-const var915!1 Int)
(assert true)
(define-const var938 String (format/215566421 (cast-from-var3788-to-var595 var3207!1) var2030!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var1218 String (append/672562846 var734 var938)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var734!1 String)
(assert (= var734!1 (str.++ var734 var938)))
(assert true)
(define-const var2561 String (append/672562846 var1218 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var1218!1 String)
(assert (= var1218!1 (str.++ var1218 ", end time: ")))
(define-const var3296 var3788 var3788-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3296 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var3296!1 var3788)
(declare-const var2022!1 String)
(define-const var2851 var164 var164-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var2851 var385)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var2851!1 var164)
(declare-const var385!1 Int)
(assert true)
(define-const var292 String (format/215566421 (cast-from-var3788-to-var595 var3296!1) var2851!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var1849 String (append/672562846 var2561 var292)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var2561!1 String)
(assert (= var2561!1 (str.++ var2561 var292)))
(assert true)
(define-const var2053 String (append/672562846 var1849 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var1849!1 String)
(assert (= var1849!1 (str.++ var1849 ",")))
(define-const var3121 Int (sent/-456130081 var1558)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var467 Int (ite (> var3121 0) 1 (ite (< var3121 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var1169 Int (cast-from-Int-to-Int var467)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (<= var1169 0)) ; Cond: $i22 <= 0 
(define-const var2691 String String-init) ; Statement: $r49 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2691)) ; Statement: specialinvoke $r49.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2691!1 String)
(assert (= var2691!1 ""))
(assert true)
(define-const var3044 String (append/672562846 var2691!1 " elapsed: ")) ; Statement: $r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ") 
(declare-const var2691!2 String)
(assert (= var2691!2 (str.++ var2691!1 " elapsed: ")))
(define-const var888 Int (start/-456130081 var1558)) ; Statement: $l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var3553 Int (- var385!1 var888)) ; Statement: $l7 = l0 - $l6 
(assert true)
(define-const var29 String (append/-901862667 var3044 var3553)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var3044!1 String)
(assert (str.prefixof var3044 var3044!1))
(assert true)
(define-const var2406 String (toString/-2075883882 var29)) ; Statement: $r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var609 String (append/672562846 var2053 var2406)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var2053!1 String)
(assert (= var2053!1 (str.++ var2053 var2406)))
(assert true)
(define-const var3767 String (append/672562846 var609 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var609!1 String)
(assert (= var609!1 (str.++ var609 " ms, timeout: ")))
(define-const var1447 Int (timeout/-456130081 var1558)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var2495 String (append/-1001720160 var3767 var1447)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var3767!1 String)
(assert (str.prefixof var3767 var3767!1))
(assert true)
(define-const var1 String (append/672562846 var2495 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var2495!1 String)
(assert (= var2495!1 (str.++ var2495 " ms, request: ")))
(define-const var302 var567 var1677-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2746 Bool (var3186_isDebugEnabled/-823448366 (cast-from-var567-to-var3186 var302))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (= (ite var2746 1 0) 0)) ; Cond: $z1 == 0 
(define-const var130 var1806 (request/-456130081 var1558)) ; Statement: $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert true)
(define-const var3319 var1806 (copyWithoutData/-674215476 var130)) ; Statement: $r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var928 String (append/-1031950772 var1 (cast-from-var1806-to-var3710 var3319))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var1!1 String)
(assert (str.prefixof var1 var1!1))
(assert true)
(define-const var342 String (append/672562846 var928 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var928!1 String)
(assert (= var928!1 (str.++ var928 ", channel: ")))
(define-const var3315 var470 (channel/-456130081 var1558)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var1307 var1928 (var229_getLocalAddress/2019899378 (cast-from-var470-to-var229 var3315))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2003 String (append/-1031950772 var342 (cast-from-var1928-to-var3710 var1307))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var342!1 String)
(assert (str.prefixof var342 var342!1))
(assert true)
(define-const var1680 String (append/672562846 var2003 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2003!1 String)
(assert (= var2003!1 (str.++ var2003 " -> ")))
(define-const var2217 var470 (channel/-456130081 var1558)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3741 var1928 (var470_getRemoteAddress/1597111645 var2217)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var507 String (append/-1031950772 var1680 (cast-from-var1928-to-var3710 var3741))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var1680!1 String)
(assert (str.prefixof var1680 var1680!1))
(assert true)
(define-const var3532 String (toString/-2075883882 var507)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var1538_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3788-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var164-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var3788-to-var595=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var3186_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var567-to-var3186=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), copyWithoutData/-674215476=([org.apache.dubbo.remoting.exchange.Request], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1806-to-var3710=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var229_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var470-to-var229=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var1928-to-var3710=([java.net.InetSocketAddress], java.lang.Object), var470_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var1677=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var1558=r0, var2379=z0, var1538=java.lang.System, var385=l0, var3905=$r43, var2245=$l1, var2325=$b2, var3975=$i20, var2041=$r39, var3291=$r1, var2156=$r40, var3028=$r2, var734=$r6, var3788=java.text.SimpleDateFormat, var3207=$r44, var2022="yyyy-MM-dd HH:mm:ss.SSS", var164=java.util.Date, var2030=$r45, var915=$l3, var595=java.text.DateFormat, var938=$r5, var1218=$r7, var2561=$r11, var3296=$r46, var2851=$r47, var292=$r10, var1849=$r12, var2053=$r16, var3121=$l4, var467=$b5, var1169=$i22, var2691=$r49, var3044=$r14, var888=$l6, var3553=$l7, var29=$r15, var2406=$r41, var609=$r17, var3767=$r18, var1447=$i8, var2495=$r19, var1=$r22, var567=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var302=$r20, var3186=org.apache.dubbo.common.logger.Logger, var2746=$z1, var1806=org.apache.dubbo.remoting.exchange.Request, var130=$r21, var3319=$r42, var3710=java.lang.Object, var928=$r23, var342=$r26, var470=org.apache.dubbo.remoting.Channel, var3315=$r24, var1928=java.net.InetSocketAddress, var229=org.apache.dubbo.remoting.Endpoint, var1307=$r25, var2003=$r27, var1680=$r30, var2217=$r28, var3741=$r29, var507=$r31, var3532=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var1677, r0=var1558, z0=var2379, java.lang.System=var1538, l0=var385, $r43=var3905, $l1=var2245, $b2=var2325, $i20=var3975, $r39=var2041, $r1=var3291, $r40=var2156, $r2=var3028, $r6=var734, java.text.SimpleDateFormat=var3788, $r44=var3207, "yyyy-MM-dd HH:mm:ss.SSS"=var2022, java.util.Date=var164, $r45=var2030, $l3=var915, java.text.DateFormat=var595, $r5=var938, $r7=var1218, $r11=var2561, $r46=var3296, $r47=var2851, $r10=var292, $r12=var1849, $r16=var2053, $l4=var3121, $b5=var467, $i22=var1169, $r49=var2691, $r14=var3044, $l6=var888, $l7=var3553, $r15=var29, $r41=var2406, $r17=var609, $r18=var3767, $i8=var1447, $r19=var2495, $r22=var1, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var567, $r20=var302, org.apache.dubbo.common.logger.Logger=var3186, $z1=var2746, org.apache.dubbo.remoting.exchange.Request=var1806, $r21=var130, $r42=var3319, java.lang.Object=var3710, $r23=var928, $r26=var342, org.apache.dubbo.remoting.Channel=var470, $r24=var3315, java.net.InetSocketAddress=var1928, org.apache.dubbo.remoting.Endpoint=var229, $r25=var1307, $r27=var2003, $r30=var1680, $r28=var2217, $r29=var3741, $r31=var507, $r32=var3532}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 13,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = "";	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r49 = new java.lang.StringBuilder;	specialinvoke $r49.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ");	$l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l7 = l0 - $l6;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9