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

(declare-sort var2082 0)
(declare-sort var51 0)
(declare-sort var2859 0)
(declare-sort var3632 0)
(declare-sort var1720 0)
(declare-sort var311 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var51_getRemoteAddress/1597111645 (var51) var1720)
(declare-fun append/-1031950772 (String var311) String)
(declare-fun cast-from-var1720-to-var311 (var1720) var311)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3632_warn/126438324 (var3632 String String String String var2859) void)
(declare-const null-var2082 var2082)
(declare-const null-var51 var51)
(declare-const null-var2859 var2859)
(declare-const var2082-logger var3632)
(declare-const var2919 var2082) ; Statement: r2 := @this: org.apache.dubbo.remoting.exchange.support.header.ReconnectTimerTask 
(assert (not (= var2919 null-var2082)))
(declare-const var3812 var51) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3812 null-var51)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1207 var2859) ; Statement: $r18 := @caughtexception 
(assert (not (= var1207 null-var2859)))
(define-const var1055 var3632 var2082-logger) ; Statement: $r20 = <org.apache.dubbo.remoting.exchange.support.header.ReconnectTimerTask: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1081 String String-init) ; Statement: $r42 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1081)) ; Statement: specialinvoke $r42.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1081!1 String)
(assert (= var1081!1 ""))
(assert true)
(define-const var3571 String (append/672562846 var1081!1 "Exception when reconnect to remote channel ")) ; Statement: $r22 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception when reconnect to remote channel ") 
(declare-const var1081!2 String)
(assert (= var1081!2 (str.++ var1081!1 "Exception when reconnect to remote channel ")))
(define-const var1934 var1720 (var51_getRemoteAddress/1597111645 var3812)) ; Statement: $r21 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var1328 String (append/-1031950772 var3571 (cast-from-var1720-to-var311 var1934))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r21) 
(declare-const var3571!1 String)
(assert (str.prefixof var3571 var3571!1))
(assert true)
(define-const var3527 String (toString/-2075883882 var1328)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3632_warn/126438324 var1055 "99-0" "unknown error in remoting module" "" var3527 var1207)) ; Statement: interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("99-0", "unknown error in remoting module", "", $r24, $r18) 

(declare-const var1055!1 var3632)
(declare-const var1385 String)
(declare-const var191 String)
(declare-const var685 String)
(declare-const var3527!1 String)
(declare-const var1207!1 var2859)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var51_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1720-to-var311=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3632_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var2082=org.apache.dubbo.remoting.exchange.support.header.ReconnectTimerTask, var2919=r2, var51=org.apache.dubbo.remoting.Channel, var3812=r0, var2859=java.lang.Throwable, var1207=$r18, var3632=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1055=$r20, var1081=$r42, var3571=$r22, var1720=java.net.InetSocketAddress, var1934=$r21, var311=java.lang.Object, var1328=$r23, var3527=$r24, var1385="99-0", var191="unknown error in remoting module", var685=""}
; {org.apache.dubbo.remoting.exchange.support.header.ReconnectTimerTask=var2082, r2=var2919, org.apache.dubbo.remoting.Channel=var51, r0=var3812, java.lang.Throwable=var2859, $r18=var1207, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3632, $r20=var1055, $r42=var1081, $r22=var3571, java.net.InetSocketAddress=var1720, $r21=var1934, java.lang.Object=var311, $r23=var1328, $r24=var3527, "99-0"=var1385, "unknown error in remoting module"=var191, ""=var685}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.remoting.exchange.support.header.ReconnectTimerTask;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r18 := @caughtexception;	$r20 = <org.apache.dubbo.remoting.exchange.support.header.ReconnectTimerTask: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r42 = new java.lang.StringBuilder;	specialinvoke $r42.<java.lang.StringBuilder: void <init>()>();	$r22 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception when reconnect to remote channel ");	$r21 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r21);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r20.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("99-0", "unknown error in remoting module", "", $r24, $r18);	return
;block_num 3