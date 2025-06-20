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

(declare-sort var3913 0)
(declare-sort var1047 0)
(declare-sort var3201 0)
(declare-sort var3393 0)
(declare-sort var3314 0)
(declare-sort var3239 0)
(declare-sort var1467 0)
(declare-sort var627 0)
(declare-sort var3521 0)
(declare-sort var2824 0)
(declare-sort var501 0)
(declare-sort var2990 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3201_getObjectAttachments/241945301 (var3201) var3393)
(declare-fun var3239_getServiceContext/735675290 () var3314)
(declare-fun setInvoker/-967664046 (var3314 var1047) var3314)
(declare-fun setInvocation/596770720 (var3314 var3201) var3314)
(declare-fun var3239_getServerAttachment/1146677352 () var1467)
(declare-fun getLocalAddress/-2134086869 (var3239) var627)
(declare-fun cast-from-var1467-to-var3239 (var1467) var3239)
(declare-fun var3201_getAttachment/-2134772037 (var3201 String) String)
(declare-fun var3521_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setRemoteApplicationName/-1652244623 (var3314 String) var3314)
(declare-fun var2824_getTimeout/1417314331 (var3201 Int) Int)
(declare-fun var501_isNotEmptyMap/1884409606 (var3393) Bool)
(declare-fun clearAfterEachInvoke/774611878 (var3239 Bool) void)
(declare-fun isAsyncStarted/-1250802381 (var3239) Bool)
(declare-const null-var3913 var3913)
(declare-const null-var1047 var1047)
(declare-const null-var3201 var3201)
(declare-const null-var3393 var3393)
(declare-const null-var627 var627)
(declare-const null-var2990 var2990)
(declare-const var691 var3913) ; Statement: r7 := @this: org.apache.dubbo.rpc.filter.ContextFilter 
(assert (not (= var691 null-var3913)))
(declare-const var3406 var1047) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var3406 null-var1047)))
(declare-const var2924 var3201) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2924 null-var3201)))
(define-const var1848 var3393 (var3201_getObjectAttachments/241945301 var2924)) ; Statement: r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>() 
 ; Statement: if r28 == null goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (= var1848 null-var3393)) ; Cond: r28 == null 
(define-const var987 var3314 var3239_getServiceContext/735675290) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var2670 var3314 (setInvoker/-967664046 var987 var3406)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvoker(org.apache.dubbo.rpc.Invoker)>(r1) 
(assert true)
;(assert (setInvocation/596770720 var2670 var2924)) ; Statement: virtualinvoke $r3.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvocation(org.apache.dubbo.rpc.Invocation)>(r0) 

(declare-const var2670!1 var3314)
(declare-const var2924!1 var3201)
(define-const var1194 var1467 var3239_getServerAttachment/1146677352) ; Statement: $r21 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContextAttachment getServerAttachment()>() 
(assert true)
(define-const var815 var627 (getLocalAddress/-2134086869 (cast-from-var1467-to-var3239 var1194))) ; Statement: $r4 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: java.net.InetSocketAddress getLocalAddress()>() 
 ; Statement: if $r4 != null goto $r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application") 
