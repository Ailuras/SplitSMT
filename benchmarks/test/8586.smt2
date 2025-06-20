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

(declare-sort var2072 0)
(declare-sort var1441 0)
(declare-sort var2916 0)
(declare-sort var964 0)
(declare-sort var790 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun useRegistryAsMetadataCenterIfNecessary/-292613945 (var2072) void)
(declare-fun getApplicationOrElseThrow/44385039 (var2072) var1441)
(declare-fun getMetadataType/-1382817533 (var1441) String)
(declare-fun configManager/-235729372 (var2072) var2916)
(declare-fun getMetadataConfigs/-617885505 (var2916) var964)
(declare-fun var790_isEmpty/73262611 (var964) Bool)
(declare-const null-var2072 var2072)
(declare-const var806 var2072) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer 
(assert (not (= var806 null-var2072)))
(assert true)
;(assert (useRegistryAsMetadataCenterIfNecessary/-292613945 var806)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsMetadataCenterIfNecessary()>() 

(declare-const var806!1 var2072)
(assert true)
(define-const var957 var1441 (getApplicationOrElseThrow/44385039 var806!1)) ; Statement: r1 = specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>() 
(assert true)
(define-const var3952 String (getMetadataType/-1382817533 var957)) ; Statement: r2 = virtualinvoke r1.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataType()>() 
(define-const var1542 var2916 (configManager/-235729372 var806!1)) ; Statement: $r3 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager> 
(assert true)
(define-const var2741 var964 (getMetadataConfigs/-617885505 var1542)) ; Statement: r4 = virtualinvoke $r3.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getMetadataConfigs()>() 
(define-const var2748 Bool (var790_isEmpty/73262611 var2741)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r4) 
 ; Statement: if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert (not (= (ite var2748 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3830 String "remote") ; Statement: $r17 = "remote" 
(assert true)
(define-const var828 Bool (= var3830 var3952)) ; Statement: $z4 = virtualinvoke $r17.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z4 == 0 goto return 
(assert (= (ite var828 1 0) 0)) ; Cond: $z4 == 0 
 ; Statement: return 
(check-sat)
; {useRegistryAsMetadataCenterIfNecessary/-292613945=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], void), getApplicationOrElseThrow/44385039=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.ApplicationConfig), getMetadataType/-1382817533=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), configManager/-235729372=([org.apache.dubbo.config.deploy.DefaultApplicationDeployer], org.apache.dubbo.config.context.ConfigManager), getMetadataConfigs/-617885505=([org.apache.dubbo.config.context.ConfigManager], java.util.Collection), var790_isEmpty/73262611=([java.util.Collection], boolean)}
; {var2072=org.apache.dubbo.config.deploy.DefaultApplicationDeployer, var806=r0, var1441=org.apache.dubbo.config.ApplicationConfig, var957=r1, var3952=r2, var2916=org.apache.dubbo.config.context.ConfigManager, var1542=$r3, var964=java.util.Collection, var2741=r4, var790=org.apache.dubbo.common.utils.CollectionUtils, var2748=$z0, var3830=$r17, var828=$z4}
; {org.apache.dubbo.config.deploy.DefaultApplicationDeployer=var2072, r0=var806, org.apache.dubbo.config.ApplicationConfig=var1441, r1=var957, r2=var3952, org.apache.dubbo.config.context.ConfigManager=var2916, $r3=var1542, java.util.Collection=var964, r4=var2741, org.apache.dubbo.common.utils.CollectionUtils=var790, $z0=var2748, $r17=var3830, $z4=var828}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultApplicationDeployer;	specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: void useRegistryAsMetadataCenterIfNecessary()>();	r1 = specialinvoke r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.ApplicationConfig getApplicationOrElseThrow()>();	r2 = virtualinvoke r1.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getMetadataType()>();	$r3 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.config.context.ConfigManager configManager>;	r4 = virtualinvoke $r3.<org.apache.dubbo.config.context.ConfigManager: java.util.Collection getMetadataConfigs()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>(r4);	if $z0 == 0 goto $r5 = r0.<org.apache.dubbo.config.deploy.DefaultApplicationDeployer: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r17 = "remote";	$z4 = virtualinvoke $r17.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z4 == 0 goto return;	return
;block_num 3