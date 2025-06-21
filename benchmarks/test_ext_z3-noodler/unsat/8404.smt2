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

(declare-sort var2124 0)
(declare-sort var1500 0)
(declare-sort var1668 0)
(declare-sort var588 0)
(declare-sort var3991 0)
(declare-sort var3094 0)
(declare-sort var1177 0)
(declare-sort var1506 0)
(declare-sort var2058 0)
(declare-sort var2746 0)
(declare-sort var465 0)
(declare-sort var2204 0)
(declare-sort var2410 0)
(declare-sort var650 0)
(declare-sort var2180 0)
(declare-sort var2944 0)
(declare-sort var2651 0)
(declare-sort var1558 0)
(declare-sort var3458 0)
(declare-sort var2473 0)
(declare-sort var1208 0)
(declare-sort var3779 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1668-init () var1668)
(declare-fun <init>/1138455297 (var1668) void)
(declare-fun protocol/1679408145 (var2124) String)
(declare-fun setName/-777255745 (var1668 String) void)
(declare-fun port/1679408145 (var2124) Int)
(declare-fun setPort/-255570608 (var1668 Int) void)
(declare-fun nullAssert/-1712169857 (var2124) void)
(declare-fun logger/1679408145 (var2124) var588)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceClass/1679408145 (var2124) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun getPort/-726260002 (var1668) Int)
(declare-fun append/-1031950772 (String var3991) String)
(declare-fun cast-from-Int-to-var3991 (Int) var3991)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3094_info/484404803 (var3094 String) void)
(declare-fun cast-from-var588-to-var3094 (var588) var3094)
(declare-fun applicationModel/1679408145 (var2124) var1177)
(declare-fun getApplicationConfigManager/1850072349 (var1177) var1506)
(declare-fun getProtocol/-806407548 (var1506 String) var2058)
(declare-fun var2746_bootstrap$/-1357636845 (var1668) var1500)
(declare-fun ifPresent/-1974843347 (var2058 var1500) void)
(declare-fun getApplicationConfig/-1342331182 (var2124) var465)
(declare-fun var2204-init () var2204)
(declare-fun <init>/-1544369510 (var2204) void)
(declare-fun getInternalModule/890555230 (var1177) var2410)
(declare-fun setScopeModel/-330737779 (var650 var2180) void)
(declare-fun cast-from-var2204-to-var650 (var2204) var650)
(declare-fun cast-from-var2410-to-var2180 (var2410) var2180)
(declare-fun setApplication/-1646744778 (var2944 var465) void)
(declare-fun cast-from-var2204-to-var2944 (var2204) var2944)
(declare-fun var2651-init () var2651)
(declare-fun <init>/-1236919578 (var2651) void)
(declare-fun refresh/-1420329662 (var650) void)
(declare-fun cast-from-var2651-to-var650 (var2651) var650)
(declare-fun setNeedRefresh/2137881272 (var650 Bool) void)
(declare-fun registryId/1679408145 (var2124) String)
(declare-fun setId/369852133 (var650 String) void)
(declare-fun setAddress/937761227 (var2651 String) void)
(declare-fun cast-from-var1177-to-var2180 (var1177) var2180)
(declare-fun setRegistry/2051566610 (var2944 var2651) void)
(declare-fun var1558_valueOf/1602327315 (Bool) var1558)
(declare-fun setRegister/1766462515 (var3458 var1558) void)
(declare-fun cast-from-var2204-to-var3458 (var2204) var3458)
(declare-fun setProtocol/-57857418 (var3458 var1668) void)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun setDelay/1793925547 (var3458 Int) void)
(declare-fun setInterface/-223027320 (var2473 ClassObject) void)
(declare-fun cast-from-var2204-to-var2473 (var2204) var2473)
(declare-fun ref/1679408145 (var2124) var3991)
(declare-fun setRef/-1853520609 (var2473 var3991) void)
(declare-fun getName/922463553 (var465) String)
(declare-fun setGroup/767739090 (var3458 String) void)
(declare-fun version/1679408145 (var2124) String)
(declare-fun var1208_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setVersion/28300825 (var3458 String) void)
(declare-fun setFilter/-549200969 (var2944 String) void)
(declare-fun executor/1679408145 (var2124) var3779)
(declare-fun setExecutor/1452101433 (var3458 var3779) void)
(declare-const null-var2124 var2124)
(declare-const null-var1500 var1500)
(declare-const var2248 var2124) ; Statement: r1 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder 
(assert (not (= var2248 null-var2124)))
(declare-const var3672 var1500) ; Statement: r36 := @parameter0: java.util.function.Consumer 
(assert (not (= var3672 null-var1500)))
(define-const var1074 var1668 var1668-init) ; Statement: $r0 = new org.apache.dubbo.config.ProtocolConfig 
(assert true)
;(assert (<init>/1138455297 var1074)) ; Statement: specialinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void <init>()>() 

