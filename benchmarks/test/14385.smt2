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

(declare-sort var3750 0)
(declare-sort var2110 0)
(declare-sort var1707 0)
(declare-sort var3970 0)
(declare-sort var687 0)
(declare-sort var1035 0)
(declare-sort var3968 0)
(declare-sort var1398 0)
(declare-sort var246 0)
(declare-sort var422 0)
(declare-sort var2306 0)
(declare-sort var1024 0)
(declare-sort var677 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun serviceMigrationData/-1907065467 (var3750) var3970)
(declare-fun var1035_getUrl/-275947851 (var1035) var687)
(declare-fun cast-from-var2110-to-var1035 (var2110) var1035)
(declare-fun getDisplayServiceKey/-87119352 (var687) String)
(declare-fun var1398_bootstrap$/-2083602026 () var3968)
(declare-fun var422_computeIfAbsent/-1297680746 (var3970 var246 var3968) var246)
(declare-fun cast-from-String-to-var246 (String) var246)
(declare-fun cast-from-var246-to-var2306 (var246) var2306)
(declare-fun var2110_hasProxyInvokers/380614091 (var2110) Bool)
(declare-fun getAddressSize/-1038487801 (var3750 var2110) Int)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var2306_put/1464166817 (var2306 var246 var246) var246)
(declare-fun cast-from-Int-to-var246 (Int) var246)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvokerType/-1209838750 (var3750 var2110) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var677_info/484404803 (var677 String) void)
(declare-fun cast-from-var1024-to-var677 (var1024) var677)
(declare-const null-var3750 var3750)
(declare-const null-var2110 var2110)
(declare-const null-var1707 var1707)
(declare-const var3750-logger var1024)
(declare-const var2408 var3750) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator 
(assert (not (= var2408 null-var3750)))
(declare-const var622 var2110) ; Statement: r8 := @parameter0: org.apache.dubbo.rpc.cluster.ClusterInvoker 
(assert (not (= var622 null-var2110)))
(declare-const var679 var2110) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.cluster.ClusterInvoker 
(assert (not (= var679 null-var2110)))
(declare-const var3790 var1707) ; Statement: r11 := @parameter2: org.apache.dubbo.registry.client.migration.model.MigrationRule 
(assert (not (= var3790 null-var1707)))
(define-const var999 var3970 (serviceMigrationData/-1907065467 var2408)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: java.util.concurrent.ConcurrentMap serviceMigrationData> 
(define-const var247 var687 (var1035_getUrl/-275947851 (cast-from-var2110-to-var1035 var679))) ; Statement: $r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var2760 String (getDisplayServiceKey/-87119352 var247)) ; Statement: $r5 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getDisplayServiceKey()>() 
(define-const var3396 var3968 var1398_bootstrap$/-2083602026) ; Statement: $r4 = staticinvoke <org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator$lambda_shouldMigrate_0__1039: java.util.function.Function bootstrap$()>() 
(define-const var3630 var246 (var422_computeIfAbsent/-1297680746 var999 (cast-from-String-to-var246 var2760) var3396)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r2, $r5, $r4) 
(define-const var1362 var2306 (cast-from-var246-to-var2306 var3630)) ; Statement: r7 = (java.util.Map) $r6 
(define-const var644 Bool (var2110_hasProxyInvokers/380614091 var622)) ; Statement: $z0 = interfaceinvoke r8.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean hasProxyInvokers()>() 
 ; Statement: if $z0 != 0 goto $z1 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean hasProxyInvokers()>() 
