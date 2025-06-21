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

(declare-sort var1703 0)
(declare-sort var947 0)
(declare-sort var742 0)
(declare-sort var1234 0)
(declare-sort var3475 0)
(declare-sort var1965 0)
(declare-sort var2045 0)
(declare-sort var2079 0)
(declare-sort var1465 0)
(declare-sort var3739 0)
(declare-sort var3244 0)
(declare-sort var1659 0)
(declare-sort var1121 0)
(declare-sort var2620 0)
(declare-sort var1707 0)
(declare-sort var896 0)
(declare-sort var3516 0)
(declare-sort var1314 0)
(declare-sort var48 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1965!class ClassObject)
(declare-const var3739!class ClassObject)
(declare-const var1121!class ClassObject)
(declare-fun <init>/-1583366782 (var742) void)
(declare-fun cast-from-var1703-to-var742 (var1703) var742)
(declare-fun frameworkModel/1326816129 (var742) var947)
(declare-fun var1234-init () var1234)
(declare-fun <init>/-1454159546 (var1234 var947) void)
(declare-fun triBuiltinService/517154976 (var1703) var1234)
(declare-fun getDefaultExtension/-1730855204 (var2045 ClassObject) var3475)
(declare-fun cast-from-var947-to-var2045 (var947) var2045)
(declare-fun cast-from-var3475-to-var1965 (var3475) var1965)
(declare-fun pathResolver/517154976 (var1703) var1965)
(declare-fun getBeanFactory/819046718 (var1465) var2079)
(declare-fun cast-from-var947-to-var1465 (var947) var1465)
(declare-fun getOrRegisterBean/1447783332 (var2079 ClassObject) var3475)
(declare-fun cast-from-var3475-to-var3244 (var3475) var3244)
(declare-fun mappingRegistry/517154976 (var1703) var3244)
(declare-fun getSupportedExtensions/-542929121 (var2045 ClassObject) var1659)
(declare-fun String_join/1594745010 (String var2620) String)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun cast-from-var1659-to-var2620 (var1659) var2620)
(declare-fun acceptEncodings/517154976 (var1703) String)
(declare-fun var1707_defaultModel/-1553605813 () var1707)
(declare-fun var3516_getEnvConfiguration/-1335399760 (var1465) var896)
(declare-fun cast-from-var1707-to-var1465 (var1707) var1465)
(declare-fun var896_getBoolean/-715542197 (var896 String Bool) Bool)
(declare-fun defaultApplication/-72063182 (var947) var1707)
(declare-fun var3516_getGlobalConfiguration/-670113096 (var1465) var896)
(declare-fun var1314_init/-1714339362 (var896) void)
(declare-fun var48_init/-1123429576 (var896) void)
(declare-const null-var1703 var1703)
(declare-const null-var947 var947)
(declare-const var1758 var1703) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.TripleProtocol 
(assert (not (= var1758 null-var1703)))
(declare-const var171 var947) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel 
(assert (not (= var171 null-var947)))
(assert true)
;(assert (<init>/-1583366782 (cast-from-var1703-to-var742 var1758))) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.protocol.AbstractProtocol: void <init>()>() 

