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

(declare-sort var1948 0)
(declare-sort var235 0)
(declare-sort var1221 0)
(declare-sort var648 0)
(declare-sort var584 0)
(declare-sort var2773 0)
(declare-sort var2544 0)
(declare-sort var957 0)
(declare-sort var901 0)
(declare-sort var3414 0)
(declare-sort var255 0)
(declare-sort var2270 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1221_getObjectAttachments/241945301 (var1221) var648)
(declare-fun var2773_getServiceContext/735675290 () var584)
(declare-fun setInvoker/-967664046 (var584 var235) var584)
(declare-fun setInvocation/596770720 (var584 var1221) var584)
(declare-fun var2773_getServerAttachment/1146677352 () var2544)
(declare-fun getLocalAddress/-2134086869 (var2773) var957)
(declare-fun cast-from-var2544-to-var2773 (var2544) var2773)
(declare-fun var1221_getAttachment/-2134772037 (var1221 String) String)
(declare-fun var901_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getAttachment/420907265 (var2773 String) String)
(declare-fun setRemoteApplicationName/-1652244623 (var584 String) var584)
(declare-fun var3414_getTimeout/1417314331 (var1221 Int) Int)
(declare-fun var255_isNotEmptyMap/1884409606 (var648) Bool)
(declare-fun clearAfterEachInvoke/774611878 (var2773 Bool) void)
(declare-fun isAsyncStarted/-1250802381 (var2773) Bool)
(declare-const null-var1948 var1948)
(declare-const null-var235 var235)
(declare-const null-var1221 var1221)
(declare-const null-var648 var648)
(declare-const null-var957 var957)
(declare-const null-var2270 var2270)
(declare-const var1080 var1948) ; Statement: r7 := @this: org.apache.dubbo.rpc.filter.ContextFilter 
(assert (not (= var1080 null-var1948)))
(declare-const var2309 var235) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2309 null-var235)))
(declare-const var2353 var1221) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var2353 null-var1221)))
(define-const var2313 var648 (var1221_getObjectAttachments/241945301 var2353)) ; Statement: r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>() 
 ; Statement: if r28 == null goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (= var2313 null-var648)) ; Cond: r28 == null 
(define-const var963 var584 var2773_getServiceContext/735675290) ; Statement: $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var581 var584 (setInvoker/-967664046 var963 var2309)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvoker(org.apache.dubbo.rpc.Invoker)>(r1) 
(assert true)
;(assert (setInvocation/596770720 var581 var2353)) ; Statement: virtualinvoke $r3.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvocation(org.apache.dubbo.rpc.Invocation)>(r0) 

(declare-const var581!1 var584)
(declare-const var2353!1 var1221)
(define-const var3710 var2544 var2773_getServerAttachment/1146677352) ; Statement: $r21 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContextAttachment getServerAttachment()>() 
(assert true)
(define-const var3699 var957 (getLocalAddress/-2134086869 (cast-from-var2544-to-var2773 var3710))) ; Statement: $r4 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: java.net.InetSocketAddress getLocalAddress()>() 
 ; Statement: if $r4 != null goto $r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application") 
(assert (not (= var3699 null-var957))) ; Cond: $r4 != null 
(define-const var1959 String (var1221_getAttachment/-2134772037 var2353!1 "remote.application")) ; Statement: $r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application") 
(define-const var3347 Bool (var901_isNotEmpty/-1251449450 var1959)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r18) 
 ; Statement: if $z0 == 0 goto $r6 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert (= (ite var3347 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1619 var584 var2773_getServiceContext/735675290) ; Statement: $r6 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var2403 String (getAttachment/420907265 (cast-from-var2544-to-var2773 var3710) "remote.application")) ; Statement: $r5 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: java.lang.String getAttachment(java.lang.String)>("remote.application") 
(assert true)
;(assert (setRemoteApplicationName/-1652244623 var1619 var2403)) ; Statement: virtualinvoke $r6.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setRemoteApplicationName(java.lang.String)>($r5) 

(declare-const var1619!1 var584)
(declare-const var2403!1 String)
(assert true) ; Non Conditional
(define-const var1920 Int (var3414_getTimeout/1417314331 var2353!1 -1)) ; Statement: $l2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: long getTimeout(org.apache.dubbo.rpc.Invocation,long)>(r0, -1L) 
(define-const var966 Int (ite (> var1920 -1) 1 (ite (< var1920 -1) -1 0))) ; Statement: $b0 = $l2 cmp -1L 
 ; Statement: if $b0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28) 
(assert (= var966 0)) ; Cond: $b0 == 0 
(define-const var1752 Bool (var255_isNotEmptyMap/1884409606 var2313)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28) 
 ; Statement: if $z1 == 0 goto $z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
(assert (= (ite var1752 1 0) 0)) ; Cond: $z1 == 0 
(define-const var190 Bool true) ; Statement: $z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation 
 ; Statement: if $z6 == 0 goto virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(0) 
(assert (not (= (ite var190 1 0) 0))) ; Negate: Cond: $z6 == 0  
(declare-const var1632 var2270) ; Statement: $r27 := @caughtexception 
(assert (not (= var1632 null-var2270)))
(assert true) ; Non Conditional
(assert true)
;(assert (clearAfterEachInvoke/774611878 (cast-from-var2544-to-var2773 var3710) (ite (= 1 1) true false))) ; Statement: virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(1) 

(declare-const var3710!1 var2544)
(declare-const var3069 Int)
(assert true)
(define-const var2870 Bool (isAsyncStarted/-1250802381 (cast-from-var2544-to-var2773 var3710!1))) ; Statement: $z5 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: boolean isAsyncStarted()>() 
 ; Statement: if $z5 == 0 goto throw $r27 
