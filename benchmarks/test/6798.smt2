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

(declare-sort var722 0)
(declare-sort var3183 0)
(declare-sort var1299 0)
(declare-sort var454 0)
(declare-sort var3607 0)
(declare-sort var868 0)
(declare-sort var666 0)
(declare-sort var161 0)
(declare-sort var604 0)
(declare-sort var3111 0)
(declare-sort var35 0)
(declare-sort var3469 0)
(declare-sort var684 0)
(declare-sort var1678 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3607-init () var3607)
(declare-fun <init>/819945617 (var3607) void)
(declare-fun getVersion/189836348 (var3183) String)
(declare-fun setVersion/458920672 (var868 String) void)
(declare-fun cast-from-var3607-to-var868 (var3607) var868)
(declare-fun getGroup/1342955253 (var3183) String)
(declare-fun setGroup/-1095497895 (var868 String) void)
(declare-fun setDefaultGroup/1333710876 (var3607 String) void)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun setServiceInterfaceName/1800892157 (var868 String) void)
(declare-fun setServiceType/1618954904 (var3607 ClassObject) void)
(declare-fun var3183_buildKey/1628109746 (String String String) String)
(declare-fun setServiceKey/1448309474 (var868 String) void)
(declare-fun var666-init () var666)
(declare-fun getServiceKey/395021990 (var3607) String)
(declare-fun serviceRepository/-508343383 (var722) var161)
(declare-fun getServiceInterfaceName/-1042727181 (var868) String)
(declare-fun lookupService/-881429514 (var161 String) var1299)
(declare-fun var604-init () var604)
(declare-fun <init>/613807010 (var604 Int) void)
(declare-fun var35_getClassLoader/1955646820 (ClassObject) var3111)
(declare-fun <init>/749650884 (var666 String var454 var1299 var722 var3607 var3469 var3111) void)
(declare-fun cast-from-var604-to-var3469 (var604) var3469)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getDesc/-1571219874 (var1678) String)
(declare-fun cast-from-var722-to-var1678 (var722) var1678)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var684_info/484404803 (var684 String) void)
(declare-fun registerConsumer/-649326312 (var161 var666) void)
(declare-const null-var722 var722)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3183 var3183)
(declare-const null-var1299 var1299)
(declare-const null-var454 var454)
(declare-const var722-logger var684)
(declare-const var1044 var722) ; Statement: r14 := @this: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var1044 null-var722)))
(declare-const var783 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var783 null-ClassObject)))
(declare-const var2196 var3183) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2196 null-var3183)))
(declare-const var705 var1299) ; Statement: r13 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var705 null-var1299)))
(declare-const var1804 var454) ; Statement: r12 := @parameter3: java.lang.Object 
(assert (not (= var1804 null-var454)))
(define-const var807 var3607 var3607-init) ; Statement: $r0 = new org.apache.dubbo.rpc.model.ServiceMetadata 
(assert true)
;(assert (<init>/819945617 var807)) ; Statement: specialinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void <init>()>() 

