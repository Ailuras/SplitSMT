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

(declare-sort var3027 0)
(declare-sort var2103 0)
(declare-sort var1722 0)
(declare-sort var2741 0)
(declare-sort var1529 0)
(declare-sort var3363 0)
(declare-sort var226 0)
(declare-sort var2491 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1529_access$000/-563156919 () var2741)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun invocation/-1446163009 (var3027) var3363)
(declare-fun var226_getMethodName/-516674313 (var3363) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2741_error/377575788 (var2741 String String String String var1722) void)
(declare-fun retriedTimes/-1446163009 (var3027) Int)
(declare-fun retries/-1446163009 (var3027) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun append/-1031950772 (String var2491) String)
(declare-fun cast-from-var3363-to-var2491 (var3363) var2491)
(declare-const null-var3027 var3027)
(declare-const null-var2103 var2103)
(declare-const null-var1722 var1722)
(declare-const var896 var3027) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask 
(assert (not (= var896 null-var3027)))
(declare-const var1082 var2103) ; Statement: r31 := @parameter0: org.apache.dubbo.common.timer.Timeout 
(assert (not (= var1082 null-var2103)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var417 var1722) ; Statement: $r22 := @caughtexception 
(assert (not (= var417 null-var1722)))
(define-const var2197 var2741 var1529_access$000/-563156919) ; Statement: $r30 = staticinvoke <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$000()>() 
(define-const var1696 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1696)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1696!1 String)
(assert (= var1696!1 ""))
(assert true)
(define-const var3903 String (append/672562846 var1696!1 "Failed retry to invoke method ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed retry to invoke method ") 
(declare-const var1696!2 String)
(assert (= var1696!2 (str.++ var1696!1 "Failed retry to invoke method ")))
(define-const var1385 var3363 (invocation/-1446163009 var896)) ; Statement: $r24 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: org.apache.dubbo.rpc.Invocation invocation> 
(define-const var3957 String (var226_getMethodName/-516674313 var1385)) ; Statement: $r25 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>($r24) 
(assert true)
(define-const var3350 String (append/672562846 var3903 var3957)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var3903!1 String)
(assert (= var3903!1 (str.++ var3903 var3957)))
(assert true)
(define-const var1570 String (append/672562846 var3350 ", waiting again.")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", waiting again.") 
(declare-const var3350!1 String)
(assert (= var3350!1 (str.++ var3350 ", waiting again.")))
(assert true)
(define-const var205 String (toString/-2075883882 var1570)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2741_error/377575788 var2197 "2-10" "Failed retry to invoke method" "" var205 var417)) ; Statement: interfaceinvoke $r30.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failed retry to invoke method", "", $r29, $r22) 

(declare-const var2197!1 var2741)
(declare-const var1814 String)
(declare-const var2393 String)
(declare-const var3985 String)
(declare-const var205!1 String)
(declare-const var417!1 var1722)
(define-const var1654 Int (retriedTimes/-1446163009 var896)) ; Statement: $i2 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes> 
(define-const var2247 Int (+ var1654 1)) ; Statement: $i3 = $i2 + 1 
(declare-const var896!1 var3027)
(assert (not (= var896!1 null-var3027)))
(assert (= (retriedTimes/-1446163009 var896!1) var2247)) ; Statement: r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes> = $i3 
(define-const var1881 Int (retries/-1446163009 var896!1)) ; Statement: $i4 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retries> 
 ; Statement: if $i3 < $i4 goto specialinvoke r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void rePut(org.apache.dubbo.common.timer.Timeout)>(r31) 
(assert (not (< var2247 var1881))) ; Negate: Cond: $i3 < $i4  
(define-const var2687 var2741 var1529_access$000/-563156919) ; Statement: $r39 = staticinvoke <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$000()>() 
(define-const var1619 String String-init) ; Statement: $r32 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1619)) ; Statement: specialinvoke $r32.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1619!1 String)
(assert (= var1619!1 ""))
(assert true)
(define-const var581 String (append/672562846 var1619!1 "Failed retry times exceed threshold (")) ; Statement: $r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed retry times exceed threshold (") 
(declare-const var1619!2 String)
(assert (= var1619!2 (str.++ var1619!1 "Failed retry times exceed threshold (")))
(define-const var3713 Int (retries/-1446163009 var896!1)) ; Statement: $i5 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retries> 
(assert true)
(define-const var459 String (append/-1001720160 var581 var3713)) ; Statement: $r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i5) 
(declare-const var581!1 String)
(assert (str.prefixof var581 var581!1))
(assert true)
(define-const var328 String (append/672562846 var459 "), We have to abandon, invocation->")) ; Statement: $r36 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), We have to abandon, invocation->") 
(declare-const var459!1 String)
(assert (= var459!1 (str.++ var459 "), We have to abandon, invocation->")))
(define-const var1347 var3363 (invocation/-1446163009 var896!1)) ; Statement: $r35 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: org.apache.dubbo.rpc.Invocation invocation> 
(assert true)
(define-const var423 String (append/-1031950772 var328 (cast-from-var3363-to-var2491 var1347))) ; Statement: $r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var328!1 String)
(assert (str.prefixof var328 var328!1))
(assert true)
(define-const var3291 String (toString/-2075883882 var423)) ; Statement: $r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2741_error/377575788 var2687 "2-10" "Failed retry to invoke method and retry times exceed threshold" "" var3291 var417!1)) ; Statement: interfaceinvoke $r39.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failed retry to invoke method and retry times exceed threshold", "", $r38, $r22) 

