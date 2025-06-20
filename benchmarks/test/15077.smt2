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

(declare-sort var1042 0)
(declare-sort var3748 0)
(declare-sort var2983 0)
(declare-sort var2641 0)
(declare-sort var2072 0)
(declare-sort var3895 0)
(declare-sort var1237 0)
(declare-sort var3456 0)
(declare-sort var2318 0)
(declare-sort var1099 0)
(declare-sort var2370 0)
(declare-sort var2888 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const String!class ClassObject)
(declare-const var3895!class ClassObject)
(declare-const var2318!class ClassObject)
(declare-fun <init>/-279557996 (var2983) void)
(declare-fun cast-from-var1042-to-var2983 (var1042) var2983)
(declare-fun var2641-init () var2641)
(declare-fun <init>/-2175807 (var2641) void)
(declare-fun cast-from-var2641-to-var2072 (var2641) var2072)
(declare-fun registerStatus/-183717227 (var1042) var2072)
(declare-fun subscribeStatus/-183717227 (var1042) var2072)
(declare-fun nacosConnectionManager/-183717227 (var1042) var3748)
(declare-fun arr-ClassObject-init () (Array Int ClassObject))
(declare-fun var3456_findMethod/1018470640 (ClassObject String (Array Int ClassObject)) var1237)
(declare-fun isSupportBatchRegister/-183717227 (var1042) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-388390247 (String Bool) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2370_info/484404803 (var2370 String) void)
(declare-fun cast-from-var1099-to-var2370 (var1099) var2370)
(declare-fun var2888_max/1360571700 (Int Int) Int)
(declare-fun retryTimes/-183717227 (var1042) Int)
(declare-fun sleepMsBetweenRetries/-183717227 (var1042) Int)
(declare-const null-var1042 var1042)
(declare-const null-var3748 var3748)
(declare-const null-Int Int)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-var1237 var1237)
(declare-const var1042-logger var1099)
(declare-const var2111 var1042) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper 
(assert (not (= var2111 null-var1042)))
(declare-const var1399 var3748) ; Statement: r3 := @parameter0: org.apache.dubbo.registry.nacos.NacosConnectionManager 
(assert (not (= var1399 null-var3748)))
(declare-const var2058 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2058 null-Int)))
(declare-const var2977 Int) ; Statement: i2 := @parameter2: int 
(assert (not (= var2977 null-Int)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1042-to-var2983 var2111))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2111!1 var1042)
(define-const var1 var2641 var2641-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1!1 var2641)
(declare-const var2111!2 var1042)
(assert (not (= var2111!2 null-var1042)))
(assert (= (registerStatus/-183717227 var2111!2) (cast-from-var2641-to-var2072 var1!1))) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap registerStatus> = $r1 
(define-const var1658 var2641 var2641-init) ; Statement: $r2 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var1658)) ; Statement: specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var1658!1 var2641)
(declare-const var2111!3 var1042)
(assert (not (= var2111!3 null-var1042)))
(assert (= (subscribeStatus/-183717227 var2111!3) (cast-from-var2641-to-var2072 var1658!1))) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap subscribeStatus> = $r2 
(declare-const var2111!4 var1042)
(assert (not (= var2111!4 null-var1042)))
(assert (= (nacosConnectionManager/-183717227 var2111!4) var1399)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.registry.nacos.NacosConnectionManager nacosConnectionManager> = r3 
(define-const var1264 (Array Int ClassObject) arr-ClassObject-init) ; Statement: $r4 = newarray (java.lang.Class)[3] 
(declare-const var1264!1 (Array Int ClassObject))
(assert (not (= var1264!1 null-__Array__Int__ClassObject__)))
(assert (= (select var1264!1 0) String!class)) ; Statement: $r4[0] = class "Ljava/lang/String;" 
(declare-const var1264!2 (Array Int ClassObject))
(assert (not (= var1264!2 null-__Array__Int__ClassObject__)))
(assert (= (select var1264!2 1) String!class)) ; Statement: $r4[1] = class "Ljava/lang/String;" 
(declare-const var1264!3 (Array Int ClassObject))
(assert (not (= var1264!3 null-__Array__Int__ClassObject__)))
(assert (= (select var1264!3 2) var3895!class)) ; Statement: $r4[2] = class "Ljava/util/List;" 
(define-const var518 var1237 (var3456_findMethod/1018470640 var2318!class "batchRegisterInstance" var1264!3)) ; Statement: $r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(class "Lcom/alibaba/nacos/api/naming/NamingService;", "batchRegisterInstance", $r4) 
 ; Statement: if $r5 == null goto $z1 = 0 
(assert (not (= var518 null-var1237))) ; Negate: Cond: $r5 == null  
(define-const var3468 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> = $z1] 
(assert true) ; Non Conditional
(declare-const var2111!5 var1042)
(assert (not (= var2111!5 null-var1042)))
(assert (= (isSupportBatchRegister/-183717227 var2111!5) var3468)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> = $z1 
(define-const var2131 var1099 var1042-logger) ; Statement: $r7 = <org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3875 String String-init) ; Statement: $r6 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3875)) ; Statement: specialinvoke $r6.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3875!1 String)
(assert (= var3875!1 ""))
(assert true)
(define-const var973 String (append/672562846 var3875!1 "Nacos batch register enable: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Nacos batch register enable: ") 
(declare-const var3875!2 String)
(assert (= var3875!2 (str.++ var3875!1 "Nacos batch register enable: ")))
(define-const var268 Bool (isSupportBatchRegister/-183717227 var2111!5)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> 
(assert true)
(define-const var3810 String (append/-388390247 var973 var268)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0) 
(declare-const var973!1 String)
(assert (str.prefixof var973 var973!1))
(assert true)
(define-const var1141 String (toString/-2075883882 var3810)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2370_info/484404803 (cast-from-var1099-to-var2370 var2131) var1141)) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r10) 