(declare-const var1074!1 var1668)
(define-const var2897 String (protocol/1679408145 var2248)) ; Statement: $r2 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> 
(assert true)
;(assert (setName/-777255745 var1074!1 var2897)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setName(java.lang.String)>($r2) 

(declare-const var1074!2 var1668)
(declare-const var2897!1 String)
(define-const var3387 Int (port/1679408145 var2248)) ; Statement: $r3 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Integer port> 
(assert true)
;(assert (setPort/-255570608 var1074!2 var3387)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setPort(java.lang.Integer)>($r3) 

(declare-const var1074!3 var1668)
(declare-const var3387!1 Int)
(assert true)
;(assert (nullAssert/-1712169857 var2248)) ; Statement: specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: void nullAssert()>() 

(declare-const var2248!1 var2124)
(define-const var1618 var588 (logger/1679408145 var2248!1)) ; Statement: $r5 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1380 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1380)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1380!1 String)
(assert (= var1380!1 ""))
(assert true)
(define-const var1123 String (append/672562846 var1380!1 "Using ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Using ") 
(declare-const var1380!2 String)
(assert (= var1380!2 (str.++ var1380!1 "Using ")))
(define-const var1841 String (protocol/1679408145 var2248!1)) ; Statement: $r6 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> 
(assert true)
(define-const var3034 String (append/672562846 var1123 var1841)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1123!1 String)
(assert (= var1123!1 (str.++ var1123 var1841)))
(assert true)
(define-const var1550 String (append/672562846 var3034 " protocol to export ")) ; Statement: $r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" protocol to export ") 
(declare-const var3034!1 String)
(assert (= var3034!1 (str.++ var3034 " protocol to export ")))
(define-const var2510 ClassObject (interfaceClass/1679408145 var2248!1)) ; Statement: $r9 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass> 
(assert true)
(define-const var3562 String (getName/-1958580599 var2510)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2625 String (append/672562846 var1550 var3562)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1550!1 String)
(assert (= var1550!1 (str.++ var1550 var3562)))
(assert true)
(define-const var3403 String (append/672562846 var2625 " service on port ")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" service on port ") 
(declare-const var2625!1 String)
(assert (= var2625!1 (str.++ var2625 " service on port ")))
(assert true)
(define-const var635 Int (getPort/-726260002 var1074!3)) ; Statement: $r13 = virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.Integer getPort()>() 
(assert true)
(define-const var3042 String (append/-1031950772 var3403 (cast-from-Int-to-var3991 var635))) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13) 
(declare-const var3403!1 String)
(assert (str.prefixof var3403 var3403!1))
(assert true)
(define-const var1574 String (toString/-2075883882 var3042)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3094_info/484404803 (cast-from-var588-to-var3094 var1618) var1574)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r16) 

(declare-const var1618!1 var588)
(declare-const var1574!1 String)
(define-const var2286 var1177 (applicationModel/1679408145 var2248!1)) ; Statement: $r17 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var3792 var1506 (getApplicationConfigManager/1850072349 var2286)) ; Statement: $r19 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(define-const var2315 String (protocol/1679408145 var2248!1)) ; Statement: $r18 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> 
(assert true)
(define-const var1285 var2058 (getProtocol/-806407548 var3792 var2315)) ; Statement: $r21 = virtualinvoke $r19.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getProtocol(java.lang.String)>($r18) 
(define-const var3125 var1500 (var2746_bootstrap$/-1357636845 var1074!3)) ; Statement: $r20 = staticinvoke <org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.ProtocolConfig)>($r0) 
(assert true)
;(assert (ifPresent/-1974843347 var1285 var3125)) ; Statement: virtualinvoke $r21.<java.util.Optional: void ifPresent(java.util.function.Consumer)>($r20) 

