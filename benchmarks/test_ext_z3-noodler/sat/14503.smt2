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

(declare-sort var1840 0)
(declare-sort var2174 0)
(declare-sort var341 0)
(declare-sort var1439 0)
(declare-sort var324 0)
(declare-sort var612 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1991509242 (var324 var2174) void)
(declare-fun cast-from-var1840-to-var324 (var1840) var324)
(declare-fun directory/-972593768 (var1840) var341)
(declare-fun url/-972593768 (var1840) var1439)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var612_getRuleKey/876266182 (var1439) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun initWith/710174258 (var324 String) void)
(declare-const null-var1840 var1840)
(declare-const null-var2174 var2174)
(declare-const null-var341 var341)
(declare-const null-var1439 var1439)
(declare-const var2341 var1840) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener 
(assert (not (= var2341 null-var1840)))
(declare-const var3256 var2174) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var3256 null-var2174)))
(declare-const var1144 var341) ; Statement: r2 := @parameter1: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var1144 null-var341)))
(declare-const var3245 var1439) ; Statement: r3 := @parameter2: org.apache.dubbo.common.URL 
(assert (not (= var3245 null-var1439)))
(assert true)
;(assert (<init>/1991509242 (cast-from-var1840-to-var324 var2341) var3256)) ; Statement: specialinvoke r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: void <init>(org.apache.dubbo.rpc.model.ModuleModel)>(r1) 

(declare-const var2341!1 var1840)
(declare-const var3256!1 var2174)
(declare-const var2341!2 var1840)
(assert (not (= var2341!2 null-var1840)))
(assert (= (directory/-972593768 var2341!2) var1144)) ; Statement: r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.registry.integration.RegistryDirectory directory> = r2 
(declare-const var2341!3 var1840)
(assert (not (= var2341!3 null-var1840)))
(assert (= (url/-972593768 var2341!3) var3245)) ; Statement: r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url> = r3 
(define-const var653 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var653)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var653!1 String)
(assert (= var653!1 ""))
(define-const var3142 String (var612_getRuleKey/876266182 var3245)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>(r3) 
(assert true)
(define-const var3953 String (append/672562846 var653!1 var3142)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var653!2 String)
(assert (= var653!2 (str.++ var653!1 var3142)))
(assert true)
(define-const var3773 String (append/672562846 var3953 ".configurators")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators") 
(declare-const var3953!1 String)
(assert (= var3953!1 (str.++ var3953 ".configurators")))
(assert true)
(define-const var1453 String (toString/-2075883882 var3773)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (initWith/710174258 (cast-from-var1840-to-var324 var2341!3) var1453)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: void initWith(java.lang.String)>($r8) 

(declare-const var2341!4 var1840)
(declare-const var1453!1 String)
 ; Statement: return 
(check-sat)
; {<init>/1991509242=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, org.apache.dubbo.rpc.model.ModuleModel], void), cast-from-var1840-to-var324=([org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.integration.AbstractConfiguratorListener), directory/-972593768=([org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.integration.RegistryDirectory), url/-972593768=([org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.common.URL), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var612_getRuleKey/876266182=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), initWith/710174258=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, java.lang.String], void)}
; {var1840=org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener, var2341=r0, var2174=org.apache.dubbo.rpc.model.ModuleModel, var3256=r1, var341=org.apache.dubbo.registry.integration.RegistryDirectory, var1144=r2, var1439=org.apache.dubbo.common.URL, var3245=r3, var324=org.apache.dubbo.registry.integration.AbstractConfiguratorListener, var653=$r4, var612=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var3142=$r5, var3953=$r6, var3773=$r7, var1453=$r8}
; {org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener=var1840, r0=var2341, org.apache.dubbo.rpc.model.ModuleModel=var2174, r1=var3256, org.apache.dubbo.registry.integration.RegistryDirectory=var341, r2=var1144, org.apache.dubbo.common.URL=var1439, r3=var3245, org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var324, $r4=var653, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var612, $r5=var3142, $r6=var3953, $r7=var3773, $r8=var1453}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener;	r1 := @parameter0: org.apache.dubbo.rpc.model.ModuleModel;	r2 := @parameter1: org.apache.dubbo.registry.integration.RegistryDirectory;	r3 := @parameter2: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.registry.integration.AbstractConfiguratorListener: void <init>(org.apache.dubbo.rpc.model.ModuleModel)>(r1);	r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.registry.integration.RegistryDirectory directory> = r2;	r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url> = r3;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r5 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>(r3);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: void initWith(java.lang.String)>($r8);	return
;block_num 1