(assert (not (= var815 null-var627))) ; Cond: $r4 != null 
(define-const var1408 String (var3201_getAttachment/-2134772037 var2924!1 "remote.application")) ; Statement: $r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application") 
(define-const var2291 Bool (var3521_isNotEmpty/-1251449450 var1408)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r18) 
 ; Statement: if $z0 == 0 goto $r6 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (not (= (ite var2291 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var985 var3314 var3239_getServiceContext/735675290) ; Statement: $r14 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
;(assert (setRemoteApplicationName/-1652244623 var985 var1408)) ; Statement: virtualinvoke $r14.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setRemoteApplicationName(java.lang.String)>($r18) 

(declare-const var985!1 var3314)
(declare-const var1408!1 String)
 ; Statement: goto [?= $l2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: long getTimeout(org.apache.dubbo.rpc.Invocation,long)>(r0, -1L)] 
(assert true) ; Non Conditional
(define-const var1382 Int (var2824_getTimeout/1417314331 var2924!1 -1)) ; Statement: $l2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: long getTimeout(org.apache.dubbo.rpc.Invocation,long)>(r0, -1L) 
(define-const var1188 Int (ite (> var1382 -1) 1 (ite (< var1382 -1) -1 0))) ; Statement: $b0 = $l2 cmp -1L 
 ; Statement: if $b0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28) 
(assert (= var1188 0)) ; Cond: $b0 == 0 
(define-const var1766 Bool (var501_isNotEmptyMap/1884409606 var1848)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28) 
 ; Statement: if $z1 == 0 goto $z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
(assert (= (ite var1766 1 0) 0)) ; Cond: $z1 == 0 
(define-const var310 Bool true) ; Statement: $z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
 ; Statement: if $z6 == 0 goto virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(0) 
(assert (not (= (ite var310 1 0) 0))) ; Negate: Cond: $z6 == 0  
(declare-const var2571 var2990) ; Statement: $r27 := @caughtexception 
(assert (not (= var2571 null-var2990)))
(assert true) ; Non Conditional
(assert true)
;(assert (clearAfterEachInvoke/774611878 (cast-from-var1467-to-var3239 var1194) (ite (= 1 1) true false))) ; Statement: virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(1) 

(declare-const var1194!1 var1467)
(declare-const var3241 Int)
(assert true)
(define-const var2997 Bool (isAsyncStarted/-1250802381 (cast-from-var1467-to-var3239 var1194!1))) ; Statement: $z5 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: boolean isAsyncStarted()>() 
 ; Statement: if $z5 == 0 goto throw $r27 
(assert (= (ite var2997 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: throw $r27 
(check-sat)
; {var3201_getObjectAttachments/241945301=([org.apache.dubbo.rpc.Invocation], java.util.Map), var3239_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), setInvoker/-967664046=([org.apache.dubbo.rpc.RpcServiceContext, org.apache.dubbo.rpc.Invoker], org.apache.dubbo.rpc.RpcServiceContext), setInvocation/596770720=([org.apache.dubbo.rpc.RpcServiceContext, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.RpcServiceContext), var3239_getServerAttachment/1146677352=([], org.apache.dubbo.rpc.RpcContextAttachment), getLocalAddress/-2134086869=([org.apache.dubbo.rpc.RpcContext], java.net.InetSocketAddress), cast-from-var1467-to-var3239=([org.apache.dubbo.rpc.RpcContextAttachment], org.apache.dubbo.rpc.RpcContext), var3201_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var3521_isNotEmpty/-1251449450=([java.lang.String], boolean), setRemoteApplicationName/-1652244623=([org.apache.dubbo.rpc.RpcServiceContext, java.lang.String], org.apache.dubbo.rpc.RpcServiceContext), var2824_getTimeout/1417314331=([org.apache.dubbo.rpc.Invocation, long], long), var501_isNotEmptyMap/1884409606=([java.util.Map], boolean), clearAfterEachInvoke/774611878=([org.apache.dubbo.rpc.RpcContext, boolean], void), isAsyncStarted/-1250802381=([org.apache.dubbo.rpc.RpcContext], boolean)}
; {var3913=org.apache.dubbo.rpc.filter.ContextFilter, var691=r7, var1047=org.apache.dubbo.rpc.Invoker, var3406=r1, var3201=org.apache.dubbo.rpc.Invocation, var2924=r0, var3393=java.util.Map, var1848=r28, var3314=org.apache.dubbo.rpc.RpcServiceContext, var3239=org.apache.dubbo.rpc.RpcContext, var987=$r2, var2670=$r3, var1467=org.apache.dubbo.rpc.RpcContextAttachment, var1194=$r21, var627=java.net.InetSocketAddress, var815=$r4, var1408=$r18, var3521=org.apache.dubbo.common.utils.StringUtils, var2291=$z0, var985=$r14, var2824=org.apache.dubbo.rpc.support.RpcUtils, var1382=$l2, var1188=$b0, var501=org.apache.dubbo.common.utils.CollectionUtils, var1766=$z1, var310=$z6, var2990=java.lang.Throwable, var2571=$r27, var3241=1, var2997=$z5}
; {org.apache.dubbo.rpc.filter.ContextFilter=var3913, r7=var691, org.apache.dubbo.rpc.Invoker=var1047, r1=var3406, org.apache.dubbo.rpc.Invocation=var3201, r0=var2924, java.util.Map=var3393, r28=var1848, org.apache.dubbo.rpc.RpcServiceContext=var3314, org.apache.dubbo.rpc.RpcContext=var3239, $r2=var987, $r3=var2670, org.apache.dubbo.rpc.RpcContextAttachment=var1467, $r21=var1194, java.net.InetSocketAddress=var627, $r4=var815, $r18=var1408, org.apache.dubbo.common.utils.StringUtils=var3521, $z0=var2291, $r14=var985, org.apache.dubbo.rpc.support.RpcUtils=var2824, $l2=var1382, $b0=var1188, org.apache.dubbo.common.utils.CollectionUtils=var501, $z1=var1766, $z6=var310, java.lang.Throwable=var2990, $r27=var2571, 1=var3241, $z5=var2997}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.filter.ContextFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>();	if r28 == null goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvoker(org.apache.dubbo.rpc.Invoker)>(r1);	virtualinvoke $r3.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvocation(org.apache.dubbo.rpc.Invocation)>(r0);	$r21 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContextAttachment getServerAttachment()>();	$r4 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: java.net.InetSocketAddress getLocalAddress()>();	if $r4 != null goto $r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application");	$r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r18);	if $z0 == 0 goto $r6 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r14 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	virtualinvoke $r14.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setRemoteApplicationName(java.lang.String)>($r18);	goto [?= $l2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: long getTimeout(org.apache.dubbo.rpc.Invocation,long)>(r0, -1L)];	$l2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: long getTimeout(org.apache.dubbo.rpc.Invocation,long)>(r0, -1L);	$b0 = $l2 cmp -1L;	if $b0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28);	if $z1 == 0 goto $z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	$z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	if $z6 == 0 goto virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(0);	$r27 := @caughtexception;	virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(1);	$z5 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: boolean isAsyncStarted()>();	if $z5 == 0 goto throw $r27;	throw $r27
;block_num 10