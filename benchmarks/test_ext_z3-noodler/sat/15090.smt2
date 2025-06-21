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

(declare-sort var235 0)
(declare-sort var1590 0)
(declare-sort var1105 0)
(declare-sort var3219 0)
(declare-sort var163 0)
(declare-sort var1672 0)
(declare-sort var1515 0)
(declare-sort var1076 0)
(declare-sort var2591 0)
(declare-sort var1540 0)
(declare-sort var1798 0)
(declare-sort var1398 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const String!class ClassObject)
(declare-const var1672!class ClassObject)
(declare-const var2591!class ClassObject)
(declare-fun <init>/-279557996 (var1105) void)
(declare-fun cast-from-var235-to-var1105 (var235) var1105)
(declare-fun var3219-init () var3219)
(declare-fun <init>/-2175807 (var3219) void)
(declare-fun cast-from-var3219-to-var163 (var3219) var163)
(declare-fun registerStatus/-183717227 (var235) var163)
(declare-fun subscribeStatus/-183717227 (var235) var163)
(declare-fun nacosConnectionManager/-183717227 (var235) var1590)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var1076_findMethod/1018470640 (ClassObject String (Array Int ClassObject)) var1515)
(declare-fun isSupportBatchRegister/-183717227 (var235) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-388390247 (String Bool) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1798_info/484404803 (var1798 String) void)
(declare-fun cast-from-var1540-to-var1798 (var1540) var1798)
(declare-fun var1398_max/1360571700 (Int Int) Int)
(declare-fun retryTimes/-183717227 (var235) Int)
(declare-fun sleepMsBetweenRetries/-183717227 (var235) Int)
(declare-const null-var235 var235)
(declare-const null-var1590 var1590)
(declare-const null-Int Int)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-var1515 var1515)
(declare-const var235-logger var1540)
(declare-const var3969 var235) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper 
(assert (not (= var3969 null-var235)))
(declare-const var94 var1590) ; Statement: r3 := @parameter0: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var94 null-var1590)))
(declare-const var3548 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var3548 null-Int)))
(declare-const var3611 Int) ; Statement: i2 := @parameter2: int 
(assert (not (= var3611 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var235-to-var1105 var3969))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3969!1 var235)
(define-const var1808 var3219 var3219-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1808)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1808!1 var3219)
(declare-const var3969!2 var235)
(assert (not (= var3969!2 null-var235)))
(assert (= (registerStatus/-183717227 var3969!2) (cast-from-var3219-to-var163 var1808!1))) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap registerStatus> = $r1 
(define-const var2337 var3219 var3219-init) ; Statement: $r2 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2337)) ; Statement: specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2337!1 var3219)
(declare-const var3969!3 var235)
(assert (not (= var3969!3 null-var235)))
(assert (= (subscribeStatus/-183717227 var3969!3) (cast-from-var3219-to-var163 var2337!1))) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap subscribeStatus> = $r2 
(declare-const var3969!4 var235)
(assert (not (= var3969!4 null-var235)))
(assert (= (nacosConnectionManager/-183717227 var3969!4) var94)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.registry.nacos.NacosConnectionManager nacosConnectionManager> = r3 
(define-const var833 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r4 = newarray (java.lang.Class)[3] 
(declare-const var833!1 (Array Int ClassObject))
(assert (not (= var833!1 null-__Array__Int__ClassObject__)))
(assert (= (select var833!1 0) String!class)) ; Statement: $r4[0] = class "Ljava/lang/String;" 
(declare-const var833!2 (Array Int ClassObject))
(assert (not (= var833!2 null-__Array__Int__ClassObject__)))
(assert (= (select var833!2 1) String!class)) ; Statement: $r4[1] = class "Ljava/lang/String;" 
(declare-const var833!3 (Array Int ClassObject))
(assert (not (= var833!3 null-__Array__Int__ClassObject__)))
(assert (= (select var833!3 2) var1672!class)) ; Statement: $r4[2] = class "Ljava/util/List;" 
(define-const var2345 var1515 (var1076_findMethod/1018470640 var2591!class "batchRegisterInstance" var833!3)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(class "Lcom/alibaba/nacos/api/naming/NamingService;", "batchRegisterInstance", $r4) 
 ; Statement: if $r5 == null goto $z1 = 0 
(assert (= var2345 null-var1515)) ; Cond: $r5 == null 
(define-const var2797 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
(declare-const var3969!5 var235)
(assert (not (= var3969!5 null-var235)))
(assert (= (isSupportBatchRegister/-183717227 var3969!5) var2797)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> = $z1 
(define-const var3848 var1540 var235-logger) ; Statement: $r7 = <org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var396 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var396)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var396!1 String)
(assert (= var396!1 ""))
(assert true)
(define-const var2563 String (append/672562846 var396!1 "Nacos batch register enable: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Nacos batch register enable: ") 
(declare-const var396!2 String)
(assert (= var396!2 (str.++ var396!1 "Nacos batch register enable: ")))
(define-const var1395 Bool (isSupportBatchRegister/-183717227 var3969!5)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> 
(assert true)
(define-const var1880 String (append/-388390247 var2563 var1395)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var2563!1 String)
(assert (str.prefixof var2563 var2563!1))
(assert true)
(define-const var3892 String (toString/-2075883882 var1880)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1798_info/484404803 (cast-from-var1540-to-var1798 var3848) var3892)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r10) 

(declare-const var3848!1 var1540)
(declare-const var3892!1 String)
(define-const var1589 Int (var1398_max/1360571700 var3548 0)) ; Statement: $i1 = staticinvoke <java.lang.Math: int max(int,int)>(i0, 0) 
(declare-const var3969!6 var235)
(assert (not (= var3969!6 null-var235)))
(assert (= (retryTimes/-183717227 var3969!6) var1589)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int retryTimes> = $i1 
(declare-const var3969!7 var235)
(assert (not (= var3969!7 null-var235)))
(assert (= (sleepMsBetweenRetries/-183717227 var3969!7) var3611)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int sleepMsBetweenRetries> = i2 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var235-to-var1105=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.lang.Object), var3219-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var3219-to-var163=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), registerStatus/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.util.concurrent.ConcurrentMap), subscribeStatus/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.util.concurrent.ConcurrentMap), nacosConnectionManager/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], org.apache.dubbo.registry.nacos.NacosConnectionManager), arr-ClassObject-init=([], java.lang.Class[]), var1076_findMethod/1018470640=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), isSupportBatchRegister/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1798_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1540-to-var1798=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var1398_max/1360571700=([int, int], int), retryTimes/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], int), sleepMsBetweenRetries/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], int)}
; {var235=org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper, var3969=r0, var1590=org.apache.dubbo.registry.nacos.NacosConnectionManager, var94=r3, var3548=i0, var3611=i2, var1105=java.lang.Object, var3219=java.util.concurrent.ConcurrentHashMap, var1808=$r1, var163=java.util.concurrent.ConcurrentMap, var2337=$r2, var833=$r4, var1672=java.util.List, var1515=java.lang.reflect.Method, var1076=org.apache.dubbo.common.utils.MethodUtils, var2591=com.alibaba.nacos.api.naming.NamingService, var2345=$r5, var2797=$z1, var1540=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3848=$r7, var396=$r6, var2563=$r8, var1395=$z0, var1880=$r9, var3892=$r10, var1798=org.apache.dubbo.common.logger.Logger, var1398=java.lang.Math, var1589=$i1}
; {org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper=var235, r0=var3969, org.apache.dubbo.registry.nacos.NacosConnectionManager=var1590, r3=var94, i0=var3548, i2=var3611, java.lang.Object=var1105, java.util.concurrent.ConcurrentHashMap=var3219, $r1=var1808, java.util.concurrent.ConcurrentMap=var163, $r2=var2337, $r4=var833, java.util.List=var1672, java.lang.reflect.Method=var1515, org.apache.dubbo.common.utils.MethodUtils=var1076, com.alibaba.nacos.api.naming.NamingService=var2591, $r5=var2345, $z1=var2797, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1540, $r7=var3848, $r6=var396, $r8=var2563, $z0=var1395, $r9=var1880, $r10=var3892, org.apache.dubbo.common.logger.Logger=var1798, java.lang.Math=var1398, $i1=var1589}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper;	r3 := @parameter0: org.apache.dubbo.registry.nacos.NacosConnectionManager;	i0 := @parameter1: int;	i2 := @parameter2: int;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap registerStatus> = $r1;	$r2 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap subscribeStatus> = $r2;	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.registry.nacos.NacosConnectionManager nacosConnectionManager> = r3;	$r4 = newarray (java.lang.Class)[3];	$r4[0] = class "Ljava/lang/String;";	$r4[1] = class "Ljava/lang/String;";	$r4[2] = class "Ljava/util/List;";	$r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(class "Lcom/alibaba/nacos/api/naming/NamingService;", "batchRegisterInstance", $r4);	if $r5 == null goto $z1 = 0;	$z1 = 0;	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> = $z1;	$r7 = <org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Nacos batch register enable: ");	$z0 = r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r10);	$i1 = staticinvoke <java.lang.Math: int max(int,int)>(i0, 0);	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int retryTimes> = $i1;	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int sleepMsBetweenRetries> = i2;	return
;block_num 3