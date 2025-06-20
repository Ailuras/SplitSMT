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

(declare-sort var1360 0)
(declare-sort var3266 0)
(declare-sort var1735 0)
(declare-sort var302 0)
(declare-sort var2652 0)
(declare-sort var3275 0)
(declare-sort var1889 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isClosed/1772375327 (var3266) Bool)
(declare-fun cast-from-var1360-to-var3266 (var1360) var3266)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getRemoteAddress/-557105490 (var1360) var302)
(declare-fun append/-1031950772 (String var2652) String)
(declare-fun cast-from-var302-to-var2652 (var302) var2652)
(declare-fun getClass/1258963082 (var2652) ClassObject)
(declare-fun cast-from-var1360-to-var2652 (var1360) var2652)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun var3275_getLocalHost/-1653363627 () String)
(declare-fun var1889_getVersion/310196261 () String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1735_warn/1431914100 (var1735 String String String String) void)
(declare-const null-var1360 var1360)
(declare-const var1360-logger var1735)
(declare-const var1496 var1360) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.AbstractClient 
(assert (not (= var1496 null-var1360)))
(assert true)
(define-const var2025 Bool (isClosed/1772375327 (cast-from-var1360-to-var3266 var1496))) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: boolean isClosed()>() 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.remoting.transport.AbstractClient: java.util.concurrent.locks.Lock connectLock> 
(assert (not (= (ite var2025 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var537 var1735 var1360-logger) ; Statement: $r22 = <org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2371 String String-init) ; Statement: $r21 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2371)) ; Statement: specialinvoke $r21.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2371!1 String)
(assert (= var2371!1 ""))
(assert true)
(define-const var2114 String (append/672562846 var2371!1 "No need to close connection to server ")) ; Statement: $r24 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No need to close connection to server ") 
(declare-const var2371!2 String)
(assert (= var2371!2 (str.++ var2371!1 "No need to close connection to server ")))
(assert true)
(define-const var2625 var302 (getRemoteAddress/-557105490 var1496)) ; Statement: $r23 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var2515 String (append/-1031950772 var2114 (cast-from-var302-to-var2652 var2625))) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var2114!1 String)
(assert (str.prefixof var2114 var2114!1))
(assert true)
(define-const var3178 String (append/672562846 var2515 " from ")) ; Statement: $r28 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from ") 
(declare-const var2515!1 String)
(assert (= var2515!1 (str.++ var2515 " from ")))
(assert true)
(define-const var1760 ClassObject (getClass/1258963082 (cast-from-var1360-to-var2652 var1496))) ; Statement: $r26 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var1739 String (getSimpleName/-390194377 var1760)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var1783 String (append/672562846 var3178 var1739)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27) 
(declare-const var3178!1 String)
(assert (= var3178!1 (str.++ var3178 var1739)))
(assert true)
(define-const var2972 String (append/672562846 var1783 " ")) ; Statement: $r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ") 
(declare-const var1783!1 String)
(assert (= var1783!1 (str.++ var1783 " ")))
(define-const var59 String var3275_getLocalHost/-1653363627) ; Statement: $r30 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>() 
(assert true)
(define-const var2297 String (append/672562846 var2972 var59)) ; Statement: $r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30) 
(declare-const var2972!1 String)
(assert (= var2972!1 (str.++ var2972 var59)))
(assert true)
(define-const var1008 String (append/672562846 var2297 " using dubbo version ")) ; Statement: $r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" using dubbo version ") 
(declare-const var2297!1 String)
(assert (= var2297!1 (str.++ var2297 " using dubbo version ")))
(define-const var441 String var1889_getVersion/310196261) ; Statement: $r33 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>() 
(assert true)
(define-const var2006 String (append/672562846 var1008 var441)) ; Statement: $r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r33) 
(declare-const var1008!1 String)
(assert (= var1008!1 (str.++ var1008 var441)))
(assert true)
(define-const var2697 String (append/672562846 var2006 ", cause: the client status is closed.")) ; Statement: $r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: the client status is closed.") 
(declare-const var2006!1 String)
(assert (= var2006!1 (str.++ var2006 ", cause: the client status is closed.")))
(assert true)
(define-const var238 String (toString/-2075883882 var2697)) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1735_warn/1431914100 var537 "6-1" "" "" var238)) ; Statement: interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-1", "", "", $r37) 