(declare-const var807!1 var3607)
(assert true)
(define-const var2323 String (getVersion/189836348 var2196)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(assert true)
;(assert (setVersion/458920672 (cast-from-var3607-to-var868 var807!1) var2323)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setVersion(java.lang.String)>($r2) 

(declare-const var807!2 var3607)
(declare-const var2323!1 String)
(assert true)
(define-const var2727 String (getGroup/1342955253 var2196)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
;(assert (setGroup/-1095497895 (cast-from-var3607-to-var868 var807!2) var2727)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setGroup(java.lang.String)>($r3) 

(declare-const var807!3 var3607)
(declare-const var2727!1 String)
(assert true)
(define-const var1337 String (getGroup/1342955253 var2196)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
;(assert (setDefaultGroup/1333710876 var807!3 var1337)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setDefaultGroup(java.lang.String)>($r4) 

(declare-const var807!4 var3607)
(declare-const var1337!1 String)
(assert true)
(define-const var2031 String (getName/-1958580599 var783)) ; Statement: $r6 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
;(assert (setServiceInterfaceName/1800892157 (cast-from-var3607-to-var868 var807!4) var2031)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceInterfaceName(java.lang.String)>($r6) 

(declare-const var807!5 var3607)
(declare-const var2031!1 String)
(assert true)
;(assert (setServiceType/1618954904 var807!5 var783)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceType(java.lang.Class)>(r5) 

(declare-const var807!6 var3607)
(declare-const var783!1 ClassObject)
(assert true)
(define-const var3970 String (getName/-1958580599 var783!1)) ; Statement: $r9 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1126 String (getGroup/1342955253 var2196)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
(define-const var3088 String (getVersion/189836348 var2196)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var1342 String (var3183_buildKey/1628109746 var3970 var1126 var3088)) ; Statement: r10 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r9, $r8, $r7) 
(assert true)
;(assert (setServiceKey/1448309474 (cast-from-var3607-to-var868 var807!6) var1342)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceKey(java.lang.String)>(r10) 

(declare-const var807!7 var3607)
(declare-const var1342!1 String)
(define-const var2110 var666 var666-init) ; Statement: $r11 = new org.apache.dubbo.rpc.model.ConsumerModel 
(assert true)
(define-const var291 String (getServiceKey/395021990 var807!7)) ; Statement: $r17 = virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.String getServiceKey()>() 
 ; Statement: if r13 != null goto $r29 = r13 
(assert (not (not (= var705 null-var1299)))) ; Negate: Cond: r13 != null  
(define-const var1089 var161 (serviceRepository/-508343383 var1044)) ; Statement: $r27 = r14.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ModuleServiceRepository serviceRepository> 
(assert true)
(define-const var1491 String (getServiceInterfaceName/-1042727181 (cast-from-var3607-to-var868 var807!7))) ; Statement: $r28 = virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.String getServiceInterfaceName()>() 
(assert true)
(define-const var2078 var1299 (lookupService/-881429514 var1089 var1491)) ; Statement: $r29 = virtualinvoke $r27.<org.apache.dubbo.rpc.model.ModuleServiceRepository: org.apache.dubbo.rpc.model.ServiceDescriptor lookupService(java.lang.String)>($r28) 
 ; Statement: goto [?= $r15 = new java.util.HashMap] 
(assert true) ; Non Conditional
(define-const var1884 var604 var604-init) ; Statement: $r15 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var1884 0)) ; Statement: specialinvoke $r15.<java.util.HashMap: void <init>(int)>(0) 

(declare-const var1884!1 var604)
(declare-const var1281 Int)
(define-const var797 var3111 (var35_getClassLoader/1955646820 var783!1)) ; Statement: $r16 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.ClassLoader getClassLoader(java.lang.Class)>(r5) 
(assert true)
;(assert (<init>/749650884 var2110 var291 var1804 var2078 var1044 var807!7 (cast-from-var604-to-var3469 var1884!1) var797)) ; Statement: specialinvoke $r11.<org.apache.dubbo.rpc.model.ConsumerModel: void <init>(java.lang.String,java.lang.Object,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.util.Map,java.lang.ClassLoader)>($r17, r12, $r29, r14, $r0, $r15, $r16) 

(declare-const var2110!1 var666)
(declare-const var291!1 String)
(declare-const var1804!1 var454)
(declare-const var2078!1 var1299)
(declare-const var1044!1 var722)
(declare-const var807!8 var3607)
(declare-const var1884!2 var604)
(declare-const var797!1 var3111)
(define-const var1383 var684 var722-logger) ; Statement: $r19 = <org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.logger.Logger logger> 
(define-const var685 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var685)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var685!1 String)
(assert (= var685!1 ""))
(assert true)
(define-const var1759 String (append/672562846 var685!1 "Dynamically registering consumer model ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Dynamically registering consumer model ") 
(declare-const var685!2 String)
(assert (= var685!2 (str.++ var685!1 "Dynamically registering consumer model ")))
(assert true)
(define-const var3923 String (append/672562846 var1759 var1342!1)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10) 
(declare-const var1759!1 String)
(assert (= var1759!1 (str.++ var1759 var1342!1)))
(assert true)
(define-const var3651 String (append/672562846 var3923 " into model ")) ; Statement: $r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" into model ") 
(declare-const var3923!1 String)
(assert (= var3923!1 (str.++ var3923 " into model ")))
(assert true)
(define-const var2050 String (getDesc/-1571219874 (cast-from-var722-to-var1678 var1044!1))) ; Statement: $r22 = virtualinvoke r14.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>() 
(assert true)
(define-const var3108 String (append/672562846 var3651 var2050)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var3651!1 String)
(assert (= var3651!1 (str.++ var3651 var2050)))
(assert true)
(define-const var3087 String (toString/-2075883882 var3108)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var684_info/484404803 var1383 var3087)) ; Statement: interfaceinvoke $r19.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r25) 

(declare-const var1383!1 var684)
(declare-const var3087!1 String)
(define-const var3231 var161 (serviceRepository/-508343383 var1044!1)) ; Statement: $r26 = r14.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ModuleServiceRepository serviceRepository> 
(assert true)
;(assert (registerConsumer/-649326312 var3231 var2110!1)) ; Statement: virtualinvoke $r26.<org.apache.dubbo.rpc.model.ModuleServiceRepository: void registerConsumer(org.apache.dubbo.rpc.model.ConsumerModel)>($r11) 

(declare-const var3231!1 var161)
(declare-const var2110!2 var666)
 ; Statement: return $r11 
(check-sat)
; {var3607-init=([], org.apache.dubbo.rpc.model.ServiceMetadata), <init>/819945617=([org.apache.dubbo.rpc.model.ServiceMetadata], void), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), setVersion/458920672=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), cast-from-var3607-to-var868=([org.apache.dubbo.rpc.model.ServiceMetadata], org.apache.dubbo.common.BaseServiceMetadata), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), setGroup/-1095497895=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), setDefaultGroup/1333710876=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.String], void), getName/-1958580599=([java.lang.Class], java.lang.String), setServiceInterfaceName/1800892157=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), setServiceType/1618954904=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.Class], void), var3183_buildKey/1628109746=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), setServiceKey/1448309474=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), var666-init=([], org.apache.dubbo.rpc.model.ConsumerModel), getServiceKey/395021990=([org.apache.dubbo.rpc.model.ServiceMetadata], java.lang.String), serviceRepository/-508343383=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ModuleServiceRepository), getServiceInterfaceName/-1042727181=([org.apache.dubbo.common.BaseServiceMetadata], java.lang.String), lookupService/-881429514=([org.apache.dubbo.rpc.model.ModuleServiceRepository, java.lang.String], org.apache.dubbo.rpc.model.ServiceDescriptor), var604-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), var35_getClassLoader/1955646820=([java.lang.Class], java.lang.ClassLoader), <init>/749650884=([org.apache.dubbo.rpc.model.ConsumerModel, java.lang.String, java.lang.Object, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.rpc.model.ServiceMetadata, java.util.Map, java.lang.ClassLoader], void), cast-from-var604-to-var3469=([java.util.HashMap], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getDesc/-1571219874=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var722-to-var1678=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var684_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), registerConsumer/-649326312=([org.apache.dubbo.rpc.model.ModuleServiceRepository, org.apache.dubbo.rpc.model.ConsumerModel], void)}
; {var722=org.apache.dubbo.rpc.model.ModuleModel, var1044=r14, var783=r5, var3183=org.apache.dubbo.common.URL, var2196=r1, var1299=org.apache.dubbo.rpc.model.ServiceDescriptor, var705=r13, var454=java.lang.Object, var1804=r12, var3607=org.apache.dubbo.rpc.model.ServiceMetadata, var807=$r0, var2323=$r2, var868=org.apache.dubbo.common.BaseServiceMetadata, var2727=$r3, var1337=$r4, var2031=$r6, var3970=$r9, var1126=$r8, var3088=$r7, var1342=r10, var666=org.apache.dubbo.rpc.model.ConsumerModel, var2110=$r11, var291=$r17, var161=org.apache.dubbo.rpc.model.ModuleServiceRepository, var1089=$r27, var1491=$r28, var2078=$r29, var604=java.util.HashMap, var1884=$r15, var1281=0, var3111=java.lang.ClassLoader, var35=org.apache.dubbo.common.utils.ClassUtils, var797=$r16, var3469=java.util.Map, var684=org.apache.dubbo.common.logger.Logger, var1383=$r19, var685=$r18, var1759=$r20, var3923=$r21, var3651=$r23, var1678=org.apache.dubbo.rpc.model.ScopeModel, var2050=$r22, var3108=$r24, var3087=$r25, var3231=$r26}
; {org.apache.dubbo.rpc.model.ModuleModel=var722, r14=var1044, r5=var783, org.apache.dubbo.common.URL=var3183, r1=var2196, org.apache.dubbo.rpc.model.ServiceDescriptor=var1299, r13=var705, java.lang.Object=var454, r12=var1804, org.apache.dubbo.rpc.model.ServiceMetadata=var3607, $r0=var807, $r2=var2323, org.apache.dubbo.common.BaseServiceMetadata=var868, $r3=var2727, $r4=var1337, $r6=var2031, $r9=var3970, $r8=var1126, $r7=var3088, r10=var1342, org.apache.dubbo.rpc.model.ConsumerModel=var666, $r11=var2110, $r17=var291, org.apache.dubbo.rpc.model.ModuleServiceRepository=var161, $r27=var1089, $r28=var1491, $r29=var2078, java.util.HashMap=var604, $r15=var1884, 0=var1281, java.lang.ClassLoader=var3111, org.apache.dubbo.common.utils.ClassUtils=var35, $r16=var797, java.util.Map=var3469, org.apache.dubbo.common.logger.Logger=var684, $r19=var1383, $r18=var685, $r20=var1759, $r21=var3923, $r23=var3651, org.apache.dubbo.rpc.model.ScopeModel=var1678, $r22=var2050, $r24=var3108, $r25=var3087, $r26=var3231}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r14 := @this: org.apache.dubbo.rpc.model.ModuleModel;	r5 := @parameter0: java.lang.Class;	r1 := @parameter1: org.apache.dubbo.common.URL;	r13 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r12 := @parameter3: java.lang.Object;	$r0 = new org.apache.dubbo.rpc.model.ServiceMetadata;	specialinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setVersion(java.lang.String)>($r2);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setGroup(java.lang.String)>($r3);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setDefaultGroup(java.lang.String)>($r4);	$r6 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceInterfaceName(java.lang.String)>($r6);	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceType(java.lang.Class)>(r5);	$r9 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	r10 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r9, $r8, $r7);	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceKey(java.lang.String)>(r10);	$r11 = new org.apache.dubbo.rpc.model.ConsumerModel;	$r17 = virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.String getServiceKey()>();	if r13 != null goto $r29 = r13;	$r27 = r14.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ModuleServiceRepository serviceRepository>;	$r28 = virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.String getServiceInterfaceName()>();	$r29 = virtualinvoke $r27.<org.apache.dubbo.rpc.model.ModuleServiceRepository: org.apache.dubbo.rpc.model.ServiceDescriptor lookupService(java.lang.String)>($r28);	goto [?= $r15 = new java.util.HashMap];	$r15 = new java.util.HashMap;	specialinvoke $r15.<java.util.HashMap: void <init>(int)>(0);	$r16 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.ClassLoader getClassLoader(java.lang.Class)>(r5);	specialinvoke $r11.<org.apache.dubbo.rpc.model.ConsumerModel: void <init>(java.lang.String,java.lang.Object,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.util.Map,java.lang.ClassLoader)>($r17, r12, $r29, r14, $r0, $r15, $r16);	$r19 = <org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.logger.Logger logger>;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Dynamically registering consumer model ");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10);	$r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" into model ");	$r22 = virtualinvoke r14.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r19.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r25);	$r26 = r14.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ModuleServiceRepository serviceRepository>;	virtualinvoke $r26.<org.apache.dubbo.rpc.model.ModuleServiceRepository: void registerConsumer(org.apache.dubbo.rpc.model.ConsumerModel)>($r11);	return $r11
;block_num 3