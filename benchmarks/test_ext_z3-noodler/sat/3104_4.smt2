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

(declare-sort var3472 0)
(declare-sort var3808 0)
(declare-sort var18 0)
(declare-sort var123 0)
(declare-sort var525 0)
(declare-sort var40 0)
(declare-sort var381 0)
(declare-sort var2843 0)
(declare-sort var1725 0)
(declare-sort var2007 0)
(declare-sort var3192 0)
(declare-sort var556 0)
(declare-sort var3600 0)
(declare-sort var339 0)
(declare-sort var2046 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3192!class ClassObject)
(declare-fun <init>/-1546997481 (var123) void)
(declare-fun cast-from-var3472-to-var123 (var3472) var123)
(declare-fun var525-init () var525)
(declare-fun <init>/882121004 (var525) void)
(declare-fun cast-from-var525-to-var40 (var525) var40)
(declare-fun listeners/898879186 (var3472) var40)
(declare-fun threadName/898879186 (var3472) String)
(declare-fun url/898879186 (var3472) var18)
(declare-fun getAttribute/-225665909 (var18 String) var381)
(declare-fun cast-from-var381-to-String (var381) String)
(declare-fun getParameter/506106603 (var18 String String) String)
(declare-fun var2843_splitToSet/395946401 (String Int Bool) var40)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var18) var1725)
(declare-fun getExtensionLoader/-514331157 (var556 ClassObject) var2007)
(declare-fun cast-from-var1725-to-var556 (var1725) var556)
(declare-fun var339_bootstrap$/832036118 (var3472 var2007) var3600)
(declare-fun var2046_forEach/-1836413473 (var2046 var3600) void)
(declare-fun cast-from-var40-to-var2046 (var40) var2046)
(declare-const null-var3472 var3472)
(declare-const null-String String)
(declare-const null-var18 var18)
(declare-const var31 var3472) ; Statement: r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport 
(assert (not (= var31 null-var3472)))
(declare-const var2521 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2521 null-String)))
(declare-const var682 var18) ; Statement: r3 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var682 null-var18)))
(assert true)
;(assert (<init>/-1546997481 (cast-from-var3472-to-var123 var31))) ; Statement: specialinvoke r0.<java.util.concurrent.ThreadPoolExecutor$AbortPolicy: void <init>()>() 

(declare-const var31!1 var3472)
(define-const var3302 var525 var525-init) ; Statement: $r1 = new org.apache.dubbo.common.utils.ConcurrentHashSet 
(assert true)
;(assert (<init>/882121004 var3302)) ; Statement: specialinvoke $r1.<org.apache.dubbo.common.utils.ConcurrentHashSet: void <init>()>() 

