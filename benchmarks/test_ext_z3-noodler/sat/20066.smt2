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

(declare-sort var2134 0)
(declare-sort var1852 0)
(declare-sort var1855 0)
(declare-sort var3479 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvokeMode/-198859798 (var1855) var3479)
(declare-const null-var2134 var2134)
(declare-const null-var1852 var1852)
(declare-const null-var1855 var1855)
(declare-const var3479-SYNC var3479)
(declare-const var3954 var2134) ; Statement: r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker 
(assert (not (= var3954 null-var2134)))
(declare-const var847 var1852) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult 
(assert (not (= var847 null-var1852)))
(declare-const var2366 var1855) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var2366 null-var1855)))
(define-const var3204 var3479 var3479-SYNC) ; Statement: $r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC> 
(assert true)
(define-const var3586 var3479 (getInvokeMode/-198859798 var2366)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>() 
 ; Statement: if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout") 
(assert (not (= var3204 var3586))) ; Negate: Cond: $r1 == $r2  
 ; Statement: return 
(check-sat)
; {getInvokeMode/-198859798=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.InvokeMode)}
; {var2134=org.apache.dubbo.rpc.protocol.AbstractInvoker, var3954=r15, var1852=org.apache.dubbo.rpc.AsyncRpcResult, var847=r4, var1855=org.apache.dubbo.rpc.RpcInvocation, var2366=r0, var3479=org.apache.dubbo.rpc.InvokeMode, var3204=$r1, var3586=$r2}
; {org.apache.dubbo.rpc.protocol.AbstractInvoker=var2134, r15=var3954, org.apache.dubbo.rpc.AsyncRpcResult=var1852, r4=var847, org.apache.dubbo.rpc.RpcInvocation=var1855, r0=var2366, org.apache.dubbo.rpc.InvokeMode=var3479, $r1=var3204, $r2=var3586}
;seq 
;cnt {}
;stmts r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker;	r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	$r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC>;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>();	if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout");	return
;block_num 2