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

(declare-sort var1223 0)
(declare-sort var177 0)
(declare-sort var1299 0)
(declare-sort var121 0)
(declare-sort var2636 0)
(declare-sort var3005 0)
(declare-sort var2658 0)
(declare-sort var1326 0)
(declare-sort var590 0)
(declare-sort var814 0)
(declare-sort var3061 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun failTimer/1417468231 (var1223) var2658)
(declare-fun var1326-init () var1326)
(declare-fun retries/1417468231 (var1223) Int)
(declare-fun <init>/-1498217955 (var1326 var1223 var177 var1299 var121 var2636 Int Int var3005) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3061) String)
(declare-fun cast-from-var1299-to-var3061 (var1299) var3061)
(declare-fun getMessage/849299655 (var590) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var814_error/377575788 (var814 String String String String var590) void)
(declare-const null-var1223 var1223)
(declare-const null-var177 var177)
(declare-const null-var1299 var1299)
(declare-const null-var121 var121)
(declare-const null-var2636 var2636)
(declare-const null-var3005 var3005)
(declare-const null-var2658 var2658)
(declare-const null-var590 var590)
(declare-const var1223-logger var814)
(declare-const var365 var1223) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker 
(assert (not (= var365 null-var1223)))
(declare-const var3667 var177) ; Statement: r3 := @parameter0: org.apache.dubbo.rpc.cluster.LoadBalance 
(assert (not (= var3667 null-var177)))
(declare-const var2913 var1299) ; Statement: r4 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2913 null-var1299)))
(declare-const var2746 var121) ; Statement: r5 := @parameter2: java.util.List 
(assert (not (= var2746 null-var121)))
(declare-const var40 var2636) ; Statement: r6 := @parameter3: org.apache.dubbo.rpc.Invoker 
(assert (not (= var40 null-var2636)))
(declare-const var1200 var3005) ; Statement: r7 := @parameter4: org.apache.dubbo.common.URL 
(assert (not (= var1200 null-var3005)))
(define-const var3393 var2658 (failTimer/1417468231 var365)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.timer.Timer failTimer> 
 ; Statement: if $r1 != null goto $r2 = new org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask 
(assert (not (= var3393 null-var2658))) ; Cond: $r1 != null 
(define-const var1574 var1326 var1326-init) ; Statement: $r2 = new org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask 
(define-const var3883 Int (retries/1417468231 var365)) ; Statement: $i0 = r0.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: int retries> 
(assert true)
;(assert (<init>/-1498217955 var1574 var365 var3667 var2913 var2746 var40 var3883 5 var1200)) ; Statement: specialinvoke $r2.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void <init>(org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker,org.apache.dubbo.rpc.cluster.LoadBalance,org.apache.dubbo.rpc.Invocation,java.util.List,org.apache.dubbo.rpc.Invoker,int,long,org.apache.dubbo.common.URL)>(r0, r3, r4, r5, r6, $i0, 5L, r7) 

(declare-const var1574!1 var1326)
(declare-const var365!1 var1223)
(declare-const var3667!1 var177)
(declare-const var2913!1 var1299)
(declare-const var2746!1 var121)
(declare-const var40!1 var2636)
(declare-const var3883!1 Int)
(declare-const var3011 Int)
(declare-const var1200!1 var3005)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3416 var590) ; Statement: $r14 := @caughtexception 
(assert (not (= var3416 null-var590)))
(define-const var900 var814 var1223-logger) ; Statement: $r16 = <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3435 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3435)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3435!1 String)
(assert (= var3435!1 ""))
(assert true)
(define-const var1343 String (append/672562846 var3435!1 "Failback background works error, invocation->")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failback background works error, invocation->") 
(declare-const var3435!2 String)
(assert (= var3435!2 (str.++ var3435!1 "Failback background works error, invocation->")))
(assert true)
(define-const var2420 String (append/-1031950772 var1343 (cast-from-var1299-to-var3061 var2913!1))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r4) 
(declare-const var1343!1 String)
(assert (str.prefixof var1343 var1343!1))
(assert true)
(define-const var1026 String (append/672562846 var2420 ", exception: ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", exception: ") 
(declare-const var2420!1 String)
(assert (= var2420!1 (str.++ var2420 ", exception: ")))
(assert true)
(define-const var175 String (getMessage/849299655 var3416)) ; Statement: $r19 = virtualinvoke $r14.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var641 String (append/672562846 var1026 var175)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var1026!1 String)
(assert (= var1026!1 (str.++ var1026 var175)))
(assert true)
(define-const var1856 String (toString/-2075883882 var641)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var814_error/377575788 var900 "2-9" "add newTimeout exception" "" var1856 var3416)) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-9", "add newTimeout exception", "", $r22, $r14) 

(declare-const var900!1 var814)
(declare-const var1776 String)
(declare-const var2275 String)
(declare-const var3789 String)
(declare-const var1856!1 String)
(declare-const var3416!1 var590)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {failTimer/1417468231=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker], org.apache.dubbo.common.timer.Timer), var1326-init=([], org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask), retries/1417468231=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker], int), <init>/-1498217955=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask, org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker, org.apache.dubbo.rpc.cluster.LoadBalance, org.apache.dubbo.rpc.Invocation, java.util.List, org.apache.dubbo.rpc.Invoker, int, long, org.apache.dubbo.common.URL], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1299-to-var3061=([org.apache.dubbo.rpc.Invocation], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var814_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var1223=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker, var365=r0, var177=org.apache.dubbo.rpc.cluster.LoadBalance, var3667=r3, var1299=org.apache.dubbo.rpc.Invocation, var2913=r4, var121=java.util.List, var2746=r5, var2636=org.apache.dubbo.rpc.Invoker, var40=r6, var3005=org.apache.dubbo.common.URL, var1200=r7, var2658=org.apache.dubbo.common.timer.Timer, var3393=$r1, var1326=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask, var1574=$r2, var3883=$i0, var3011=5L, var590=java.lang.Throwable, var3416=$r14, var814=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var900=$r16, var3435=$r15, var1343=$r17, var3061=java.lang.Object, var2420=$r18, var1026=$r20, var175=$r19, var641=$r21, var1856=$r22, var1776="2-9", var2275="add newTimeout exception", var3789=""}
; {org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker=var1223, r0=var365, org.apache.dubbo.rpc.cluster.LoadBalance=var177, r3=var3667, org.apache.dubbo.rpc.Invocation=var1299, r4=var2913, java.util.List=var121, r5=var2746, org.apache.dubbo.rpc.Invoker=var2636, r6=var40, org.apache.dubbo.common.URL=var3005, r7=var1200, org.apache.dubbo.common.timer.Timer=var2658, $r1=var3393, org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask=var1326, $r2=var1574, $i0=var3883, 5L=var3011, java.lang.Throwable=var590, $r14=var3416, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var814, $r16=var900, $r15=var3435, $r17=var1343, java.lang.Object=var3061, $r18=var2420, $r20=var1026, $r19=var175, $r21=var641, $r22=var1856, "2-9"=var1776, "add newTimeout exception"=var2275, ""=var3789}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker;	r3 := @parameter0: org.apache.dubbo.rpc.cluster.LoadBalance;	r4 := @parameter1: org.apache.dubbo.rpc.Invocation;	r5 := @parameter2: java.util.List;	r6 := @parameter3: org.apache.dubbo.rpc.Invoker;	r7 := @parameter4: org.apache.dubbo.common.URL;	$r1 = r0.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.timer.Timer failTimer>;	if $r1 != null goto $r2 = new org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask;	$r2 = new org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask;	$i0 = r0.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: int retries>;	specialinvoke $r2.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void <init>(org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker,org.apache.dubbo.rpc.cluster.LoadBalance,org.apache.dubbo.rpc.Invocation,java.util.List,org.apache.dubbo.rpc.Invoker,int,long,org.apache.dubbo.common.URL)>(r0, r3, r4, r5, r6, $i0, 5L, r7);	$r14 := @caughtexception;	$r16 = <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failback background works error, invocation->");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r4);	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", exception: ");	$r19 = virtualinvoke $r14.<java.lang.Throwable: java.lang.String getMessage()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-9", "add newTimeout exception", "", $r22, $r14);	return
;block_num 4