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

(declare-sort var1716 0)
(declare-sort var484 0)
(declare-sort var1744 0)
(declare-sort var2445 0)
(declare-sort var695 0)
(declare-sort var1473 0)
(declare-sort var2475 0)
(declare-sort var3923 0)
(declare-sort var3832 0)
(declare-sort var1040 0)
(declare-sort var2477 0)
(declare-sort var2639 0)
(declare-sort var641 0)
(declare-sort var1987 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var641!class ClassObject)
(declare-fun <init>/229079087 (var1744 var484) void)
(declare-fun cast-from-var1716-to-var1744 (var1716) var1744)
(declare-fun var2445-init () var2445)
(declare-fun <init>/-2175807 (var2445) void)
(declare-fun cast-from-var2445-to-var695 (var2445) var695)
(declare-fun stringAddress/-1068639500 (var1716) var695)
(declare-fun stringParam/-1068639500 (var1716) var695)
(declare-fun cast-from-var2445-to-var1473 (var2445) var1473)
(declare-fun waitForRemove/-1068639500 (var1716) var1473)
(declare-fun var2475-init () var2475)
(declare-fun <init>/-1145820757 (var2475 Int) void)
(declare-fun semaphore/-1068639500 (var1716) var2475)
(declare-fun stringUrls/-1068639500 (var1716) var1473)
(declare-fun var3923-init () var3923)
(declare-fun <init>/613807010 (var3923 Int) void)
(declare-fun cast-from-var3923-to-var1473 (var3923) var1473)
(declare-fun extraParameters/-1068639500 (var1716) var1473)
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun var1473_put/1464166817 (var1473 var3832 var3832) var3832)
(declare-fun cast-from-String-to-var3832 (String) var3832)
(declare-fun getOrDefaultFrameworkModel/-1637556979 (var484) var1040)
(declare-fun getBeanFactory/819046718 (var2639) var2477)
(declare-fun cast-from-var1040-to-var2639 (var1040) var2639)
(declare-fun getBean/643676830 (var2477 ClassObject) var3832)
(declare-fun cast-from-var3832-to-var641 (var3832) var641)
(declare-fun nextScheduledExecutor/1701528213 (var641) var1987)
(declare-fun cacheRemovalScheduler/-1068639500 (var1716) var1987)
(declare-fun getScopeModel/-1957927771 (var484) var2639)
(declare-fun var1716_getIntConfig/-1315732386 (var2639 String Int) Int)
(declare-fun cacheRemovalTaskIntervalInMillis/-1068639500 (var1716) Int)
(declare-fun cacheClearWaitingThresholdInMillis/-1068639500 (var1716) Int)
(declare-const null-var1716 var1716)
(declare-const null-var484 var484)
(declare-const var2420 var1716) ; Statement: r0 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry 
(assert (not (= var2420 null-var1716)))
(declare-const var806 var484) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var806 null-var484)))
(assert true)
;(assert (<init>/229079087 (cast-from-var1716-to-var1744 var2420) var806)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void <init>(org.apache.dubbo.common.URL)>(r1) 

(declare-const var2420!1 var1716)
(declare-const var806!1 var484)
(define-const var3404 var2445 var2445-init) ; Statement: $r2 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var3404)) ; Statement: specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var3404!1 var2445)
(declare-const var2420!2 var1716)
(assert (not (= var2420!2 null-var1716)))
(assert (= (stringAddress/-1068639500 var2420!2) (cast-from-var2445-to-var695 var3404!1))) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.ConcurrentMap stringAddress> = $r2 
(define-const var768 var2445 var2445-init) ; Statement: $r3 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var768)) ; Statement: specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var768!1 var2445)
(declare-const var2420!3 var1716)
(assert (not (= var2420!3 null-var1716)))
(assert (= (stringParam/-1068639500 var2420!3) (cast-from-var2445-to-var695 var768!1))) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.ConcurrentMap stringParam> = $r3 
(define-const var1789 var2445 var2445-init) ; Statement: $r4 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1789)) ; Statement: specialinvoke $r4.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1789!1 var2445)
(declare-const var2420!4 var1716)
(assert (not (= var2420!4 null-var1716)))
(assert (= (waitForRemove/-1068639500 var2420!4) (cast-from-var2445-to-var1473 var1789!1))) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map waitForRemove> = $r4 
(define-const var3144 var2475 var2475-init) ; Statement: $r5 = new java.util.concurrent.Semaphore 
(assert true)
;(assert (<init>/-1145820757 var3144 1)) ; Statement: specialinvoke $r5.<java.util.concurrent.Semaphore: void <init>(int)>(1) 

