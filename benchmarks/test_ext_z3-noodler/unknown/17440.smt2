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

(declare-sort var424 0)
(declare-sort var1636 0)
(declare-sort var2169 0)
(declare-sort var1682 0)
(declare-sort var3714 0)
(declare-sort var39 0)
(declare-sort var3551 0)
(declare-sort var64 0)
(declare-sort var3973 0)
(declare-sort var1858 0)
(declare-sort var1193 0)
(declare-sort var2163 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1636_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var424) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2169-init () var2169)
(declare-fun <init>/-1862704206 (var2169 String) void)
(declare-fun var1682-init () var1682)
(declare-fun start/-456130081 (var424) Int)
(declare-fun <init>/593337323 (var1682 Int) void)
(declare-fun format/215566421 (var3714 var1682) String)
(declare-fun cast-from-var2169-to-var3714 (var2169) var3714)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var424) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var3551_isDebugEnabled/-823448366 (var3551) Bool)
(declare-fun cast-from-var39-to-var3551 (var39) var3551)
(declare-fun request/-456130081 (var424) var64)
(declare-fun copyWithoutData/-674215476 (var64) var64)
(declare-fun append/-1031950772 (String var3973) String)
(declare-fun cast-from-var64-to-var3973 (var64) var3973)
(declare-fun channel/-456130081 (var424) var1858)
(declare-fun var2163_getLocalAddress/2019899378 (var2163) var1193)
(declare-fun cast-from-var1858-to-var2163 (var1858) var2163)
(declare-fun cast-from-var1193-to-var3973 (var1193) var3973)
(declare-fun var1858_getRemoteAddress/1597111645 (var1858) var1193)
(declare-const null-var424 var424)
(declare-const null-Bool Bool)
(declare-const var424-logger var39)
(declare-const var2658 var424) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var2658 null-var424)))
(declare-const var3599 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var3599 null-Bool)))
(define-const var1825 Int var1636_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var335 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var335)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var335!1 String)
(assert (= var335!1 ""))
(define-const var3509 Int (sent/-456130081 var2658)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var3453 Int (ite (> var3509 0) 1 (ite (< var3509 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var1818 Int (cast-from-Int-to-Int var3453)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var1818 0)) ; Cond: $i20 <= 0 
(define-const var1403 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var1705 String (append/672562846 var335!1 var1403)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var335!2 String)
(assert (= var335!2 (str.++ var335!1 var1403)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (= (ite var3599 1 0) 0)) ; Cond: z0 == 0 
(define-const var3996 String "") ; Statement: $r40 = "" 
(assert true) ; Non Conditional
(assert true)
(define-const var3058 String (append/672562846 var1705 var3996)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var1705!1 String)
(assert (= var1705!1 (str.++ var1705 var3996)))
(assert true)
(define-const var730 String (append/672562846 var3058 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var3058!1 String)
(assert (= var3058!1 (str.++ var3058 ". start time: ")))
(define-const var2683 var2169 var2169-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var2683 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var2683!1 var2169)
(declare-const var7 String)
(define-const var2193 var1682 var1682-init) ; Statement: $r45 = new java.util.Date 
(define-const var820 Int (start/-456130081 var2658)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var2193 var820)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var2193!1 var1682)
(declare-const var820!1 Int)
(assert true)
(define-const var436 String (format/215566421 (cast-from-var2169-to-var3714 var2683!1) var2193!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var1473 String (append/672562846 var730 var436)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var730!1 String)
(assert (= var730!1 (str.++ var730 var436)))
(assert true)
(define-const var2018 String (append/672562846 var1473 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var1473!1 String)
(assert (= var1473!1 (str.++ var1473 ", end time: ")))
(define-const var1400 var2169 var2169-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var1400 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var1400!1 var2169)
(declare-const var7!1 String)
(define-const var123 var1682 var1682-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var123 var1825)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var123!1 var1682)
(declare-const var1825!1 Int)
(assert true)
(define-const var2436 String (format/215566421 (cast-from-var2169-to-var3714 var1400!1) var123!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var3202 String (append/672562846 var2018 var2436)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var2018!1 String)
(assert (= var2018!1 (str.++ var2018 var2436)))
(assert true)
(define-const var982 String (append/672562846 var3202 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var3202!1 String)
(assert (= var3202!1 (str.++ var3202 ",")))
(define-const var2269 Int (sent/-456130081 var2658)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var883 Int (ite (> var2269 0) 1 (ite (< var2269 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var2567 Int (cast-from-Int-to-Int var883)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (not (<= var2567 0))) ; Negate: Cond: $i22 <= 0  
(define-const var3615 String String-init) ; Statement: $r48 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3615)) ; Statement: specialinvoke $r48.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3615!1 String)
(assert (= var3615!1 ""))
(assert true)
(define-const var3095 String (append/672562846 var3615!1 " client elapsed: ")) ; Statement: $r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ") 
(declare-const var3615!2 String)
(assert (= var3615!2 (str.++ var3615!1 " client elapsed: ")))
(define-const var1579 Int (sent/-456130081 var2658)) ; Statement: $l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var73 Int (start/-456130081 var2658)) ; Statement: $l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var2469 Int (- var1579 var73)) ; Statement: $l11 = $l10 - $l9 
(assert true)
(define-const var1519 String (append/-901862667 var3095 var2469)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11) 
(declare-const var3095!1 String)
(assert (str.prefixof var3095 var3095!1))
(assert true)
(define-const var1092 String (append/672562846 var1519 " ms, server elapsed: ")) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ") 
(declare-const var1519!1 String)
(assert (= var1519!1 (str.++ var1519 " ms, server elapsed: ")))
(define-const var334 Int (sent/-456130081 var2658)) ; Statement: $l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var3141 Int (- var1825!1 var334)) ; Statement: $l13 = l0 - $l12 
(assert true)
(define-const var66 String (append/-901862667 var1092 var3141)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13) 
(declare-const var1092!1 String)
(assert (str.prefixof var1092 var1092!1))
(assert true)
(define-const var3940 String (toString/-2075883882 var66)) ; Statement: $r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)] 
(assert true) ; Non Conditional
(assert true)
(define-const var3246 String (append/672562846 var982 var3940)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var982!1 String)
(assert (= var982!1 (str.++ var982 var3940)))
(assert true)
(define-const var476 String (append/672562846 var3246 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var3246!1 String)
(assert (= var3246!1 (str.++ var3246 " ms, timeout: ")))
(define-const var1415 Int (timeout/-456130081 var2658)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var2053 String (append/-1001720160 var476 var1415)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var476!1 String)
(assert (str.prefixof var476 var476!1))
(assert true)
(define-const var227 String (append/672562846 var2053 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var2053!1 String)
(assert (= var2053!1 (str.++ var2053 " ms, request: ")))
(define-const var3905 var39 var424-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3669 Bool (var3551_isDebugEnabled/-823448366 (cast-from-var39-to-var3551 var3905))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (= (ite var3669 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3124 var64 (request/-456130081 var2658)) ; Statement: $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert true)
(define-const var1037 var64 (copyWithoutData/-674215476 var3124)) ; Statement: $r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3448 String (append/-1031950772 var227 (cast-from-var64-to-var3973 var1037))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var227!1 String)
(assert (str.prefixof var227 var227!1))
(assert true)
(define-const var1540 String (append/672562846 var3448 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var3448!1 String)
(assert (= var3448!1 (str.++ var3448 ", channel: ")))
(define-const var538 var1858 (channel/-456130081 var2658)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3223 var1193 (var2163_getLocalAddress/2019899378 (cast-from-var1858-to-var2163 var538))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2081 String (append/-1031950772 var1540 (cast-from-var1193-to-var3973 var3223))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var1540!1 String)
(assert (str.prefixof var1540 var1540!1))
(assert true)
(define-const var2669 String (append/672562846 var2081 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2081!1 String)
(assert (= var2081!1 (str.++ var2081 " -> ")))
(define-const var3352 var1858 (channel/-456130081 var2658)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3584 var1193 (var1858_getRemoteAddress/1597111645 var3352)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1898 String (append/-1031950772 var2669 (cast-from-var1193-to-var3973 var3584))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2669!1 String)
(assert (str.prefixof var2669 var2669!1))
(assert true)
(define-const var189 String (toString/-2075883882 var1898)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var1636_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2169-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var1682-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var2169-to-var3714=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var3551_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var39-to-var3551=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), copyWithoutData/-674215476=([org.apache.dubbo.remoting.exchange.Request], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var64-to-var3973=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var2163_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var1858-to-var2163=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var1193-to-var3973=([java.net.InetSocketAddress], java.lang.Object), var1858_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var424=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var2658=r0, var3599=z0, var1636=java.lang.System, var1825=l0, var335=$r43, var3509=$l1, var3453=$b2, var1818=$i20, var1403=$r39, var1705=$r1, var3996=$r40, var3058=$r2, var730=$r6, var2169=java.text.SimpleDateFormat, var2683=$r44, var7="yyyy-MM-dd HH:mm:ss.SSS", var1682=java.util.Date, var2193=$r45, var820=$l3, var3714=java.text.DateFormat, var436=$r5, var1473=$r7, var2018=$r11, var1400=$r46, var123=$r47, var2436=$r10, var3202=$r12, var982=$r16, var2269=$l4, var883=$b5, var2567=$i22, var3615=$r48, var3095=$r34, var1579=$l10, var73=$l9, var2469=$l11, var1519=$r35, var1092=$r36, var334=$l12, var3141=$l13, var66=$r37, var3940=$r41, var3246=$r17, var476=$r18, var1415=$i8, var2053=$r19, var227=$r22, var39=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3905=$r20, var3551=org.apache.dubbo.common.logger.Logger, var3669=$z1, var64=org.apache.dubbo.remoting.exchange.Request, var3124=$r21, var1037=$r42, var3973=java.lang.Object, var3448=$r23, var1540=$r26, var1858=org.apache.dubbo.remoting.Channel, var538=$r24, var1193=java.net.InetSocketAddress, var2163=org.apache.dubbo.remoting.Endpoint, var3223=$r25, var2081=$r27, var2669=$r30, var3352=$r28, var3584=$r29, var1898=$r31, var189=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var424, r0=var2658, z0=var3599, java.lang.System=var1636, l0=var1825, $r43=var335, $l1=var3509, $b2=var3453, $i20=var1818, $r39=var1403, $r1=var1705, $r40=var3996, $r2=var3058, $r6=var730, java.text.SimpleDateFormat=var2169, $r44=var2683, "yyyy-MM-dd HH:mm:ss.SSS"=var7, java.util.Date=var1682, $r45=var2193, $l3=var820, java.text.DateFormat=var3714, $r5=var436, $r7=var1473, $r11=var2018, $r46=var1400, $r47=var123, $r10=var2436, $r12=var3202, $r16=var982, $l4=var2269, $b5=var883, $i22=var2567, $r48=var3615, $r34=var3095, $l10=var1579, $l9=var73, $l11=var2469, $r35=var1519, $r36=var1092, $l12=var334, $l13=var3141, $r37=var66, $r41=var3940, $r17=var3246, $r18=var476, $i8=var1415, $r19=var2053, $r22=var227, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var39, $r20=var3905, org.apache.dubbo.common.logger.Logger=var3551, $z1=var3669, org.apache.dubbo.remoting.exchange.Request=var64, $r21=var3124, $r42=var1037, java.lang.Object=var3973, $r23=var3448, $r26=var1540, org.apache.dubbo.remoting.Channel=var1858, $r24=var538, java.net.InetSocketAddress=var1193, org.apache.dubbo.remoting.Endpoint=var2163, $r25=var3223, $r27=var2081, $r30=var2669, $r28=var3352, $r29=var3584, $r31=var1898, $r32=var189}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 14,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = "";	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r48 = new java.lang.StringBuilder;	specialinvoke $r48.<java.lang.StringBuilder: void <init>()>();	$r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ");	$l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l11 = $l10 - $l9;	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11);	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ");	$l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l13 = l0 - $l12;	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13);	$r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)];	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9