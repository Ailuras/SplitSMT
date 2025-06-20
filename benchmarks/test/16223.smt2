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

(declare-sort var2809 0)
(declare-sort var169 0)
(declare-sort var1170 0)
(declare-sort var66 0)
(declare-sort var1982 0)
(declare-sort var3526 0)
(declare-sort var4 0)
(declare-sort var803 0)
(declare-sort var2944 0)
(declare-sort var3689 0)
(declare-sort var2687 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun serviceDiscovery/-518639494 (var2809) var66)
(declare-fun var66_serviceCacheBuilder/1525882524 (var66) var1982)
(declare-fun var1982_name/-738952975 (var1982 String) var1982)
(declare-fun var1982_build/912772622 (var1982) var3526)
(declare-fun var4-init () var4)
(declare-fun <init>/1379513029 (var4 var2809 var3526 String var169) void)
(declare-fun var3526_addListener/2007192526 (var3526 var803) void)
(declare-fun cast-from-var4-to-var803 (var4) var803)
(declare-fun var3689-init () var3689)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/456387396 (var3689 Int String var2687) void)
(declare-fun cast-from-var2944-to-var2687 (var2944) var2687)
(declare-const null-var2809 var2809)
(declare-const null-var169 var169)
(declare-const null-String String)
(declare-const null-var2944 var2944)
(declare-const var2647 var2809) ; Statement: r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery 
(assert (not (= var2647 null-var2809)))
(declare-const var2300 var169) ; Statement: r7 := @parameter0: java.util.concurrent.CountDownLatch 
(assert (not (= var2300 null-var169)))
(declare-const var428 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var428 null-String)))
(define-const var291 var66 (serviceDiscovery/-518639494 var2647)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery: org.apache.curator.x.discovery.ServiceDiscovery serviceDiscovery> 
(define-const var2324 var1982 (var66_serviceCacheBuilder/1525882524 var291)) ; Statement: $r3 = interfaceinvoke $r1.<org.apache.curator.x.discovery.ServiceDiscovery: org.apache.curator.x.discovery.ServiceCacheBuilder serviceCacheBuilder()>() 
(define-const var2518 var1982 (var1982_name/-738952975 var2324 var428)) ; Statement: $r4 = interfaceinvoke $r3.<org.apache.curator.x.discovery.ServiceCacheBuilder: org.apache.curator.x.discovery.ServiceCacheBuilder name(java.lang.String)>(r2) 
(define-const var3077 var3526 (var1982_build/912772622 var2518)) ; Statement: r5 = interfaceinvoke $r4.<org.apache.curator.x.discovery.ServiceCacheBuilder: org.apache.curator.x.discovery.ServiceCache build()>() 
(define-const var370 var4 var4-init) ; Statement: $r6 = new org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher 
(assert true)
;(assert (<init>/1379513029 var370 var2647 var3077 var428 var2300)) ; Statement: specialinvoke $r6.<org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher: void <init>(org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery,org.apache.curator.x.discovery.ServiceCache,java.lang.String,java.util.concurrent.CountDownLatch)>(r0, r5, r2, r7) 

(declare-const var370!1 var4)
(declare-const var2647!1 var2809)
(declare-const var3077!1 var3526)
(declare-const var428!1 String)
(declare-const var2300!1 var169)
;(assert (var3526_addListener/2007192526 var3077!1 (cast-from-var4-to-var803 var370!1))) ; Statement: interfaceinvoke r5.<org.apache.curator.x.discovery.ServiceCache: void addListener(java.lang.Object)>($r6) 

(declare-const var3077!2 var3526)
(declare-const var370!2 var4)
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3562 var2944) ; Statement: $r8 := @caughtexception 
(assert (not (= var3562 null-var2944)))
(define-const var3872 var3689 var3689-init) ; Statement: $r9 = new org.apache.dubbo.rpc.RpcException 
(define-const var1301 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1301)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1301!1 String)
(assert (= var1301!1 ""))
(assert true)
(define-const var700 String (append/672562846 var1301!1 "Failed subscribe service: ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed subscribe service: ") 
(declare-const var1301!2 String)
(assert (= var1301!2 (str.++ var1301!1 "Failed subscribe service: ")))
(assert true)
(define-const var1872 String (append/672562846 var700 var428!1)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var700!1 String)
(assert (= var700!1 (str.++ var700 var428!1)))
(assert true)
(define-const var1063 String (toString/-2075883882 var1872)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/456387396 var3872 9 var1063 (cast-from-var2944-to-var2687 var3562))) ; Statement: specialinvoke $r9.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(9, $r13, $r8) 

