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

(declare-sort var748 0)
(declare-sort var2080 0)
(declare-sort var3634 0)
(declare-sort var1547 0)
(declare-sort var2003 0)
(declare-sort var1910 0)
(declare-sort var3530 0)
(declare-sort var3506 0)
(declare-sort var72 0)
(declare-sort var2761 0)
(declare-sort var1294 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getUrl/-945338117 (var3530) var1910)
(declare-fun cast-from-var748-to-var3530 (var748) var3530)
(declare-fun var3506_getMethodName/-516674313 (var3634) String)
(declare-fun var3506_calculateTimeout/2120566713 (var1910 var3634 String Int) Int)
(declare-fun var72-init () var72)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3634_getServiceName/-67876927 (var3634) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1027821060 (var72 Int String) void)
(declare-fun var2761_newDefaultAsyncResult/-2013762118 (var1294 var3634) var2761)
(declare-fun cast-from-var72-to-var1294 (var72) var1294)
(declare-const null-var748 var748)
(declare-const null-var2080 var2080)
(declare-const null-var3634 var3634)
(declare-const null-var1547 var1547)
(declare-const null-var2003 var2003)
(declare-const var2177 var748) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker 
(assert (not (= var2177 null-var748)))
(declare-const var3337 var2080) ; Statement: r6 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor 
(assert (not (= var3337 null-var2080)))
(declare-const var1214 var3634) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1214 null-var3634)))
(declare-const var1796 var1547) ; Statement: r17 := @parameter2: org.apache.dubbo.rpc.protocol.tri.call.ClientCall 
(assert (not (= var1796 null-var1547)))
(declare-const var1615 var2003) ; Statement: r8 := @parameter3: java.util.concurrent.ExecutorService 
(assert (not (= var1615 null-var2003)))
(assert true)
(define-const var1285 var1910 (getUrl/-945338117 (cast-from-var748-to-var3530 var2177))) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>() 
(define-const var763 String (var3506_getMethodName/-516674313 var1214)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1) 
(define-const var1630 Int (var3506_calculateTimeout/2120566713 var1285 var1214 var763 3000)) ; Statement: i0 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: int calculateTimeout(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation,java.lang.String,long)>($r3, r1, $r2, 3000L) 
 ; Statement: if i0 > 0 goto $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0) 
(assert (not (> var1630 0))) ; Negate: Cond: i0 > 0  
(define-const var2449 var72 var72-init) ; Statement: $r22 = new org.apache.dubbo.rpc.RpcException 
(define-const var1298 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1298)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1298!1 String)
(assert (= var1298!1 ""))
(assert true)
(define-const var3569 String (append/672562846 var1298!1 "No time left for making the following call: ")) ; Statement: $r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No time left for making the following call: ") 
(declare-const var1298!2 String)
(assert (= var1298!2 (str.++ var1298!1 "No time left for making the following call: ")))
(define-const var1433 String (var3634_getServiceName/-67876927 var1214)) ; Statement: $r24 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>() 
(assert true)
(define-const var1569 String (append/672562846 var3569 var1433)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24) 
(declare-const var3569!1 String)
(assert (= var3569!1 (str.++ var3569 var1433)))
(assert true)
(define-const var3583 String (append/672562846 var1569 ".")) ; Statement: $r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1569!1 String)
(assert (= var1569!1 (str.++ var1569 ".")))
(define-const var3519 String (var3506_getMethodName/-516674313 var1214)) ; Statement: $r27 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1) 
(assert true)
(define-const var1678 String (append/672562846 var3583 var3519)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27) 
(declare-const var3583!1 String)
(assert (= var3583!1 (str.++ var3583 var3519)))
(assert true)
(define-const var941 String (append/672562846 var1678 ", terminate directly.")) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", terminate directly.") 
(declare-const var1678!1 String)
(assert (= var1678!1 (str.++ var1678 ", terminate directly.")))
(assert true)
(define-const var2086 String (toString/-2075883882 var941)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1027821060 var2449 8 var2086)) ; Statement: specialinvoke $r22.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String)>(8, $r31) 

(declare-const var2449!1 var72)
(declare-const var1983 Int)
(declare-const var2086!1 String)
(define-const var2106 var2761 (var2761_newDefaultAsyncResult/-2013762118 (cast-from-var72-to-var1294 var2449!1) var1214)) ; Statement: $r32 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>($r22, r1) 
 ; Statement: return $r32 