(declare-const var537!1 var1735)
(declare-const var3496 String)
(declare-const var2965 String)
(declare-const var2965!1 String)
(declare-const var238!1 String)
 ; Statement: return 
(check-sat)
; {isClosed/1772375327=([org.apache.dubbo.remoting.transport.AbstractPeer], boolean), cast-from-var1360-to-var3266=([org.apache.dubbo.remoting.transport.AbstractClient], org.apache.dubbo.remoting.transport.AbstractPeer), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getRemoteAddress/-557105490=([org.apache.dubbo.remoting.transport.AbstractClient], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var302-to-var2652=([java.net.InetSocketAddress], java.lang.Object), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var1360-to-var2652=([org.apache.dubbo.remoting.transport.AbstractClient], java.lang.Object), getSimpleName/-390194377=([java.lang.Class], java.lang.String), var3275_getLocalHost/-1653363627=([], java.lang.String), var1889_getVersion/310196261=([], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1735_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var1360=org.apache.dubbo.remoting.transport.AbstractClient, var1496=r0, var3266=org.apache.dubbo.remoting.transport.AbstractPeer, var2025=$z0, var1735=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var537=$r22, var2371=$r21, var2114=$r24, var302=java.net.InetSocketAddress, var2625=$r23, var2652=java.lang.Object, var2515=$r25, var3178=$r28, var1760=$r26, var1739=$r27, var1783=$r29, var2972=$r31, var3275=org.apache.dubbo.common.utils.NetUtils, var59=$r30, var2297=$r32, var1008=$r34, var1889=org.apache.dubbo.common.Version, var441=$r33, var2006=$r35, var2697=$r36, var238=$r37, var3496="6-1", var2965=""}
; {org.apache.dubbo.remoting.transport.AbstractClient=var1360, r0=var1496, org.apache.dubbo.remoting.transport.AbstractPeer=var3266, $z0=var2025, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1735, $r22=var537, $r21=var2371, $r24=var2114, java.net.InetSocketAddress=var302, $r23=var2625, java.lang.Object=var2652, $r25=var2515, $r28=var3178, $r26=var1760, $r27=var1739, $r29=var1783, $r31=var2972, org.apache.dubbo.common.utils.NetUtils=var3275, $r30=var59, $r32=var2297, $r34=var1008, org.apache.dubbo.common.Version=var1889, $r33=var441, $r35=var2006, $r36=var2697, $r37=var238, "6-1"=var3496, ""=var2965}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.AbstractClient;	$z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: boolean isClosed()>();	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.remoting.transport.AbstractClient: java.util.concurrent.locks.Lock connectLock>;	$r22 = <org.apache.dubbo.remoting.transport.AbstractClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r21 = new java.lang.StringBuilder;	specialinvoke $r21.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No need to close connection to server ");	$r23 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractClient: java.net.InetSocketAddress getRemoteAddress()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r28 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" from ");	$r26 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r27 = virtualinvoke $r26.<java.lang.Class: java.lang.String getSimpleName()>();	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27);	$r31 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" ");	$r30 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: java.lang.String getLocalHost()>();	$r32 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r30);	$r34 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" using dubbo version ");	$r33 = staticinvoke <org.apache.dubbo.common.Version: java.lang.String getVersion()>();	$r35 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r33);	$r36 = virtualinvoke $r35.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: the client status is closed.");	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r22.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("6-1", "", "", $r37);	return
;block_num 2