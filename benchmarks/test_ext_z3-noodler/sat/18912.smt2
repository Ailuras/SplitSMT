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

(declare-sort var1172 0)
(declare-sort var3057 0)
(declare-sort var3825 0)
(declare-sort var2376 0)
(declare-sort var2841 0)
(declare-sort var638 0)
(declare-sort var2095 0)
(declare-sort var1500 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2841_getUrl/-275947851 (var2841) var2376)
(declare-fun cast-from-var3057-to-var2841 (var3057) var2841)
(declare-fun getParameter/-1307325648 (var2376 String) String)
(declare-fun getParameter/2144001655 (var2376 String Bool) Bool)
(declare-fun var638_isEmpty/-813097145 (String) Bool)
(declare-fun future/613897201 (var1172) var2095)
(declare-fun var3057_invoke/-1860754555 (var3057 var3825) var1500)
(declare-const null-var1172 var1172)
(declare-const null-var3057 var3057)
(declare-const null-var3825 var3825)
(declare-const null-var2095 var2095)
(declare-const var3727 var1172) ; Statement: r4 := @this: org.apache.dubbo.rpc.filter.AccessLogFilter 
(assert (not (= var3727 null-var1172)))
(declare-const var2071 var3057) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invoker 
(assert (not (= var2071 null-var3057)))
(declare-const var322 var3825) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.Invocation 
(assert (not (= var322 null-var3825)))
(define-const var3472 var2376 (var2841_getUrl/-275947851 (cast-from-var3057-to-var2841 var2071))) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3433 String (getParameter/-1307325648 var3472 "accesslog")) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("accesslog") 
(define-const var2335 var2376 (var2841_getUrl/-275947851 (cast-from-var3057-to-var2841 var2071))) ; Statement: $r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3021 Bool (getParameter/2144001655 var2335 "accesslog.fixed.path" (ite (= 1 1) true false))) ; Statement: z0 = virtualinvoke $r3.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("accesslog.fixed.path", 1) 
(define-const var411 Bool (var638_isEmpty/-813097145 var3433)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2) 
 ; Statement: if $z1 != 0 goto $r5 = r4.<org.apache.dubbo.rpc.filter.AccessLogFilter: java.util.concurrent.ScheduledFuture future> 
(assert (not (= (ite var411 1 0) 0))) ; Cond: $z1 != 0 
(define-const var1635 var2095 (future/613897201 var3727)) ; Statement: $r5 = r4.<org.apache.dubbo.rpc.filter.AccessLogFilter: java.util.concurrent.ScheduledFuture future> 
 ; Statement: if $r5 == null goto $r37 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r6) 
(assert (= var1635 null-var2095)) ; Cond: $r5 == null 
(define-const var2265 var1500 (var3057_invoke/-1860754555 var2071 var322)) ; Statement: $r37 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r6) 
 ; Statement: return $r37 
(check-sat)
; {var2841_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var3057-to-var2841=([org.apache.dubbo.rpc.Invoker], org.apache.dubbo.common.Node), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), var638_isEmpty/-813097145=([java.lang.String], boolean), future/613897201=([org.apache.dubbo.rpc.filter.AccessLogFilter], java.util.concurrent.ScheduledFuture), var3057_invoke/-1860754555=([org.apache.dubbo.rpc.Invoker, org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.Result)}
; {var1172=org.apache.dubbo.rpc.filter.AccessLogFilter, var3727=r4, var3057=org.apache.dubbo.rpc.Invoker, var2071=r0, var3825=org.apache.dubbo.rpc.Invocation, var322=r6, var2376=org.apache.dubbo.common.URL, var2841=org.apache.dubbo.common.Node, var3472=$r1, var3433=r2, var2335=$r3, var3021=z0, var638=org.apache.dubbo.common.utils.StringUtils, var411=$z1, var2095=java.util.concurrent.ScheduledFuture, var1635=$r5, var1500=org.apache.dubbo.rpc.Result, var2265=$r37}
; {org.apache.dubbo.rpc.filter.AccessLogFilter=var1172, r4=var3727, org.apache.dubbo.rpc.Invoker=var3057, r0=var2071, org.apache.dubbo.rpc.Invocation=var3825, r6=var322, org.apache.dubbo.common.URL=var2376, org.apache.dubbo.common.Node=var2841, $r1=var3472, r2=var3433, $r3=var2335, z0=var3021, org.apache.dubbo.common.utils.StringUtils=var638, $z1=var411, java.util.concurrent.ScheduledFuture=var2095, $r5=var1635, org.apache.dubbo.rpc.Result=var1500, $r37=var2265}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.rpc.filter.AccessLogFilter;	r0 := @parameter0: org.apache.dubbo.rpc.Invoker;	r6 := @parameter1: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	r2 = virtualinvoke $r1.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("accesslog");	$r3 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.common.URL getUrl()>();	z0 = virtualinvoke $r3.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("accesslog.fixed.path", 1);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r2);	if $z1 != 0 goto $r5 = r4.<org.apache.dubbo.rpc.filter.AccessLogFilter: java.util.concurrent.ScheduledFuture future>;	$r5 = r4.<org.apache.dubbo.rpc.filter.AccessLogFilter: java.util.concurrent.ScheduledFuture future>;	if $r5 == null goto $r37 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r6);	$r37 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invoker: org.apache.dubbo.rpc.Result invoke(org.apache.dubbo.rpc.Invocation)>(r6);	return $r37
;block_num 3