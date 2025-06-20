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

(declare-sort var3829 0)
(declare-sort var3879 0)
(declare-sort var3146 0)
(declare-sort var2567 0)
(declare-sort var877 0)
(declare-sort var334 0)
(declare-sort var2055 0)
(declare-sort var3171 0)
(declare-sort var2153 0)
(declare-sort var2152 0)
(declare-sort var1479 0)
(declare-sort var84 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3879_currentTimeMillis/630293680 () Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun sent/-456130081 (var3829) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3146-init () var3146)
(declare-fun <init>/-1862704206 (var3146 String) void)
(declare-fun var2567-init () var2567)
(declare-fun start/-456130081 (var3829) Int)
(declare-fun <init>/593337323 (var2567 Int) void)
(declare-fun format/215566421 (var877 var2567) String)
(declare-fun cast-from-var3146-to-var877 (var3146) var877)
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun timeout/-456130081 (var3829) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun var2055_isDebugEnabled/-823448366 (var2055) Bool)
(declare-fun cast-from-var334-to-var2055 (var334) var2055)
(declare-fun request/-456130081 (var3829) var3171)
(declare-fun append/-1031950772 (String var2153) String)
(declare-fun cast-from-var3171-to-var2153 (var3171) var2153)
(declare-fun channel/-456130081 (var3829) var2152)
(declare-fun var84_getLocalAddress/2019899378 (var84) var1479)
(declare-fun cast-from-var2152-to-var84 (var2152) var84)
(declare-fun cast-from-var1479-to-var2153 (var1479) var2153)
(declare-fun var2152_getRemoteAddress/1597111645 (var2152) var1479)
(declare-const null-var3829 var3829)
(declare-const null-Bool Bool)
(declare-const var3829-logger var334)
(declare-const var3034 var3829) ; Statement: r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture 
(assert (not (= var3034 null-var3829)))
(declare-const var459 Bool) ; Statement: z0 := @parameter0: boolean 
(assert (not (= var459 null-Bool)))
(define-const var3312 Int var3879_currentTimeMillis/630293680) ; Statement: l0 = staticinvoke <java.lang.System: long currentTimeMillis()>() 
(define-const var3784 String String-init) ; Statement: $r43 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3784)) ; Statement: specialinvoke $r43.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3784!1 String)
(assert (= var3784!1 ""))
(define-const var755 Int (sent/-456130081 var3034)) ; Statement: $l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var230 Int (ite (> var755 0) 1 (ite (< var755 0) -1 0))) ; Statement: $b2 = $l1 cmp 0L 
(define-const var3728 Int (cast-from-Int-to-Int var230)) ; Statement: $i20 = (int) $b2 
 ; Statement: if $i20 <= 0 goto $r39 = "Sending request timeout in client-side" 
(assert (<= var3728 0)) ; Cond: $i20 <= 0 
(define-const var3910 String "Sending request timeout in client-side") ; Statement: $r39 = "Sending request timeout in client-side" 
(assert true) ; Non Conditional
(assert true)
(define-const var1342 String (append/672562846 var3784!1 var3910)) ; Statement: $r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39) 
(declare-const var3784!2 String)
(assert (= var3784!2 (str.++ var3784!1 var3910)))
 ; Statement: if z0 == 0 goto $r40 = "" 
(assert (not (= (ite var459 1 0) 0))) ; Negate: Cond: z0 == 0  
(define-const var2469 String " by scan timer") ; Statement: $r40 = " by scan timer" 
 ; Statement: goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2178 String (append/672562846 var1342 var2469)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40) 
(declare-const var1342!1 String)
(assert (= var1342!1 (str.++ var1342 var2469)))
(assert true)
(define-const var1941 String (append/672562846 var2178 ". start time: ")) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ") 
(declare-const var2178!1 String)
(assert (= var2178!1 (str.++ var2178 ". start time: ")))
(define-const var3895 var3146 var3146-init) ; Statement: $r44 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3895 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var3895!1 var3146)
(declare-const var2802 String)
(define-const var1280 var2567 var2567-init) ; Statement: $r45 = new java.util.Date 
(define-const var275 Int (start/-456130081 var3034)) ; Statement: $l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(assert true)
;(assert (<init>/593337323 var1280 var275)) ; Statement: specialinvoke $r45.<java.util.Date: void <init>(long)>($l3) 

