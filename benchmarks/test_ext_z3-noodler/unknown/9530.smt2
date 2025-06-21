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

(declare-sort var1861 0)
(declare-sort var1670 0)
(declare-sort var2325 0)
(declare-sort var468 0)
(declare-sort var1900 0)
(declare-sort var3170 0)
(declare-sort var2030 0)
(declare-sort var1938 0)
(declare-sort var2017 0)
(declare-sort var864 0)
(declare-sort var3578 0)
(declare-sort var938 0)
(declare-sort var1730 0)
(declare-sort var1227 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2325_from/-1251202111 (var1670) var2325)
(declare-fun setProtocol/-108969836 (var2325 String) var2325)
(declare-fun setHost/1155810436 (var2325 String) var2325)
(declare-fun setPort/498986771 (var2325 Int) var2325)
(declare-fun build/935716095 (var2325) var468)
(declare-fun getScopeModel/439405660 (var3170) var1900)
(declare-fun cast-from-var1861-to-var3170 (var1861) var3170)
(declare-fun setScopeModel/-1563758557 (var1670 var2030) var1670)
(declare-fun cast-from-var468-to-var1670 (var468) var1670)
(declare-fun cast-from-var1900-to-var2030 (var1900) var2030)
(declare-fun providerModel/14293649 (var1861) var1938)
(declare-fun setServiceModel/1097940449 (var1670 var2017) var1670)
(declare-fun cast-from-var1938-to-var2017 (var1938) var2017)
(declare-fun addParameter/-1629709269 (var1670 String String) var1670)
(declare-fun doExportUrl/1520567670 (var1861 var1670 Bool var864) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceClass/2052580610 (var938) ClassObject)
(declare-fun cast-from-var1861-to-var938 (var1861) var938)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun append/-1031950772 (String var1730) String)
(declare-fun cast-from-var1670-to-var1730 (var1670) var1730)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1227_info/484404803 (var1227 String) void)
(declare-fun cast-from-var3578-to-var1227 (var3578) var1227)
(declare-const null-var1861 var1861)
(declare-const null-var1670 var1670)
(declare-const var864-AUTO_REGISTER var864)
(declare-const var1861-logger var3578)
(declare-const var3107 var1861) ; Statement: r5 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var3107 null-var1861)))
(declare-const var3024 var1670) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3024 null-var1670)))
(define-const var3966 var2325 (var2325_from/-1251202111 var3024)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder 'from'(org.apache.dubbo.common.URL)>(r0) 
(assert true)
(define-const var3098 var2325 (setProtocol/-108969836 var3966 "injvm")) ; Statement: $r2 = virtualinvoke $r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder setProtocol(java.lang.String)>("injvm") 
(assert true)
(define-const var1403 var2325 (setHost/1155810436 var3098 "127.0.0.1")) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder setHost(java.lang.String)>("127.0.0.1") 
(assert true)
(define-const var31 var2325 (setPort/498986771 var1403 0)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder setPort(int)>(0) 
(assert true)
(define-const var296 var468 (build/935716095 var31)) ; Statement: r19 = virtualinvoke $r4.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.url.component.ServiceConfigURL build()>() 
(assert true)
(define-const var3918 var1900 (getScopeModel/439405660 (cast-from-var1861-to-var3170 var3107))) ; Statement: $r6 = virtualinvoke r5.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>() 
(assert true)
(define-const var2905 var1670 (setScopeModel/-1563758557 (cast-from-var468-to-var1670 var296) (cast-from-var1900-to-var2030 var3918))) ; Statement: $r8 = virtualinvoke r19.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r6) 
(define-const var3500 var1938 (providerModel/14293649 var3107)) ; Statement: $r7 = r5.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ProviderModel providerModel> 
(assert true)
(define-const var3987 var1670 (setServiceModel/1097940449 var2905 (cast-from-var1938-to-var2017 var3500))) ; Statement: r20 = virtualinvoke $r8.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r7) 
(assert true)
(define-const var372 var1670 (addParameter/-1629709269 var3987 "exporter.listener" "injvm")) ; Statement: r21 = virtualinvoke r20.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("exporter.listener", "injvm") 
(define-const var167 var864 var864-AUTO_REGISTER) ; Statement: $r9 = <org.apache.dubbo.common.constants.RegisterTypeEnum: org.apache.dubbo.common.constants.RegisterTypeEnum AUTO_REGISTER> 
(assert true)
;(assert (doExportUrl/1520567670 var3107 var372 (ite (= 1 0) true false) var167)) ; Statement: specialinvoke r5.<org.apache.dubbo.config.ServiceConfig: void doExportUrl(org.apache.dubbo.common.URL,boolean,org.apache.dubbo.common.constants.RegisterTypeEnum)>(r21, 0, $r9) 