(declare-const var3144!1 var2475)
(declare-const var3875 Int)
(declare-const var2420!5 var1716)
(assert (not (= var2420!5 null-var1716)))
(assert (= (semaphore/-1068639500 var2420!5) var3144!1)) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.Semaphore semaphore> = $r5 
(define-const var3554 var2445 var2445-init) ; Statement: $r6 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var3554)) ; Statement: specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var3554!1 var2445)
(declare-const var2420!6 var1716)
(assert (not (= var2420!6 null-var1716)))
(assert (= (stringUrls/-1068639500 var2420!6) (cast-from-var2445-to-var1473 var3554!1))) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map stringUrls> = $r6 
(define-const var1501 var3923 var3923-init) ; Statement: $r7 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var1501 8)) ; Statement: specialinvoke $r7.<java.util.HashMap: void <init>(int)>(8) 

(declare-const var1501!1 var3923)
(declare-const var3455 Int)
(declare-const var2420!7 var1716)
(assert (not (= var2420!7 null-var1716)))
(assert (= (extraParameters/-1068639500 var2420!7) (cast-from-var3923-to-var1473 var1501!1))) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map extraParameters> = $r7 
(define-const var996 var1473 (extraParameters/-1068639500 var2420!7)) ; Statement: $r8 = r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map extraParameters> 
(define-const var1425 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r9 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
;(assert (var1473_put/1464166817 var996 (cast-from-String-to-var3832 "check") (cast-from-String-to-var3832 var1425))) ; Statement: interfaceinvoke $r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("check", $r9) 

(declare-const var996!1 var1473)
(declare-const var148 String)
(declare-const var1425!1 String)
(assert true)
(define-const var2341 var1040 (getOrDefaultFrameworkModel/-1637556979 var806!1)) ; Statement: $r10 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>() 
(assert true)
(define-const var2646 var2477 (getBeanFactory/819046718 (cast-from-var1040-to-var2639 var2341))) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var2476 var3832 (getBean/643676830 var2646 var641!class)) ; Statement: $r12 = virtualinvoke $r11.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/FrameworkExecutorRepository;") 
(define-const var2142 var641 (cast-from-var3832-to-var641 var2476)) ; Statement: $r13 = (org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository) $r12 
(assert true)
(define-const var2667 var1987 (nextScheduledExecutor/1701528213 var2142)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository: java.util.concurrent.ScheduledExecutorService nextScheduledExecutor()>() 
(declare-const var2420!8 var1716)
(assert (not (= var2420!8 null-var1716)))
(assert (= (cacheRemovalScheduler/-1068639500 var2420!8) var2667)) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.ScheduledExecutorService cacheRemovalScheduler> = $r14 
(assert true)
(define-const var2380 var2639 (getScopeModel/-1957927771 var806!1)) ; Statement: $r15 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var1467 Int (var1716_getIntConfig/-1315732386 var2380 "dubbo.application.url.cache.task.interval" 120000)) ; Statement: $i0 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: int getIntConfig(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String,int)>($r15, "dubbo.application.url.cache.task.interval", 120000) 
(declare-const var2420!9 var1716)
(assert (not (= var2420!9 null-var1716)))
(assert (= (cacheRemovalTaskIntervalInMillis/-1068639500 var2420!9) var1467)) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: int cacheRemovalTaskIntervalInMillis> = $i0 
(assert true)
(define-const var3061 var2639 (getScopeModel/-1957927771 var806!1)) ; Statement: $r16 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>() 
(define-const var649 Int (var1716_getIntConfig/-1315732386 var3061 "dubbo.application.url.cache.clear.waiting" 300000)) ; Statement: $i1 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: int getIntConfig(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String,int)>($r16, "dubbo.application.url.cache.clear.waiting", 300000) 
(declare-const var2420!10 var1716)
(assert (not (= var2420!10 null-var1716)))
(assert (= (cacheClearWaitingThresholdInMillis/-1068639500 var2420!10) var649)) ; Statement: r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: int cacheClearWaitingThresholdInMillis> = $i1 
 ; Statement: return 
