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

(declare-sort var2571 0)
(declare-sort var370 0)
(declare-sort var3852 0)
(declare-sort var3056 0)
(declare-sort var878 0)
(declare-sort var1537 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun useRegistryAsMetadataCenterIfNecessary/-292613945 (var2571) void)
(declare-fun getApplicationOrElseThrow/44385039 (var2571) var370)
(declare-fun getMetadataType/-1382817533 (var370) String)
(declare-fun configManager/-235729372 (var2571) var3852)
(declare-fun getMetadataConfigs/-617885505 (var3852) var3056)
(declare-fun var878_isEmpty/73262611 (var3056) Bool)
(declare-fun var1537-init () var1537)
(declare-fun <init>/-1092629202 (var1537 String) void)
(declare-const null-var2571 var2571)
(declare-const var3050 var2571) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var3050 null-var2571)))
(assert true)
;(assert (useRegistryAsMetadataCenterIfNecessary/-292613945 var3050)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsMetadataCenterIfNecessary()>() 

(declare-const var3050!1 var2571)
(assert true)
(define-const var2753 var370 (getApplicationOrElseThrow/44385039 var3050!1)) ; Statement: r1 = specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>() 
(assert true)
(define-const var241 String (getMetadataType/-1382817533 var2753)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataType()>() 
(define-const var1922 var3852 (configManager/-235729372 var3050!1)) ; Statement: $r3 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
(define-const var3030 var3056 (getMetadataConfigs/-617885505 var1922)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getMetadataConfigs()>() 
(define-const var2393 Bool (var878_isEmpty/73262611 var3030)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (not (= (ite var2393 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1919 String "remote") ; Statement: $r17 = "remote" 
(assert true)
(define-const var225 Bool (= var1919 var241)) ; Statement: $z4 = virtualinvoke $r17.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z4 == 0 goto return 
(assert (not (= (ite var225 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var1011 var1537 var1537-init) ; Statement: $r18 = new java.lang.IllegalStateException 
(assert true)
;(assert (<init>/-1092629202 var1011 "No MetadataConfig found, Metadata Center address is required when \u0027metadata=remote\u0027 is enabled.")) ; Statement: specialinvoke $r18.<java.lang.IllegalStateException: void <init>(java.lang.String)>("No MetadataConfig found, Metadata Center address is required when \'metadata=remote\' is enabled.") 

(declare-const var1011!1 var1537)
(declare-const var2945 String)
 ; Statement: throw $r18 
(check-sat)
; {useRegistryAsMetadataCenterIfNecessary/-292613945=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], void), getApplicationOrElseThrow/44385039=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.ApplicationConfig), getMetadataType/-1382817533=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), configManager/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.context.ConfigManager), getMetadataConfigs/-617885505=([org.apache.dubbo.config.context.ConfigManager], java.util.Collection), var878_isEmpty/73262611=([java.util.Collection], boolean), var1537-init=([], java.lang.IllegalStateException), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var2571=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var3050=r0, var370=org.apache.dubbo.config.ApplicationConfig, var2753=r1, var241=r2, var3852=org.apache.dubbo.config.context.ConfigManager, var1922=$r3, var3056=java.util.Collection, var3030=r4, var878=org.apache.dubbo.common.utils.CollectionUtils, var2393=$z0, var1919=$r17, var225=$z4, var1537=java.lang.IllegalStateException, var1011=$r18, var2945="No MetadataConfig found, Metadata Center address is required when \'metadata=remote\' is enabled."}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var2571, r0=var3050, org.apache.dubbo.config.ApplicationConfig=var370, r1=var2753, r2=var241, org.apache.dubbo.config.context.ConfigManager=var3852, $r3=var1922, java.util.Collection=var3056, r4=var3030, org.apache.dubbo.common.utils.CollectionUtils=var878, $z0=var2393, $r17=var1919, $z4=var225, java.lang.IllegalStateException=var1537, $r18=var1011, "No MetadataConfig found, Metadata Center address is required when \'metadata=remote\' is enabled."=var2945}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsMetadataCenterIfNecessary()>();	r1 = specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>();	r2 = virtualinvoke r1.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataType()>();	$r3 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	r4 = virtualinvoke $r3.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getMetadataConfigs()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r4);	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r17 = "remote";	$z4 = virtualinvoke $r17.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z4 == 0 goto return;	$r18 = new java.lang.IllegalStateException;	specialinvoke $r18.<java.lang.IllegalStateException: void <init>(java.lang.String)>("No MetadataConfig found, Metadata Center address is required when \'metadata=remote\' is enabled.");	throw $r18
;block_num 3