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

(declare-sort var739 0)
(declare-sort var1844 0)
(declare-sort var158 0)
(declare-sort var2673 0)
(declare-sort var1511 0)
(declare-sort var804 0)
(declare-sort var888 0)
(declare-sort var2912 0)
(declare-sort var2268 0)
(declare-sort var2995 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvokeMode/-198859798 (var158) var2673)
(declare-fun var804_currentThread/-1037784612 () var804)
(declare-fun interrupt/1189171174 (var804) void)
(declare-fun var888-init () var888)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMethodName/-937628946 (var158) String)
(declare-fun getUrl/-945338117 (var739) var2912)
(declare-fun append/-1031950772 (String var2268) String)
(declare-fun cast-from-var2912-to-var2268 (var2912) var2268)
(declare-fun getMessage/849299655 (var2995) String)
(declare-fun cast-from-var1511-to-var2995 (var1511) var2995)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/552350055 (var888 String var2995) void)
(declare-const null-var739 var739)
(declare-const null-var1844 var1844)
(declare-const null-var158 var158)
(declare-const var2673-SYNC var2673)
(declare-const null-var1511 var1511)
(declare-const var1124 var739) ; Statement: r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker 
(assert (not (= var1124 null-var739)))
(declare-const var3629 var1844) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult 
(assert (not (= var3629 null-var1844)))
(declare-const var3082 var158) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3082 null-var158)))
(define-const var3593 var2673 var2673-SYNC) ; Statement: $r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC> 
(assert true)
(define-const var2742 var2673 (getInvokeMode/-198859798 var3082)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>() 
 ; Statement: if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout") 
(assert (not (= var3593 var2742))) ; Negate: Cond: $r1 == $r2  
(declare-const var492 var1511) ; Statement: $r72 := @caughtexception 
(assert (not (= var492 null-var1511)))
(define-const var2519 var804 var804_currentThread/-1037784612) ; Statement: $r73 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>() 
(assert true)
;(assert (interrupt/1189171174 var2519)) ; Statement: virtualinvoke $r73.<java.lang.Thread: void interrupt()>() 

(declare-const var2519!1 var804)
(define-const var2842 var888 var888-init) ; Statement: $r74 = new org.apache.dubbo.rpc.RpcException 
(define-const var537 String String-init) ; Statement: $r75 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var537)) ; Statement: specialinvoke $r75.<java.lang.StringBuilder: void <init>()>() 
(declare-const var537!1 String)
(assert (= var537!1 ""))
(assert true)
(define-const var3202 String (append/672562846 var537!1 "Interrupted unexpectedly while waiting for remote result to return! method: ")) ; Statement: $r77 = virtualinvoke $r75.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Interrupted unexpectedly while waiting for remote result to return! method: ") 
(declare-const var537!2 String)
(assert (= var537!2 (str.++ var537!1 "Interrupted unexpectedly while waiting for remote result to return! method: ")))
(assert true)
(define-const var1054 String (getMethodName/-937628946 var3082)) ; Statement: $r76 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var1523 String (append/672562846 var3202 var1054)) ; Statement: $r78 = virtualinvoke $r77.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r76) 
(declare-const var3202!1 String)
(assert (= var3202!1 (str.++ var3202 var1054)))
(assert true)
(define-const var1377 String (append/672562846 var1523 ", provider: ")) ; Statement: $r80 = virtualinvoke $r78.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ") 
(declare-const var1523!1 String)
(assert (= var1523!1 (str.++ var1523 ", provider: ")))
(assert true)
(define-const var3232 var2912 (getUrl/-945338117 var1124)) ; Statement: $r79 = virtualinvoke r15.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var623 String (append/-1031950772 var1377 (cast-from-var2912-to-var2268 var3232))) ; Statement: $r81 = virtualinvoke $r80.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r79) 
(declare-const var1377!1 String)
(assert (str.prefixof var1377 var1377!1))
(assert true)
(define-const var583 String (append/672562846 var623 ", cause: ")) ; Statement: $r83 = virtualinvoke $r81.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var623!1 String)
(assert (= var623!1 (str.++ var623 ", cause: ")))
(assert true)
(define-const var1908 String (getMessage/849299655 (cast-from-var1511-to-var2995 var492))) ; Statement: $r82 = virtualinvoke $r72.<java.lang.InterruptedException: java.lang.String getMessage()>() 
(assert true)
(define-const var2123 String (append/672562846 var583 var1908)) ; Statement: $r84 = virtualinvoke $r83.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r82) 
(declare-const var583!1 String)
(assert (= var583!1 (str.++ var583 var1908)))
(assert true)
(define-const var988 String (toString/-2075883882 var2123)) ; Statement: $r85 = virtualinvoke $r84.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/552350055 var2842 var988 (cast-from-var1511-to-var2995 var492))) ; Statement: specialinvoke $r74.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r85, $r72) 