(declare-const var3302!1 var525)
(declare-const var31!2 var3472)
(assert (not (= var31!2 null-var3472)))
(assert (= (listeners/898879186 var31!2) (cast-from-var525-to-var40 var3302!1))) ; Statement: r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.util.Set listeners> = $r1 
(declare-const var31!3 var3472)
(assert (not (= var31!3 null-var3472)))
(assert (= (threadName/898879186 var31!3) var2521)) ; Statement: r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String threadName> = r2 
(declare-const var31!4 var3472)
(assert (not (= var31!4 null-var3472)))
(assert (= (url/898879186 var31!4) var682)) ; Statement: r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> = r3 
(assert true)
(define-const var3271 var381 (getAttribute/-225665909 var682 "thread-pool-exhausted-listeners")) ; Statement: $r4 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("thread-pool-exhausted-listeners") 
(define-const var3496 String (cast-from-var381-to-String var3271)) ; Statement: $r5 = (java.lang.String) $r4 
(assert true)
(define-const var1375 String (getParameter/506106603 var682 "thread-pool-exhausted-listeners" var3496)) ; Statement: r6 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("thread-pool-exhausted-listeners", $r5) 
(define-const var1028 var40 (var2843_splitToSet/395946401 var1375 44 (ite (= 1 1) true false))) ; Statement: r7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>(r6, 44, 1) 
(assert true)
(define-const var1338 var1725 (getOrDefaultFrameworkModel/-1637556979 var682)) ; Statement: r8 = virtualinvoke r3.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var626 var2007 (getExtensionLoader/-514331157 (cast-from-var1725-to-var556 var1338) var3192!class)) ; Statement: r9 = virtualinvoke r8.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/event/ThreadPoolExhaustedListener;") 
(define-const var1781 var3600 (var339_bootstrap$/832036118 var31!4 var626)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport$lambda_new_0__244: java.util.function.Consumer bootstrap$(org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport,org.apache.dubbo.common.extension.ExtensionLoader)>(r0, r9) 
;(assert (var2046_forEach/-1836413473 (cast-from-var40-to-var2046 var1028) var1781)) ; Statement: interfaceinvoke r7.<java.util.Set: void forEach(java.util.function.Consumer)>($r10) 

(declare-const var1028!1 var40)
(declare-const var1781!1 var3600)
 ; Statement: return 
(check-sat)
; {<init>/-1546997481=([java.util.concurrent.ThreadPoolExecutor$AbortPolicy], void), cast-from-var3472-to-var123=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], java.util.concurrent.ThreadPoolExecutor$AbortPolicy), var525-init=([], org.apache.dubbo.common.utils.ConcurrentHashSet), <init>/882121004=([org.apache.dubbo.common.utils.ConcurrentHashSet], void), cast-from-var525-to-var40=([org.apache.dubbo.common.utils.ConcurrentHashSet], java.util.Set), listeners/898879186=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], java.util.Set), threadName/898879186=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], java.lang.String), url/898879186=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport], org.apache.dubbo.common.URL), getAttribute/-225665909=([org.apache.dubbo.common.URL, java.lang.String], java.lang.Object), cast-from-var381-to-String=([java.lang.Object], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2843_splitToSet/395946401=([java.lang.String, char, boolean], java.util.Set), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getExtensionLoader/-514331157=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), cast-from-var1725-to-var556=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), var339_bootstrap$/832036118=([org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, org.apache.dubbo.common.extension.ExtensionLoader], java.util.function.Consumer), var2046_forEach/-1836413473=([java.lang.Iterable, java.util.function.Consumer], void), cast-from-var40-to-var2046=([java.util.Set], java.lang.Iterable)}
; {var3472=org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport, var31=r0, var2521=r2, var3808=null_type, var18=org.apache.dubbo.common.URL, var682=r3, var123=java.util.concurrent.ThreadPoolExecutor$AbortPolicy, var525=org.apache.dubbo.common.utils.ConcurrentHashSet, var3302=$r1, var40=java.util.Set, var381=java.lang.Object, var3271=$r4, var3496=$r5, var1375=r6, var2843=org.apache.dubbo.common.utils.StringUtils, var1028=r7, var1725=org.apache.dubbo.rpc.model.FrameworkModel, var1338=r8, var2007=org.apache.dubbo.common.extension.ExtensionLoader, var3192=org.apache.dubbo.common.threadpool.event.ThreadPoolExhaustedListener, var556=org.apache.dubbo.common.extension.ExtensionAccessor, var626=r9, var3600=java.util.function.Consumer, var339=org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport$lambda_new_0__244, var1781=$r10, var2046=java.lang.Iterable}
; {org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport=var3472, r0=var31, r2=var2521, null_type=var3808, org.apache.dubbo.common.URL=var18, r3=var682, java.util.concurrent.ThreadPoolExecutor$AbortPolicy=var123, org.apache.dubbo.common.utils.ConcurrentHashSet=var525, $r1=var3302, java.util.Set=var40, java.lang.Object=var381, $r4=var3271, $r5=var3496, r6=var1375, org.apache.dubbo.common.utils.StringUtils=var2843, r7=var1028, org.apache.dubbo.rpc.model.FrameworkModel=var1725, r8=var1338, org.apache.dubbo.common.extension.ExtensionLoader=var2007, org.apache.dubbo.common.threadpool.event.ThreadPoolExhaustedListener=var3192, org.apache.dubbo.common.extension.ExtensionAccessor=var556, r9=var626, java.util.function.Consumer=var3600, org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport$lambda_new_0__244=var339, $r10=var1781, java.lang.Iterable=var2046}
;seq <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport;	r2 := @parameter0: java.lang.String;	r3 := @parameter1: org.apache.dubbo.common.URL;	specialinvoke r0.<java.util.concurrent.ThreadPoolExecutor$AbortPolicy: void <init>()>();	$r1 = new org.apache.dubbo.common.utils.ConcurrentHashSet;	specialinvoke $r1.<org.apache.dubbo.common.utils.ConcurrentHashSet: void <init>()>();	r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.util.Set listeners> = $r1;	r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: java.lang.String threadName> = r2;	r0.<org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport: org.apache.dubbo.common.URL url> = r3;	$r4 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.Object getAttribute(java.lang.String)>("thread-pool-exhausted-listeners");	$r5 = (java.lang.String) $r4;	r6 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("thread-pool-exhausted-listeners", $r5);	r7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Set splitToSet(java.lang.String,char,boolean)>(r6, 44, 1);	r8 = virtualinvoke r3.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	r9 = virtualinvoke r8.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/event/ThreadPoolExhaustedListener;");	$r10 = staticinvoke <org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport$lambda_new_0__244: java.util.function.Consumer bootstrap$(org.apache.dubbo.common.threadpool.support.AbortPolicyWithReport,org.apache.dubbo.common.extension.ExtensionLoader)>(r0, r9);	interfaceinvoke r7.<java.util.Set: void forEach(java.util.function.Consumer)>($r10);	return
;block_num 1