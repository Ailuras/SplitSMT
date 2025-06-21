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

(declare-sort var1614 0)
(declare-sort var1284 0)
(declare-sort var1639 0)
(declare-sort var3394 0)
(declare-sort var3934 0)
(declare-sort var2254 0)
(declare-sort var1705 0)
(declare-sort var325 0)
(declare-sort var270 0)
(declare-sort var2339 0)
(declare-sort var1516 0)
(declare-sort var2501 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1284_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var1614) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1639-init () var1639)
(declare-fun <init>/-1862704206 (var1639 String) void)
(declare-fun var3394-init () var3394)
(declare-fun start/-456130081 (var1614) Int)
(declare-fun <init>/593337323 (var3394 Int) void)
(declare-fun format/215566421 (var3934 var3394) String)
(declare-fun cast-from-var1639-to-var3934 (var1639) var3934)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var1614) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var1705_isDebugEnabled/-823448366 (var1705) Bool)
(declare-fun cast-from-var2254-to-var1705 (var2254) var1705)
(declare-fun request/-456130081 (var1614) var325)
(declare-fun append/-1031950772 (String var270) String)
(declare-fun cast-from-var325-to-var270 (var325) var270)
(declare-fun channel/-456130081 (var1614) var2339)
(declare-fun var2501_getLocalAddress/2019899378 (var2501) var1516)
(declare-fun cast-from-var2339-to-var2501 (var2339) var2501)
(declare-fun cast-from-var1516-to-var270 (var1516) var270)
(declare-fun var2339_getRemoteAddress/1597111645 (var2339) var1516)
(declare-const null-var1614 var1614)
(declare-const null-Bool Bool)
(declare-const var1614-logger var2254)
(declare-const var1163 var1614) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var1163 null-var1614)))
(declare-const var79 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var79 null-Bool)))
(define-const var59 Int var1284_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var1919 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1919)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1919!1 String)
(assert (= var1919!1 ""))
(define-const var2911 Int (sent/-456130081 var1163)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var719 Int (ite (> var2911 0) 1 (ite (< var2911 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var1489 Int (cast-from-Int-to-Int var719)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var1489 0)) ; Cond: $i20 <= 0 
(define-const var297 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var3059 String (append/672562846 var1919!1 var297)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var1919!2 String)
(assert (= var1919!2 (str.++ var1919!1 var297)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (not (= (ite var79 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var666 String " by scan timer") ; Statement: $r40 = " by scan timer" 
 ; Statement: goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1909 String (append/672562846 var3059 var666)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var3059!1 String)
(assert (= var3059!1 (str.++ var3059 var666)))
(assert true)
(define-const var2406 String (append/672562846 var1909 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var1909!1 String)
(assert (= var1909!1 (str.++ var1909 ". start time: ")))
(define-const var1638 var1639 var1639-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var1638 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var1638!1 var1639)
(declare-const var2494 String)
(define-const var2224 var3394 var3394-init) ; Statement: $r45 = new java.util.Date 
(define-const var3168 Int (start/-456130081 var1163)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var2224 var3168)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var2224!1 var3394)
(declare-const var3168!1 Int)
(assert true)
(define-const var630 String (format/215566421 (cast-from-var1639-to-var3934 var1638!1) var2224!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var3811 String (append/672562846 var2406 var630)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2406!1 String)
(assert (= var2406!1 (str.++ var2406 var630)))
(assert true)
(define-const var2393 String (append/672562846 var3811 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var3811!1 String)
(assert (= var3811!1 (str.++ var3811 ", end time: ")))
(define-const var750 var1639 var1639-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var750 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var750!1 var1639)
(declare-const var2494!1 String)
(define-const var1737 var3394 var3394-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var1737 var59)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var1737!1 var3394)
(declare-const var59!1 Int)
(assert true)
(define-const var2358 String (format/215566421 (cast-from-var1639-to-var3934 var750!1) var1737!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var225 String (append/672562846 var2393 var2358)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var2393!1 String)
(assert (= var2393!1 (str.++ var2393 var2358)))
(assert true)
(define-const var2136 String (append/672562846 var225 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var225!1 String)
(assert (= var225!1 (str.++ var225 ",")))
(define-const var618 Int (sent/-456130081 var1163)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var3408 Int (ite (> var618 0) 1 (ite (< var618 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var512 Int (cast-from-Int-to-Int var3408)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (not (<= var512 0))) ; Negate: Cond: $i22 <= 0  
(define-const var561 String String-init) ; Statement: $r48 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var561)) ; Statement: specialinvoke $r48.<java.lang.StringBuilder: void <init>()>() 
(declare-const var561!1 String)
(assert (= var561!1 ""))
(assert true)
(define-const var3220 String (append/672562846 var561!1 " client elapsed: ")) ; Statement: $r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ") 
(declare-const var561!2 String)
(assert (= var561!2 (str.++ var561!1 " client elapsed: ")))
(define-const var1039 Int (sent/-456130081 var1163)) ; Statement: $l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var799 Int (start/-456130081 var1163)) ; Statement: $l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var1183 Int (- var1039 var799)) ; Statement: $l11 = $l10 - $l9 
(assert true)
(define-const var3501 String (append/-901862667 var3220 var1183)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11) 
(declare-const var3220!1 String)
(assert (str.prefixof var3220 var3220!1))
(assert true)
(define-const var2289 String (append/672562846 var3501 " ms, server elapsed: ")) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ") 
(declare-const var3501!1 String)
(assert (= var3501!1 (str.++ var3501 " ms, server elapsed: ")))
(define-const var2548 Int (sent/-456130081 var1163)) ; Statement: $l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var2076 Int (- var59!1 var2548)) ; Statement: $l13 = l0 - $l12 
(assert true)
(define-const var2915 String (append/-901862667 var2289 var2076)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13) 
(declare-const var2289!1 String)
(assert (str.prefixof var2289 var2289!1))
(assert true)
(define-const var3181 String (toString/-2075883882 var2915)) ; Statement: $r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2106 String (append/672562846 var2136 var3181)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var2136!1 String)
(assert (= var2136!1 (str.++ var2136 var3181)))
(assert true)
(define-const var1327 String (append/672562846 var2106 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var2106!1 String)
(assert (= var2106!1 (str.++ var2106 " ms, timeout: ")))
(define-const var1690 Int (timeout/-456130081 var1163)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var625 String (append/-1001720160 var1327 var1690)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var1327!1 String)
(assert (str.prefixof var1327 var1327!1))
(assert true)
(define-const var1240 String (append/672562846 var625 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var625!1 String)
(assert (= var625!1 (str.++ var625 " ms, request: ")))
(define-const var3293 var2254 var1614-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1714 Bool (var1705_isDebugEnabled/-823448366 (cast-from-var2254-to-var1705 var3293))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (not (= (ite var1714 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var691 var325 (request/-456130081 var1163)) ; Statement: $r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
 ; Statement: goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2173 String (append/-1031950772 var1240 (cast-from-var325-to-var270 var691))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var1240!1 String)
(assert (str.prefixof var1240 var1240!1))
(assert true)
(define-const var773 String (append/672562846 var2173 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var2173!1 String)
(assert (= var2173!1 (str.++ var2173 ", channel: ")))
(define-const var2209 var2339 (channel/-456130081 var1163)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3350 var1516 (var2501_getLocalAddress/2019899378 (cast-from-var2339-to-var2501 var2209))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3465 String (append/-1031950772 var773 (cast-from-var1516-to-var270 var3350))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var773!1 String)
(assert (str.prefixof var773 var773!1))
(assert true)
(define-const var2948 String (append/672562846 var3465 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3465!1 String)
(assert (= var3465!1 (str.++ var3465 " -> ")))
(define-const var3529 var2339 (channel/-456130081 var1163)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var850 var1516 (var2339_getRemoteAddress/1597111645 var3529)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var2552 String (append/-1031950772 var2948 (cast-from-var1516-to-var270 var850))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2948!1 String)
(assert (str.prefixof var2948 var2948!1))
(assert true)
(define-const var3106 String (toString/-2075883882 var2552)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var1284_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1639-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var3394-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var1639-to-var3934=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var1705_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var2254-to-var1705=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var325-to-var270=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var2501_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var2339-to-var2501=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var1516-to-var270=([java.net.InetSocketAddress], java.lang.Object), var2339_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var1614=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var1163=r0, var79=z0, var1284=java.lang.System, var59=l0, var1919=$r43, var2911=$l1, var719=$b2, var1489=$i20, var297=$r39, var3059=$r1, var666=$r40, var1909=$r2, var2406=$r6, var1639=java.text.SimpleDateFormat, var1638=$r44, var2494="yyyy-MM-dd HH:mm:ss.SSS", var3394=java.util.Date, var2224=$r45, var3168=$l3, var3934=java.text.DateFormat, var630=$r5, var3811=$r7, var2393=$r11, var750=$r46, var1737=$r47, var2358=$r10, var225=$r12, var2136=$r16, var618=$l4, var3408=$b5, var512=$i22, var561=$r48, var3220=$r34, var1039=$l10, var799=$l9, var1183=$l11, var3501=$r35, var2289=$r36, var2548=$l12, var2076=$l13, var2915=$r37, var3181=$r41, var2106=$r17, var1327=$r18, var1690=$i8, var625=$r19, var1240=$r22, var2254=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3293=$r20, var1705=org.apache.dubbo.common.logger.Logger, var1714=$z1, var325=org.apache.dubbo.remoting.exchange.Request, var691=$r42, var270=java.lang.Object, var2173=$r23, var773=$r26, var2339=org.apache.dubbo.remoting.Channel, var2209=$r24, var1516=java.net.InetSocketAddress, var2501=org.apache.dubbo.remoting.Endpoint, var3350=$r25, var3465=$r27, var2948=$r30, var3529=$r28, var850=$r29, var2552=$r31, var3106=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var1614, r0=var1163, z0=var79, java.lang.System=var1284, l0=var59, $r43=var1919, $l1=var2911, $b2=var719, $i20=var1489, $r39=var297, $r1=var3059, $r40=var666, $r2=var1909, $r6=var2406, java.text.SimpleDateFormat=var1639, $r44=var1638, "yyyy-MM-dd HH:mm:ss.SSS"=var2494, java.util.Date=var3394, $r45=var2224, $l3=var3168, java.text.DateFormat=var3934, $r5=var630, $r7=var3811, $r11=var2393, $r46=var750, $r47=var1737, $r10=var2358, $r12=var225, $r16=var2136, $l4=var618, $b5=var3408, $i22=var512, $r48=var561, $r34=var3220, $l10=var1039, $l9=var799, $l11=var1183, $r35=var3501, $r36=var2289, $l12=var2548, $l13=var2076, $r37=var2915, $r41=var3181, $r17=var2106, $r18=var1327, $i8=var1690, $r19=var625, $r22=var1240, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2254, $r20=var3293, org.apache.dubbo.common.logger.Logger=var1705, $z1=var1714, org.apache.dubbo.remoting.exchange.Request=var325, $r42=var691, java.lang.Object=var270, $r23=var2173, $r26=var773, org.apache.dubbo.remoting.Channel=var2339, $r24=var2209, java.net.InetSocketAddress=var1516, org.apache.dubbo.remoting.Endpoint=var2501, $r25=var3350, $r27=var3465, $r30=var2948, $r28=var3529, $r29=var850, $r31=var2552, $r32=var3106}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 14,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = " by scan timer";	goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)];	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r48 = new java.lang.StringBuilder;	specialinvoke $r48.<java.lang.StringBuilder: void <init>()>();	$r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ");	$l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l11 = $l10 - $l9;	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11);	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ");	$l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l13 = l0 - $l12;	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13);	$r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)];	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)];	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9