(check-sat)
; {getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var748-to-var3530=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), var3506_getMethodName/-516674313=([org.apache.dubbo.rpc.Invocation], java.lang.String), var3506_calculateTimeout/2120566713=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.Invocation, java.lang.String, long], int), var72-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3634_getServiceName/-67876927=([org.apache.dubbo.rpc.Invocation], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1027821060=([org.apache.dubbo.rpc.RpcException, int, java.lang.String], void), var2761_newDefaultAsyncResult/-2013762118=([java.lang.Throwable, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.AsyncRpcResult), cast-from-var72-to-var1294=([org.apache.dubbo.rpc.RpcException], java.lang.Throwable)}
; {var748=org.apache.dubbo.rpc.protocol.tri.TripleInvoker, var2177=r0, var2080=org.apache.dubbo.rpc.model.MethodDescriptor, var3337=r6, var3634=org.apache.dubbo.rpc.Invocation, var1214=r1, var1547=org.apache.dubbo.rpc.protocol.tri.call.ClientCall, var1796=r17, var2003=java.util.concurrent.ExecutorService, var1615=r8, var1910=org.apache.dubbo.common.URL, var3530=org.apache.dubbo.rpc.protocol.AbstractInvoker, var1285=$r3, var3506=org.apache.dubbo.rpc.support.RpcUtils, var763=$r2, var1630=i0, var72=org.apache.dubbo.rpc.RpcException, var2449=$r22, var1298=$r23, var3569=$r25, var1433=$r24, var1569=$r26, var3583=$r28, var3519=$r27, var1678=$r29, var941=$r30, var2086=$r31, var1983=8, var2761=org.apache.dubbo.rpc.AsyncRpcResult, var1294=java.lang.Throwable, var2106=$r32}
; {org.apache.dubbo.rpc.protocol.tri.TripleInvoker=var748, r0=var2177, org.apache.dubbo.rpc.model.MethodDescriptor=var2080, r6=var3337, org.apache.dubbo.rpc.Invocation=var3634, r1=var1214, org.apache.dubbo.rpc.protocol.tri.call.ClientCall=var1547, r17=var1796, java.util.concurrent.ExecutorService=var2003, r8=var1615, org.apache.dubbo.common.URL=var1910, org.apache.dubbo.rpc.protocol.AbstractInvoker=var3530, $r3=var1285, org.apache.dubbo.rpc.support.RpcUtils=var3506, $r2=var763, i0=var1630, org.apache.dubbo.rpc.RpcException=var72, $r22=var2449, $r23=var1298, $r25=var3569, $r24=var1433, $r26=var1569, $r28=var3583, $r27=var3519, $r29=var1678, $r30=var941, $r31=var2086, 8=var1983, org.apache.dubbo.rpc.AsyncRpcResult=var2761, java.lang.Throwable=var1294, $r32=var2106}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker;	r6 := @parameter0: org.apache.dubbo.rpc.model.MethodDescriptor;	r1 := @parameter1: org.apache.dubbo.rpc.Invocation;	r17 := @parameter2: org.apache.dubbo.rpc.protocol.tri.call.ClientCall;	r8 := @parameter3: java.util.concurrent.ExecutorService;	$r3 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>();	$r2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1);	i0 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: int calculateTimeout(org.apache.dubbo.common.URL,org.apache.dubbo.rpc.Invocation,java.lang.String,long)>($r3, r1, $r2, 3000L);	if i0 > 0 goto $r4 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i0);	$r22 = new org.apache.dubbo.rpc.RpcException;	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r25 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No time left for making the following call: ");	$r24 = interfaceinvoke r1.<org.apache.dubbo.rpc.Invocation: java.lang.String getServiceName()>();	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r24);	$r28 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r27 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: java.lang.String getMethodName(org.apache.dubbo.rpc.Invocation)>(r1);	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r27);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", terminate directly.");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r22.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String)>(8, $r31);	$r32 = staticinvoke <org.apache.dubbo.rpc.AsyncRpcResult: org.apache.dubbo.rpc.AsyncRpcResult newDefaultAsyncResult(java.lang.Throwable,org.apache.dubbo.rpc.Invocation)>($r22, r1);	return $r32
;block_num 2