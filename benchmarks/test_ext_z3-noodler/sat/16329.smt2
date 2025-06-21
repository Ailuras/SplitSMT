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

(declare-sort var1231 0)
(declare-sort var3327 0)
(declare-sort var2767 0)
(declare-sort var1122 0)
(declare-sort var3225 0)
(declare-sort var149 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3327_getRemoteAddress/1597111645 (var3327) var3225)
(declare-fun append/-1031950772 (String var149) String)
(declare-fun cast-from-var3225-to-var149 (var3225) var149)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1122_warn/126438324 (var1122 String String String String var2767) void)
(declare-const null-var1231 var1231)
(declare-const null-var3327 var3327)
(declare-const null-var2767 var2767)
(declare-const var1231-logger var1122)
(declare-const var1106 var1231) ; Statement: r3 := @this: org.apache.dubbo.remoting.exchange.support.header.HeartbeatTimerTask 
(assert (not (= var1106 null-var1231)))
(declare-const var1465 var3327) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var1465 null-var3327)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2803 var2767) ; Statement: $r17 := @caughtexception 
(assert (not (= var2803 null-var2767)))
(define-const var2833 var1122 var1231-logger) ; Statement: $r19 = <org.apache.dubbo.remoting.exchange.support.header.HeartbeatTimerTask: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1690 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1690)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1690!1 String)
(assert (= var1690!1 ""))
(assert true)
(define-const var1307 String (append/672562846 var1690!1 "Exception when heartbeat to remote channel ")) ; Statement: $r21 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception when heartbeat to remote channel ") 
(declare-const var1690!2 String)
(assert (= var1690!2 (str.++ var1690!1 "Exception when heartbeat to remote channel ")))
(define-const var679 var3225 (var3327_getRemoteAddress/1597111645 var1465)) ; Statement: $r20 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var165 String (append/-1031950772 var1307 (cast-from-var3225-to-var149 var679))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var1307!1 String)
(assert (str.prefixof var1307 var1307!1))
(assert true)
(define-const var3271 String (toString/-2075883882 var165)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1122_warn/126438324 var2833 "6-14" "" "" var3271 var2803)) ; Statement: interfaceinvoke $r19.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-14", "", "", $r23, $r17) 

(declare-const var2833!1 var1122)
(declare-const var3709 String)
(declare-const var38 String)
(declare-const var38!1 String)
(declare-const var3271!1 String)
(declare-const var2803!1 var2767)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3327_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3225-to-var149=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1122_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1231=org.apache.dubbo.remoting.exchange.support.header.HeartbeatTimerTask, var1106=r3, var3327=org.apache.dubbo.remoting.Channel, var1465=r0, var2767=java.lang.Throwable, var2803=$r17, var1122=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2833=$r19, var1690=$r27, var1307=$r21, var3225=java.net.InetSocketAddress, var679=$r20, var149=java.lang.Object, var165=$r22, var3271=$r23, var3709="6-14", var38=""}
; {org.apache.dubbo.remoting.exchange.support.header.HeartbeatTimerTask=var1231, r3=var1106, org.apache.dubbo.remoting.Channel=var3327, r0=var1465, java.lang.Throwable=var2767, $r17=var2803, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1122, $r19=var2833, $r27=var1690, $r21=var1307, java.net.InetSocketAddress=var3225, $r20=var679, java.lang.Object=var149, $r22=var165, $r23=var3271, "6-14"=var3709, ""=var38}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.exchange.support.header.HeartbeatTimerTask;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r17 := @caughtexception;	$r19 = <org.apache.dubbo.remoting.exchange.support.header.HeartbeatTimerTask: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r21 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception when heartbeat to remote channel ");	$r20 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r19.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-14", "", "", $r23, $r17);	return
;block_num 3