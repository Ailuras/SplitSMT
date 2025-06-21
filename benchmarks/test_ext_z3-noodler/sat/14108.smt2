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

(declare-sort var835 0)
(declare-sort var3024 0)
(declare-sort var957 0)
(declare-sort var1721 0)
(declare-sort var3854 0)
(declare-sort var1910 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/480148646 (var835) var3024)
(declare-fun <init>/1991509242 (var3854 var957) void)
(declare-fun cast-from-var835-to-var3854 (var835) var3854)
(declare-fun directory/480148646 (var835) var3024)
(declare-fun url/480148646 (var835) var1721)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1910_getRuleKey/876266182 (var1721) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun initWith/710174258 (var3854 String) void)
(declare-const null-var835 var835)
(declare-const null-var3024 var3024)
(declare-const null-var957 var957)
(declare-const null-var1721 var1721)
(declare-const var1030 var835) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener 
(assert (not (= var1030 null-var835)))
(declare-const var2149 var3024) ; Statement: r1 := @parameter0: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var2149 null-var3024)))
(declare-const var3523 var957) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var3523 null-var957)))
(declare-const var116 var3024) ; Statement: r3 := @parameter2: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var116 null-var3024)))
(declare-const var117 var1721) ; Statement: r4 := @parameter3: org.apache.dubbo.common.URL 
(assert (not (= var117 null-var1721)))
(declare-const var1030!1 var835)
(assert (not (= var1030!1 null-var835)))
(assert (= (this$0/480148646 var1030!1) var2149)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory this$0> = r1 
(assert true)
;(assert (<init>/1991509242 (cast-from-var835-to-var3854 var1030!1) var3523)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: void <init>(org.apache.dubbo.rpc.model.ModuleModel)>(r2) 

(declare-const var1030!2 var835)
(declare-const var3523!1 var957)
(declare-const var1030!3 var835)
(assert (not (= var1030!3 null-var835)))
(assert (= (directory/480148646 var1030!3) var116)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory directory> = r3 
(declare-const var1030!4 var835)
(assert (not (= var1030!4 null-var835)))
(assert (= (url/480148646 var1030!4) var117)) ; Statement: r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url> = r4 
(define-const var3154 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3154)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3154!1 String)
(assert (= var3154!1 ""))
(define-const var2650 String (var1910_getRuleKey/876266182 var117)) ; Statement: $r6 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>(r4) 
(assert true)
(define-const var2103 String (append/672562846 var3154!1 var2650)) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var3154!2 String)
(assert (= var3154!2 (str.++ var3154!1 var2650)))
(assert true)
(define-const var1333 String (append/672562846 var2103 ".configurators")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators") 
(declare-const var2103!1 String)
(assert (= var2103!1 (str.++ var2103 ".configurators")))
(assert true)
(define-const var3122 String (toString/-2075883882 var1333)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (initWith/710174258 (cast-from-var835-to-var3854 var1030!4) var3122)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: void initWith(java.lang.String)>($r9) 

(declare-const var1030!5 var835)
(declare-const var3122!1 String)
 ; Statement: return 
(check-sat)
; {this$0/480148646=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory), <init>/1991509242=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, org.apache.dubbo.rpc.model.ModuleModel], void), cast-from-var835-to-var3854=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.integration.AbstractConfiguratorListener), directory/480148646=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory), url/480148646=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.common.URL), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1910_getRuleKey/876266182=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), initWith/710174258=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, java.lang.String], void)}
; {var835=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener, var1030=r0, var3024=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var2149=r1, var957=org.apache.dubbo.rpc.model.ModuleModel, var3523=r2, var116=r3, var1721=org.apache.dubbo.common.URL, var117=r4, var3854=org.apache.dubbo.registry.integration.AbstractConfiguratorListener, var3154=$r5, var1910=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var2650=$r6, var2103=$r7, var1333=$r8, var3122=$r9}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener=var835, r0=var1030, org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var3024, r1=var2149, org.apache.dubbo.rpc.model.ModuleModel=var957, r2=var3523, r3=var116, org.apache.dubbo.common.URL=var1721, r4=var117, org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var3854, $r5=var3154, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var1910, $r6=var2650, $r7=var2103, $r8=var1333, $r9=var3122}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener;	r1 := @parameter0: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r2 := @parameter1: org.apache.dubbo.rpc.model.ModuleModel;	r3 := @parameter2: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	r4 := @parameter3: org.apache.dubbo.common.URL;	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory this$0> = r1;	specialinvoke r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: void <init>(org.apache.dubbo.rpc.model.ModuleModel)>(r2);	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory directory> = r3;	r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url> = r4;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>(r4);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: void initWith(java.lang.String)>($r9);	return
;block_num 1