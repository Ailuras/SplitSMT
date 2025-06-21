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

(declare-sort var1026 0)
(declare-sort var1285 0)
(declare-sort var529 0)
(declare-sort var3394 0)
(declare-sort var57 0)
(declare-sort var2891 0)
(declare-sort var2798 0)
(declare-sort var2730 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var57) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2891_error/377575788 (var2891 String String String String var57) void)
(declare-fun var2798_newDefaultAsyncResult/-950815275 (var2730 var57 var1285) var2798)
(declare-const null-var1026 var1026)
(declare-const null-var1285 var1285)
(declare-const null-var529 var529)
(declare-const null-var3394 var3394)
(declare-const null-var57 var57)
(declare-const var1026-logger var2891)
(declare-const null-var2730 var2730)
(declare-const var3221 var1026) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.support.FailsafeClusterInvoker 
(assert (not (= var3221 null-var1026)))
(declare-const var3303 var1285) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var3303 null-var1285)))
(declare-const var3663 var529) ; Statement: r3 := @parameter1: java.util.List 
(assert (not (= var3663 null-var529)))
(declare-const var2658 var3394) ; Statement: r1 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance 
(assert (not (= var2658 null-var3394)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2140 var57) ; Statement: $r5 := @caughtexception 
(assert (not (= var2140 null-var57)))
(define-const var2340 var2891 var1026-logger) ; Statement: $r7 = <org.apache.dubbo.rpc.cluster.support.FailsafeClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3287 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3287)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3287!1 String)
(assert (= var3287!1 ""))
(assert true)
(define-const var2330 String (append/672562846 var3287!1 "Failsafe ignore exception: ")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failsafe ignore exception: ") 
(declare-const var3287!2 String)
(assert (= var3287!2 (str.++ var3287!1 "Failsafe ignore exception: ")))
(assert true)
(define-const var3052 String (getMessage/849299655 var2140)) ; Statement: $r8 = virtualinvoke $r5.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3132 String (append/672562846 var2330 var3052)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2330!1 String)
(assert (= var2330!1 (str.++ var2330 var3052)))
(assert true)
(define-const var727 String (toString/-2075883882 var3132)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2891_error/377575788 var2340 "2-8" "Failsafe for provider exception" "" var727 var2140)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-8", "Failsafe for provider exception", "", $r11, $r5) 

(declare-const var2340!1 var2891)
(declare-const var2292 String)
(declare-const var3867 String)
(declare-const var3607 String)
(declare-const var727!1 String)
(declare-const var2140!1 var57)
(define-const var1730 var2798 (var2798_newDefaultAsyncResult/-950815275 null-var2730 null-var57 var3303)) ; Statement: $r12 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Object,java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>(null, null, r2) 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2891_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var2798_newDefaultAsyncResult/-950815275=([java.lang.Object, java.lang.Throwable, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.AsyncRpcResult)}
; {var1026=org.apache.dubbo.rpc.cluster.support.FailsafeClusterInvoker, var3221=r0, var1285=org.apache.dubbo.rpc.Invocation, var3303=r2, var529=java.util.List, var3663=r3, var3394=org.apache.dubbo.rpc.cluster.LoadBalance, var2658=r1, var57=java.lang.Throwable, var2140=$r5, var2891=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2340=$r7, var3287=$r6, var2330=$r9, var3052=$r8, var3132=$r10, var727=$r11, var2292="2-8", var3867="Failsafe for provider exception", var3607="", var2798=org.apache.dubbo.rpc.AsyncRpcResult, var2730=java.lang.Object, var1730=$r12}
; {org.apache.dubbo.rpc.cluster.support.FailsafeClusterInvoker=var1026, r0=var3221, org.apache.dubbo.rpc.Invocation=var1285, r2=var3303, java.util.List=var529, r3=var3663, org.apache.dubbo.rpc.cluster.LoadBalance=var3394, r1=var2658, java.lang.Throwable=var57, $r5=var2140, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2891, $r7=var2340, $r6=var3287, $r9=var2330, $r8=var3052, $r10=var3132, $r11=var727, "2-8"=var2292, "Failsafe for provider exception"=var3867, ""=var3607, org.apache.dubbo.rpc.AsyncRpcResult=var2798, java.lang.Object=var2730, $r12=var1730}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.support.FailsafeClusterInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.Invocation;	r3 := @parameter1: java.util.List;	r1 := @parameter2: org.apache.dubbo.rpc.cluster.LoadBalance;	$r5 := @caughtexception;	$r7 = <org.apache.dubbo.rpc.cluster.support.FailsafeClusterInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failsafe ignore exception: ");	$r8 = virtualinvoke $r5.<java.lang.Throwable: java.lang.String getMessage()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-8", "Failsafe for provider exception", "", $r11, $r5);	$r12 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Object,java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>(null, null, r2);	return $r12
;block_num 2