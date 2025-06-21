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

(declare-sort var3542 0)
(declare-sort var2717 0)
(declare-sort var1467 0)
(declare-sort var2227 0)
(declare-sort var1375 0)
(declare-sort var2697 0)
(declare-sort var25 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPreferredExecutorService/166314845 (var1375 var1467) var2227)
(declare-fun cast-from-var3542-to-var1375 (var3542) var1375)
(declare-fun var25-init () var25)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getClass/1258963082 (var1467) ClassObject)
(declare-fun cast-from-var3542-to-var1467 (var3542) var1467)
(declare-fun append/-1031950772 (String var1467) String)
(declare-fun cast-from-ClassObject-to-var1467 (ClassObject) var1467)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1164709639 (var25 var1467 var2717 String var2697) void)
(declare-const null-var3542 var3542)
(declare-const null-var2717 var2717)
(declare-const null-var1467 var1467)
(declare-const null-var2697 var2697)
(declare-const var2219 var3542) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler 
(assert (not (= var2219 null-var3542)))
(declare-const var3282 var2717) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3282 null-var2717)))
(declare-const var3824 var1467) ; Statement: r1 := @parameter1: java.lang.Object 
(assert (not (= var3824 null-var1467)))
(assert true)
(define-const var2020 var2227 (getPreferredExecutorService/166314845 (cast-from-var3542-to-var1375 var2219) var3824)) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1) 
(define-const var3025 Bool false) ; Statement: $z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request 
 ; Statement: if $z0 == 0 goto $z1 = r2 instanceof org.apache.dubbo.common.threadpool.ThreadlessExecutor 
(assert (not (= (ite var3025 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var1647 var2697) ; Statement: $r11 := @caughtexception 
(assert (not (= var1647 null-var2697)))
(define-const var3230 Bool false) ; Statement: $z2 = $r11 instanceof java.util.concurrent.RejectedExecutionException 
 ; Statement: if $z2 == 0 goto $r12 = new org.apache.dubbo.remoting.ExecutionException 
(assert (= (ite var3230 1 0) 0)) ; Cond: $z2 == 0 
(define-const var3825 var25 var25-init) ; Statement: $r12 = new org.apache.dubbo.remoting.ExecutionException 
(define-const var2922 String String-init) ; Statement: $r13 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2922)) ; Statement: specialinvoke $r13.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2922!1 String)
(assert (= var2922!1 ""))
(assert true)
(define-const var909 ClassObject (getClass/1258963082 (cast-from-var3542-to-var1467 var2219))) ; Statement: $r14 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>() 
(assert true)
(define-const var782 String (append/-1031950772 var2922!1 (cast-from-ClassObject-to-var1467 var909))) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var2922!2 String)
(assert (str.prefixof var2922!1 var2922!2))
(assert true)
(define-const var521 String (append/672562846 var782 " error when process received event.")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event.") 
(declare-const var782!1 String)
(assert (= var782!1 (str.++ var782 " error when process received event.")))
(assert true)
(define-const var1579 String (toString/-2075883882 var521)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1164709639 var3825 var3824 var3282 var1579 var1647)) ; Statement: specialinvoke $r12.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r3, $r17, $r11) 

(declare-const var3825!1 var25)
(declare-const var3824!1 var1467)
(declare-const var3282!1 var2717)
(declare-const var1579!1 String)
(declare-const var1647!1 var2697)
 ; Statement: throw $r12 
(check-sat)
; {getPreferredExecutorService/166314845=([org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, java.lang.Object], java.util.concurrent.ExecutorService), cast-from-var3542-to-var1375=([org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler], org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler), var25-init=([], org.apache.dubbo.remoting.ExecutionException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3542-to-var1467=([org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var1467=([java.lang.Class], java.lang.Object), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1164709639=([org.apache.dubbo.remoting.ExecutionException, java.lang.Object, org.apache.dubbo.remoting.Channel, java.lang.String, java.lang.Throwable], void)}
; {var3542=org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler, var2219=r0, var2717=org.apache.dubbo.remoting.Channel, var3282=r3, var1467=java.lang.Object, var3824=r1, var2227=java.util.concurrent.ExecutorService, var1375=org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler, var2020=r2, var3025=$z0, var2697=java.lang.Throwable, var1647=$r11, var3230=$z2, var25=org.apache.dubbo.remoting.ExecutionException, var3825=$r12, var2922=$r13, var909=$r14, var782=$r15, var521=$r16, var1579=$r17}
; {org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler=var3542, r0=var2219, org.apache.dubbo.remoting.Channel=var2717, r3=var3282, java.lang.Object=var1467, r1=var3824, java.util.concurrent.ExecutorService=var2227, org.apache.dubbo.remoting.transport.dispatcher.WrappedChannelHandler=var1375, r2=var2020, $z0=var3025, java.lang.Throwable=var2697, $r11=var1647, $z2=var3230, org.apache.dubbo.remoting.ExecutionException=var25, $r12=var3825, $r13=var2922, $r14=var909, $r15=var782, $r16=var521, $r17=var1579}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	r1 := @parameter1: java.lang.Object;	r2 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.dispatcher.execution.ExecutionChannelHandler: java.util.concurrent.ExecutorService getPreferredExecutorService(java.lang.Object)>(r1);	$z0 = r1 instanceof org.apache.dubbo.remoting.exchange.Request;	if $z0 == 0 goto $z1 = r2 instanceof org.apache.dubbo.common.threadpool.ThreadlessExecutor;	$r11 := @caughtexception;	$z2 = $r11 instanceof java.util.concurrent.RejectedExecutionException;	if $z2 == 0 goto $r12 = new org.apache.dubbo.remoting.ExecutionException;	$r12 = new org.apache.dubbo.remoting.ExecutionException;	$r13 = new java.lang.StringBuilder;	specialinvoke $r13.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke r0.<java.lang.Object: java.lang.Class getClass()>();	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" error when process received event.");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r12.<org.apache.dubbo.remoting.ExecutionException: void <init>(java.lang.Object,org.apache.dubbo.remoting.Channel,java.lang.String,java.lang.Throwable)>(r1, r3, $r17, $r11);	throw $r12
;block_num 3