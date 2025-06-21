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

(declare-sort var784 0)
(declare-sort var2151 0)
(declare-sort var413 0)
(declare-sort var2008 0)
(declare-sort var727 0)
(declare-sort var3610 0)
(declare-sort var3143 0)
(declare-sort var1403 0)
(declare-sort var1113 0)
(declare-sort var600 0)
(declare-sort var1483 0)
(declare-sort var2099 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun connectionClient/-1039249422 (var784) var413)
(declare-fun isConnected/-173866065 (var2008) Bool)
(declare-fun cast-from-var413-to-var2008 (var413) var2008)
(declare-fun var727-init () var727)
(declare-fun <init>/-2088142221 (var727) void)
(declare-fun arr-var3143-init () (Array Int var3143))
(declare-fun getUrl/-945338117 (var1113) var1403)
(declare-fun cast-from-var784-to-var1113 (var784) var1113)
(declare-fun getAddress/-2093578336 (var1403) String)
(declare-fun cast-from-String-to-var3143 (String) var3143)
(declare-fun String_format/1339386452 (String (Array Int var3143)) String)
(declare-fun withDescription/65961942 (var3610 String) var3610)
(declare-fun asException/-351536454 (var3610) var600)
(declare-fun completeExceptionally/-1031437253 (var727 var1483) Bool)
(declare-fun cast-from-var600-to-var1483 (var600) var1483)
(declare-fun var2099-init () var2099)
(declare-fun <init>/541937347 (var2099 var727 var2151) void)
(declare-const null-var784 var784)
(declare-const null-var2151 var2151)
(declare-const var3610-UNAVAILABLE var3610)
(declare-const null-__Array__Int__var3143__ (Array Int var3143))
(declare-const var1851 var784) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker 
(assert (not (= var1851 null-var784)))
(declare-const var162 var2151) ; Statement: r2 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var162 null-var2151)))
(define-const var1384 var413 (connectionClient/-1039249422 var1851)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient connectionClient> 
(assert true)
(define-const var814 Bool (isConnected/-173866065 (cast-from-var413-to-var2008 var1384))) ; Statement: $z0 = virtualinvoke $r1.<org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: boolean isConnected()>() 
 ; Statement: if $z0 != 0 goto $r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
(assert (not (not (= (ite var814 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1863 var727 var727-init) ; Statement: $r49 = new java.util.concurrent.CompletableFuture 
(assert true)
;(assert (<init>/-2088142221 var1863)) ; Statement: specialinvoke $r49.<java.util.concurrent.CompletableFuture: void <init>()>() 

(declare-const var1863!1 var727)
(define-const var2872 var3610 var3610-UNAVAILABLE) ; Statement: $r29 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNAVAILABLE> 
(define-const var37 (Array Int var3143) arr-var3143-init) ; Statement: $r28 = newarray (java.lang.Object)[1] 
(assert true)
(define-const var1546 var1403 (getUrl/-945338117 (cast-from-var784-to-var1113 var1851))) ; Statement: $r30 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1370 String (getAddress/-2093578336 var1546)) ; Statement: $r31 = virtualinvoke $r30.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(declare-const var37!1 (Array Int var3143))
(assert (not (= var37!1 null-__Array__Int__var3143__)))
(assert (= (select var37!1 0) (cast-from-String-to-var3143 var1370))) ; Statement: $r28[0] = $r31 
(define-const var1328 String (String_format/1339386452 "upstream %s is unavailable" var37!1)) ; Statement: $r32 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("upstream %s is unavailable", $r28) 
(assert true)
(define-const var3359 var3610 (withDescription/65961942 var2872 var1328)) ; Statement: $r33 = virtualinvoke $r29.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r32) 
(assert true)
(define-const var333 var600 (asException/-351536454 var3359)) ; Statement: r44 = virtualinvoke $r33.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>() 
(assert true)
;(assert (completeExceptionally/-1031437253 var1863!1 (cast-from-var600-to-var1483 var333))) ; Statement: virtualinvoke $r49.<java.util.concurrent.CompletableFuture: boolean completeExceptionally(java.lang.Throwable)>(r44) 

(declare-const var1863!2 var727)
(declare-const var333!1 var600)
(define-const var3905 var2099 var2099-init) ; Statement: $r50 = new org.apache.dubbo.rpc.AsyncRpcResult 
(assert true)
;(assert (<init>/541937347 var3905 var1863!2 var162)) ; Statement: specialinvoke $r50.<org.apache.dubbo.rpc.AsyncRpcResult: void <init>(java.util.concurrent.CompletableFuture,org.apache.dubbo.rpc.Invocation)>($r49, r2) 

(declare-const var3905!1 var2099)
(declare-const var1863!3 var727)
(declare-const var162!1 var2151)
 ; Statement: return $r50 
(check-sat)
; {connectionClient/-1039249422=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], org.apache.dubbo.remoting.api.connection.AbstractConnectionClient), isConnected/-173866065=([org.apache.dubbo.remoting.transport.AbstractClient], boolean), cast-from-var413-to-var2008=([org.apache.dubbo.remoting.api.connection.AbstractConnectionClient], org.apache.dubbo.remoting.transport.AbstractClient), var727-init=([], java.util.concurrent.CompletableFuture), <init>/-2088142221=([java.util.concurrent.CompletableFuture], void), arr-var3143-init=([], java.lang.Object[]), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), cast-from-var784-to-var1113=([org.apache.dubbo.rpc.protocol.tri.TripleInvoker], org.apache.dubbo.rpc.protocol.AbstractInvoker), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), cast-from-String-to-var3143=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), asException/-351536454=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.StatusRpcException), completeExceptionally/-1031437253=([java.util.concurrent.CompletableFuture, java.lang.Throwable], boolean), cast-from-var600-to-var1483=([org.apache.dubbo.rpc.StatusRpcException], java.lang.Throwable), var2099-init=([], org.apache.dubbo.rpc.AsyncRpcResult), <init>/541937347=([org.apache.dubbo.rpc.AsyncRpcResult, java.util.concurrent.CompletableFuture, org.apache.dubbo.rpc.Invocation], void)}
; {var784=org.apache.dubbo.rpc.protocol.tri.TripleInvoker, var1851=r0, var2151=org.apache.dubbo.rpc.Invocation, var162=r2, var413=org.apache.dubbo.remoting.api.connection.AbstractConnectionClient, var1384=$r1, var2008=org.apache.dubbo.remoting.transport.AbstractClient, var814=$z0, var727=java.util.concurrent.CompletableFuture, var1863=$r49, var3610=org.apache.dubbo.rpc.TriRpcStatus, var2872=$r29, var3143=java.lang.Object, var37=$r28, var1403=org.apache.dubbo.common.URL, var1113=org.apache.dubbo.rpc.protocol.AbstractInvoker, var1546=$r30, var1370=$r31, var1328=$r32, var3359=$r33, var600=org.apache.dubbo.rpc.StatusRpcException, var333=r44, var1483=java.lang.Throwable, var2099=org.apache.dubbo.rpc.AsyncRpcResult, var3905=$r50}
; {org.apache.dubbo.rpc.protocol.tri.TripleInvoker=var784, r0=var1851, org.apache.dubbo.rpc.Invocation=var2151, r2=var162, org.apache.dubbo.remoting.api.connection.AbstractConnectionClient=var413, $r1=var1384, org.apache.dubbo.remoting.transport.AbstractClient=var2008, $z0=var814, java.util.concurrent.CompletableFuture=var727, $r49=var1863, org.apache.dubbo.rpc.TriRpcStatus=var3610, $r29=var2872, java.lang.Object=var3143, $r28=var37, org.apache.dubbo.common.URL=var1403, org.apache.dubbo.rpc.protocol.AbstractInvoker=var1113, $r30=var1546, $r31=var1370, $r32=var1328, $r33=var3359, org.apache.dubbo.rpc.StatusRpcException=var600, r44=var333, java.lang.Throwable=var1483, org.apache.dubbo.rpc.AsyncRpcResult=var2099, $r50=var3905}
;seq <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.TripleInvoker;	r2 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.remoting.api.connection.AbstractConnectionClient connectionClient>;	$z0 = virtualinvoke $r1.<org.apache.dubbo.remoting.api.connection.AbstractConnectionClient: boolean isConnected()>();	if $z0 != 0 goto $r3 = interfaceinvoke r2.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	$r49 = new java.util.concurrent.CompletableFuture;	specialinvoke $r49.<java.util.concurrent.CompletableFuture: void <init>()>();	$r29 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNAVAILABLE>;	$r28 = newarray (java.lang.Object)[1];	$r30 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.TripleInvoker: org.apache.dubbo.common.URL getUrl()>();	$r31 = virtualinvoke $r30.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r28[0] = $r31;	$r32 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("upstream %s is unavailable", $r28);	$r33 = virtualinvoke $r29.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r32);	r44 = virtualinvoke $r33.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>();	virtualinvoke $r49.<java.util.concurrent.CompletableFuture: boolean completeExceptionally(java.lang.Throwable)>(r44);	$r50 = new org.apache.dubbo.rpc.AsyncRpcResult;	specialinvoke $r50.<org.apache.dubbo.rpc.AsyncRpcResult: void <init>(java.util.concurrent.CompletableFuture,org.apache.dubbo.rpc.Invocation)>($r49, r2);	return $r50
;block_num 2