(assert (not (not (= (ite var644 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(assert true)
(define-const var342 Int (getAddressSize/-1038487801 var2408 var679)) ; Statement: $i5 = specialinvoke r0.<org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: int getAddressSize(org.apache.dubbo.rpc.cluster.ClusterInvoker)>(r1) 
(define-const var370 Int (Int_valueOf/-1371140006 var342)) ; Statement: $r37 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i5) 
;(assert (var2306_put/1464166817 var1362 (cast-from-String-to-var246 "OLD_ADDRESS_SIZE") (cast-from-Int-to-var246 var370))) ; Statement: interfaceinvoke r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("OLD_ADDRESS_SIZE", $r37) 

(declare-const var1362!1 var2306)
(declare-const var2023 String)
(declare-const var370!1 Int)
(define-const var2659 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
(define-const var2860 Int (Int_valueOf/-1371140006 var2659)) ; Statement: $r38 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i7) 
;(assert (var2306_put/1464166817 var1362!1 (cast-from-String-to-var246 "NEW_ADDRESS_SIZE") (cast-from-Int-to-var246 var2860))) ; Statement: interfaceinvoke r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("NEW_ADDRESS_SIZE", $r38) 

(declare-const var1362!2 var2306)
(declare-const var1466 String)
(declare-const var2860!1 Int)
(define-const var2919 var1024 var3750-logger) ; Statement: $r40 = <org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3154 String String-init) ; Statement: $r56 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3154)) ; Statement: specialinvoke $r56.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3154!1 String)
(assert (= var3154!1 ""))
(assert true)
(define-const var2236 String (append/672562846 var3154!1 "No ")) ; Statement: $r42 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No ") 
(declare-const var3154!2 String)
(assert (= var3154!2 (str.++ var3154!1 "No ")))
(assert true)
(define-const var1514 String (getInvokerType/-1209838750 var2408 var622)) ; Statement: $r41 = specialinvoke r0.<org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: java.lang.String getInvokerType(org.apache.dubbo.rpc.cluster.ClusterInvoker)>(r8) 
(assert true)
(define-const var3976 String (append/672562846 var2236 var1514)) ; Statement: $r43 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41) 
(declare-const var2236!1 String)
(assert (= var2236!1 (str.++ var2236 var1514)))
(assert true)
(define-const var1176 String (append/672562846 var3976 " address available, stop compare.")) ; Statement: $r44 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" address available, stop compare.") 
(declare-const var3976!1 String)
(assert (= var3976!1 (str.++ var3976 " address available, stop compare.")))
(assert true)
(define-const var1027 String (toString/-2075883882 var1176)) ; Statement: $r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var677_info/484404803 (cast-from-var1024-to-var677 var2919) var1027)) ; Statement: interfaceinvoke $r40.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r45) 

(declare-const var2919!1 var1024)
(declare-const var1027!1 String)
 ; Statement: return 0 
