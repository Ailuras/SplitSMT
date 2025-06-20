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

(declare-sort var702 0)
(declare-sort var3516 0)
(declare-sort var1157 0)
(declare-sort var238 0)
(declare-sort var3179 0)
(declare-sort var190 0)
(declare-sort var3106 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3179_access$000/-563156919 () var238)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun invocation/-1446163009 (var702) var190)
(declare-fun var3106_getMethodName/-516674313 (var190) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var238_error/377575788 (var238 String String String String var1157) void)
(declare-fun retriedTimes/-1446163009 (var702) Int)
(declare-fun retries/-1446163009 (var702) Int)
(declare-fun rePut/-1547903079 (var702 var3516) void)
(declare-const null-var702 var702)
(declare-const null-var3516 var3516)
(declare-const null-var1157 var1157)
(declare-const var3813 var702) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask 
(assert (not (= var3813 null-var702)))
(declare-const var2269 var3516) ; Statement: r31 := @parameter0: org.apache.dubbo.common.timer.Timeout 
(assert (not (= var2269 null-var3516)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var744 var1157) ; Statement: $r22 := @caughtexception 
(assert (not (= var744 null-var1157)))
(define-const var1474 var238 var3179_access$000/-563156919) ; Statement: $r30 = staticinvoke <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$000()>() 
(define-const var2115 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2115)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2115!1 String)
(assert (= var2115!1 ""))
(assert true)
(define-const var1638 String (append/672562846 var2115!1 "Failed retry to invoke method ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed retry to invoke method ") 
(declare-const var2115!2 String)
(assert (= var2115!2 (str.++ var2115!1 "Failed retry to invoke method ")))
(define-const var3564 var190 (invocation/-1446163009 var3813)) ; Statement: $r24 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: org.apache.dubbo.rpc.Invocation invocation> 
(define-const var2826 String (var3106_getMethodName/-516674313 var3564)) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>($r24) 
(assert true)
(define-const var2544 String (append/672562846 var1638 var2826)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var1638!1 String)
(assert (= var1638!1 (str.++ var1638 var2826)))
(assert true)
(define-const var2746 String (append/672562846 var2544 ", waiting again.")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", waiting again.") 
(declare-const var2544!1 String)
(assert (= var2544!1 (str.++ var2544 ", waiting again.")))
(assert true)
(define-const var572 String (toString/-2075883882 var2746)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var238_error/377575788 var1474 "2-10" "Failed retry to invoke method" "" var572 var744)) ; Statement: interfaceinvoke $r30.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failed retry to invoke method", "", $r29, $r22) 

(declare-const var1474!1 var238)
(declare-const var2407 String)
(declare-const var3671 String)
(declare-const var812 String)
(declare-const var572!1 String)
(declare-const var744!1 var1157)
(define-const var3412 Int (retriedTimes/-1446163009 var3813)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes> 
(define-const var605 Int (+ var3412 1)) ; Statement: $i3 = $i2 + 1 
(declare-const var3813!1 var702)
(assert (not (= var3813!1 null-var702)))
(assert (= (retriedTimes/-1446163009 var3813!1) var605)) ; Statement: r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes> = $i3 
(define-const var2359 Int (retries/-1446163009 var3813!1)) ; Statement: $i4 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retries> 
 ; Statement: if $i3 < $i4 goto specialinvoke r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void rePut(org.apache.dubbo.common.timer.Timeout)>(r31) 
(assert (< var605 var2359)) ; Cond: $i3 < $i4 
(assert true)
;(assert (rePut/-1547903079 var3813!1 var2269)) ; Statement: specialinvoke r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void rePut(org.apache.dubbo.common.timer.Timeout)>(r31) 

(declare-const var3813!2 var702)
(declare-const var2269!1 var3516)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var3179_access$000/-563156919=([], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), invocation/-1446163009=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask], org.apache.dubbo.rpc.Invocation), var3106_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var238_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), retriedTimes/-1446163009=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask], int), retries/-1446163009=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask], int), rePut/-1547903079=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask, org.apache.dubbo.common.timer.Timeout], void)}
; {var702=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask, var3813=r1, var3516=org.apache.dubbo.common.timer.Timeout, var2269=r31, var1157=java.lang.Throwable, var744=$r22, var238=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3179=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker, var1474=$r30, var2115=$r23, var1638=$r26, var190=org.apache.dubbo.rpc.Invocation, var3564=$r24, var3106=org.apache.dubbo.rpc.support.RpcUtils, var2826=$r25, var2544=$r27, var2746=$r28, var572=$r29, var2407="2-10", var3671="Failed retry to invoke method", var812="", var3412=$i2, var605=$i3, var2359=$i4}
; {org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask=var702, r1=var3813, org.apache.dubbo.common.timer.Timeout=var3516, r31=var2269, java.lang.Throwable=var1157, $r22=var744, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var238, org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker=var3179, $r30=var1474, $r23=var2115, $r26=var1638, org.apache.dubbo.rpc.Invocation=var190, $r24=var3564, org.apache.dubbo.rpc.support.RpcUtils=var3106, $r25=var2826, $r27=var2544, $r28=var2746, $r29=var572, "2-10"=var2407, "Failed retry to invoke method"=var3671, ""=var812, $i2=var3412, $i3=var605, $i4=var2359}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask;	r31 := @parameter0: org.apache.dubbo.common.timer.Timeout;	$r22 := @caughtexception;	$r30 = staticinvoke <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$000()>();	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed retry to invoke method ");	$r24 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: org.apache.dubbo.rpc.Invocation invocation>;	$r25 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>($r24);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", waiting again.");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r30.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failed retry to invoke method", "", $r29, $r22);	$i2 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes>;	$i3 = $i2 + 1;	r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes> = $i3;	$i4 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retries>;	if $i3 < $i4 goto specialinvoke r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void rePut(org.apache.dubbo.common.timer.Timeout)>(r31);	specialinvoke r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void rePut(org.apache.dubbo.common.timer.Timeout)>(r31);	return
;block_num 4