(declare-const var1280!1 var2567)
(declare-const var275!1 Int)
(assert true)
(define-const var1173 String (format/215566421 (cast-from-var3146-to-var877 var3895!1) var1280!1)) ; Statement: $r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45) 
(assert true)
(define-const var1718 String (append/672562846 var1941 var1173)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1941!1 String)
(assert (= var1941!1 (str.++ var1941 var1173)))
(assert true)
(define-const var526 String (append/672562846 var1718 ", end time: ")) ; Statement: $r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ") 
(declare-const var1718!1 String)
(assert (= var1718!1 (str.++ var1718 ", end time: ")))
(define-const var3468 var3146 var3146-init) ; Statement: $r46 = new java.text.SimpleDateFormat 
(assert true)
;(assert (<init>/-1862704206 var3468 "yyyy-MM-dd HH:mm:ss.SSS")) ; Statement: specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS") 

(declare-const var3468!1 var3146)
(declare-const var2802!1 String)
(define-const var3338 var2567 var2567-init) ; Statement: $r47 = new java.util.Date 
(assert true)
;(assert (<init>/593337323 var3338 var3312)) ; Statement: specialinvoke $r47.<java.util.Date: void <init>(long)>(l0) 

(declare-const var3338!1 var2567)
(declare-const var3312!1 Int)
(assert true)
(define-const var3566 String (format/215566421 (cast-from-var3146-to-var877 var3468!1) var3338!1)) ; Statement: $r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47) 
(assert true)
(define-const var32 String (append/672562846 var526 var3566)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var526!1 String)
(assert (= var526!1 (str.++ var526 var3566)))
(assert true)
(define-const var3901 String (append/672562846 var32 ",")) ; Statement: $r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",") 
(declare-const var32!1 String)
(assert (= var32!1 (str.++ var32 ",")))
(define-const var2304 Int (sent/-456130081 var3034)) ; Statement: $l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent> 
(define-const var1058 Int (ite (> var2304 0) 1 (ite (< var2304 0) -1 0))) ; Statement: $b5 = $l4 cmp 0L 
(define-const var3050 Int (cast-from-Int-to-Int var1058)) ; Statement: $i22 = (int) $b5 
 ; Statement: if $i22 <= 0 goto $r49 = new java.lang.StringBuilder 
