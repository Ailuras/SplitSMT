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

(declare-sort var1701 0)
(declare-sort var2421 0)
(declare-sort var1866 0)
(declare-sort var509 0)
(declare-sort var271 0)
(declare-sort var2431 0)
(declare-sort var94 0)
(declare-sort var376 0)
(declare-sort var2609 0)
(declare-sort var549 0)
(declare-sort var749 0)
(declare-sort var2951 0)
(declare-sort var1938 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var94_getServiceContext/735675290 () var2431)
(declare-fun getConsumerUrl/-1021200294 (var2431) var376)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var749_getMethodName/-516674313 (var2421) String)
(declare-fun getMessage/849299655 (var2609) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var549_error/377575788 (var549 String String String String var2609) void)
(declare-fun retries/1417468231 (var1701) Int)
(declare-fun var2951_newDefaultAsyncResult/-950815275 (var1938 var2609 var2421) var2951)
(declare-const null-var1701 var1701)
(declare-const null-var2421 var2421)
(declare-const null-var1866 var1866)
(declare-const null-var509 var509)
(declare-const null-var271 var271)
(declare-const null-var2609 var2609)
(declare-const var1701-logger var549)
(declare-const null-var1938 var1938)
(declare-const var2520 var1701) ; Statement: r2 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker 
(assert (not (= var2520 null-var1701)))
(declare-const var20 var2421) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var20 null-var2421)))
(declare-const var1242 var1866) ; Statement: r5 := @parameter1: java.util.List 
(assert (not (= var1242 null-var1866)))
(declare-const var2397 var509) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance 
(assert (not (= var2397 null-var509)))
(define-const var3100 var271 null-var271) ; Statement: r19 = null 
(define-const var2305 var2431 var94_getServiceContext/735675290) ; Statement: $r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var1724 var376 (getConsumerUrl/-1021200294 var2305)) ; Statement: r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var829 var2609) ; Statement: $r7 := @caughtexception 
(assert (not (= var829 null-var2609)))
(define-const var1331 var549 var1701-logger) ; Statement: $r9 = <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1579 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1579)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1579!1 String)
(assert (= var1579!1 ""))
(assert true)
(define-const var194 String (append/672562846 var1579!1 "Failback to invoke method ")) ; Statement: $r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failback to invoke method ") 
(declare-const var1579!2 String)
(assert (= var1579!2 (str.++ var1579!1 "Failback to invoke method ")))
(define-const var921 String (var749_getMethodName/-516674313 var20)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r4) 
(assert true)
(define-const var2146 String (append/672562846 var194 var921)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var194!1 String)
(assert (= var194!1 (str.++ var194 var921)))
(assert true)
(define-const var992 String (append/672562846 var2146 ", wait for retry in background. Ignored exception: ")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", wait for retry in background. Ignored exception: ") 
(declare-const var2146!1 String)
(assert (= var2146!1 (str.++ var2146 ", wait for retry in background. Ignored exception: ")))
(assert true)
(define-const var503 String (getMessage/849299655 var829)) ; Statement: $r13 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3676 String (append/672562846 var992 var503)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var992!1 String)
(assert (= var992!1 (str.++ var992 var503)))
(assert true)
(define-const var2975 String (append/672562846 var3676 ", ")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ") 
(declare-const var3676!1 String)
(assert (= var3676!1 (str.++ var3676 ", ")))
(assert true)
(define-const var3406 String (toString/-2075883882 var2975)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var549_error/377575788 var1331 "2-10" "Failback to invoke method and start to retries" "" var3406 var829)) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failback to invoke method and start to retries", "", $r17, $r7) 

(declare-const var1331!1 var549)
(declare-const var1018 String)
(declare-const var2715 String)
(declare-const var2578 String)
(declare-const var3406!1 String)
(declare-const var829!1 var2609)
(define-const var3227 Int (retries/1417468231 var2520)) ; Statement: $i0 = r2.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: int retries> 
 ; Statement: if $i0 <= 0 goto $r18 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Object,java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>(null, null, r4) 
(assert (<= var3227 0)) ; Cond: $i0 <= 0 
(define-const var1298 var2951 (var2951_newDefaultAsyncResult/-950815275 null-var1938 null-var2609 var20)) ; Statement: $r18 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Object,java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>(null, null, r4) 
 ; Statement: return $r18 
(check-sat)
; {var94_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var749_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var549_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), retries/1417468231=([org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker], int), var2951_newDefaultAsyncResult/-950815275=([java.lang.Object, java.lang.Throwable, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.AsyncRpcResult)}
; {var1701=org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker, var2520=r2, var2421=org.apache.dubbo.rpc.Invocation, var20=r4, var1866=java.util.List, var1242=r5, var509=org.apache.dubbo.rpc.cluster.LoadBalance, var2397=r3, var271=org.apache.dubbo.rpc.Invoker, var3100=r19, var2431=org.apache.dubbo.rpc.RpcServiceContext, var94=org.apache.dubbo.rpc.RpcContext, var2305=$r0, var376=org.apache.dubbo.common.URL, var1724=r1, var2609=java.lang.Throwable, var829=$r7, var549=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1331=$r9, var1579=$r8, var194=$r11, var749=org.apache.dubbo.rpc.support.RpcUtils, var921=$r10, var2146=$r12, var992=$r14, var503=$r13, var3676=$r15, var2975=$r16, var3406=$r17, var1018="2-10", var2715="Failback to invoke method and start to retries", var2578="", var3227=$i0, var2951=org.apache.dubbo.rpc.AsyncRpcResult, var1938=java.lang.Object, var1298=$r18}
; {org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker=var1701, r2=var2520, org.apache.dubbo.rpc.Invocation=var2421, r4=var20, java.util.List=var1866, r5=var1242, org.apache.dubbo.rpc.cluster.LoadBalance=var509, r3=var2397, org.apache.dubbo.rpc.Invoker=var271, r19=var3100, org.apache.dubbo.rpc.RpcServiceContext=var2431, org.apache.dubbo.rpc.RpcContext=var94, $r0=var2305, org.apache.dubbo.common.URL=var376, r1=var1724, java.lang.Throwable=var2609, $r7=var829, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var549, $r9=var1331, $r8=var1579, $r11=var194, org.apache.dubbo.rpc.support.RpcUtils=var749, $r10=var921, $r12=var2146, $r14=var992, $r13=var503, $r15=var3676, $r16=var2975, $r17=var3406, "2-10"=var1018, "Failback to invoke method and start to retries"=var2715, ""=var2578, $i0=var3227, org.apache.dubbo.rpc.AsyncRpcResult=var2951, java.lang.Object=var1938, $r18=var1298}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker;	r4 := @parameter0: org.apache.dubbo.rpc.Invocation;	r5 := @parameter1: java.util.List;	r3 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance;	r19 = null;	$r0 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r1 = virtualinvoke $r0.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	$r7 := @caughtexception;	$r9 = <org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failback to invoke method ");	$r10 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r4);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", wait for retry in background. Ignored exception: ");	$r13 = virtualinvoke $r7.<java.lang.Throwable: java.lang.String getMessage()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", ");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-10", "Failback to invoke method and start to retries", "", $r17, $r7);	$i0 = r2.<org.apache.dubbo.rpc.cluster.support.FailbackClusterInvoker: int retries>;	if $i0 <= 0 goto $r18 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Object,java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>(null, null, r4);	$r18 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Object,java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>(null, null, r4);	return $r18
;block_num 3