(declare-const var2842!1 var888)
(declare-const var988!1 String)
(declare-const var492!1 var1511)
 ; Statement: throw $r74 
(check-sat)
; {getInvokeMode/-198859798=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.InvokeMode), var804_currentThread/-1037784612=([], java.lang.Thread), interrupt/1189171174=([java.lang.Thread], void), var888-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMethodName/-937628946=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2912-to-var2268=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1511-to-var2995=([java.lang.InterruptedException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var739=org.apache.dubbo.rpc.protocol.AbstractInvoker, var1124=r15, var1844=org.apache.dubbo.rpc.AsyncRpcResult, var3629=r4, var158=org.apache.dubbo.rpc.RpcInvocation, var3082=r0, var2673=org.apache.dubbo.rpc.InvokeMode, var3593=$r1, var2742=$r2, var1511=java.lang.InterruptedException, var492=$r72, var804=java.lang.Thread, var2519=$r73, var888=org.apache.dubbo.rpc.RpcException, var2842=$r74, var537=$r75, var3202=$r77, var1054=$r76, var1523=$r78, var1377=$r80, var2912=org.apache.dubbo.common.URL, var3232=$r79, var2268=java.lang.Object, var623=$r81, var583=$r83, var2995=java.lang.Throwable, var1908=$r82, var2123=$r84, var988=$r85}
; {org.apache.dubbo.rpc.protocol.AbstractInvoker=var739, r15=var1124, org.apache.dubbo.rpc.AsyncRpcResult=var1844, r4=var3629, org.apache.dubbo.rpc.RpcInvocation=var158, r0=var3082, org.apache.dubbo.rpc.InvokeMode=var2673, $r1=var3593, $r2=var2742, java.lang.InterruptedException=var1511, $r72=var492, java.lang.Thread=var804, $r73=var2519, org.apache.dubbo.rpc.RpcException=var888, $r74=var2842, $r75=var537, $r77=var3202, $r76=var1054, $r78=var1523, $r80=var1377, org.apache.dubbo.common.URL=var2912, $r79=var3232, java.lang.Object=var2268, $r81=var623, $r83=var583, java.lang.Throwable=var2995, $r82=var1908, $r84=var2123, $r85=var988}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker;	r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	$r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC>;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>();	if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout");	$r72 := @caughtexception;	$r73 = staticinvoke <java.lang.Thread: java.lang.Thread currentThread()>();	virtualinvoke $r73.<java.lang.Thread: void interrupt()>();	$r74 = new org.apache.dubbo.rpc.RpcException;	$r75 = new java.lang.StringBuilder;	specialinvoke $r75.<java.lang.StringBuilder: void <init>()>();	$r77 = virtualinvoke $r75.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Interrupted unexpectedly while waiting for remote result to return! method: ");	$r76 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getMethodName()>();	$r78 = virtualinvoke $r77.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r76);	$r80 = virtualinvoke $r78.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ");	$r79 = virtualinvoke r15.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	$r81 = virtualinvoke $r80.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r79);	$r83 = virtualinvoke $r81.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r82 = virtualinvoke $r72.<java.lang.InterruptedException: java.lang.String getMessage()>();	$r84 = virtualinvoke $r83.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r82);	$r85 = virtualinvoke $r84.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r74.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r85, $r72);	throw $r74
;block_num 2