(assert (<= var3050 0)) ; Cond: $i22 <= 0 
(define-const var2306 String String-init) ; Statement: $r49 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2306)) ; Statement: specialinvoke $r49.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2306!1 String)
(assert (= var2306!1 ""))
(assert true)
(define-const var2820 String (append/672562846 var2306!1 " elapsed: ")) ; Statement: $r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ") 
(declare-const var2306!2 String)
(assert (= var2306!2 (str.++ var2306!1 " elapsed: ")))
(define-const var1455 Int (start/-456130081 var3034)) ; Statement: $l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start> 
(define-const var3602 Int (- var3312!1 var1455)) ; Statement: $l7 = l0 - $l6 
(assert true)
(define-const var2634 String (append/-901862667 var2820 var3602)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7) 
(declare-const var2820!1 String)
(assert (str.prefixof var2820 var2820!1))
(assert true)
(define-const var1307 String (toString/-2075883882 var2634)) ; Statement: $r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var2227 String (append/672562846 var3901 var1307)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var3901!1 String)
(assert (= var3901!1 (str.++ var3901 var1307)))
(assert true)
(define-const var3374 String (append/672562846 var2227 " ms, timeout: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ") 
(declare-const var2227!1 String)
(assert (= var2227!1 (str.++ var2227 " ms, timeout: ")))
(define-const var1791 Int (timeout/-456130081 var3034)) ; Statement: $i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout> 
(assert true)
(define-const var1940 String (append/-1001720160 var3374 var1791)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8) 
(declare-const var3374!1 String)
(assert (str.prefixof var3374 var3374!1))
(assert true)
(define-const var3218 String (append/672562846 var1940 " ms, request: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ") 
(declare-const var1940!1 String)
(assert (= var1940!1 (str.++ var1940 " ms, request: ")))
(define-const var2908 var334 var3829-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2922 Bool (var2055_isDebugEnabled/-823448366 (cast-from-var334-to-var2055 var2908))) ; Statement: $z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>() 
 ; Statement: if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
(assert (not (= (ite var2922 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var284 var3171 (request/-456130081 var3034)) ; Statement: $r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request> 
 ; Statement: goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)] 
(assert true) ; Non Conditional
(assert true)
(define-const var2579 String (append/-1031950772 var3218 (cast-from-var3171-to-var2153 var284))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42) 
(declare-const var3218!1 String)
(assert (str.prefixof var3218 var3218!1))
(assert true)
(define-const var2084 String (append/672562846 var2579 ", channel: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ") 
(declare-const var2579!1 String)
(assert (= var2579!1 (str.++ var2579 ", channel: ")))
(define-const var1852 var2152 (channel/-456130081 var3034)) ; Statement: $r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3181 var1479 (var84_getLocalAddress/2019899378 (cast-from-var2152-to-var84 var1852))) ; Statement: $r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>() 
(assert true)
(define-const var1288 String (append/-1031950772 var2084 (cast-from-var1479-to-var2153 var3181))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var2084!1 String)
(assert (str.prefixof var2084 var2084!1))
(assert true)
(define-const var3689 String (append/672562846 var1288 " -> ")) ; Statement: $r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var1288!1 String)
(assert (= var1288!1 (str.++ var1288 " -> ")))
(define-const var674 var2152 (channel/-456130081 var3034)) ; Statement: $r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel> 
(define-const var3510 var1479 (var2152_getRemoteAddress/1597111645 var674)) ; Statement: $r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1722 String (append/-1031950772 var3689 (cast-from-var1479-to-var2153 var3510))) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var3689!1 String)
(assert (str.prefixof var3689 var3689!1))
(assert true)
(define-const var2352 String (toString/-2075883882 var1722)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r32 
(check-sat)
; {var3879_currentTimeMillis/630293680=([], long), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), sent/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), cast-from-Int-to-Int=([byte], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3146-init=([], java.text.SimpleDateFormat), <init>/-1862704206=([java.text.SimpleDateFormat, java.lang.String], void), var2567-init=([], java.util.Date), start/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], long), <init>/593337323=([java.util.Date, long], void), format/215566421=([java.text.DateFormat, java.util.Date], java.lang.String), cast-from-var3146-to-var877=([java.text.SimpleDateFormat], java.text.DateFormat), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), timeout/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), var2055_isDebugEnabled/-823448366=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var334-to-var2055=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), request/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.exchange.Request), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3171-to-var2153=([org.apache.dubbo.remoting.exchange.Request], java.lang.Object), channel/-456130081=([org.apache.dubbo.remoting.exchange.support.DefaultFuture], org.apache.dubbo.remoting.Channel), var84_getLocalAddress/2019899378=([org.apache.dubbo.remoting.Endpoint], java.net.InetSocketAddress), cast-from-var2152-to-var84=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint), cast-from-var1479-to-var2153=([java.net.InetSocketAddress], java.lang.Object), var2152_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress)}
; {var3829=org.apache.dubbo.remoting.exchange.support.DefaultFuture, var3034=r0, var459=z0, var3879=java.lang.System, var3312=l0, var3784=$r43, var755=$l1, var230=$b2, var3728=$i20, var3910=$r39, var1342=$r1, var2469=$r40, var2178=$r2, var1941=$r6, var3146=java.text.SimpleDateFormat, var3895=$r44, var2802="yyyy-MM-dd HH:mm:ss.SSS", var2567=java.util.Date, var1280=$r45, var275=$l3, var877=java.text.DateFormat, var1173=$r5, var1718=$r7, var526=$r11, var3468=$r46, var3338=$r47, var3566=$r10, var32=$r12, var3901=$r16, var2304=$l4, var1058=$b5, var3050=$i22, var2306=$r49, var2820=$r14, var1455=$l6, var3602=$l7, var2634=$r15, var1307=$r41, var2227=$r17, var3374=$r18, var1791=$i8, var1940=$r19, var3218=$r22, var334=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2908=$r20, var2055=org.apache.dubbo.common.logger.Logger, var2922=$z1, var3171=org.apache.dubbo.remoting.exchange.Request, var284=$r42, var2153=java.lang.Object, var2579=$r23, var2084=$r26, var2152=org.apache.dubbo.remoting.Channel, var1852=$r24, var1479=java.net.InetSocketAddress, var84=org.apache.dubbo.remoting.Endpoint, var3181=$r25, var1288=$r27, var3689=$r30, var674=$r28, var3510=$r29, var1722=$r31, var2352=$r32}
; {org.apache.dubbo.remoting.exchange.support.DefaultFuture=var3829, r0=var3034, z0=var459, java.lang.System=var3879, l0=var3312, $r43=var3784, $l1=var755, $b2=var230, $i20=var3728, $r39=var3910, $r1=var1342, $r40=var2469, $r2=var2178, $r6=var1941, java.text.SimpleDateFormat=var3146, $r44=var3895, "yyyy-MM-dd HH:mm:ss.SSS"=var2802, java.util.Date=var2567, $r45=var1280, $l3=var275, java.text.DateFormat=var877, $r5=var1173, $r7=var1718, $r11=var526, $r46=var3468, $r47=var3338, $r10=var3566, $r12=var32, $r16=var3901, $l4=var2304, $b5=var1058, $i22=var3050, $r49=var2306, $r14=var2820, $l6=var1455, $l7=var3602, $r15=var2634, $r41=var1307, $r17=var2227, $r18=var3374, $i8=var1791, $r19=var1940, $r22=var3218, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var334, $r20=var2908, org.apache.dubbo.common.logger.Logger=var2055, $z1=var2922, org.apache.dubbo.remoting.exchange.Request=var3171, $r42=var284, java.lang.Object=var2153, $r23=var2579, $r26=var2084, org.apache.dubbo.remoting.Channel=var2152, $r24=var1852, java.net.InetSocketAddress=var1479, org.apache.dubbo.remoting.Endpoint=var84, $r25=var3181, $r27=var1288, $r30=var3689, $r28=var674, $r29=var3510, $r31=var1722, $r32=var2352}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 13,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3}
;stmts r0 := @this: org.apache.dubbo.remoting.exchange.support.DefaultFuture;	z0 := @parameter0: boolean;	l0 = staticinvoke <java.lang.System: long currentTimeMillis()>();	$r43 = new java.lang.StringBuilder;	specialinvoke $r43.<java.lang.StringBuilder: void <init>()>();	$l1 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b2 = $l1 cmp 0L;	$i20 = (int) $b2;	if $i20 <= 0 goto $r39 = "Sending request timeout in client-side";	$r39 = "Sending request timeout in client-side";	$r1 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r39);	if z0 == 0 goto $r40 = "";	$r40 = " by scan timer";	goto [?= $r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40)];	$r2 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r40);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(". start time: ");	$r44 = new java.text.SimpleDateFormat;	specialinvoke $r44.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r45 = new java.util.Date;	$l3 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	specialinvoke $r45.<java.util.Date: void <init>(long)>($l3);	$r5 = virtualinvoke $r44.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r45);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r11 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", end time: ");	$r46 = new java.text.SimpleDateFormat;	specialinvoke $r46.<java.text.SimpleDateFormat: void <init>(java.lang.String)>("yyyy-MM-dd HH:mm:ss.SSS");	$r47 = new java.util.Date;	specialinvoke $r47.<java.util.Date: void <init>(long)>(l0);	$r10 = virtualinvoke $r46.<java.text.SimpleDateFormat: java.lang.String format(java.util.Date)>($r47);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r16 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",");	$l4 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long sent>;	$b5 = $l4 cmp 0L;	$i22 = (int) $b5;	if $i22 <= 0 goto $r49 = new java.lang.StringBuilder;	$r49 = new java.lang.StringBuilder;	specialinvoke $r49.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" elapsed: ");	$l6 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: long start>;	$l7 = l0 - $l6;	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>($l7);	$r41 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, timeout: ");	$i8 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: int timeout>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i8);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ms, request: ");	$r20 = <org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isDebugEnabled()>();	if $z1 == 0 goto $r21 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	$r42 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.exchange.Request request>;	goto [?= $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42)];	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r42);	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", channel: ");	$r24 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r25 = interfaceinvoke $r24.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getLocalAddress()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r30 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r28 = r0.<org.apache.dubbo.remoting.exchange.support.DefaultFuture: org.apache.dubbo.remoting.Channel channel>;	$r29 = interfaceinvoke $r28.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.String toString()>();	return $r32
;block_num 9