(declare-const var1285!1 var2058)
(declare-const var3125!1 var1500)
(assert true)
(define-const var1524 var465 (getApplicationConfig/-1342331182 var2248!1)) ; Statement: r22 = specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.ApplicationConfig getApplicationConfig()>() 
(define-const var401 var2204 var2204-init) ; Statement: $r23 = new org.apache.dubbo.config.ServiceConfig 
(assert true)
;(assert (<init>/-1544369510 var401)) ; Statement: specialinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void <init>()>() 

(declare-const var401!1 var2204)
(define-const var3724 var1177 (applicationModel/1679408145 var2248!1)) ; Statement: $r24 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var537 var2410 (getInternalModule/890555230 var3724)) ; Statement: $r25 = virtualinvoke $r24.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(assert true)
;(assert (setScopeModel/-330737779 (cast-from-var2204-to-var650 var401!1) (cast-from-var2410-to-var2180 var537))) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r25) 

(declare-const var401!2 var2204)
(declare-const var537!1 var2410)
(assert true)
;(assert (setApplication/-1646744778 (cast-from-var2204-to-var2944 var401!2) var1524)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setApplication(org.apache.dubbo.config.ApplicationConfig)>(r22) 

(declare-const var401!3 var2204)
(declare-const var1524!1 var465)
(define-const var692 var2651 var2651-init) ; Statement: $r26 = new org.apache.dubbo.config.RegistryConfig 
(assert true)
;(assert (<init>/-1236919578 var692)) ; Statement: specialinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void <init>()>() 

(declare-const var692!1 var2651)
(assert true)
;(assert (refresh/-1420329662 (cast-from-var2651-to-var650 var692!1))) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void refresh()>() 

(declare-const var692!2 var2651)
(assert true)
;(assert (setNeedRefresh/2137881272 (cast-from-var2651-to-var650 var692!2) (ite (= 1 0) true false))) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setNeedRefresh(boolean)>(0) 

(declare-const var692!3 var2651)
(declare-const var836 Int)
(define-const var375 String (registryId/1679408145 var2248!1)) ; Statement: $r27 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String registryId> 
(assert true)
;(assert (setId/369852133 (cast-from-var2651-to-var650 var692!3) var375)) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setId(java.lang.String)>($r27) 

(declare-const var692!4 var2651)
(declare-const var375!1 String)
(assert true)
;(assert (setAddress/937761227 var692!4 "N/A")) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setAddress(java.lang.String)>("N/A") 

(declare-const var692!5 var2651)
(declare-const var3080 String)
(define-const var2157 var1177 (applicationModel/1679408145 var2248!1)) ; Statement: $r28 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
;(assert (setScopeModel/-330737779 (cast-from-var2651-to-var650 var692!5) (cast-from-var1177-to-var2180 var2157))) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r28) 