(declare-const var3872!1 var3689)
(declare-const var786 Int)
(declare-const var1063!1 String)
(declare-const var3562!1 var2944)
 ; Statement: throw $r9 
(check-sat)
; {serviceDiscovery/-518639494=([org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery], org.apache.curator.x.discovery.ServiceDiscovery), var66_serviceCacheBuilder/1525882524=([org.apache.curator.x.discovery.ServiceDiscovery], org.apache.curator.x.discovery.ServiceCacheBuilder), var1982_name/-738952975=([org.apache.curator.x.discovery.ServiceCacheBuilder, java.lang.String], org.apache.curator.x.discovery.ServiceCacheBuilder), var1982_build/912772622=([org.apache.curator.x.discovery.ServiceCacheBuilder], org.apache.curator.x.discovery.ServiceCache), var4-init=([], org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher), <init>/1379513029=([org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher, org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery, org.apache.curator.x.discovery.ServiceCache, java.lang.String, java.util.concurrent.CountDownLatch], void), var3526_addListener/2007192526=([org.apache.curator.x.discovery.ServiceCache, java.lang.Object], void), cast-from-var4-to-var803=([org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher], java.lang.Object), var3689-init=([], org.apache.dubbo.rpc.RpcException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/456387396=([org.apache.dubbo.rpc.RpcException, int, java.lang.String, java.lang.Throwable], void), cast-from-var2944-to-var2687=([java.lang.Exception], java.lang.Throwable)}
; {var2809=org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery, var2647=r0, var169=java.util.concurrent.CountDownLatch, var2300=r7, var428=r2, var1170=null_type, var66=org.apache.curator.x.discovery.ServiceDiscovery, var291=$r1, var1982=org.apache.curator.x.discovery.ServiceCacheBuilder, var2324=$r3, var2518=$r4, var3526=org.apache.curator.x.discovery.ServiceCache, var3077=r5, var4=org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher, var370=$r6, var803=java.lang.Object, var2944=java.lang.Exception, var3562=$r8, var3689=org.apache.dubbo.rpc.RpcException, var3872=$r9, var1301=$r10, var700=$r11, var1872=$r12, var1063=$r13, var2687=java.lang.Throwable, var786=9}
; {org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery=var2809, r0=var2647, java.util.concurrent.CountDownLatch=var169, r7=var2300, r2=var428, null_type=var1170, org.apache.curator.x.discovery.ServiceDiscovery=var66, $r1=var291, org.apache.curator.x.discovery.ServiceCacheBuilder=var1982, $r3=var2324, $r4=var2518, org.apache.curator.x.discovery.ServiceCache=var3526, r5=var3077, org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher=var4, $r6=var370, java.lang.Object=var803, java.lang.Exception=var2944, $r8=var3562, org.apache.dubbo.rpc.RpcException=var3689, $r9=var3872, $r10=var1301, $r11=var700, $r12=var1872, $r13=var1063, java.lang.Throwable=var2687, 9=var786}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery;	r7 := @parameter0: java.util.concurrent.CountDownLatch;	r2 := @parameter1: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery: org.apache.curator.x.discovery.ServiceDiscovery serviceDiscovery>;	$r3 = interfaceinvoke $r1.<org.apache.curator.x.discovery.ServiceDiscovery: org.apache.curator.x.discovery.ServiceCacheBuilder serviceCacheBuilder()>();	$r4 = interfaceinvoke $r3.<org.apache.curator.x.discovery.ServiceCacheBuilder: org.apache.curator.x.discovery.ServiceCacheBuilder name(java.lang.String)>(r2);	r5 = interfaceinvoke $r4.<org.apache.curator.x.discovery.ServiceCacheBuilder: org.apache.curator.x.discovery.ServiceCache build()>();	$r6 = new org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher;	specialinvoke $r6.<org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscoveryChangeWatcher: void <init>(org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery,org.apache.curator.x.discovery.ServiceCache,java.lang.String,java.util.concurrent.CountDownLatch)>(r0, r5, r2, r7);	interfaceinvoke r5.<org.apache.curator.x.discovery.ServiceCache: void addListener(java.lang.Object)>($r6);	$r8 := @caughtexception;	$r9 = new org.apache.dubbo.rpc.RpcException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed subscribe service: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<org.apache.dubbo.rpc.RpcException: void <init>(int,java.lang.String,java.lang.Throwable)>(9, $r13, $r8);	throw $r9
;block_num 2