(check-sat)
; {<init>/229079087=([org.apache.dubbo.registry.support.FailbackRegistry, org.apache.dubbo.common.URL], void), cast-from-var1716-to-var1744=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], org.apache.dubbo.registry.support.FailbackRegistry), var2445-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2445-to-var695=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), stringAddress/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.concurrent.ConcurrentMap), stringParam/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.concurrent.ConcurrentMap), cast-from-var2445-to-var1473=([java.util.concurrent.ConcurrentHashMap], java.util.Map), waitForRemove/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.Map), var2475-init=([], java.util.concurrent.Semaphore), <init>/-1145820757=([java.util.concurrent.Semaphore, int], void), semaphore/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.concurrent.Semaphore), stringUrls/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.Map), var3923-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), cast-from-var3923-to-var1473=([java.util.HashMap], java.util.Map), extraParameters/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.Map), String_valueOf/-1973653463=([boolean], java.lang.String), var1473_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3832=([java.lang.String], java.lang.Object), getOrDefaultFrameworkModel/-1637556979=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.FrameworkModel), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), cast-from-var1040-to-var2639=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ScopeModel), getBean/643676830=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var3832-to-var641=([java.lang.Object], org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository), nextScheduledExecutor/1701528213=([org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository], java.util.concurrent.ScheduledExecutorService), cacheRemovalScheduler/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], java.util.concurrent.ScheduledExecutorService), getScopeModel/-1957927771=([org.apache.dubbo.common.URL], org.apache.dubbo.rpc.model.ScopeModel), var1716_getIntConfig/-1315732386=([org.apache.dubbo.rpc.model.ScopeModel, java.lang.String, int], int), cacheRemovalTaskIntervalInMillis/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], int), cacheClearWaitingThresholdInMillis/-1068639500=([org.apache.dubbo.registry.support.CacheableFailbackRegistry], int)}
; {var1716=org.apache.dubbo.registry.support.CacheableFailbackRegistry, var2420=r0, var484=org.apache.dubbo.common.URL, var806=r1, var1744=org.apache.dubbo.registry.support.FailbackRegistry, var2445=java.util.concurrent.ConcurrentHashMap, var3404=$r2, var695=java.util.concurrent.ConcurrentMap, var768=$r3, var1789=$r4, var1473=java.util.Map, var2475=java.util.concurrent.Semaphore, var3144=$r5, var3875=1, var3554=$r6, var3923=java.util.HashMap, var1501=$r7, var3455=8, var996=$r8, var1425=$r9, var3832=java.lang.Object, var148="check", var1040=org.apache.dubbo.rpc.model.FrameworkModel, var2341=$r10, var2477=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var2639=org.apache.dubbo.rpc.model.ScopeModel, var2646=$r11, var641=org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository, var2476=$r12, var2142=$r13, var1987=java.util.concurrent.ScheduledExecutorService, var2667=$r14, var2380=$r15, var1467=$i0, var3061=$r16, var649=$i1}
; {org.apache.dubbo.registry.support.CacheableFailbackRegistry=var1716, r0=var2420, org.apache.dubbo.common.URL=var484, r1=var806, org.apache.dubbo.registry.support.FailbackRegistry=var1744, java.util.concurrent.ConcurrentHashMap=var2445, $r2=var3404, java.util.concurrent.ConcurrentMap=var695, $r3=var768, $r4=var1789, java.util.Map=var1473, java.util.concurrent.Semaphore=var2475, $r5=var3144, 1=var3875, $r6=var3554, java.util.HashMap=var3923, $r7=var1501, 8=var3455, $r8=var996, $r9=var1425, java.lang.Object=var3832, "check"=var148, org.apache.dubbo.rpc.model.FrameworkModel=var1040, $r10=var2341, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var2477, org.apache.dubbo.rpc.model.ScopeModel=var2639, $r11=var2646, org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository=var641, $r12=var2476, $r13=var2142, java.util.concurrent.ScheduledExecutorService=var1987, $r14=var2667, $r15=var2380, $i0=var1467, $r16=var3061, $i1=var649}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.registry.support.FailbackRegistry: void <init>(org.apache.dubbo.common.URL)>(r1);	$r2 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.ConcurrentMap stringAddress> = $r2;	$r3 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r3.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.ConcurrentMap stringParam> = $r3;	$r4 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r4.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map waitForRemove> = $r4;	$r5 = new java.util.concurrent.Semaphore;	specialinvoke $r5.<java.util.concurrent.Semaphore: void <init>(int)>(1);	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.Semaphore semaphore> = $r5;	$r6 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r6.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map stringUrls> = $r6;	$r7 = new java.util.HashMap;	specialinvoke $r7.<java.util.HashMap: void <init>(int)>(8);	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map extraParameters> = $r7;	$r8 = r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.Map extraParameters>;	$r9 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	interfaceinvoke $r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("check", $r9);	$r10 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.FrameworkModel getOrDefaultFrameworkModel()>();	$r11 = virtualinvoke $r10.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r12 = virtualinvoke $r11.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getBean(java.lang.Class)>(class "Lorg/apache/dubbo/common/threadpool/manager/FrameworkExecutorRepository;");	$r13 = (org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository) $r12;	$r14 = virtualinvoke $r13.<org.apache.dubbo.common.threadpool.manager.FrameworkExecutorRepository: java.util.concurrent.ScheduledExecutorService nextScheduledExecutor()>();	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: java.util.concurrent.ScheduledExecutorService cacheRemovalScheduler> = $r14;	$r15 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$i0 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: int getIntConfig(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String,int)>($r15, "dubbo.application.url.cache.task.interval", 120000);	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: int cacheRemovalTaskIntervalInMillis> = $i0;	$r16 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.rpc.model.ScopeModel getScopeModel()>();	$i1 = staticinvoke <org.apache.dubbo.registry.support.CacheableFailbackRegistry: int getIntConfig(org.apache.dubbo.rpc.model.ScopeModel,java.lang.String,int)>($r16, "dubbo.application.url.cache.clear.waiting", 300000);	r0.<org.apache.dubbo.registry.support.CacheableFailbackRegistry: int cacheClearWaitingThresholdInMillis> = $i1;	return
;block_num 1