(declare-const var3107!1 var1861)
(declare-const var372!1 var1670)
(declare-const var2540 Int)
(declare-const var167!1 var864)
(define-const var1033 var3578 var1861-logger) ; Statement: $r11 = <org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3287 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3287)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3287!1 String)
(assert (= var3287!1 ""))
(assert true)
(define-const var2217 String (append/672562846 var3287!1 "Export dubbo service ")) ; Statement: $r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Export dubbo service ") 
(declare-const var3287!2 String)
(assert (= var3287!2 (str.++ var3287!1 "Export dubbo service ")))
(define-const var2478 ClassObject (interfaceClass/2052580610 (cast-from-var1861-to-var938 var3107!1))) ; Statement: $r12 = r5.<org.apache.dubbo.config.ServiceConfig: java.lang.Class interfaceClass> 
(assert true)
(define-const var149 String (getName/-1958580599 var2478)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2519 String (append/672562846 var2217 var149)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var2217!1 String)
(assert (= var2217!1 (str.++ var2217 var149)))
(assert true)
(define-const var1980 String (append/672562846 var2519 " to local registry url : ")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to local registry url : ") 
(declare-const var2519!1 String)
(assert (= var2519!1 (str.++ var2519 " to local registry url : ")))
(assert true)
(define-const var709 String (append/-1031950772 var1980 (cast-from-var1670-to-var1730 var372!1))) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r21) 
(declare-const var1980!1 String)
(assert (str.prefixof var1980 var1980!1))
(assert true)
(define-const var3704 String (toString/-2075883882 var709)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1227_info/484404803 (cast-from-var3578-to-var1227 var1033) var3704)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r18) 

(declare-const var1033!1 var3578)
(declare-const var3704!1 String)
 ; Statement: return 