(assert (= (ite var2870 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: throw $r27 
(check-sat)
; {var1221_getObjectAttachments/241945301=([org.apache.dubbo.rpc.Invocation], java.util.Map), var2773_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), setInvoker/-967664046=([org.apache.dubbo.rpc.RpcServiceContext, org.apache.dubbo.rpc.Invoker], org.apache.dubbo.rpc.RpcServiceContext), setInvocation/596770720=([org.apache.dubbo.rpc.RpcServiceContext, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.RpcServiceContext), var2773_getServerAttachment/1146677352=([], org.apache.dubbo.rpc.RpcContextAttachment), getLocalAddress/-2134086869=([org.apache.dubbo.rpc.RpcContext], java.net.InetSocketAddress), cast-from-var2544-to-var2773=([org.apache.dubbo.rpc.RpcContextAttachment], org.apache.dubbo.rpc.RpcContext), var1221_getAttachment/-2134772037=([org.apache.dubbo.rpc.Invocation, java.lang.String], java.lang.String), var901_isNotEmpty/-1251449450=([java.lang.String], boolean), getAttachment/420907265=([org.apache.dubbo.rpc.RpcContext, java.lang.String], java.lang.String), setRemoteApplicationName/-1652244623=([org.apache.dubbo.rpc.RpcServiceContext, java.lang.String], org.apache.dubbo.rpc.RpcServiceContext), var3414_getTimeout/1417314331=([org.apache.dubbo.rpc.Invocation, long], long), var255_isNotEmptyMap/1884409606=([java.util.Map], boolean), clearAfterEachInvoke/774611878=([org.apache.dubbo.rpc.RpcContext, boolean], void), isAsyncStarted/-1250802381=([org.apache.dubbo.rpc.RpcContext], boolean)}
; {var1948=org.apache.dubbo.rpc.filter.ContextFilter, var1080=r7, var235=org.apache.dubbo.rpc.Invoker, var2309=r1, var1221=org.apache.dubbo.rpc.Invocation, var2353=r0, var648=java.util.Map, var2313=r28, var584=org.apache.dubbo.rpc.RpcServiceContext, var2773=org.apache.dubbo.rpc.RpcContext, var963=$r2, var581=$r3, var2544=org.apache.dubbo.rpc.RpcContextAttachment, var3710=$r21, var957=java.net.InetSocketAddress, var3699=$r4, var1959=$r18, var901=org.apache.dubbo.common.utils.StringUtils, var3347=$z0, var1619=$r6, var2403=$r5, var3414=org.apache.dubbo.rpc.support.RpcUtils, var1920=$l2, var966=$b0, var255=org.apache.dubbo.common.utils.CollectionUtils, var1752=$z1, var190=$z6, var2270=java.lang.Throwable, var1632=$r27, var3069=1, var2870=$z5}
; {org.apache.dubbo.rpc.filter.ContextFilter=var1948, r7=var1080, org.apache.dubbo.rpc.Invoker=var235, r1=var2309, org.apache.dubbo.rpc.Invocation=var1221, r0=var2353, java.util.Map=var648, r28=var2313, org.apache.dubbo.rpc.RpcServiceContext=var584, org.apache.dubbo.rpc.RpcContext=var2773, $r2=var963, $r3=var581, org.apache.dubbo.rpc.RpcContextAttachment=var2544, $r21=var3710, java.net.InetSocketAddress=var957, $r4=var3699, $r18=var1959, org.apache.dubbo.common.utils.StringUtils=var901, $z0=var3347, $r6=var1619, $r5=var2403, org.apache.dubbo.rpc.support.RpcUtils=var3414, $l2=var1920, $b0=var966, org.apache.dubbo.common.utils.CollectionUtils=var255, $z1=var1752, $z6=var190, java.lang.Throwable=var2270, $r27=var1632, 1=var3069, $z5=var2870}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.filter.ContextFilter;	r1 := @parameter0: org.apache.dubbo.rpc.Invoker;	r0 := @parameter1: org.apache.dubbo.rpc.Invocation;	r28 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.util.Map getObjectAttachments()>();	if r28 == null goto $r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r2 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvoker(org.apache.dubbo.rpc.Invoker)>(r1);	virtualinvoke $r3.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setInvocation(org.apache.dubbo.rpc.Invocation)>(r0);	$r21 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcContextAttachment getServerAttachment()>();	$r4 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: java.net.InetSocketAddress getLocalAddress()>();	if $r4 != null goto $r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application");	$r18 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getAttachment(java.lang.String)>("remote.application");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r18);	if $z0 == 0 goto $r6 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r6 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r5 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: java.lang.String getAttachment(java.lang.String)>("remote.application");	virtualinvoke $r6.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.rpc.RpcServiceContext setRemoteApplicationName(java.lang.String)>($r5);	$l2 = staticinvoke <org.apache.dubbo.rpc.support.RpcUtils: long getTimeout(org.apache.dubbo.rpc.Invocation,long)>(r0, -1L);	$b0 = $l2 cmp -1L;	if $b0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28);	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmptyMap(java.util.Map)>(r28);	if $z1 == 0 goto $z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	$z6 = r0 instanceof org.apache.dubbo.rpc.RpcInvocation;	if $z6 == 0 goto virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(0);	$r27 := @caughtexception;	virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: void clearAfterEachInvoke(boolean)>(1);	$z5 = virtualinvoke $r21.<org.apache.dubbo.rpc.RpcContext: boolean isAsyncStarted()>();	if $z5 == 0 goto throw $r27;	throw $r27
;block_num 10