(declare-const var1758!1 var1703)
(declare-const var1758!2 var1703)
(assert (not (= var1758!2 null-var1703)))
(assert (= (frameworkModel/1326816129 (cast-from-var1703-to-var742 var1758!2)) var171)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> = r1 
(define-const var713 var1234 var1234-init) ; Statement: $r2 = new org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService 
(assert true)
;(assert (<init>/-1454159546 var713 var171)) ; Statement: specialinvoke $r2.<org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService: void <init>(org.apache.dubbo.rpc.model.FrameworkModel)>(r1) 

(declare-const var713!1 var1234)
(declare-const var171!1 var947)
(declare-const var1758!3 var1703)
(assert (not (= var1758!3 null-var1703)))
(assert (= (triBuiltinService/517154976 var1758!3) var713!1)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService triBuiltinService> = $r2 
(assert true)
(define-const var499 var3475 (getDefaultExtension/-1730855204 (cast-from-var947-to-var2045 var171!1) var1965!class)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: java.lang.Object getDefaultExtension(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/PathResolver;") 
(define-const var1437 var1965 (cast-from-var3475-to-var1965 var499)) ; Statement: $r4 = (org.apache.dubbo.rpc.PathResolver) $r3 
(declare-const var1758!4 var1703)
(assert (not (= var1758!4 null-var1703)))
(assert (= (pathResolver/517154976 var1758!4) var1437)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.PathResolver pathResolver> = $r4 
(assert true)
(define-const var281 var2079 (getBeanFactory/819046718 (cast-from-var947-to-var1465 var171!1))) ; Statement: $r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>() 
(assert true)
(define-const var2314 var3475 (getOrRegisterBean/1447783332 var281 var3739!class)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getOrRegisterBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/DefaultRequestMappingRegistry;") 
(define-const var2870 var3244 (cast-from-var3475-to-var3244 var2314)) ; Statement: $r7 = (org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry) $r6 
(declare-const var1758!5 var1703)
(assert (not (= var1758!5 null-var1703)))
(assert (= (mappingRegistry/517154976 var1758!5) var2870)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> = $r7 
(assert true)
(define-const var140 var1659 (getSupportedExtensions/-542929121 (cast-from-var947-to-var2045 var171!1) var1121!class)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: java.util.Set getSupportedExtensions(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/protocol/tri/compressor/DeCompressor;") 
(define-const var2290 String (String_join/1594745010 (cast-from-String-to-String ",") (cast-from-var1659-to-var2620 var140))) ; Statement: $r9 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>(",", $r8) 
(declare-const var1758!6 var1703)
(assert (not (= var1758!6 null-var1703)))
(assert (= (acceptEncodings/517154976 var1758!6) var2290)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: java.lang.String acceptEncodings> = $r9 
(define-const var3476 var1707 var1707_defaultModel/-1553605813) ; Statement: $r10 = staticinvoke <org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ApplicationModel defaultModel()>() 
(define-const var121 var896 (var3516_getEnvConfiguration/-1335399760 (cast-from-var1707-to-var1465 var3476))) ; Statement: r11 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getEnvConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r10) 
(define-const var2680 Bool (var896_getBoolean/-715542197 var121 "dubbo.rpc.tri.support-no-lower-header" (ite (= 1 1) true false))) ; Statement: $z0 = interfaceinvoke r11.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.rpc.tri.support-no-lower-header", 1) 
(define-const var3515 Bool var2680) ; Statement: <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER> = $z0 
(define-const var1070 Bool (var896_getBoolean/-715542197 var121 "dubbo.rpc.tri.ignore-1.0.0-version" (ite (= 1 0) true false))) ; Statement: $z1 = interfaceinvoke r11.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.rpc.tri.ignore-1.0.0-version", 0) 
(define-const var2413 Bool var1070) ; Statement: <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION> = $z1 
(define-const var3500 Bool (var896_getBoolean/-715542197 var121 "dubbo.rpc.tri.resolve-fallback-to-default" (ite (= 1 1) true false))) ; Statement: $z2 = interfaceinvoke r11.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.rpc.tri.resolve-fallback-to-default", 1) 
(define-const var2277 Bool var3500) ; Statement: <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean RESOLVE_FALLBACK_TO_DEFAULT> = $z2 
(assert true)
(define-const var3251 var1707 (defaultApplication/-72063182 var171!1)) ; Statement: $r12 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>() 
(define-const var3325 var896 (var3516_getGlobalConfiguration/-670113096 (cast-from-var1707-to-var1465 var3251))) ; Statement: r13 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r12) 
(define-const var1414 Bool (var896_getBoolean/-715542197 var3325 "dubbo.protocol.triple.verbose" (ite (= 1 0) true false))) ; Statement: $z3 = interfaceinvoke r13.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.protocol.triple.verbose", 0) 
(define-const var686 Bool var1414) ; Statement: <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean VERBOSE_ENABLED> = $z3 
;(assert (var1314_init/-1714339362 var3325)) ; Statement: staticinvoke <org.apache.dubbo.rpc.protocol.tri.ServletExchanger: void init(org.apache.dubbo.common.config.Configuration)>(r13) 

(declare-const var3325!1 var896)
;(assert (var48_init/-1123429576 var3325!1)) ; Statement: staticinvoke <org.apache.dubbo.rpc.protocol.tri.Http3Exchanger: void init(org.apache.dubbo.common.config.Configuration)>(r13) 

(declare-const var3325!2 var896)
 ; Statement: return 
(check-sat)
; {<init>/-1583366782=([org.apache.dubbo.rpc.protocol.AbstractProtocol], void), cast-from-var1703-to-var742=([org.apache.dubbo.rpc.protocol.tri.TripleProtocol], org.apache.dubbo.rpc.protocol.AbstractProtocol), frameworkModel/1326816129=([org.apache.dubbo.rpc.protocol.AbstractProtocol], org.apache.dubbo.rpc.model.FrameworkModel), var1234-init=([], org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService), <init>/-1454159546=([org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService, org.apache.dubbo.rpc.model.FrameworkModel], void), triBuiltinService/517154976=([org.apache.dubbo.rpc.protocol.tri.TripleProtocol], org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService), getDefaultExtension/-1730855204=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], java.lang.Object), cast-from-var947-to-var2045=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.common.extension.ExtensionAccessor), cast-from-var3475-to-var1965=([java.lang.Object], org.apache.dubbo.rpc.PathResolver), pathResolver/517154976=([org.apache.dubbo.rpc.protocol.tri.TripleProtocol], org.apache.dubbo.rpc.PathResolver), getBeanFactory/819046718=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.beans.factory.ScopeBeanFactory), cast-from-var947-to-var1465=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ScopeModel), getOrRegisterBean/1447783332=([org.apache.dubbo.common.beans.factory.ScopeBeanFactory, java.lang.Class], java.lang.Object), cast-from-var3475-to-var3244=([java.lang.Object], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), mappingRegistry/517154976=([org.apache.dubbo.rpc.protocol.tri.TripleProtocol], org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry), getSupportedExtensions/-542929121=([org.apache.dubbo.common.extension.ExtensionAccessor, java.lang.Class], java.util.Set), String_join/1594745010=([java.lang.CharSequence, java.lang.Iterable], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), cast-from-var1659-to-var2620=([java.util.Set], java.lang.Iterable), acceptEncodings/517154976=([org.apache.dubbo.rpc.protocol.tri.TripleProtocol], java.lang.String), var1707_defaultModel/-1553605813=([], org.apache.dubbo.rpc.model.ApplicationModel), var3516_getEnvConfiguration/-1335399760=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), cast-from-var1707-to-var1465=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), var896_getBoolean/-715542197=([org.apache.dubbo.common.config.Configuration, java.lang.String, boolean], boolean), defaultApplication/-72063182=([org.apache.dubbo.rpc.model.FrameworkModel], org.apache.dubbo.rpc.model.ApplicationModel), var3516_getGlobalConfiguration/-670113096=([org.apache.dubbo.rpc.model.ScopeModel], org.apache.dubbo.common.config.Configuration), var1314_init/-1714339362=([org.apache.dubbo.common.config.Configuration], void), var48_init/-1123429576=([org.apache.dubbo.common.config.Configuration], void)}
; {var1703=org.apache.dubbo.rpc.protocol.tri.TripleProtocol, var1758=r0, var947=org.apache.dubbo.rpc.model.FrameworkModel, var171=r1, var742=org.apache.dubbo.rpc.protocol.AbstractProtocol, var1234=org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService, var713=$r2, var3475=java.lang.Object, var1965=org.apache.dubbo.rpc.PathResolver, var2045=org.apache.dubbo.common.extension.ExtensionAccessor, var499=$r3, var1437=$r4, var2079=org.apache.dubbo.common.beans.factory.ScopeBeanFactory, var1465=org.apache.dubbo.rpc.model.ScopeModel, var281=$r5, var3739=org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry, var2314=$r6, var3244=org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry, var2870=$r7, var1659=java.util.Set, var1121=org.apache.dubbo.rpc.protocol.tri.compressor.DeCompressor, var140=$r8, var2620=java.lang.Iterable, var2290=$r9, var1707=org.apache.dubbo.rpc.model.ApplicationModel, var3476=$r10, var896=org.apache.dubbo.common.config.Configuration, var3516=org.apache.dubbo.common.config.ConfigurationUtils, var121=r11, var2680=$z0, var3515=<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER>, var1070=$z1, var2413=<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION>, var3500=$z2, var2277=<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean RESOLVE_FALLBACK_TO_DEFAULT>, var3251=$r12, var3325=r13, var1414=$z3, var686=<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean VERBOSE_ENABLED>, var1314=org.apache.dubbo.rpc.protocol.tri.ServletExchanger, var48=org.apache.dubbo.rpc.protocol.tri.Http3Exchanger}
; {org.apache.dubbo.rpc.protocol.tri.TripleProtocol=var1703, r0=var1758, org.apache.dubbo.rpc.model.FrameworkModel=var947, r1=var171, org.apache.dubbo.rpc.protocol.AbstractProtocol=var742, org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService=var1234, $r2=var713, java.lang.Object=var3475, org.apache.dubbo.rpc.PathResolver=var1965, org.apache.dubbo.common.extension.ExtensionAccessor=var2045, $r3=var499, $r4=var1437, org.apache.dubbo.common.beans.factory.ScopeBeanFactory=var2079, org.apache.dubbo.rpc.model.ScopeModel=var1465, $r5=var281, org.apache.dubbo.rpc.protocol.tri.rest.mapping.DefaultRequestMappingRegistry=var3739, $r6=var2314, org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry=var3244, $r7=var2870, java.util.Set=var1659, org.apache.dubbo.rpc.protocol.tri.compressor.DeCompressor=var1121, $r8=var140, java.lang.Iterable=var2620, $r9=var2290, org.apache.dubbo.rpc.model.ApplicationModel=var1707, $r10=var3476, org.apache.dubbo.common.config.Configuration=var896, org.apache.dubbo.common.config.ConfigurationUtils=var3516, r11=var121, $z0=var2680, <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER>=var3515, $z1=var1070, <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION>=var2413, $z2=var3500, <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean RESOLVE_FALLBACK_TO_DEFAULT>=var2277, $r12=var3251, r13=var3325, $z3=var1414, <org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean VERBOSE_ENABLED>=var686, org.apache.dubbo.rpc.protocol.tri.ServletExchanger=var1314, org.apache.dubbo.rpc.protocol.tri.Http3Exchanger=var48}
;seq <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>
;cnt {"<java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.TripleProtocol;	r1 := @parameter0: org.apache.dubbo.rpc.model.FrameworkModel;	specialinvoke r0.<org.apache.dubbo.rpc.protocol.AbstractProtocol: void <init>()>();	r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.model.FrameworkModel frameworkModel> = r1;	$r2 = new org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService;	specialinvoke $r2.<org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService: void <init>(org.apache.dubbo.rpc.model.FrameworkModel)>(r1);	r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.protocol.tri.service.TriBuiltinService triBuiltinService> = $r2;	$r3 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: java.lang.Object getDefaultExtension(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/PathResolver;");	$r4 = (org.apache.dubbo.rpc.PathResolver) $r3;	r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.PathResolver pathResolver> = $r4;	$r5 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.common.beans.factory.ScopeBeanFactory getBeanFactory()>();	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.beans.factory.ScopeBeanFactory: java.lang.Object getOrRegisterBean(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/protocol/tri/rest/mapping/DefaultRequestMappingRegistry;");	$r7 = (org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry) $r6;	r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: org.apache.dubbo.rpc.protocol.tri.rest.mapping.RequestMappingRegistry mappingRegistry> = $r7;	$r8 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: java.util.Set getSupportedExtensions(java.lang.Class)>(class "Lorg/apache/dubbo/rpc/protocol/tri/compressor/DeCompressor;");	$r9 = staticinvoke <java.lang.String: java.lang.String join(java.lang.CharSequence,java.lang.Iterable)>(",", $r8);	r0.<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: java.lang.String acceptEncodings> = $r9;	$r10 = staticinvoke <org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ApplicationModel defaultModel()>();	r11 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getEnvConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r10);	$z0 = interfaceinvoke r11.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.rpc.tri.support-no-lower-header", 1);	<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean CONVERT_NO_LOWER_HEADER> = $z0;	$z1 = interfaceinvoke r11.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.rpc.tri.ignore-1.0.0-version", 0);	<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean IGNORE_1_0_0_VERSION> = $z1;	$z2 = interfaceinvoke r11.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.rpc.tri.resolve-fallback-to-default", 1);	<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean RESOLVE_FALLBACK_TO_DEFAULT> = $z2;	$r12 = virtualinvoke r1.<org.apache.dubbo.rpc.model.FrameworkModel: org.apache.dubbo.rpc.model.ApplicationModel defaultApplication()>();	r13 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: org.apache.dubbo.common.config.Configuration getGlobalConfiguration(org.apache.dubbo.rpc.model.ScopeModel)>($r12);	$z3 = interfaceinvoke r13.<org.apache.dubbo.common.config.Configuration: boolean getBoolean(java.lang.String,boolean)>("dubbo.protocol.triple.verbose", 0);	<org.apache.dubbo.rpc.protocol.tri.TripleProtocol: boolean VERBOSE_ENABLED> = $z3;	staticinvoke <org.apache.dubbo.rpc.protocol.tri.ServletExchanger: void init(org.apache.dubbo.common.config.Configuration)>(r13);	staticinvoke <org.apache.dubbo.rpc.protocol.tri.Http3Exchanger: void init(org.apache.dubbo.common.config.Configuration)>(r13);	return
;block_num 1