(declare-const var692!6 var2651)
(declare-const var2157!1 var1177)
(assert true)
;(assert (setRegistry/2051566610 (cast-from-var2204-to-var2944 var401!3) var692!6)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegistry(org.apache.dubbo.config.RegistryConfig)>($r26) 

(declare-const var401!4 var2204)
(declare-const var692!7 var2651)
(define-const var1960 var1558 (var1558_valueOf/1602327315 (ite (= 1 0) true false))) ; Statement: $r29 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0) 
(assert true)
;(assert (setRegister/1766462515 (cast-from-var2204-to-var3458 var401!4) var1960)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegister(java.lang.Boolean)>($r29) 

(declare-const var401!5 var2204)
(declare-const var1960!1 var1558)
(assert true)
;(assert (setProtocol/-57857418 (cast-from-var2204-to-var3458 var401!5) var1074!3)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setProtocol(org.apache.dubbo.config.ProtocolConfig)>($r0) 

(declare-const var401!6 var2204)
(declare-const var1074!4 var1668)
(define-const var1013 Int (Int_valueOf/-1371140006 0)) ; Statement: $r30 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0) 
(assert true)
;(assert (setDelay/1793925547 (cast-from-var2204-to-var3458 var401!6) var1013)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setDelay(java.lang.Integer)>($r30) 

(declare-const var401!7 var2204)
(declare-const var1013!1 Int)
(define-const var3206 ClassObject (interfaceClass/1679408145 var2248!1)) ; Statement: $r31 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass> 
(assert true)
;(assert (setInterface/-223027320 (cast-from-var2204-to-var2473 var401!7) var3206)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setInterface(java.lang.Class)>($r31) 

(declare-const var401!8 var2204)
(declare-const var3206!1 ClassObject)
(define-const var3710 var3991 (ref/1679408145 var2248!1)) ; Statement: $r32 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Object ref> 
(assert true)
;(assert (setRef/-1853520609 (cast-from-var2204-to-var2473 var401!8) var3710)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRef(java.lang.Object)>($r32) 

(declare-const var401!9 var2204)
(declare-const var3710!1 var3991)
(assert true)
(define-const var1561 String (getName/922463553 var1524!1)) ; Statement: $r33 = virtualinvoke r22.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>() 
(assert true)
;(assert (setGroup/767739090 (cast-from-var2204-to-var3458 var401!9) var1561)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setGroup(java.lang.String)>($r33) 

(declare-const var401!10 var2204)
(declare-const var1561!1 String)
(define-const var1178 String (version/1679408145 var2248!1)) ; Statement: $r34 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String version> 
(define-const var120 Bool (var1208_isNotEmpty/-1251449450 var1178)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r34) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>("1.0.0") 
(assert (= (ite var120 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
;(assert (setVersion/28300825 (cast-from-var2204-to-var3458 var401!10) "1.0.0")) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>("1.0.0") 

(declare-const var401!11 var2204)
(declare-const var1789 String)
(assert true) ; Non Conditional
(assert true)
;(assert (setFilter/-549200969 (cast-from-var2204-to-var2944 var401!11) "-default")) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setFilter(java.lang.String)>("-default") 

(declare-const var401!12 var2204)
(declare-const var1190 String)
(define-const var1303 var3779 (executor/1679408145 var2248!1)) ; Statement: $r35 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.util.concurrent.Executor executor> 
(assert true)
;(assert (setExecutor/1452101433 (cast-from-var2204-to-var3458 var401!12) var1303)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setExecutor(java.util.concurrent.Executor)>($r35) 

(declare-const var401!13 var2204)
(declare-const var1303!1 var3779)
 ; Statement: if null == r36 goto return $r23 
(assert (= null-var1500 var3672)) ; Cond: null == r36 
 ; Statement: return $r23 
(check-sat)
; {var1668-init=([], org.apache.dubbo.config.ProtocolConfig), <init>/1138455297=([org.apache.dubbo.config.ProtocolConfig], void), protocol/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), setName/-777255745=([org.apache.dubbo.config.ProtocolConfig, java.lang.String], void), port/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.Integer), setPort/-255570608=([org.apache.dubbo.config.ProtocolConfig, java.lang.Integer], void), nullAssert/-1712169857=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], void), logger/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceClass/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), getPort/-726260002=([org.apache.dubbo.config.ProtocolConfig], java.lang.Integer), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var3991=([java.lang.Integer], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3094_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var588-to-var3094=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), applicationModel/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), getProtocol/-806407548=([org.apache.dubbo.config.context.ConfigManager, java.lang.String], java.util.Optional), var2746_bootstrap$/-1357636845=([org.apache.dubbo.config.ProtocolConfig], java.util.function.Consumer), ifPresent/-1974843347=([java.util.Optional, java.util.function.Consumer], void), getApplicationConfig/-1342331182=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.config.ApplicationConfig), var2204-init=([], org.apache.dubbo.config.ServiceConfig), <init>/-1544369510=([org.apache.dubbo.config.ServiceConfig], void), getInternalModule/890555230=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ModuleModel), setScopeModel/-330737779=([org.apache.dubbo.config.AbstractConfig, org.apache.dubbo.rpc.model.ScopeModel], void), cast-from-var2204-to-var650=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractConfig), cast-from-var2410-to-var2180=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), setApplication/-1646744778=([org.apache.dubbo.config.AbstractInterfaceConfig, org.apache.dubbo.config.ApplicationConfig], void), cast-from-var2204-to-var2944=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var2651-init=([], org.apache.dubbo.config.RegistryConfig), <init>/-1236919578=([org.apache.dubbo.config.RegistryConfig], void), refresh/-1420329662=([org.apache.dubbo.config.AbstractConfig], void), cast-from-var2651-to-var650=([org.apache.dubbo.config.RegistryConfig], org.apache.dubbo.config.AbstractConfig), setNeedRefresh/2137881272=([org.apache.dubbo.config.AbstractConfig, boolean], void), registryId/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), setId/369852133=([org.apache.dubbo.config.AbstractConfig, java.lang.String], void), setAddress/937761227=([org.apache.dubbo.config.RegistryConfig, java.lang.String], void), cast-from-var1177-to-var2180=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), setRegistry/2051566610=([org.apache.dubbo.config.AbstractInterfaceConfig, org.apache.dubbo.config.RegistryConfig], void), var1558_valueOf/1602327315=([boolean], java.lang.Boolean), setRegister/1766462515=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.Boolean], void), cast-from-var2204-to-var3458=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractServiceConfig), setProtocol/-57857418=([org.apache.dubbo.config.AbstractServiceConfig, org.apache.dubbo.config.ProtocolConfig], void), Int_valueOf/-1371140006=([int], java.lang.Integer), setDelay/1793925547=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.Integer], void), setInterface/-223027320=([org.apache.dubbo.config.ServiceConfigBase, java.lang.Class], void), cast-from-var2204-to-var2473=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), ref/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.Object), setRef/-1853520609=([org.apache.dubbo.config.ServiceConfigBase, java.lang.Object], void), getName/922463553=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), setGroup/767739090=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.String], void), version/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), var1208_isNotEmpty/-1251449450=([java.lang.String], boolean), setVersion/28300825=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.String], void), setFilter/-549200969=([org.apache.dubbo.config.AbstractInterfaceConfig, java.lang.String], void), executor/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.util.concurrent.Executor), setExecutor/1452101433=([org.apache.dubbo.config.AbstractServiceConfig, java.util.concurrent.Executor], void)}
; {var2124=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder, var2248=r1, var1500=java.util.function.Consumer, var3672=r36, var1668=org.apache.dubbo.config.ProtocolConfig, var1074=$r0, var2897=$r2, var3387=$r3, var588=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1618=$r5, var1380=$r4, var1123=$r7, var1841=$r6, var3034=$r8, var1550=$r11, var2510=$r9, var3562=$r10, var2625=$r12, var3403=$r14, var635=$r13, var3991=java.lang.Object, var3042=$r15, var1574=$r16, var3094=org.apache.dubbo.common.logger.Logger, var1177=org.apache.dubbo.rpc.model.ApplicationModel, var2286=$r17, var1506=org.apache.dubbo.config.context.ConfigManager, var3792=$r19, var2315=$r18, var2058=java.util.Optional, var1285=$r21, var2746=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500, var3125=$r20, var465=org.apache.dubbo.config.ApplicationConfig, var1524=r22, var2204=org.apache.dubbo.config.ServiceConfig, var401=$r23, var3724=$r24, var2410=org.apache.dubbo.rpc.model.ModuleModel, var537=$r25, var650=org.apache.dubbo.config.AbstractConfig, var2180=org.apache.dubbo.rpc.model.ScopeModel, var2944=org.apache.dubbo.config.AbstractInterfaceConfig, var2651=org.apache.dubbo.config.RegistryConfig, var692=$r26, var836=0, var375=$r27, var3080="N/A", var2157=$r28, var1558=java.lang.Boolean, var1960=$r29, var3458=org.apache.dubbo.config.AbstractServiceConfig, var1013=$r30, var3206=$r31, var2473=org.apache.dubbo.config.ServiceConfigBase, var3710=$r32, var1561=$r33, var1178=$r34, var1208=org.apache.dubbo.common.utils.StringUtils, var120=$z0, var1789="1.0.0", var1190="-default", var3779=java.util.concurrent.Executor, var1303=$r35}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder=var2124, r1=var2248, java.util.function.Consumer=var1500, r36=var3672, org.apache.dubbo.config.ProtocolConfig=var1668, $r0=var1074, $r2=var2897, $r3=var3387, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var588, $r5=var1618, $r4=var1380, $r7=var1123, $r6=var1841, $r8=var3034, $r11=var1550, $r9=var2510, $r10=var3562, $r12=var2625, $r14=var3403, $r13=var635, java.lang.Object=var3991, $r15=var3042, $r16=var1574, org.apache.dubbo.common.logger.Logger=var3094, org.apache.dubbo.rpc.model.ApplicationModel=var1177, $r17=var2286, org.apache.dubbo.config.context.ConfigManager=var1506, $r19=var3792, $r18=var2315, java.util.Optional=var2058, $r21=var1285, org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500=var2746, $r20=var3125, org.apache.dubbo.config.ApplicationConfig=var465, r22=var1524, org.apache.dubbo.config.ServiceConfig=var2204, $r23=var401, $r24=var3724, org.apache.dubbo.rpc.model.ModuleModel=var2410, $r25=var537, org.apache.dubbo.config.AbstractConfig=var650, org.apache.dubbo.rpc.model.ScopeModel=var2180, org.apache.dubbo.config.AbstractInterfaceConfig=var2944, org.apache.dubbo.config.RegistryConfig=var2651, $r26=var692, 0=var836, $r27=var375, "N/A"=var3080, $r28=var2157, java.lang.Boolean=var1558, $r29=var1960, org.apache.dubbo.config.AbstractServiceConfig=var3458, $r30=var1013, $r31=var3206, org.apache.dubbo.config.ServiceConfigBase=var2473, $r32=var3710, $r33=var1561, $r34=var1178, org.apache.dubbo.common.utils.StringUtils=var1208, $z0=var120, "1.0.0"=var1789, "-default"=var1190, java.util.concurrent.Executor=var3779, $r35=var1303}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder;	r36 := @parameter0: java.util.function.Consumer;	$r0 = new org.apache.dubbo.config.ProtocolConfig;	specialinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void <init>()>();	$r2 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol>;	virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setName(java.lang.String)>($r2);	$r3 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Integer port>;	virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setPort(java.lang.Integer)>($r3);	specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: void nullAssert()>();	$r5 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Using ");	$r6 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" protocol to export ");	$r9 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass>;	$r10 = virtualinvoke $r9.<java.lang.Class: java.lang.String getName()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" service on port ");	$r13 = virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.Integer getPort()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r16);	$r17 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r19 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	$r18 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol>;	$r21 = virtualinvoke $r19.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getProtocol(java.lang.String)>($r18);	$r20 = staticinvoke <org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.ProtocolConfig)>($r0);	virtualinvoke $r21.<java.util.Optional: void ifPresent(java.util.function.Consumer)>($r20);	r22 = specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.ApplicationConfig getApplicationConfig()>();	$r23 = new org.apache.dubbo.config.ServiceConfig;	specialinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void <init>()>();	$r24 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r25 = virtualinvoke $r24.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r25);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setApplication(org.apache.dubbo.config.ApplicationConfig)>(r22);	$r26 = new org.apache.dubbo.config.RegistryConfig;	specialinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void <init>()>();	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void refresh()>();	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setNeedRefresh(boolean)>(0);	$r27 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String registryId>;	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setId(java.lang.String)>($r27);	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setAddress(java.lang.String)>("N/A");	$r28 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r28);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegistry(org.apache.dubbo.config.RegistryConfig)>($r26);	$r29 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegister(java.lang.Boolean)>($r29);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setProtocol(org.apache.dubbo.config.ProtocolConfig)>($r0);	$r30 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setDelay(java.lang.Integer)>($r30);	$r31 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setInterface(java.lang.Class)>($r31);	$r32 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Object ref>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRef(java.lang.Object)>($r32);	$r33 = virtualinvoke r22.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>();	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setGroup(java.lang.String)>($r33);	$r34 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String version>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r34);	if $z0 == 0 goto virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>("1.0.0");	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>("1.0.0");	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setFilter(java.lang.String)>("-default");	$r35 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.util.concurrent.Executor executor>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setExecutor(java.util.concurrent.Executor)>($r35);	if null == r36 goto return $r23;	return $r23
;block_num 4