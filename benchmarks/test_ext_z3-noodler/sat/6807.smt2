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

(declare-sort var3271 0)
(declare-sort var2675 0)
(declare-sort var535 0)
(declare-sort var50 0)
(declare-sort var1544 0)
(declare-sort var3943 0)
(declare-sort var3554 0)
(declare-sort var221 0)
(declare-sort var595 0)
(declare-sort var3888 0)
(declare-sort var582 0)
(declare-sort var1732 0)
(declare-sort var3579 0)
(declare-sort var1950 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1544-init () var1544)
(declare-fun <init>/819945617 (var1544) void)
(declare-fun getVersion/189836348 (var2675) String)
(declare-fun setVersion/458920672 (var3943 String) void)
(declare-fun cast-from-var1544-to-var3943 (var1544) var3943)
(declare-fun getGroup/1342955253 (var2675) String)
(declare-fun setGroup/-1095497895 (var3943 String) void)
(declare-fun setDefaultGroup/1333710876 (var1544 String) void)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun setServiceInterfaceName/1800892157 (var3943 String) void)
(declare-fun setServiceType/1618954904 (var1544 ClassObject) void)
(declare-fun var2675_buildKey/1628109746 (String String String) String)
(declare-fun setServiceKey/1448309474 (var3943 String) void)
(declare-fun var3554-init () var3554)
(declare-fun getServiceKey/395021990 (var1544) String)
(declare-fun var221-init () var221)
(declare-fun <init>/613807010 (var221 Int) void)
(declare-fun var3888_getClassLoader/1955646820 (ClassObject) var595)
(declare-fun <init>/749650884 (var3554 String var50 var535 var3271 var1544 var582 var595) void)
(declare-fun cast-from-var221-to-var582 (var221) var582)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getDesc/-1571219874 (var3579) String)
(declare-fun cast-from-var3271-to-var3579 (var3271) var3579)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1732_info/484404803 (var1732 String) void)
(declare-fun serviceRepository/-508343383 (var3271) var1950)
(declare-fun registerConsumer/-649326312 (var1950 var3554) void)
(declare-const null-var3271 var3271)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2675 var2675)
(declare-const null-var535 var535)
(declare-const null-var50 var50)
(declare-const var3271-logger var1732)
(declare-const var1638 var3271) ; Statement: r14 := @this: org.apache.dubbo.rpc.model.ModuleModel 
(assert (not (= var1638 null-var3271)))
(declare-const var2377 ClassObject) ; Statement: r5 := @parameter0: java.lang.Class 
(assert (not (= var2377 null-ClassObject)))
(declare-const var1446 var2675) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var1446 null-var2675)))
(declare-const var3357 var535) ; Statement: r13 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor 
(assert (not (= var3357 null-var535)))
(declare-const var3538 var50) ; Statement: r12 := @parameter3: java.lang.Object 
(assert (not (= var3538 null-var50)))
(define-const var579 var1544 var1544-init) ; Statement: $r0 = new org.apache.dubbo.rpc.model.ServiceMetadata 
(assert true)
;(assert (<init>/819945617 var579)) ; Statement: specialinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void <init>()>() 

