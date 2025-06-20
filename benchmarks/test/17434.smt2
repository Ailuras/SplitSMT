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

(declare-sort var1623 0)
(declare-sort var2771 0)
(declare-sort var791 0)
(declare-sort var1146 0)
(declare-sort var2367 0)
(declare-sort var2025 0)
(declare-sort var61 0)
(declare-sort var1204 0)
(declare-sort var3698 0)
(declare-sort var3700 0)
(declare-sort var1234 0)
(declare-sort var597 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2771_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var1623) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var791-init () var791)
(declare-fun <init>/-1862704206 (var791 String) void)
(declare-fun var1146-init () var1146)
(declare-fun start/-456130081 (var1623) Int)
(declare-fun <init>/593337323 (var1146 Int) void)
(declare-fun format/215566421 (var2367 var1146) String)
(declare-fun cast-from-var791-to-var2367 (var791) var2367)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var1623) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var61_isDebugEnabled/-823448366 (var61) Bool)
(declare-fun cast-from-var2025-to-var61 (var2025) var61)
(declare-fun request/-456130081 (var1623) var1204)
(declare-fun copyWithoutData/-674215476 (var1204) var1204)
(declare-fun append/-1031950772 (String var3698) String)
(declare-fun cast-from-var1204-to-var3698 (var1204) var3698)
(declare-fun channel/-456130081 (var1623) var3700)
(declare-fun var597_getLocalAddress/2019899378 (var597) var1234)
(declare-fun cast-from-var3700-to-var597 (var3700) var597)
(declare-fun cast-from-var1234-to-var3698 (var1234) var3698)
(declare-fun var3700_getRemoteAddress/1597111645 (var3700) var1234)
(declare-const null-var1623 var1623)
(declare-const null-Bool Bool)
(declare-const var1623-logger var2025)
(declare-const var3099 var1623) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var3099 null-var1623)))
(declare-const var1561 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var1561 null-Bool)))
(define-const var541 Int var2771_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var3325 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3325)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3325!1 String)
(assert (= var3325!1 ""))
(define-const var2511 Int (sent/-456130081 var3099)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var1703 Int (ite (> var2511 0) 1 (ite (< var2511 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var15 Int (cast-from-Int-to-Int var1703)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var15 0)) ; Cond: $i20 <= 0 
(define-const var2002 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var3252 String (append/672562846 var3325!1 var2002)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var3325!2 String)
(assert (= var3325!2 (str.++ var3325!1 var2002)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (not (= (ite var1561 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var1570 String " by scan timer") ; Statement: $r40 = " by scan timer" 
 ; Statement: goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)] 
(assert true) ; Non Conditional
(assert true)
(define-const var356 String (append/672562846 var3252 var1570)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var3252!1 String)
(assert (= var3252!1 (str.++ var3252 var1570)))
(assert true)
(define-const var1373 String (append/672562846 var356 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var356!1 String)
(assert (= var356!1 (str.++ var356 ". start time: ")))
(define-const var762 var791 var791-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var762 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var762!1 var791)
(declare-const var2277 String)
(define-const var2594 var1146 var1146-init) ; Statement: $r45 = new java.util.Date 
(define-const var770 Int (start/-456130081 var3099)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var2594 var770)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var2594!1 var1146)
(declare-const var770!1 Int)
(assert true)
(define-const var245 String (format/215566421 (cast-from-var791-to-var2367 var762!1) var2594!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var3592 String (append/672562846 var1373 var245)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1373!1 String)
(assert (= var1373!1 (str.++ var1373 var245)))
(assert true)
(define-const var3571 String (append/672562846 var3592 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var3592!1 String)
(assert (= var3592!1 (str.++ var3592 ", end time: ")))
(define-const var2772 var791 var791-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var2772 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var2772!1 var791)
(declare-const var2277!1 String)
(define-const var1742 var1146 var1146-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var1742 var541)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var1742!1 var1146)
(declare-const var541!1 Int)
(assert true)
(define-const var1355 String (format/215566421 (cast-from-var791-to-var2367 var2772!1) var1742!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var2496 String (append/672562846 var3571 var1355)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3571!1 String)
(assert (= var3571!1 (str.++ var3571 var1355)))
(assert true)
(define-const var1239 String (append/672562846 var2496 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var2496!1 String)
(assert (= var2496!1 (str.++ var2496 ",")))
(define-const var1264 Int (sent/-456130081 var3099)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var1976 Int (ite (> var1264 0) 1 (ite (< var1264 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var783 Int (cast-from-Int-to-Int var1976)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (<= var783 0)) ; Cond: $i22 <= 0 
(define-const var2525 String String-init) ; Statement: $r49 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2525)) ; Statement: specialinvoke $r49.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2525!1 String)
(assert (= var2525!1 ""))
(assert true)
(define-const var226 String (append/672562846 var2525!1 " elapsed: ")) ; Statement: $r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ") 
(declare-const var2525!2 String)
(assert (= var2525!2 (str.++ var2525!1 " elapsed: ")))
(define-const var655 Int (start/-456130081 var3099)) ; Statement: $l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var49 Int (- var541!1 var655)) ; Statement: $l7 = l0 - $l6 
(assert true)
(define-const var1150 String (append/-901862667 var226 var49)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var226!1 String)
(assert (str.prefixof var226 var226!1))
(assert true)
(define-const var1326 String (toString/-2075883882 var1150)) ; Statement: $r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var472 String (append/672562846 var1239 var1326)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var1239!1 String)
(assert (= var1239!1 (str.++ var1239 var1326)))
(assert true)
(define-const var2128 String (append/672562846 var472 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var472!1 String)
(assert (= var472!1 (str.++ var472 " ms, timeout: ")))
(define-const var547 Int (timeout/-456130081 var3099)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var3020 String (append/-1001720160 var2128 var547)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var2128!1 String)
(assert (str.prefixof var2128 var2128!1))
(assert true)
(define-const var523 String (append/672562846 var3020 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var3020!1 String)
(assert (= var3020!1 (str.++ var3020 " ms, request: ")))
(define-const var2921 var2025 var1623-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var376 Bool (var61_isDebugEnabled/-823448366 (cast-from-var2025-to-var61 var2921))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (= (ite var376 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3447 var1204 (request/-456130081 var3099)) ; Statement: $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert true)
(define-const var2689 var1204 (copyWithoutData/-674215476 var3447)) ; Statement: $r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var2941 String (append/-1031950772 var523 (cast-from-var1204-to-var3698 var2689))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var523!1 String)
(assert (str.prefixof var523 var523!1))
(assert true)
(define-const var3925 String (append/672562846 var2941 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var2941!1 String)
(assert (= var2941!1 (str.++ var2941 ", channel: ")))
(define-const var3952 var3700 (channel/-456130081 var3099)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var2364 var1234 (var597_getLocalAddress/2019899378 (cast-from-var3700-to-var597 var3952))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var3224 String (append/-1031950772 var3925 (cast-from-var1234-to-var3698 var2364))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var3925!1 String)
(assert (str.prefixof var3925 var3925!1))
(assert true)
(define-const var1520 String (append/672562846 var3224 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var3224!1 String)
(assert (= var3224!1 (str.++ var3224 " -> ")))
(define-const var2568 var3700 (channel/-456130081 var3099)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var1037 var1234 (var3700_getRemoteAddress/1597111645 var2568)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var3524 String (append/-1031950772 var1520 (cast-from-var1234-to-var3698 var1037))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var1520!1 String)
(assert (str.prefixof var1520 var1520!1))
(assert true)
(define-const var3418 String (toString/-2075883882 var3524)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var2771_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var791-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var1146-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var791-to-var2367=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var61_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var2025-to-var61=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), copyWithoutData/-674215476=([org.apache.dubbo.remoting.exchange.Request], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1204-to-var3698=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var597_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var3700-to-var597=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var1234-to-var3698=([java.net.InetSocketAddress], java.lang.Object), var3700_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var1623=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var3099=r0, var1561=z0, var2771=java.lang.System, var541=l0, var3325=$r43, var2511=$l1, var1703=$b2, var15=$i20, var2002=$r39, var3252=$r1, var1570=$r40, var356=$r2, var1373=$r6, var791=java.text.SimpleDateFormat, var762=$r44, var2277="yyyy-MM-dd HH:mm:ss.SSS", var1146=java.util.Date, var2594=$r45, var770=$l3, var2367=java.text.DateFormat, var245=$r5, var3592=$r7, var3571=$r11, var2772=$r46, var1742=$r47, var1355=$r10, var2496=$r12, var1239=$r16, var1264=$l4, var1976=$b5, var783=$i22, var2525=$r49, var226=$r14, var655=$l6, var49=$l7, var1150=$r15, var1326=$r41, var472=$r17, var2128=$r18, var547=$i8, var3020=$r19, var523=$r22, var2025=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2921=$r20, var61=org.apache.dubbo.common.logger.Logger, var376=$z1, var1204=org.apache.dubbo.remoting.exchange.Request, var3447=$r21, var2689=$r42, var3698=java.lang.Object, var2941=$r23, var3925=$r26, var3700=org.apache.dubbo.remoting.Channel, var3952=$r24, var1234=java.net.InetSocketAddress, var597=org.apache.dubbo.remoting.Endpoint, var2364=$r25, var3224=$r27, var1520=$r30, var2568=$r28, var1037=$r29, var3524=$r31, var3418=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var1623, r0=var3099, z0=var1561, java.lang.System=var2771, l0=var541, $r43=var3325, $l1=var2511, $b2=var1703, $i20=var15, $r39=var2002, $r1=var3252, $r40=var1570, $r2=var356, $r6=var1373, java.text.SimpleDateFormat=var791, $r44=var762, "yyyy-MM-dd HH:mm:ss.SSS"=var2277, java.util.Date=var1146, $r45=var2594, $l3=var770, java.text.DateFormat=var2367, $r5=var245, $r7=var3592, $r11=var3571, $r46=var2772, $r47=var1742, $r10=var1355, $r12=var2496, $r16=var1239, $l4=var1264, $b5=var1976, $i22=var783, $r49=var2525, $r14=var226, $l6=var655, $l7=var49, $r15=var1150, $r41=var1326, $r17=var472, $r18=var2128, $i8=var547, $r19=var3020, $r22=var523, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2025, $r20=var2921, org.apache.dubbo.common.logger.Logger=var61, $z1=var376, org.apache.dubbo.remoting.exchange.Request=var1204, $r21=var3447, $r42=var2689, java.lang.Object=var3698, $r23=var2941, $r26=var3925, org.apache.dubbo.remoting.Channel=var3700, $r24=var3952, java.net.InetSocketAddress=var1234, org.apache.dubbo.remoting.Endpoint=var597, $r25=var2364, $r27=var3224, $r30=var1520, $r28=var2568, $r29=var1037, $r31=var3524, $r32=var3418}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 13,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = " by scan timer";	goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)];	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r49 = new java.lang.StringBuilder;	specialinvoke $r49.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ");	$l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l7 = l0 - $l6;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = virtualinvoke $r21.<org.apache.dubbo.remoting.exchange.Request: org.apache.dubbo.remoting.exchange.Request copyWithoutData()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9