(check-sat)
; {serviceMigrationData/-1907065467=([org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator], java.util.concurrent.ConcurrentMap), var1035_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2110-to-var1035=([org.apache.dubbo.rpc.cluster.ClusterInvoker], org.apache.dubbo.common.Node), getDisplayServiceKey/-87119352=([org.apache.dubbo.common.URL], java.lang.String), var1398_bootstrap$/-2083602026=([], java.util.function.Function), var422_computeIfAbsent/-1297680746=([java.util.concurrent.ConcurrentMap, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var246=([java.lang.String], java.lang.Object), cast-from-var246-to-var2306=([java.lang.Object], java.util.Map), var2110_hasProxyInvokers/380614091=([org.apache.dubbo.rpc.cluster.ClusterInvoker], boolean), getAddressSize/-1038487801=([org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator, org.apache.dubbo.rpc.cluster.ClusterInvoker], int), Int_valueOf/-1371140006=([int], java.lang.Integer), var2306_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-Int-to-var246=([java.lang.Integer], java.lang.Object), cast-from-Int-to-Int=([int], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvokerType/-1209838750=([org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator, org.apache.dubbo.rpc.cluster.ClusterInvoker], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var677_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1024-to-var677=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var3750=org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator, var2408=r0, var2110=org.apache.dubbo.rpc.cluster.ClusterInvoker, var622=r8, var679=r1, var1707=org.apache.dubbo.registry.client.migration.model.MigrationRule, var3790=r11, var3970=java.util.concurrent.ConcurrentMap, var999=$r2, var687=org.apache.dubbo.common.URL, var1035=org.apache.dubbo.common.Node, var247=$r3, var2760=$r5, var3968=java.util.function.Function, var1398=org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator$lambda_shouldMigrate_0__1039, var3396=$r4, var246=java.lang.Object, var422=org.apache.dubbo.common.utils.ConcurrentHashMapUtils, var3630=$r6, var2306=java.util.Map, var1362=r7, var644=$z0, var342=$i5, var370=$r37, var2023="OLD_ADDRESS_SIZE", var2659=$i7, var2860=$r38, var1466="NEW_ADDRESS_SIZE", var1024=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2919=$r40, var3154=$r56, var2236=$r42, var1514=$r41, var3976=$r43, var1176=$r44, var1027=$r45, var677=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator=var3750, r0=var2408, org.apache.dubbo.rpc.cluster.ClusterInvoker=var2110, r8=var622, r1=var679, org.apache.dubbo.registry.client.migration.model.MigrationRule=var1707, r11=var3790, java.util.concurrent.ConcurrentMap=var3970, $r2=var999, org.apache.dubbo.common.URL=var687, org.apache.dubbo.common.Node=var1035, $r3=var247, $r5=var2760, java.util.function.Function=var3968, org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator$lambda_shouldMigrate_0__1039=var1398, $r4=var3396, java.lang.Object=var246, org.apache.dubbo.common.utils.ConcurrentHashMapUtils=var422, $r6=var3630, java.util.Map=var2306, r7=var1362, $z0=var644, $i5=var342, $r37=var370, "OLD_ADDRESS_SIZE"=var2023, $i7=var2659, $r38=var2860, "NEW_ADDRESS_SIZE"=var1466, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1024, $r40=var2919, $r56=var3154, $r42=var2236, $r41=var1514, $r43=var3976, $r44=var1176, $r45=var1027, org.apache.dubbo.common.logger.Logger=var677}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator;	r8 := @parameter0: org.apache.dubbo.rpc.cluster.ClusterInvoker;	r1 := @parameter1: org.apache.dubbo.rpc.cluster.ClusterInvoker;	r11 := @parameter2: org.apache.dubbo.registry.client.migration.model.MigrationRule;	$r2 = r0.<org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: java.util.concurrent.ConcurrentMap serviceMigrationData>;	$r3 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke $r3.<org.apache.dubbo.common.URL: java.lang.String getDisplayServiceKey()>();	$r4 = staticinvoke <org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator$lambda_shouldMigrate_0__1039: java.util.function.Function bootstrap$()>();	$r6 = staticinvoke <org.apache.dubbo.common.utils.ConcurrentHashMapUtils: java.lang.Object computeIfAbsent(java.util.concurrent.ConcurrentMap,java.lang.Object,java.util.function.Function)>($r2, $r5, $r4);	r7 = (java.util.Map) $r6;	$z0 = interfaceinvoke r8.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean hasProxyInvokers()>();	if $z0 != 0 goto $z1 = interfaceinvoke r1.<org.apache.dubbo.rpc.cluster.ClusterInvoker: boolean hasProxyInvokers()>();	$i5 = specialinvoke r0.<org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: int getAddressSize(org.apache.dubbo.rpc.cluster.ClusterInvoker)>(r1);	$r37 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i5);	interfaceinvoke r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("OLD_ADDRESS_SIZE", $r37);	$i7 = (int) -1;	$r38 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i7);	interfaceinvoke r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("NEW_ADDRESS_SIZE", $r38);	$r40 = <org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r56 = new java.lang.StringBuilder;	specialinvoke $r56.<java.lang.StringBuilder: void <init>()>();	$r42 = virtualinvoke $r56.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("No ");	$r41 = specialinvoke r0.<org.apache.dubbo.registry.client.migration.DefaultMigrationAddressComparator: java.lang.String getInvokerType(org.apache.dubbo.rpc.cluster.ClusterInvoker)>(r8);	$r43 = virtualinvoke $r42.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r41);	$r44 = virtualinvoke $r43.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" address available, stop compare.");	$r45 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r40.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r45);	return 0
;block_num 2