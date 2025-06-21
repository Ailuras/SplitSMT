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

(declare-sort var768 0)
(declare-sort var2880 0)
(declare-sort var271 0)
(declare-sort var3578 0)
(declare-sort var36 0)
(declare-sort var428 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvokeMode/-198859798 (var271) var3578)
(declare-fun var428-init () var428)
(declare-fun getMessage/849299655 (var36) String)
(declare-fun <init>/552350055 (var428 String var36) void)
(declare-const null-var768 var768)
(declare-const null-var2880 var2880)
(declare-const null-var271 var271)
(declare-const var3578-SYNC var3578)
(declare-const null-var36 var36)
(declare-const var2685 var768) ; Statement: r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker 
(assert (not (= var2685 null-var768)))
(declare-const var555 var2880) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult 
(assert (not (= var555 null-var2880)))
(declare-const var3430 var271) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var3430 null-var271)))
(define-const var3814 var3578 var3578-SYNC) ; Statement: $r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC> 
(assert true)
(define-const var1330 var3578 (getInvokeMode/-198859798 var3430)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>() 
 ; Statement: if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout") 
(assert (not (= var3814 var1330))) ; Negate: Cond: $r1 == $r2  
(declare-const var1152 var36) ; Statement: $r6 := @caughtexception 
(assert (not (= var1152 null-var36)))
(define-const var3955 var428 var428-init) ; Statement: $r7 = new org.apache.dubbo.rpc.RpcException 
(assert true)
(define-const var608 String (getMessage/849299655 var1152)) ; Statement: $r8 = virtualinvoke $r6.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
;(assert (<init>/552350055 var3955 var608 var1152)) ; Statement: specialinvoke $r7.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r8, $r6) 

(declare-const var3955!1 var428)
(declare-const var608!1 String)
(declare-const var1152!1 var36)
 ; Statement: throw $r7 
(check-sat)
; {getInvokeMode/-198859798=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.InvokeMode), var428-init=([], org.apache.dubbo.rpc.RpcException), getMessage/849299655=([java.lang.Throwable], java.lang.String), <init>/552350055=([org.apache.dubbo.rpc.RpcException, java.lang.String, java.lang.Throwable], void)}
; {var768=org.apache.dubbo.rpc.protocol.AbstractInvoker, var2685=r15, var2880=org.apache.dubbo.rpc.AsyncRpcResult, var555=r4, var271=org.apache.dubbo.rpc.RpcInvocation, var3430=r0, var3578=org.apache.dubbo.rpc.InvokeMode, var3814=$r1, var1330=$r2, var36=java.lang.Throwable, var1152=$r6, var428=org.apache.dubbo.rpc.RpcException, var3955=$r7, var608=$r8}
; {org.apache.dubbo.rpc.protocol.AbstractInvoker=var768, r15=var2685, org.apache.dubbo.rpc.AsyncRpcResult=var2880, r4=var555, org.apache.dubbo.rpc.RpcInvocation=var271, r0=var3430, org.apache.dubbo.rpc.InvokeMode=var3578, $r1=var3814, $r2=var1330, java.lang.Throwable=var36, $r6=var1152, org.apache.dubbo.rpc.RpcException=var428, $r7=var3955, $r8=var608}
;seq 
;cnt {}
;stmts r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker;	r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	$r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC>;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>();	if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout");	$r6 := @caughtexception;	$r7 = new org.apache.dubbo.rpc.RpcException;	$r8 = virtualinvoke $r6.<java.lang.Throwable: java.lang.String getMessage()>();	specialinvoke $r7.<org.apache.dubbo.rpc.RpcException: void <init>(java.lang.String,java.lang.Throwable)>($r8, $r6);	throw $r7
;block_num 2