(declare-const var2131!1 var1099)
(declare-const var1141!1 String)
(define-const var3443 Int (var2888_max/1360571700 var2058 0)) ; Statement: $i1 = staticinvoke <java.lang.Math: int max(int,int)>(i0, 0) 
(declare-const var2111!6 var1042)
(assert (not (= var2111!6 null-var1042)))
(assert (= (retryTimes/-183717227 var2111!6) var3443)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int retryTimes> = $i1 
(declare-const var2111!7 var1042)
(assert (not (= var2111!7 null-var1042)))
(assert (= (sleepMsBetweenRetries/-183717227 var2111!7) var2977)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int sleepMsBetweenRetries> = i2 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1042-to-var2983=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.lang.Object), var2641-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2641-to-var2072=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), registerStatus/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.util.concurrent.ConcurrentMap), subscribeStatus/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], java.util.concurrent.ConcurrentMap), nacosConnectionManager/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], org.apache.dubbo.registry.nacos.NacosConnectionManager), arr-ClassObject-init=([], java.lang.Class[]), var3456_findMethod/1018470640=([java.lang.Class, java.lang.String, java.lang.Class[]], java.lang.reflect.Method), isSupportBatchRegister/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2370_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1099-to-var2370=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), var2888_max/1360571700=([int, int], int), retryTimes/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], int), sleepMsBetweenRetries/-183717227=([org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper], int)}
; {var1042=org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper, var2111=r0, var3748=org.apache.dubbo.registry.nacos.NacosConnectionManager, var1399=r3, var2058=i0, var2977=i2, var2983=java.lang.Object, var2641=java.util.concurrent.ConcurrentHashMap, var1=$r1, var2072=java.util.concurrent.ConcurrentMap, var1658=$r2, var1264=$r4, var3895=java.util.List, var1237=java.lang.reflect.Method, var3456=org.apache.dubbo.common.utils.MethodUtils, var2318=com.alibaba.nacos.api.naming.NamingService, var518=$r5, var3468=$z1, var1099=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2131=$r7, var3875=$r6, var973=$r8, var268=$z0, var3810=$r9, var1141=$r10, var2370=org.apache.dubbo.common.logger.Logger, var2888=java.lang.Math, var3443=$i1}
; {org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper=var1042, r0=var2111, org.apache.dubbo.registry.nacos.NacosConnectionManager=var3748, r3=var1399, i0=var2058, i2=var2977, java.lang.Object=var2983, java.util.concurrent.ConcurrentHashMap=var2641, $r1=var1, java.util.concurrent.ConcurrentMap=var2072, $r2=var1658, $r4=var1264, java.util.List=var3895, java.lang.reflect.Method=var1237, org.apache.dubbo.common.utils.MethodUtils=var3456, com.alibaba.nacos.api.naming.NamingService=var2318, $r5=var518, $z1=var3468, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1099, $r7=var2131, $r6=var3875, $r8=var973, $z0=var268, $r9=var3810, $r10=var1141, org.apache.dubbo.common.logger.Logger=var2370, java.lang.Math=var2888, $i1=var3443}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper;	r3 := @parameter0: org.apache.dubbo.registry.nacos.NacosConnectionManager;	i0 := @parameter1: int;	i2 := @parameter2: int;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap registerStatus> = $r1;	$r2 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r2.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: java.util.concurrent.ConcurrentMap subscribeStatus> = $r2;	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.registry.nacos.NacosConnectionManager nacosConnectionManager> = r3;	$r4 = newarray (java.lang.Class)[3];	$r4[0] = class "Ljava/lang/String;";	$r4[1] = class "Ljava/lang/String;";	$r4[2] = class "Ljava/util/List;";	$r5 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.reflect.Method findMethod(java.lang.Class,java.lang.String,java.lang.Class[])>(class "Lcom/alibaba/nacos/api/naming/NamingService;", "batchRegisterInstance", $r4);	if $r5 == null goto $z1 = 0;	$z1 = 1;	goto [?= r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> = $z1];	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister> = $z1;	$r7 = <org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r6 = new java.lang.StringBuilder;	specialinvoke $r6.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Nacos batch register enable: ");	$z0 = r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: boolean isSupportBatchRegister>;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r10);	$i1 = staticinvoke <java.lang.Math: int max(int,int)>(i0, 0);	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int retryTimes> = $i1;	r0.<org.apache.dubbo.registry.nacos.NacosNamingServiceWrapper: int sleepMsBetweenRetries> = i2;	return
;block_num 3