(check-sat)
; {var2325_from/-1251202111=([org.apache.dubbo.common.URL], org.apache.dubbo.common.URLBuilder), setProtocol/-108969836=([org.apache.dubbo.common.URLBuilder, java.lang.String], org.apache.dubbo.common.URLBuilder), setHost/1155810436=([org.apache.dubbo.common.URLBuilder, java.lang.String], org.apache.dubbo.common.URLBuilder), setPort/498986771=([org.apache.dubbo.common.URLBuilder, int], org.apache.dubbo.common.URLBuilder), build/935716095=([org.apache.dubbo.common.URLBuilder], org.apache.dubbo.common.url.component.ServiceConfigURL), getScopeModel/439405660=([org.apache.dubbo.config.AbstractMethodConfig], org.apache.dubbo.rpc.model.ModuleModel), cast-from-var1861-to-var3170=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractMethodConfig), setScopeModel/-1563758557=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.URL), cast-from-var468-to-var1670=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), cast-from-var1900-to-var2030=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), providerModel/14293649=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.rpc.model.ProviderModel), setServiceModel/1097940449=([org.apache.dubbo.common.URL, org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.common.URL), cast-from-var1938-to-var2017=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL), doExportUrl/1520567670=([org.apache.dubbo.config.ServiceConfig, org.apache.dubbo.common.URL, boolean, org.apache.dubbo.common.constants.RegisterTypeEnum], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceClass/2052580610=([org.apache.dubbo.config.ServiceConfigBase], java.lang.Class), cast-from-var1861-to-var938=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), getName/-1958580599=([java.lang.Class], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1670-to-var1730=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1227_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3578-to-var1227=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var1861=org.apache.dubbo.config.ServiceConfig, var3107=r5, var1670=org.apache.dubbo.common.URL, var3024=r0, var2325=org.apache.dubbo.common.URLBuilder, var3966=$r1, var3098=$r2, var1403=$r3, var31=$r4, var468=org.apache.dubbo.common.url.component.ServiceConfigURL, var296=r19, var1900=org.apache.dubbo.rpc.model.ModuleModel, var3170=org.apache.dubbo.config.AbstractMethodConfig, var3918=$r6, var2030=org.apache.dubbo.rpc.model.ScopeModel, var2905=$r8, var1938=org.apache.dubbo.rpc.model.ProviderModel, var3500=$r7, var2017=org.apache.dubbo.rpc.model.ServiceModel, var3987=r20, var372=r21, var864=org.apache.dubbo.common.constants.RegisterTypeEnum, var167=$r9, var2540=0, var3578=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1033=$r11, var3287=$r10, var2217=$r14, var938=org.apache.dubbo.config.ServiceConfigBase, var2478=$r12, var149=$r13, var2519=$r15, var1980=$r16, var1730=java.lang.Object, var709=$r17, var3704=$r18, var1227=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.config.ServiceConfig=var1861, r5=var3107, org.apache.dubbo.common.URL=var1670, r0=var3024, org.apache.dubbo.common.URLBuilder=var2325, $r1=var3966, $r2=var3098, $r3=var1403, $r4=var31, org.apache.dubbo.common.url.component.ServiceConfigURL=var468, r19=var296, org.apache.dubbo.rpc.model.ModuleModel=var1900, org.apache.dubbo.config.AbstractMethodConfig=var3170, $r6=var3918, org.apache.dubbo.rpc.model.ScopeModel=var2030, $r8=var2905, org.apache.dubbo.rpc.model.ProviderModel=var1938, $r7=var3500, org.apache.dubbo.rpc.model.ServiceModel=var2017, r20=var3987, r21=var372, org.apache.dubbo.common.constants.RegisterTypeEnum=var864, $r9=var167, 0=var2540, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3578, $r11=var1033, $r10=var3287, $r14=var2217, org.apache.dubbo.config.ServiceConfigBase=var938, $r12=var2478, $r13=var149, $r15=var2519, $r16=var1980, java.lang.Object=var1730, $r17=var709, $r18=var3704, org.apache.dubbo.common.logger.Logger=var1227}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r5 := @this: org.apache.dubbo.config.ServiceConfig;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r1 = staticinvoke <org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder 'from'(org.apache.dubbo.common.URL)>(r0);	$r2 = virtualinvoke $r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder setProtocol(java.lang.String)>("injvm");	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder setHost(java.lang.String)>("127.0.0.1");	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder setPort(int)>(0);	r19 = virtualinvoke $r4.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.url.component.ServiceConfigURL build()>();	$r6 = virtualinvoke r5.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ModuleModel getScopeModel()>();	$r8 = virtualinvoke r19.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r6);	$r7 = r5.<org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.rpc.model.ProviderModel providerModel>;	r20 = virtualinvoke $r8.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setServiceModel(org.apache.dubbo.rpc.model.ServiceModel)>($r7);	r21 = virtualinvoke r20.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>("exporter.listener", "injvm");	$r9 = <org.apache.dubbo.common.constants.RegisterTypeEnum: org.apache.dubbo.common.constants.RegisterTypeEnum AUTO_REGISTER>;	specialinvoke r5.<org.apache.dubbo.config.ServiceConfig: void doExportUrl(org.apache.dubbo.common.URL,boolean,org.apache.dubbo.common.constants.RegisterTypeEnum)>(r21, 0, $r9);	$r11 = <org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r14 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Export dubbo service ");	$r12 = r5.<org.apache.dubbo.config.ServiceConfig: java.lang.Class interfaceClass>;	$r13 = virtualinvoke $r12.<java.lang.Class: java.lang.String getName()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" to local registry url : ");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r21);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r18);	return
;block_num 1