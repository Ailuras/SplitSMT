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

(declare-sort var87 0)
(declare-sort var887 0)
(declare-sort var1401 0)
(declare-sort var2998 0)
(declare-sort var3340 0)
(declare-sort var1555 0)
(declare-sort var477 0)
(declare-sort var1782 0)
(declare-sort var3981 0)
(declare-sort var1103 0)
(declare-sort var2271 0)
(declare-sort var1162 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var887_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var87) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1401-init () var1401)
(declare-fun <init>/-1862704206 (var1401 String) void)
(declare-fun var2998-init () var2998)
(declare-fun start/-456130081 (var87) Int)
(declare-fun <init>/593337323 (var2998 Int) void)
(declare-fun format/215566421 (var3340 var2998) String)
(declare-fun cast-from-var1401-to-var3340 (var1401) var3340)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var87) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var477_isDebugEnabled/-823448366 (var477) Bool)
(declare-fun cast-from-var1555-to-var477 (var1555) var477)
(declare-fun request/-456130081 (var87) var1782)
(declare-fun copyWithoutData/-674215476 (var1782) var1782)
(declare-fun append/-1031950772 (String var3981) String)
(declare-fun cast-from-var1782-to-var3981 (var1782) var3981)
(declare-fun channel/-456130081 (var87) var1103)
(declare-fun var1162_getLocalAddress/2019899378 (var1162) var2271)
(declare-fun cast-from-var1103-to-var1162 (var1103) var1162)
(declare-fun cast-from-var2271-to-var3981 (var2271) var3981)
(declare-fun var1103_getRemoteAddress/1597111645 (var1103) var2271)
(declare-const null-var87 var87)
(declare-const null-Bool Bool)
(declare-const var87-logger var1555)
(declare-const var269 var87) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var269 null-var87)))
(declare-const var2264 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var2264 null-Bool)))
(define-const var1358 Int var887_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var1171 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1171)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1171!1 String)
(assert (= var1171!1 ""))
(define-const var3223 Int (sent/-456130081 var269)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var3065 Int (ite (> var3223 0) 1 (ite (< var3223 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var989 Int (cast-from-Int-to-Int var3065)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var989 0)) ; Cond: $i20 <= 0 
(define-const var3174 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var3077 String (append/672562846 var1171!1 var3174)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var1171!2 String)
(assert (= var1171!2 (str.++ var1171!1 var3174)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (not (= (ite var2264 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var2279 String " by scan timer") ; Statement: $r40 = " by scan timer" 
 ; Statement: goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2629 String (append/672562846 var3077 var2279)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var3077!1 String)
(assert (= var3077!1 (str.++ var3077 var2279)))
(assert true)
(define-const var2638 String (append/672562846 var2629 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var2629!1 String)
(assert (= var2629!1 (str.++ var2629 ". start time: ")))
(define-const var1669 var1401 var1401-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var1669 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var1669!1 var1401)
(declare-const var2115 String)
(define-const var3716 var2998 var2998-init) ; Statement: $r45 = new java.util.Date 
(define-const var3188 Int (start/-456130081 var269)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var3716 var3188)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var3716!1 var2998)
(declare-const var3188!1 Int)
(assert true)
(define-const var3985 String (format/215566421 (cast-from-var1401-to-var3340 var1669!1) var3716!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var2586 String (append/672562846 var2638 var3985)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2638!1 String)
(assert (= var2638!1 (str.++ var2638 var3985)))
(assert true)
(define-const var3555 String (append/672562846 var2586 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var2586!1 String)
(assert (= var2586!1 (str.++ var2586 ", end time: ")))
(define-const var406 var1401 var1401-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var406 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var406!1 var1401)
(declare-const var2115!1 String)
(define-const var3436 var2998 var2998-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var3436 var1358)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var3436!1 var2998)
(declare-const var1358!1 Int)
(assert true)
(define-const var1330 String (format/215566421 (cast-from-var1401-to-var3340 var406!1) var3436!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var839 String (append/672562846 var3555 var1330)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3555!1 String)
(assert (= var3555!1 (str.++ var3555 var1330)))
(assert true)
(define-const var3371 String (append/672562846 var839 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var839!1 String)
(assert (= var839!1 (str.++ var839 ",")))
(define-const var3997 Int (sent/-456130081 var269)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var691 Int (ite (> var3997 0) 1 (ite (< var3997 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var1827 Int (cast-from-Int-to-Int var691)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (not (<= var1827 0))) ; Negate: Cond: $i22 <= 0  
(define-const var2708 String String-init) ; Statement: $r48 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2708)) ; Statement: specialinvoke $r48.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2708!1 String)
(assert (= var2708!1 ""))
(assert true)
(define-const var1754 String (append/672562846 var2708!1 " client elapsed: ")) ; Statement: $r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ") 
(declare-const var2708!2 String)
(assert (= var2708!2 (str.++ var2708!1 " client elapsed: ")))
(define-const var2635 Int (sent/-456130081 var269)) ; Statement: $l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var3596 Int (start/-456130081 var269)) ; Statement: $l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var2516 Int (- var2635 var3596)) ; Statement: $l11 = $l10 - $l9 
(assert true)
(define-const var659 String (append/-901862667 var1754 var2516)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11) 
(declare-const var1754!1 String)
(assert (str.prefixof var1754 var1754!1))
(assert true)
(define-const var2500 String (append/672562846 var659 " ms, server elapsed: ")) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ") 
(declare-const var659!1 String)
(assert (= var659!1 (str.++ var659 " ms, server elapsed: ")))
(define-const var2157 Int (sent/-456130081 var269)) ; Statement: $l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var635 Int (- var1358!1 var2157)) ; Statement: $l13 = l0 - $l12 
(assert true)
(define-const var1600 String (append/-901862667 var2500 var635)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13) 
(declare-const var2500!1 String)
(assert (str.prefixof var2500 var2500!1))
(assert true)
(define-const var812 String (toString/-2075883882 var1600)) ; Statement: $r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)] 
(assert true) ; Non Conditional
(assert true)
(define-const var541 String (append/672562846 var3371 var812)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var3371!1 String)
(assert (= var3371!1 (str.++ var3371 var812)))
(assert true)
(define-const var2953 String (append/672562846 var541 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var541!1 String)
(assert (= var541!1 (str.++ var541 " ms, timeout: ")))
(define-const var2071 Int (timeout/-456130081 var269)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var1359 String (append/-1001720160 var2953 var2071)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var2953!1 String)
(assert (str.prefixof var2953 var2953!1))
(assert true)
(define-const var359 String (append/672562846 var1359 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var1359!1 String)
(assert (= var1359!1 (str.++ var1359 " ms, request: ")))
(define-const var3592 var1555 var87-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var687 Bool (var477_isDebugEnabled/-823448366 (cast-from-var1555-to-var477 var3592))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (= (ite var687 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3408 var1782 (request/-456130081 var269)) ; Statement: $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert true)
(define-const var2018 var1782 (copyWithoutData/-674215476 var3408)) ; Statement: $r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var3836 String (append/-1031950772 var359 (cast-from-var1782-to-var3981 var2018))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var359!1 String)
(assert (str.prefixof var359 var359!1))
(assert true)
(define-const var453 String (append/672562846 var3836 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var3836!1 String)
(assert (= var3836!1 (str.++ var3836 ", channel: ")))
(define-const var824 var1103 (channel/-456130081 var269)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3489 var2271 (var1162_getLocalAddress/2019899378 (cast-from-var1103-to-var1162 var824))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var1413 String (append/-1031950772 var453 (cast-from-var2271-to-var3981 var3489))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var453!1 String)
(assert (str.prefixof var453 var453!1))
(assert true)
(define-const var1506 String (append/672562846 var1413 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var1413!1 String)
(assert (= var1413!1 (str.++ var1413 " -> ")))
(define-const var444 var1103 (channel/-456130081 var269)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var2298 var2271 (var1103_getRemoteAddress/1597111645 var444)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1461 String (append/-1031950772 var1506 (cast-from-var2271-to-var3981 var2298))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var1506!1 String)
(assert (str.prefixof var1506 var1506!1))
(assert true)
(define-const var965 String (toString/-2075883882 var1461)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var887_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1401-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var2998-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var1401-to-var3340=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var477_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1555-to-var477=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), copyWithoutData/-674215476=([org.apache.dubbo.remoting.exchange.Request], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1782-to-var3981=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var1162_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var1103-to-var1162=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var2271-to-var3981=([java.net.InetSocketAddress], java.lang.Object), var1103_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var87=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var269=r0, var2264=z0, var887=java.lang.System, var1358=l0, var1171=$r43, var3223=$l1, var3065=$b2, var989=$i20, var3174=$r39, var3077=$r1, var2279=$r40, var2629=$r2, var2638=$r6, var1401=java.text.SimpleDateFormat, var1669=$r44, var2115="yyyy-MM-dd HH:mm:ss.SSS", var2998=java.util.Date, var3716=$r45, var3188=$l3, var3340=java.text.DateFormat, var3985=$r5, var2586=$r7, var3555=$r11, var406=$r46, var3436=$r47, var1330=$r10, var839=$r12, var3371=$r16, var3997=$l4, var691=$b5, var1827=$i22, var2708=$r48, var1754=$r34, var2635=$l10, var3596=$l9, var2516=$l11, var659=$r35, var2500=$r36, var2157=$l12, var635=$l13, var1600=$r37, var812=$r41, var541=$r17, var2953=$r18, var2071=$i8, var1359=$r19, var359=$r22, var1555=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3592=$r20, var477=org.apache.dubbo.common.logger.Logger, var687=$z1, var1782=org.apache.dubbo.remoting.exchange.Request, var3408=$r21, var2018=$r42, var3981=java.lang.Object, var3836=$r23, var453=$r26, var1103=org.apache.dubbo.remoting.Channel, var824=$r24, var2271=java.net.InetSocketAddress, var1162=org.apache.dubbo.remoting.Endpoint, var3489=$r25, var1413=$r27, var1506=$r30, var444=$r28, var2298=$r29, var1461=$r31, var965=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var87, r0=var269, z0=var2264, java.lang.System=var887, l0=var1358, $r43=var1171, $l1=var3223, $b2=var3065, $i20=var989, $r39=var3174, $r1=var3077, $r40=var2279, $r2=var2629, $r6=var2638, java.text.SimpleDateFormat=var1401, $r44=var1669, "yyyy-MM-dd HH:mm:ss.SSS"=var2115, java.util.Date=var2998, $r45=var3716, $l3=var3188, java.text.DateFormat=var3340, $r5=var3985, $r7=var2586, $r11=var3555, $r46=var406, $r47=var3436, $r10=var1330, $r12=var839, $r16=var3371, $l4=var3997, $b5=var691, $i22=var1827, $r48=var2708, $r34=var1754, $l10=var2635, $l9=var3596, $l11=var2516, $r35=var659, $r36=var2500, $l12=var2157, $l13=var635, $r37=var1600, $r41=var812, $r17=var541, $r18=var2953, $i8=var2071, $r19=var1359, $r22=var359, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1555, $r20=var3592, org.apache.dubbo.common.logger.Logger=var477, $z1=var687, org.apache.dubbo.remoting.exchange.Request=var1782, $r21=var3408, $r42=var2018, java.lang.Object=var3981, $r23=var3836, $r26=var453, org.apache.dubbo.remoting.Channel=var1103, $r24=var824, java.net.InetSocketAddress=var2271, org.apache.dubbo.remoting.Endpoint=var1162, $r25=var3489, $r27=var1413, $r30=var1506, $r28=var444, $r29=var2298, $r31=var1461, $r32=var965}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 14,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = " by scan timer";	goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)];	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r48 = new java.lang.StringBuilder;	specialinvoke $r48.<java.lang.StringBuilder: void <init>()>();	$r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ");	$l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l11 = $l10 - $l9;	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11);	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ");	$l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l13 = l0 - $l12;	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13);	$r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)];	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9