(declare-const var2687!1 var2741)
(declare-const var1814!1 String)
(declare-const var1929 String)
(declare-const var3985!1 String)
(declare-const var3291!1 String)
(declare-const var417!2 var1722)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var1529_access$000/-563156919=([], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), invocation/-1446163009=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask], org.apache.dubbo.rpc.Invocation), var226_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2741_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), retriedTimes/-1446163009=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask], int), retries/-1446163009=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3363-to-var2491=([org.apache.dubbo.rpc.Invocation], java.lang.Object)}
; {var3027=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask, var896=r1, var2103=org.apache.dubbo.common.timer.Timeout, var1082=r31, var1722=java.lang.Throwable, var417=$r22, var2741=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1529=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker, var2197=$r30, var1696=$r23, var3903=$r26, var3363=org.apache.dubbo.rpc.Invocation, var1385=$r24, var226=org.apache.dubbo.rpc.support.RpcUtils, var3957=$r25, var3350=$r27, var1570=$r28, var205=$r29, var1814="2-10", var2393="Failed retry to invoke method", var3985="", var1654=$i2, var2247=$i3, var1881=$i4, var2687=$r39, var1619=$r32, var581=$r33, var3713=$i5, var459=$r34, var328=$r36, var1347=$r35, var2491=java.lang.Object, var423=$r37, var3291=$r38, var1929="Failed retry to invoke method and retry times exceed threshold"}
; {org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask=var3027, r1=var896, org.apache.dubbo.common.timer.Timeout=var2103, r31=var1082, java.lang.Throwable=var1722, $r22=var417, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2741, org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker=var1529, $r30=var2197, $r23=var1696, $r26=var3903, org.apache.dubbo.rpc.Invocation=var3363, $r24=var1385, org.apache.dubbo.rpc.support.RpcUtils=var226, $r25=var3957, $r27=var3350, $r28=var1570, $r29=var205, "2-10"=var1814, "Failed retry to invoke method"=var2393, ""=var3985, $i2=var1654, $i3=var2247, $i4=var1881, $r39=var2687, $r32=var1619, $r33=var581, $i5=var3713, $r34=var459, $r36=var328, $r35=var1347, java.lang.Object=var2491, $r37=var423, $r38=var3291, "Failed retry to invoke method and retry times exceed threshold"=var1929}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask;	r31 := @parameter0: org.apache.dubbo.common.timer.Timeout;	$r22 := @caughtexception;	$r30 = staticinvoke <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$000()>();	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed retry to invoke method ");	$r24 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: org.apache.dubbo.rpc.Invocation invocation>;	$r25 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>($r24);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", waiting again.");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r30.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failed retry to invoke method", "", $r29, $r22);	$i2 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes>;	$i3 = $i2 + 1;	r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retriedTimes> = $i3;	$i4 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retries>;	if $i3 < $i4 goto specialinvoke r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: void rePut(org.apache.dubbo.common.timer.Timeout)>(r31);	$r39 = staticinvoke <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger access$000()>();	$r32 = new java.lang.StringBuilder;	specialinvoke $r32.<java.lang.StringBuilder: void <init>()>();	$r33 = virtualinvoke $r32.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed retry times exceed threshold (");	$i5 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: int retries>;	$r34 = virtualinvoke $r33.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i5);	$r36 = virtualinvoke $r34.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), We have to abandon, invocation->");	$r35 = r1.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker$RetryTimerTask: org.apache.dubbo.rpc.Invocation invocation>;	$r37 = virtualinvoke $r36.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	$r38 = virtualinvoke $r37.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r39.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failed retry to invoke method and retry times exceed threshold", "", $r38, $r22);	goto [?= return];	return
;block_num 4