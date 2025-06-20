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

(declare-sort var3613 0)
(declare-sort var3643 0)
(declare-sort var3023 0)
(declare-sort var1568 0)
(declare-sort var115 0)
(declare-sort var2354 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3643_getRemoteAddress/1597111645 (var3643) var115)
(declare-fun append/-1031950772 (String var2354) String)
(declare-fun cast-from-var115-to-var2354 (var115) var2354)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1568_warn/126438324 (var1568 String String String String var3023) void)
(declare-const null-var3613 var3613)
(declare-const null-var3643 var3643)
(declare-const null-var3023 var3023)
(declare-const var3613-logger var1568)
(declare-const var520 var3613) ; Statement: r3 := @this: org.apache.dubbo.remoting.exchange.support.header.CloseTimerTask 
(assert (not (= var520 null-var3613)))
(declare-const var3027 var3643) ; Statement: r0 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3027 null-var3643)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2861 var3023) ; Statement: $r12 := @caughtexception 
(assert (not (= var2861 null-var3023)))
(define-const var3728 var1568 var3613-logger) ; Statement: $r14 = <org.apache.dubbo.remoting.exchange.support.header.CloseTimerTask: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1215 String String-init) ; Statement: $r21 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1215)) ; Statement: specialinvoke $r21.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1215!1 String)
(assert (= var1215!1 ""))
(assert true)
(define-const var3636 String (append/672562846 var1215!1 "Exception when close remote channel ")) ; Statement: $r16 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception when close remote channel ") 
(declare-const var1215!2 String)
(assert (= var1215!2 (str.++ var1215!1 "Exception when close remote channel ")))
(define-const var91 var115 (var3643_getRemoteAddress/1597111645 var3027)) ; Statement: $r15 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>() 
(assert true)
(define-const var281 String (append/-1031950772 var3636 (cast-from-var115-to-var2354 var91))) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15) 
(declare-const var3636!1 String)
(assert (str.prefixof var3636 var3636!1))
(assert true)
(define-const var3729 String (toString/-2075883882 var281)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1568_warn/126438324 var3728 "6-3" "" "" var3729 var2861)) ; Statement: interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-3", "", "", $r18, $r12) 

(declare-const var3728!1 var1568)
(declare-const var1624 String)
(declare-const var540 String)
(declare-const var540!1 String)
(declare-const var3729!1 String)
(declare-const var2861!1 var3023)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3643_getRemoteAddress/1597111645=([org.apache.dubbo.remoting.Channel], java.net.InetSocketAddress), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var115-to-var2354=([java.net.InetSocketAddress], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1568_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3613=org.apache.dubbo.remoting.exchange.support.header.CloseTimerTask, var520=r3, var3643=org.apache.dubbo.remoting.Channel, var3027=r0, var3023=java.lang.Throwable, var2861=$r12, var1568=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3728=$r14, var1215=$r21, var3636=$r16, var115=java.net.InetSocketAddress, var91=$r15, var2354=java.lang.Object, var281=$r17, var3729=$r18, var1624="6-3", var540=""}
; {org.apache.dubbo.remoting.exchange.support.header.CloseTimerTask=var3613, r3=var520, org.apache.dubbo.remoting.Channel=var3643, r0=var3027, java.lang.Throwable=var3023, $r12=var2861, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1568, $r14=var3728, $r21=var1215, $r16=var3636, java.net.InetSocketAddress=var115, $r15=var91, java.lang.Object=var2354, $r17=var281, $r18=var3729, "6-3"=var1624, ""=var540}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.remoting.exchange.support.header.CloseTimerTask;	r0 := @parameter0: org.apache.dubbo.remoting.Channel;	$r12 := @caughtexception;	$r14 = <org.apache.dubbo.remoting.exchange.support.header.CloseTimerTask: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r21 = new java.lang.StringBuilder;	specialinvoke $r21.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Exception when close remote channel ");	$r15 = interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: java.net.InetSocketAddress getRemoteAddress()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("6-3", "", "", $r18, $r12);	return
;block_num 3