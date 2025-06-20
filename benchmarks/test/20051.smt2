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

(declare-sort var1001 0)
(declare-sort var3991 0)
(declare-sort var1765 0)
(declare-sort var1300 0)
(declare-sort var1278 0)
(declare-sort var3299 0)
(declare-sort var3224 0)
(declare-sort var2014 0)
(declare-sort var873 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInvokeMode/-198859798 (var1765) var1300)
(declare-fun var3299-init () var3299)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMethodName/-937628946 (var1765) String)
(declare-fun getUrl/-945338117 (var1001) var3224)
(declare-fun append/-1031950772 (String var2014) String)
(declare-fun cast-from-var3224-to-var2014 (var3224) var2014)
(declare-fun getMessage/849299655 (var873) String)
(declare-fun cast-from-var1278-to-var873 (var1278) var873)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/456387396 (var3299 Int String var873) void)
(declare-const null-var1001 var1001)
(declare-const null-var3991 var3991)
(declare-const null-var1765 var1765)
(declare-const var1300-SYNC var1300)
(declare-const null-var1278 var1278)
(declare-const var664 var1001) ; Statement: r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker 
(assert (not (= var664 null-var1001)))
(declare-const var3949 var3991) ; Statement: r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult 
(assert (not (= var3949 null-var3991)))
(declare-const var179 var1765) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation 
(assert (not (= var179 null-var1765)))
(define-const var1068 var1300 var1300-SYNC) ; Statement: $r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC> 
(assert true)
(define-const var2424 var1300 (getInvokeMode/-198859798 var179)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>() 
 ; Statement: if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout") 
(assert (not (= var1068 var2424))) ; Negate: Cond: $r1 == $r2  
(declare-const var898 var1278) ; Statement: $r9 := @caughtexception 
(assert (not (= var898 null-var1278)))
(define-const var2248 var3299 var3299-init) ; Statement: $r10 = new org.apache.dubbo.rpc.RpcException 
(define-const var3125 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3125)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3125!1 String)
(assert (= var3125!1 ""))
(assert true)
(define-const var329 String (append/672562846 var3125!1 "Invoke remote method timeout. method: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invoke remote method timeout. method: ") 
(declare-const var3125!2 String)
(assert (= var3125!2 (str.++ var3125!1 "Invoke remote method timeout. method: ")))
(assert true)
(define-const var2737 String (getMethodName/-937628946 var179)) ; Statement: $r12 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getMethodName()>() 
(assert true)
(define-const var2153 String (append/672562846 var329 var2737)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var329!1 String)
(assert (= var329!1 (str.++ var329 var2737)))
(assert true)
(define-const var3716 String (append/672562846 var2153 ", provider: ")) ; Statement: $r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ") 
(declare-const var2153!1 String)
(assert (= var2153!1 (str.++ var2153 ", provider: ")))
(assert true)
(define-const var1714 var3224 (getUrl/-945338117 var664)) ; Statement: $r16 = virtualinvoke r15.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3470 String (append/-1031950772 var3716 (cast-from-var3224-to-var2014 var1714))) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16) 
(declare-const var3716!1 String)
(assert (str.prefixof var3716 var3716!1))
(assert true)
(define-const var361 String (append/672562846 var3470 ", cause: ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3470!1 String)
(assert (= var3470!1 (str.++ var3470 ", cause: ")))
(assert true)
(define-const var3744 String (getMessage/849299655 (cast-from-var1278-to-var873 var898))) ; Statement: $r19 = virtualinvoke $r9.<java.util.concurrent.TimeoutException: java.lang.String getMessage()>() 
(assert true)
(define-const var2386 String (append/672562846 var361 var3744)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var361!1 String)
(assert (= var361!1 (str.++ var361 var3744)))
(assert true)
(define-const var2831 String (toString/-2075883882 var2386)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/456387396 var2248 2 var2831 (cast-from-var1278-to-var873 var898))) ; Statement: specialinvoke $r10.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(2, $r22, $r9) 

(declare-const var2248!1 var3299)
(declare-const var2227 Int)
(declare-const var2831!1 String)
(declare-const var898!1 var1278)
 ; Statement: throw $r10 
(check-sat)
; {getInvokeMode/-198859798=([org.apache.dubbo.rpc.RpcInvocation], org.apache.dubbo.rpc.InvokeMode), var3299-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMethodName/-937628946=([org.apache.dubbo.rpc.RpcInvocation], java.lang.String), getUrl/-945338117=([org.apache.dubbo.rpc.protocol.AbstractInvoker], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3224-to-var2014=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var1278-to-var873=([java.util.concurrent.TimeoutException], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/456387396=([org.apache.dubbo.rpc.RpcException, int, java.lang.String, java.lang.Throwable], void)}
; {var1001=org.apache.dubbo.rpc.protocol.AbstractInvoker, var664=r15, var3991=org.apache.dubbo.rpc.AsyncRpcResult, var3949=r4, var1765=org.apache.dubbo.rpc.RpcInvocation, var179=r0, var1300=org.apache.dubbo.rpc.InvokeMode, var1068=$r1, var2424=$r2, var1278=java.util.concurrent.TimeoutException, var898=$r9, var3299=org.apache.dubbo.rpc.RpcException, var2248=$r10, var3125=$r11, var329=$r13, var2737=$r12, var2153=$r14, var3716=$r17, var3224=org.apache.dubbo.common.URL, var1714=$r16, var2014=java.lang.Object, var3470=$r18, var361=$r20, var873=java.lang.Throwable, var3744=$r19, var2386=$r21, var2831=$r22, var2227=2}
; {org.apache.dubbo.rpc.protocol.AbstractInvoker=var1001, r15=var664, org.apache.dubbo.rpc.AsyncRpcResult=var3991, r4=var3949, org.apache.dubbo.rpc.RpcInvocation=var1765, r0=var179, org.apache.dubbo.rpc.InvokeMode=var1300, $r1=var1068, $r2=var2424, java.util.concurrent.TimeoutException=var1278, $r9=var898, org.apache.dubbo.rpc.RpcException=var3299, $r10=var2248, $r11=var3125, $r13=var329, $r12=var2737, $r14=var2153, $r17=var3716, org.apache.dubbo.common.URL=var3224, $r16=var1714, java.lang.Object=var2014, $r18=var3470, $r20=var361, java.lang.Throwable=var873, $r19=var3744, $r21=var2386, $r22=var2831, 2=var2227}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.rpc.protocol.AbstractInvoker;	r4 := @parameter0: org.apache.dubbo.rpc.AsyncRpcResult;	r0 := @parameter1: org.apache.dubbo.rpc.RpcInvocation;	$r1 = <org.apache.dubbo.rpc.InvokeMode: org.apache.dubbo.rpc.InvokeMode SYNC>;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: org.apache.dubbo.rpc.InvokeMode getInvokeMode()>();	if $r1 == $r2 goto r86 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.Object getObjectAttachmentWithoutConvert(java.lang.String)>("timeout");	$r9 := @caughtexception;	$r10 = new org.apache.dubbo.rpc.RpcException;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invoke remote method timeout. method: ");	$r12 = virtualinvoke r0.<org.apache.dubbo.rpc.RpcInvocation: java.lang.String getMethodName()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r17 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", provider: ");	$r16 = virtualinvoke r15.<org.apache.dubbo.rpc.protocol.AbstractInvoker: org.apache.dubbo.common.URL getUrl()>();	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r16);	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r19 = virtualinvoke $r9.<java.util.concurrent.TimeoutException: java.lang.String getMessage()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(2, $r22, $r9);	throw $r10
;block_num 2