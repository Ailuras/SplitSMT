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

(declare-sort var1105 0)
(declare-sort var781 0)
(declare-sort var326 0)
(declare-sort var1122 0)
(declare-sort var1873 0)
(declare-sort var1162 0)
(declare-sort var3555 0)
(declare-sort var2648 0)
(declare-sort var2319 0)
(declare-sort var3344 0)
(declare-sort var521 0)
(declare-sort var3243 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var781_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var1105) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var326-init () var326)
(declare-fun <init>/-1862704206 (var326 String) void)
(declare-fun var1122-init () var1122)
(declare-fun start/-456130081 (var1105) Int)
(declare-fun <init>/593337323 (var1122 Int) void)
(declare-fun format/215566421 (var1873 var1122) String)
(declare-fun cast-from-var326-to-var1873 (var326) var1873)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var1105) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var3555_isDebugEnabled/-823448366 (var3555) Bool)
(declare-fun cast-from-var1162-to-var3555 (var1162) var3555)
(declare-fun request/-456130081 (var1105) var2648)
(declare-fun append/-1031950772 (String var2319) String)
(declare-fun cast-from-var2648-to-var2319 (var2648) var2319)
(declare-fun channel/-456130081 (var1105) var3344)
(declare-fun var3243_getLocalAddress/2019899378 (var3243) var521)
(declare-fun cast-from-var3344-to-var3243 (var3344) var3243)
(declare-fun cast-from-var521-to-var2319 (var521) var2319)
(declare-fun var3344_getRemoteAddress/1597111645 (var3344) var521)
(declare-const null-var1105 var1105)
(declare-const null-Bool Bool)
(declare-const var1105-logger var1162)
(declare-const var343 var1105) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var343 null-var1105)))
(declare-const var2307 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var2307 null-Bool)))
(define-const var76 Int var781_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var3884 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3884)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3884!1 String)
(assert (= var3884!1 ""))
(define-const var500 Int (sent/-456130081 var343)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var529 Int (ite (> var500 0) 1 (ite (< var500 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var1870 Int (cast-from-Int-to-Int var529)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var1870 0)) ; Cond: $i20 <= 0 
(define-const var3746 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var3996 String (append/672562846 var3884!1 var3746)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var3884!2 String)
(assert (= var3884!2 (str.++ var3884!1 var3746)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (= (ite var2307 1 0) 0)) ; Cond: z0 == 0 
(define-const var1051 String "") ; Statement: $r40 = "" 
(assert true) ; Non Conditional
(assert true)
(define-const var1385 String (append/672562846 var3996 var1051)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var3996!1 String)
(assert (= var3996!1 (str.++ var3996 var1051)))
(assert true)
(define-const var1400 String (append/672562846 var1385 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var1385!1 String)
(assert (= var1385!1 (str.++ var1385 ". start time: ")))
(define-const var3396 var326 var326-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3396 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var3396!1 var326)
(declare-const var989 String)
(define-const var1172 var1122 var1122-init) ; Statement: $r45 = new java.util.Date 
(define-const var2070 Int (start/-456130081 var343)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var1172 var2070)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var1172!1 var1122)
(declare-const var2070!1 Int)
(assert true)
(define-const var2697 String (format/215566421 (cast-from-var326-to-var1873 var3396!1) var1172!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var2388 String (append/672562846 var1400 var2697)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1400!1 String)
(assert (= var1400!1 (str.++ var1400 var2697)))
(assert true)
(define-const var904 String (append/672562846 var2388 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var2388!1 String)
(assert (= var2388!1 (str.++ var2388 ", end time: ")))
(define-const var3764 var326 var326-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3764 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var3764!1 var326)
(declare-const var989!1 String)
(define-const var893 var1122 var1122-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var893 var76)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var893!1 var1122)
(declare-const var76!1 Int)
(assert true)
(define-const var2370 String (format/215566421 (cast-from-var326-to-var1873 var3764!1) var893!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var3310 String (append/672562846 var904 var2370)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var904!1 String)
(assert (= var904!1 (str.++ var904 var2370)))
(assert true)
(define-const var3723 String (append/672562846 var3310 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var3310!1 String)
(assert (= var3310!1 (str.++ var3310 ",")))
(define-const var3102 Int (sent/-456130081 var343)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var892 Int (ite (> var3102 0) 1 (ite (< var3102 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var3166 Int (cast-from-Int-to-Int var892)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (not (<= var3166 0))) ; Negate: Cond: $i22 <= 0  
(define-const var1598 String String-init) ; Statement: $r48 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1598)) ; Statement: specialinvoke $r48.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1598!1 String)
(assert (= var1598!1 ""))
(assert true)
(define-const var3531 String (append/672562846 var1598!1 " client elapsed: ")) ; Statement: $r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ") 
(declare-const var1598!2 String)
(assert (= var1598!2 (str.++ var1598!1 " client elapsed: ")))
(define-const var1957 Int (sent/-456130081 var343)) ; Statement: $l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var647 Int (start/-456130081 var343)) ; Statement: $l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var2656 Int (- var1957 var647)) ; Statement: $l11 = $l10 - $l9 
(assert true)
(define-const var2464 String (append/-901862667 var3531 var2656)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11) 
(declare-const var3531!1 String)
(assert (str.prefixof var3531 var3531!1))
(assert true)
(define-const var1714 String (append/672562846 var2464 " ms, server elapsed: ")) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ") 
(declare-const var2464!1 String)
(assert (= var2464!1 (str.++ var2464 " ms, server elapsed: ")))
(define-const var2494 Int (sent/-456130081 var343)) ; Statement: $l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var1027 Int (- var76!1 var2494)) ; Statement: $l13 = l0 - $l12 
(assert true)
(define-const var355 String (append/-901862667 var1714 var1027)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13) 
(declare-const var1714!1 String)
(assert (str.prefixof var1714 var1714!1))
(assert true)
(define-const var175 String (toString/-2075883882 var355)) ; Statement: $r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2548 String (append/672562846 var3723 var175)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var3723!1 String)
(assert (= var3723!1 (str.++ var3723 var175)))
(assert true)
(define-const var2830 String (append/672562846 var2548 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var2548!1 String)
(assert (= var2548!1 (str.++ var2548 " ms, timeout: ")))
(define-const var917 Int (timeout/-456130081 var343)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var1257 String (append/-1001720160 var2830 var917)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var2830!1 String)
(assert (str.prefixof var2830 var2830!1))
(assert true)
(define-const var3816 String (append/672562846 var1257 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var1257!1 String)
(assert (= var1257!1 (str.++ var1257 " ms, request: ")))
(define-const var844 var1162 var1105-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1880 Bool (var3555_isDebugEnabled/-823448366 (cast-from-var1162-to-var3555 var844))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (not (= (ite var1880 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2463 var2648 (request/-456130081 var343)) ; Statement: $r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
 ; Statement: goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)] 
(assert true) ; Non Conditional
(assert true)
(define-const var1184 String (append/-1031950772 var3816 (cast-from-var2648-to-var2319 var2463))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var3816!1 String)
(assert (str.prefixof var3816 var3816!1))
(assert true)
(define-const var2806 String (append/672562846 var1184 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var1184!1 String)
(assert (= var1184!1 (str.++ var1184 ", channel: ")))
(define-const var1245 var3344 (channel/-456130081 var343)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var1783 var521 (var3243_getLocalAddress/2019899378 (cast-from-var3344-to-var3243 var1245))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var2991 String (append/-1031950772 var2806 (cast-from-var521-to-var2319 var1783))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var2806!1 String)
(assert (str.prefixof var2806 var2806!1))
(assert true)
(define-const var2005 String (append/672562846 var2991 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var2991!1 String)
(assert (= var2991!1 (str.++ var2991 " -> ")))
(define-const var1508 var3344 (channel/-456130081 var343)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var1079 var521 (var3344_getRemoteAddress/1597111645 var1508)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1733 String (append/-1031950772 var2005 (cast-from-var521-to-var2319 var1079))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var2005!1 String)
(assert (str.prefixof var2005 var2005!1))
(assert true)
(define-const var872 String (toString/-2075883882 var1733)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var781_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var326-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var1122-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var326-to-var1873=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var3555_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var1162-to-var3555=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2648-to-var2319=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var3243_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var3344-to-var3243=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var521-to-var2319=([java.net.InetSocketAddress], java.lang.Object), var3344_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var1105=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var343=r0, var2307=z0, var781=java.lang.System, var76=l0, var3884=$r43, var500=$l1, var529=$b2, var1870=$i20, var3746=$r39, var3996=$r1, var1051=$r40, var1385=$r2, var1400=$r6, var326=java.text.SimpleDateFormat, var3396=$r44, var989="yyyy-MM-dd HH:mm:ss.SSS", var1122=java.util.Date, var1172=$r45, var2070=$l3, var1873=java.text.DateFormat, var2697=$r5, var2388=$r7, var904=$r11, var3764=$r46, var893=$r47, var2370=$r10, var3310=$r12, var3723=$r16, var3102=$l4, var892=$b5, var3166=$i22, var1598=$r48, var3531=$r34, var1957=$l10, var647=$l9, var2656=$l11, var2464=$r35, var1714=$r36, var2494=$l12, var1027=$l13, var355=$r37, var175=$r41, var2548=$r17, var2830=$r18, var917=$i8, var1257=$r19, var3816=$r22, var1162=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var844=$r20, var3555=org.apache.dubbo.common.logger.Logger, var1880=$z1, var2648=org.apache.dubbo.remoting.exchange.Request, var2463=$r42, var2319=java.lang.Object, var1184=$r23, var2806=$r26, var3344=org.apache.dubbo.remoting.Channel, var1245=$r24, var521=java.net.InetSocketAddress, var3243=org.apache.dubbo.remoting.Endpoint, var1783=$r25, var2991=$r27, var2005=$r30, var1508=$r28, var1079=$r29, var1733=$r31, var872=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var1105, r0=var343, z0=var2307, java.lang.System=var781, l0=var76, $r43=var3884, $l1=var500, $b2=var529, $i20=var1870, $r39=var3746, $r1=var3996, $r40=var1051, $r2=var1385, $r6=var1400, java.text.SimpleDateFormat=var326, $r44=var3396, "yyyy-MM-dd HH:mm:ss.SSS"=var989, java.util.Date=var1122, $r45=var1172, $l3=var2070, java.text.DateFormat=var1873, $r5=var2697, $r7=var2388, $r11=var904, $r46=var3764, $r47=var893, $r10=var2370, $r12=var3310, $r16=var3723, $l4=var3102, $b5=var892, $i22=var3166, $r48=var1598, $r34=var3531, $l10=var1957, $l9=var647, $l11=var2656, $r35=var2464, $r36=var1714, $l12=var2494, $l13=var1027, $r37=var355, $r41=var175, $r17=var2548, $r18=var2830, $i8=var917, $r19=var1257, $r22=var3816, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1162, $r20=var844, org.apache.dubbo.common.logger.Logger=var3555, $z1=var1880, org.apache.dubbo.remoting.exchange.Request=var2648, $r42=var2463, java.lang.Object=var2319, $r23=var1184, $r26=var2806, org.apache.dubbo.remoting.Channel=var3344, $r24=var1245, java.net.InetSocketAddress=var521, org.apache.dubbo.remoting.Endpoint=var3243, $r25=var1783, $r27=var2991, $r30=var2005, $r28=var1508, $r29=var1079, $r31=var1733, $r32=var872}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 14,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = "";	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r48 = new java.lang.StringBuilder;	specialinvoke $r48.<java.lang.StringBuilder: void <init>()>();	$r34 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" client elapsed: ");	$l10 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l9 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l11 = $l10 - $l9;	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l11);	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, server elapsed: ");	$l12 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$l13 = l0 - $l12;	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l13);	$r41 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41)];	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)];	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9