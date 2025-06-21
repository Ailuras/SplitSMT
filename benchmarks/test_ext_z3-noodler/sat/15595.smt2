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

(declare-sort var3886 0)
(declare-sort var3340 0)
(declare-sort var1003 0)
(declare-sort var1442 0)
(declare-sort var137 0)
(declare-sort var2391 0)
(declare-sort var2153 0)
(declare-sort var911 0)
(declare-sort var1714 0)
(declare-sort var2822 0)
(declare-sort var1885 0)
(declare-sort var386 0)
(declare-sort var3859 0)
(declare-sort var3518 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1442_builder/1174465761 () var1003)
(declare-fun getBackupAddress/-787387966 (var3886) String)
(declare-fun connectString/1161671439 (var1003 String) var1003)
(declare-fun var2391_buildRetryPolicy/1602559859 (var3886) var137)
(declare-fun retryPolicy/999273431 (var1003 var137) var1003)
(declare-fun getUserInformation/531207443 (var3886) String)
(declare-fun var911_isNotEmpty/-1251449450 (String) Bool)
(declare-fun build/787691750 (var1003) var1714)
(declare-fun var1714_start/-683266985 (var1714) void)
(declare-fun getParameterValue/784943207 (var2822 var3886) var1885)
(declare-fun cast-from-var1885-to-Int (var1885) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun cast-from-var1885-to-var386 (var1885) var386)
(declare-fun var1714_blockUntilConnected/1517012456 (var1714 Int var386) Bool)
(declare-fun var1714_getState/-1019272270 (var1714) var3859)
(declare-fun equals/1866746191 (var3859 var1885) Bool)
(declare-fun cast-from-var3859-to-var1885 (var3859) var1885)
(declare-fun var3518-init () var3518)
(declare-fun <init>/-1092629202 (var3518 String) void)
(declare-const null-var3886 var3886)
(declare-const null-var3340 var3340)
(declare-const null-var2153 var2153)
(declare-const var2822-BLOCK_UNTIL_CONNECTED_WAIT var2822)
(declare-const var2822-BLOCK_UNTIL_CONNECTED_UNIT var2822)
(declare-const var3859-STARTED var3859)
(declare-const var3436 var3886) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3436 null-var3886)))
(declare-const var117 var3340) ; Statement: r23 := @parameter1: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery 
(assert (not (= var117 null-var3340)))
(define-const var1692 var1003 var1442_builder/1174465761) ; Statement: $r2 = staticinvoke <org.apache.curator.framework.CuratorFrameworkFactory: org.apache.curator.framework.CuratorFrameworkFactory$Builder builder()>() 
(assert true)
(define-const var3263 String (getBackupAddress/-787387966 var3436)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getBackupAddress()>() 
(assert true)
(define-const var1881 var1003 (connectString/1161671439 var1692 var3263)) ; Statement: $r4 = virtualinvoke $r2.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFrameworkFactory$Builder connectString(java.lang.String)>($r1) 
(define-const var757 var137 (var2391_buildRetryPolicy/1602559859 var3436)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkUtils: org.apache.curator.RetryPolicy buildRetryPolicy(org.apache.dubbo.common.URL)>(r0) 
(assert true)
(define-const var1188 var1003 (retryPolicy/999273431 var1881 var757)) ; Statement: r24 = virtualinvoke $r4.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFrameworkFactory$Builder retryPolicy(org.apache.curator.RetryPolicy)>($r3) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3712 var2153) ; Statement: $r21 := @caughtexception 
(assert (not (= var3712 null-var2153)))
(assert true) ; Non Conditional
(assert true)
(define-const var2336 String (getUserInformation/531207443 var3436)) ; Statement: $r22 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getUserInformation()>() 
(define-const var1310 Bool (var911_isNotEmpty/-1251449450 var2336)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r22) 
 ; Statement: if $z1 == 0 goto $r20 = virtualinvoke r24.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFramework build()>() 
(assert (= (ite var1310 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var3042 var1714 (build/787691750 var1188)) ; Statement: $r20 = virtualinvoke r24.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFramework build()>() 
;(assert (var1714_start/-683266985 var3042)) ; Statement: interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: void start()>() 

(declare-const var3042!1 var1714)
(define-const var3833 var2822 var2822-BLOCK_UNTIL_CONNECTED_WAIT) ; Statement: $r7 = <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams BLOCK_UNTIL_CONNECTED_WAIT> 
(assert true)
(define-const var1670 var1885 (getParameterValue/784943207 var3833 var3436)) ; Statement: $r8 = virtualinvoke $r7.<org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: java.lang.Object getParameterValue(org.apache.dubbo.common.URL)>(r0) 
(define-const var2456 Int (cast-from-var1885-to-Int var1670)) ; Statement: $r9 = (java.lang.Integer) $r8 
(assert true)
(define-const var1096 Int (intValue/-1815674922 var2456)) ; Statement: $i0 = virtualinvoke $r9.<java.lang.Integer: int intValue()>() 
(define-const var759 var2822 var2822-BLOCK_UNTIL_CONNECTED_UNIT) ; Statement: $r10 = <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams BLOCK_UNTIL_CONNECTED_UNIT> 
(assert true)
(define-const var3044 var1885 (getParameterValue/784943207 var759 var3436)) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: java.lang.Object getParameterValue(org.apache.dubbo.common.URL)>(r0) 
(define-const var741 var386 (cast-from-var1885-to-var386 var3044)) ; Statement: $r12 = (java.util.concurrent.TimeUnit) $r11 
;(assert (var1714_blockUntilConnected/1517012456 var3042!1 var1096 var741)) ; Statement: interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: boolean blockUntilConnected(int,java.util.concurrent.TimeUnit)>($i0, $r12) 

(declare-const var3042!2 var1714)
(declare-const var1096!1 Int)
(declare-const var741!1 var386)
(define-const var535 var3859 (var1714_getState/-1019272270 var3042!2)) ; Statement: $r14 = interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: org.apache.curator.framework.imps.CuratorFrameworkState getState()>() 
(define-const var3240 var3859 var3859-STARTED) ; Statement: $r13 = <org.apache.curator.framework.imps.CuratorFrameworkState: org.apache.curator.framework.imps.CuratorFrameworkState STARTED> 
(assert true)
(define-const var3011 Bool (equals/1866746191 var535 (cast-from-var3859-to-var1885 var3240))) ; Statement: $z2 = virtualinvoke $r14.<org.apache.curator.framework.imps.CuratorFrameworkState: boolean equals(java.lang.Object)>($r13) 
 ; Statement: if $z2 != 0 goto $r15 = interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: org.apache.curator.CuratorZookeeperClient getZookeeperClient()>() 
(assert (not (not (= (ite var3011 1 0) 0)))) ; Negate: Cond: $z2 != 0  
(define-const var2105 var3518 var3518-init) ; Statement: $r17 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var2105 "zookeeper client initialization failed")) ; Statement: specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>("zookeeper client initialization failed") 

(declare-const var2105!1 var3518)
(declare-const var646 String)
 ; Statement: throw $r17 
(check-sat)
; {var1442_builder/1174465761=([], org.apache.curator.framework.CuratorFrameworkFactory$Builder), getBackupAddress/-787387966=([org.apache.dubbo.common.URL], java.lang.String), connectString/1161671439=([org.apache.curator.framework.CuratorFrameworkFactory$Builder, java.lang.String], org.apache.curator.framework.CuratorFrameworkFactory$Builder), var2391_buildRetryPolicy/1602559859=([org.apache.dubbo.common.URL], org.apache.curator.RetryPolicy), retryPolicy/999273431=([org.apache.curator.framework.CuratorFrameworkFactory$Builder, org.apache.curator.RetryPolicy], org.apache.curator.framework.CuratorFrameworkFactory$Builder), getUserInformation/531207443=([org.apache.dubbo.common.URL], java.lang.String), var911_isNotEmpty/-1251449450=([java.lang.String], boolean), build/787691750=([org.apache.curator.framework.CuratorFrameworkFactory$Builder], org.apache.curator.framework.CuratorFramework), var1714_start/-683266985=([org.apache.curator.framework.CuratorFramework], void), getParameterValue/784943207=([org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams, org.apache.dubbo.common.URL], java.lang.Object), cast-from-var1885-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int), cast-from-var1885-to-var386=([java.lang.Object], java.util.concurrent.TimeUnit), var1714_blockUntilConnected/1517012456=([org.apache.curator.framework.CuratorFramework, int, java.util.concurrent.TimeUnit], boolean), var1714_getState/-1019272270=([org.apache.curator.framework.CuratorFramework], org.apache.curator.framework.imps.CuratorFrameworkState), equals/1866746191=([org.apache.curator.framework.imps.CuratorFrameworkState, java.lang.Object], boolean), cast-from-var3859-to-var1885=([org.apache.curator.framework.imps.CuratorFrameworkState], java.lang.Object), var3518-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3886=org.apache.dubbo.common.URL, var3436=r0, var3340=org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery, var117=r23, var1003=org.apache.curator.framework.CuratorFrameworkFactory$Builder, var1442=org.apache.curator.framework.CuratorFrameworkFactory, var1692=$r2, var3263=$r1, var1881=$r4, var137=org.apache.curator.RetryPolicy, var2391=org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkUtils, var757=$r3, var1188=r24, var2153=java.lang.Throwable, var3712=$r21, var2336=$r22, var911=org.apache.dubbo.common.utils.StringUtils, var1310=$z1, var1714=org.apache.curator.framework.CuratorFramework, var3042=$r20, var2822=org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams, var3833=$r7, var1885=java.lang.Object, var1670=$r8, var2456=$r9, var1096=$i0, var759=$r10, var3044=$r11, var386=java.util.concurrent.TimeUnit, var741=$r12, var3859=org.apache.curator.framework.imps.CuratorFrameworkState, var535=$r14, var3240=$r13, var3011=$z2, var3518=java.lang.IllegalStateException, var2105=$r17, var646="zookeeper client initialization failed"}
; {org.apache.dubbo.common.URL=var3886, r0=var3436, org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery=var3340, r23=var117, org.apache.curator.framework.CuratorFrameworkFactory$Builder=var1003, org.apache.curator.framework.CuratorFrameworkFactory=var1442, $r2=var1692, $r1=var3263, $r4=var1881, org.apache.curator.RetryPolicy=var137, org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkUtils=var2391, $r3=var757, r24=var1188, java.lang.Throwable=var2153, $r21=var3712, $r22=var2336, org.apache.dubbo.common.utils.StringUtils=var911, $z1=var1310, org.apache.curator.framework.CuratorFramework=var1714, $r20=var3042, org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams=var2822, $r7=var3833, java.lang.Object=var1885, $r8=var1670, $r9=var2456, $i0=var1096, $r10=var759, $r11=var3044, java.util.concurrent.TimeUnit=var386, $r12=var741, org.apache.curator.framework.imps.CuratorFrameworkState=var3859, $r14=var535, $r13=var3240, $z2=var3011, java.lang.IllegalStateException=var3518, $r17=var2105, "zookeeper client initialization failed"=var646}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.common.URL;	r23 := @parameter1: org.apache.dubbo.registry.zookeeper.ZookeeperServiceDiscovery;	$r2 = staticinvoke <org.apache.curator.framework.CuratorFrameworkFactory: org.apache.curator.framework.CuratorFrameworkFactory$Builder builder()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getBackupAddress()>();	$r4 = virtualinvoke $r2.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFrameworkFactory$Builder connectString(java.lang.String)>($r1);	$r3 = staticinvoke <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkUtils: org.apache.curator.RetryPolicy buildRetryPolicy(org.apache.dubbo.common.URL)>(r0);	r24 = virtualinvoke $r4.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFrameworkFactory$Builder retryPolicy(org.apache.curator.RetryPolicy)>($r3);	$r21 := @caughtexception;	$r22 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getUserInformation()>();	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r22);	if $z1 == 0 goto $r20 = virtualinvoke r24.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFramework build()>();	$r20 = virtualinvoke r24.<org.apache.curator.framework.CuratorFrameworkFactory$Builder: org.apache.curator.framework.CuratorFramework build()>();	interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: void start()>();	$r7 = <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams BLOCK_UNTIL_CONNECTED_WAIT>;	$r8 = virtualinvoke $r7.<org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: java.lang.Object getParameterValue(org.apache.dubbo.common.URL)>(r0);	$r9 = (java.lang.Integer) $r8;	$i0 = virtualinvoke $r9.<java.lang.Integer: int intValue()>();	$r10 = <org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams BLOCK_UNTIL_CONNECTED_UNIT>;	$r11 = virtualinvoke $r10.<org.apache.dubbo.registry.zookeeper.util.CuratorFrameworkParams: java.lang.Object getParameterValue(org.apache.dubbo.common.URL)>(r0);	$r12 = (java.util.concurrent.TimeUnit) $r11;	interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: boolean blockUntilConnected(int,java.util.concurrent.TimeUnit)>($i0, $r12);	$r14 = interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: org.apache.curator.framework.imps.CuratorFrameworkState getState()>();	$r13 = <org.apache.curator.framework.imps.CuratorFrameworkState: org.apache.curator.framework.imps.CuratorFrameworkState STARTED>;	$z2 = virtualinvoke $r14.<org.apache.curator.framework.imps.CuratorFrameworkState: boolean equals(java.lang.Object)>($r13);	if $z2 != 0 goto $r15 = interfaceinvoke $r20.<org.apache.curator.framework.CuratorFramework: org.apache.curator.CuratorZookeeperClient getZookeeperClient()>();	$r17 = new java.lang.IllegalStateException;	specialinvoke $r17.<java.lang.IllegalStateException: void <init>(java.lang.String)>("zookeeper client initialization failed");	throw $r17
;block_num 5