(declare-const var579!1 var1544)
(assert true)
(define-const var1839 String (getVersion/189836348 var1446)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(assert true)
;(assert (setVersion/458920672 (cast-from-var1544-to-var3943 var579!1) var1839)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setVersion(java.lang.String)>($r2) 

(declare-const var579!2 var1544)
(declare-const var1839!1 String)
(assert true)
(define-const var3125 String (getGroup/1342955253 var1446)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
;(assert (setGroup/-1095497895 (cast-from-var1544-to-var3943 var579!2) var3125)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setGroup(java.lang.String)>($r3) 

(declare-const var579!3 var1544)
(declare-const var3125!1 String)
(assert true)
(define-const var1694 String (getGroup/1342955253 var1446)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
;(assert (setDefaultGroup/1333710876 var579!3 var1694)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setDefaultGroup(java.lang.String)>($r4) 

(declare-const var579!4 var1544)
(declare-const var1694!1 String)
(assert true)
(define-const var37 String (getName/-1958580599 var2377)) ; Statement: $r6 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
;(assert (setServiceInterfaceName/1800892157 (cast-from-var1544-to-var3943 var579!4) var37)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceInterfaceName(java.lang.String)>($r6) 

(declare-const var579!5 var1544)
(declare-const var37!1 String)
(assert true)
;(assert (setServiceType/1618954904 var579!5 var2377)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceType(java.lang.Class)>(r5) 

(declare-const var579!6 var1544)
(declare-const var2377!1 ClassObject)
(assert true)
(define-const var121 String (getName/-1958580599 var2377!1)) ; Statement: $r9 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3384 String (getGroup/1342955253 var1446)) ; Statement: $r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>() 
(assert true)
(define-const var1852 String (getVersion/189836348 var1446)) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>() 
(define-const var3831 String (var2675_buildKey/1628109746 var121 var3384 var1852)) ; Statement: r10 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r9, $r8, $r7) 
(assert true)
;(assert (setServiceKey/1448309474 (cast-from-var1544-to-var3943 var579!6) var3831)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceKey(java.lang.String)>(r10) 

(declare-const var579!7 var1544)
(declare-const var3831!1 String)
(define-const var1102 var3554 var3554-init) ; Statement: $r11 = new org.apache.dubbo.rpc.model.ConsumerModel 
(assert true)
(define-const var2302 String (getServiceKey/395021990 var579!7)) ; Statement: $r17 = virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.String getServiceKey()>() 
 ; Statement: if r13 != null goto $r29 = r13 
(assert (not (= var3357 null-var535))) ; Cond: r13 != null 
(define-const var3259 var535 var3357) ; Statement: $r29 = r13 
(assert true) ; Non Conditional
(define-const var3144 var221 var221-init) ; Statement: $r15 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var3144 0)) ; Statement: specialinvoke $r15.<java.util.HashMap: void <init>(int)>(0) 

(declare-const var3144!1 var221)
(declare-const var3055 Int)
(define-const var506 var595 (var3888_getClassLoader/1955646820 var2377!1)) ; Statement: $r16 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.ClassLoader getClassLoader(java.lang.Class)>(r5) 
(assert true)
;(assert (<init>/749650884 var1102 var2302 var3538 var3259 var1638 var579!7 (cast-from-var221-to-var582 var3144!1) var506)) ; Statement: specialinvoke $r11.<org.apache.dubbo.rpc.model.ConsumerModel: void <init>(java.lang.String,java.lang.Object,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.util.Map,java.lang.ClassLoader)>($r17, r12, $r29, r14, $r0, $r15, $r16) 

(declare-const var1102!1 var3554)
(declare-const var2302!1 String)
(declare-const var3538!1 var50)
(declare-const var3259!1 var535)
(declare-const var1638!1 var3271)
(declare-const var579!8 var1544)
(declare-const var3144!2 var221)
(declare-const var506!1 var595)
(define-const var3669 var1732 var3271-logger) ; Statement: $r19 = <org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.logger.Logger logger> 
(define-const var3346 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3346)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3346!1 String)
(assert (= var3346!1 ""))
(assert true)
(define-const var1801 String (append/672562846 var3346!1 "Dynamically registering consumer model ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Dynamically registering consumer model ") 
(declare-const var3346!2 String)
(assert (= var3346!2 (str.++ var3346!1 "Dynamically registering consumer model ")))
(assert true)
(define-const var534 String (append/672562846 var1801 var3831!1)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10) 
(declare-const var1801!1 String)
(assert (= var1801!1 (str.++ var1801 var3831!1)))
(assert true)
(define-const var2669 String (append/672562846 var534 " into model ")) ; Statement: $r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" into model ") 
(declare-const var534!1 String)
(assert (= var534!1 (str.++ var534 " into model ")))
(assert true)
(define-const var964 String (getDesc/-1571219874 (cast-from-var3271-to-var3579 var1638!1))) ; Statement: $r22 = virtualinvoke r14.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>() 
(assert true)
(define-const var1875 String (append/672562846 var2669 var964)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22) 
(declare-const var2669!1 String)
(assert (= var2669!1 (str.++ var2669 var964)))
(assert true)
(define-const var904 String (toString/-2075883882 var1875)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1732_info/484404803 var3669 var904)) ; Statement: interfaceinvoke $r19.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r25) 

(declare-const var3669!1 var1732)
(declare-const var904!1 String)
(define-const var561 var1950 (serviceRepository/-508343383 var1638!1)) ; Statement: $r26 = r14.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ModuleServiceRepository serviceRepository> 
(assert true)
;(assert (registerConsumer/-649326312 var561 var1102!1)) ; Statement: virtualinvoke $r26.<org.apache.dubbo.rpc.model.ModuleServiceRepository: void registerConsumer(org.apache.dubbo.rpc.model.ConsumerModel)>($r11) 

(declare-const var561!1 var1950)
(declare-const var1102!2 var3554)
 ; Statement: return $r11 
(check-sat)
; {var1544-init=([], org.apache.dubbo.rpc.model.ServiceMetadata), <init>/819945617=([org.apache.dubbo.rpc.model.ServiceMetadata], void), getVersion/189836348=([org.apache.dubbo.common.URL], java.lang.String), setVersion/458920672=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), cast-from-var1544-to-var3943=([org.apache.dubbo.rpc.model.ServiceMetadata], org.apache.dubbo.common.BaseServiceMetadata), getGroup/1342955253=([org.apache.dubbo.common.URL], java.lang.String), setGroup/-1095497895=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), setDefaultGroup/1333710876=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.String], void), getName/-1958580599=([java.lang.Class], java.lang.String), setServiceInterfaceName/1800892157=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), setServiceType/1618954904=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.Class], void), var2675_buildKey/1628109746=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), setServiceKey/1448309474=([org.apache.dubbo.common.BaseServiceMetadata, java.lang.String], void), var3554-init=([], org.apache.dubbo.rpc.model.ConsumerModel), getServiceKey/395021990=([org.apache.dubbo.rpc.model.ServiceMetadata], java.lang.String), var221-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), var3888_getClassLoader/1955646820=([java.lang.Class], java.lang.ClassLoader), <init>/749650884=([org.apache.dubbo.rpc.model.ConsumerModel, java.lang.String, java.lang.Object, org.apache.dubbo.rpc.model.ServiceDescriptor, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.rpc.model.ServiceMetadata, java.util.Map, java.lang.ClassLoader], void), cast-from-var221-to-var582=([java.util.HashMap], java.util.Map), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getDesc/-1571219874=([org.apache.dubbo.rpc.model.ScopeModel], java.lang.String), cast-from-var3271-to-var3579=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1732_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), serviceRepository/-508343383=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ModuleServiceRepository), registerConsumer/-649326312=([org.apache.dubbo.rpc.model.ModuleServiceRepository, org.apache.dubbo.rpc.model.ConsumerModel], void)}
; {var3271=org.apache.dubbo.rpc.model.ModuleModel, var1638=r14, var2377=r5, var2675=org.apache.dubbo.common.URL, var1446=r1, var535=org.apache.dubbo.rpc.model.ServiceDescriptor, var3357=r13, var50=java.lang.Object, var3538=r12, var1544=org.apache.dubbo.rpc.model.ServiceMetadata, var579=$r0, var1839=$r2, var3943=org.apache.dubbo.common.BaseServiceMetadata, var3125=$r3, var1694=$r4, var37=$r6, var121=$r9, var3384=$r8, var1852=$r7, var3831=r10, var3554=org.apache.dubbo.rpc.model.ConsumerModel, var1102=$r11, var2302=$r17, var3259=$r29, var221=java.util.HashMap, var3144=$r15, var3055=0, var595=java.lang.ClassLoader, var3888=org.apache.dubbo.common.utils.ClassUtils, var506=$r16, var582=java.util.Map, var1732=org.apache.dubbo.common.logger.Logger, var3669=$r19, var3346=$r18, var1801=$r20, var534=$r21, var2669=$r23, var3579=org.apache.dubbo.rpc.model.ScopeModel, var964=$r22, var1875=$r24, var904=$r25, var1950=org.apache.dubbo.rpc.model.ModuleServiceRepository, var561=$r26}
; {org.apache.dubbo.rpc.model.ModuleModel=var3271, r14=var1638, r5=var2377, org.apache.dubbo.common.URL=var2675, r1=var1446, org.apache.dubbo.rpc.model.ServiceDescriptor=var535, r13=var3357, java.lang.Object=var50, r12=var3538, org.apache.dubbo.rpc.model.ServiceMetadata=var1544, $r0=var579, $r2=var1839, org.apache.dubbo.common.BaseServiceMetadata=var3943, $r3=var3125, $r4=var1694, $r6=var37, $r9=var121, $r8=var3384, $r7=var1852, r10=var3831, org.apache.dubbo.rpc.model.ConsumerModel=var3554, $r11=var1102, $r17=var2302, $r29=var3259, java.util.HashMap=var221, $r15=var3144, 0=var3055, java.lang.ClassLoader=var595, org.apache.dubbo.common.utils.ClassUtils=var3888, $r16=var506, java.util.Map=var582, org.apache.dubbo.common.logger.Logger=var1732, $r19=var3669, $r18=var3346, $r20=var1801, $r21=var534, $r23=var2669, org.apache.dubbo.rpc.model.ScopeModel=var3579, $r22=var964, $r24=var1875, $r25=var904, org.apache.dubbo.rpc.model.ModuleServiceRepository=var1950, $r26=var561}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r14 := @this: org.apache.dubbo.rpc.model.ModuleModel;	r5 := @parameter0: java.lang.Class;	r1 := @parameter1: org.apache.dubbo.common.URL;	r13 := @parameter2: org.apache.dubbo.rpc.model.ServiceDescriptor;	r12 := @parameter3: java.lang.Object;	$r0 = new org.apache.dubbo.rpc.model.ServiceMetadata;	specialinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setVersion(java.lang.String)>($r2);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setGroup(java.lang.String)>($r3);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setDefaultGroup(java.lang.String)>($r4);	$r6 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceInterfaceName(java.lang.String)>($r6);	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceType(java.lang.Class)>(r5);	$r9 = virtualinvoke r5.<java.lang.Class: java.lang.String getName()>();	$r8 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getGroup()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getVersion()>();	r10 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>($r9, $r8, $r7);	virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: void setServiceKey(java.lang.String)>(r10);	$r11 = new org.apache.dubbo.rpc.model.ConsumerModel;	$r17 = virtualinvoke $r0.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.String getServiceKey()>();	if r13 != null goto $r29 = r13;	$r29 = r13;	$r15 = new java.util.HashMap;	specialinvoke $r15.<java.util.HashMap: void <init>(int)>(0);	$r16 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.ClassLoader getClassLoader(java.lang.Class)>(r5);	specialinvoke $r11.<org.apache.dubbo.rpc.model.ConsumerModel: void <init>(java.lang.String,java.lang.Object,org.apache.dubbo.rpc.model.ServiceDescriptor,org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.rpc.model.ServiceMetadata,java.util.Map,java.lang.ClassLoader)>($r17, r12, $r29, r14, $r0, $r15, $r16);	$r19 = <org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.common.logger.Logger logger>;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Dynamically registering consumer model ");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r10);	$r23 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" into model ");	$r22 = virtualinvoke r14.<org.apache.dubbo.rpc.model.ModuleModel: java.lang.String getDesc()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r22);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r19.<org.apache.dubbo.common.logger.Logger: void info(java.lang.String)>($r25);	$r26 = r14.<org.apache.dubbo.rpc.model.ModuleModel: org.apache.dubbo.rpc.model.ModuleServiceRepository serviceRepository>;	virtualinvoke $r26.<org.apache.dubbo.rpc.model.ModuleServiceRepository: void registerConsumer(org.apache.dubbo.rpc.model.ConsumerModel)>($r11);	return $r11
;block_num 3