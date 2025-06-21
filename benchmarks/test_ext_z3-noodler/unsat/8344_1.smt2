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

(declare-sort var2780 0)
(declare-sort var2465 0)
(declare-sort var1921 0)
(declare-sort var1378 0)
(declare-sort var548 0)
(declare-sort var416 0)
(declare-sort var493 0)
(declare-sort var2574 0)
(declare-sort var3077 0)
(declare-sort var1197 0)
(declare-sort var3590 0)
(declare-sort var2343 0)
(declare-sort var2857 0)
(declare-sort var2983 0)
(declare-sort var1535 0)
(declare-sort var2525 0)
(declare-sort var773 0)
(declare-sort var2678 0)
(declare-sort var3864 0)
(declare-sort var1757 0)
(declare-sort var747 0)
(declare-sort var3406 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1921-init () var1921)
(declare-fun <init>/1138455297 (var1921) void)
(declare-fun protocol/1679408145 (var2780) String)
(declare-fun setName/-777255745 (var1921 String) void)
(declare-fun port/1679408145 (var2780) Int)
(declare-fun setPort/-255570608 (var1921 Int) void)
(declare-fun nullAssert/-1712169857 (var2780) void)
(declare-fun logger/1679408145 (var2780) var1378)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceClass/1679408145 (var2780) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun getPort/-726260002 (var1921) Int)
(declare-fun append/-1031950772 (String var548) String)
(declare-fun cast-from-Int-to-var548 (Int) var548)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var416_info/484404803 (var416 String) void)
(declare-fun cast-from-var1378-to-var416 (var1378) var416)
(declare-fun applicationModel/1679408145 (var2780) var493)
(declare-fun getApplicationConfigManager/1850072349 (var493) var2574)
(declare-fun getProtocol/-806407548 (var2574 String) var3077)
(declare-fun var1197_bootstrap$/-1357636845 (var1921) var2465)
(declare-fun ifPresent/-1974843347 (var3077 var2465) void)
(declare-fun getApplicationConfig/-1342331182 (var2780) var3590)
(declare-fun var2343-init () var2343)
(declare-fun <init>/-1544369510 (var2343) void)
(declare-fun getInternalModule/890555230 (var493) var2857)
(declare-fun setScopeModel/-330737779 (var2983 var1535) void)
(declare-fun cast-from-var2343-to-var2983 (var2343) var2983)
(declare-fun cast-from-var2857-to-var1535 (var2857) var1535)
(declare-fun setApplication/-1646744778 (var2525 var3590) void)
(declare-fun cast-from-var2343-to-var2525 (var2343) var2525)
(declare-fun var773-init () var773)
(declare-fun <init>/-1236919578 (var773) void)
(declare-fun refresh/-1420329662 (var2983) void)
(declare-fun cast-from-var773-to-var2983 (var773) var2983)
(declare-fun setNeedRefresh/2137881272 (var2983 Bool) void)
(declare-fun registryId/1679408145 (var2780) String)
(declare-fun setId/369852133 (var2983 String) void)
(declare-fun setAddress/937761227 (var773 String) void)
(declare-fun cast-from-var493-to-var1535 (var493) var1535)
(declare-fun setRegistry/2051566610 (var2525 var773) void)
(declare-fun var2678_valueOf/1602327315 (Bool) var2678)
(declare-fun setRegister/1766462515 (var3864 var2678) void)
(declare-fun cast-from-var2343-to-var3864 (var2343) var3864)
(declare-fun setProtocol/-57857418 (var3864 var1921) void)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun setDelay/1793925547 (var3864 Int) void)
(declare-fun setInterface/-223027320 (var1757 ClassObject) void)
(declare-fun cast-from-var2343-to-var1757 (var2343) var1757)
(declare-fun ref/1679408145 (var2780) var548)
(declare-fun setRef/-1853520609 (var1757 var548) void)
(declare-fun getName/922463553 (var3590) String)
(declare-fun setGroup/767739090 (var3864 String) void)
(declare-fun version/1679408145 (var2780) String)
(declare-fun var747_isNotEmpty/-1251449450 (String) Bool)
(declare-fun setVersion/28300825 (var3864 String) void)
(declare-fun setFilter/-549200969 (var2525 String) void)
(declare-fun executor/1679408145 (var2780) var3406)
(declare-fun setExecutor/1452101433 (var3864 var3406) void)
(declare-const null-var2780 var2780)
(declare-const null-var2465 var2465)
(declare-const var830 var2780) ; Statement: r1 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder 
(assert (not (= var830 null-var2780)))
(declare-const var1930 var2465) ; Statement: r36 := @parameter0: java.util.function.Consumer 
(assert (not (= var1930 null-var2465)))
(define-const var3249 var1921 var1921-init) ; Statement: $r0 = new org.apache.dubbo.config.ProtocolConfig 
(assert true)
;(assert (<init>/1138455297 var3249)) ; Statement: specialinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void <init>()>() 

(declare-const var3249!1 var1921)
(define-const var2415 String (protocol/1679408145 var830)) ; Statement: $r2 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> 
(assert true)
;(assert (setName/-777255745 var3249!1 var2415)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setName(java.lang.String)>($r2) 

(declare-const var3249!2 var1921)
(declare-const var2415!1 String)
(define-const var1259 Int (port/1679408145 var830)) ; Statement: $r3 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Integer port> 
(assert true)
;(assert (setPort/-255570608 var3249!2 var1259)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setPort(java.lang.Integer)>($r3) 

(declare-const var3249!3 var1921)
(declare-const var1259!1 Int)
(assert true)
;(assert (nullAssert/-1712169857 var830)) ; Statement: specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: void nullAssert()>() 

(declare-const var830!1 var2780)
(define-const var2922 var1378 (logger/1679408145 var830!1)) ; Statement: $r5 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2100 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2100)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2100!1 String)
(assert (= var2100!1 ""))
(assert true)
(define-const var2968 String (append/672562846 var2100!1 "Using ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Using ") 
(declare-const var2100!2 String)
(assert (= var2100!2 (str.++ var2100!1 "Using ")))
(define-const var1471 String (protocol/1679408145 var830!1)) ; Statement: $r6 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> 
(assert true)
(define-const var2113 String (append/672562846 var2968 var1471)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2968!1 String)
(assert (= var2968!1 (str.++ var2968 var1471)))
(assert true)
(define-const var299 String (append/672562846 var2113 " protocol to export ")) ; Statement: $r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" protocol to export ") 
(declare-const var2113!1 String)
(assert (= var2113!1 (str.++ var2113 " protocol to export ")))
(define-const var2190 ClassObject (interfaceClass/1679408145 var830!1)) ; Statement: $r9 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass> 
(assert true)
(define-const var1690 String (getName/-1958580599 var2190)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2215 String (append/672562846 var299 var1690)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var299!1 String)
(assert (= var299!1 (str.++ var299 var1690)))
(assert true)
(define-const var3979 String (append/672562846 var2215 " service on port ")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" service on port ") 
(declare-const var2215!1 String)
(assert (= var2215!1 (str.++ var2215 " service on port ")))
(assert true)
(define-const var3510 Int (getPort/-726260002 var3249!3)) ; Statement: $r13 = virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.Integer getPort()>() 
(assert true)
(define-const var1043 String (append/-1031950772 var3979 (cast-from-Int-to-var548 var3510))) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13) 
(declare-const var3979!1 String)
(assert (str.prefixof var3979 var3979!1))
(assert true)
(define-const var2444 String (toString/-2075883882 var1043)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var416_info/484404803 (cast-from-var1378-to-var416 var2922) var2444)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r16) 

(declare-const var2922!1 var1378)
(declare-const var2444!1 String)
(define-const var1127 var493 (applicationModel/1679408145 var830!1)) ; Statement: $r17 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var3825 var2574 (getApplicationConfigManager/1850072349 var1127)) ; Statement: $r19 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>() 
(define-const var3207 String (protocol/1679408145 var830!1)) ; Statement: $r18 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol> 
(assert true)
(define-const var3579 var3077 (getProtocol/-806407548 var3825 var3207)) ; Statement: $r21 = virtualinvoke $r19.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getProtocol(java.lang.String)>($r18) 
(define-const var2973 var2465 (var1197_bootstrap$/-1357636845 var3249!3)) ; Statement: $r20 = staticinvoke <org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.ProtocolConfig)>($r0) 
(assert true)
;(assert (ifPresent/-1974843347 var3579 var2973)) ; Statement: virtualinvoke $r21.<java.util.Optional: void ifPresent(java.util.function.Consumer)>($r20) 

(declare-const var3579!1 var3077)
(declare-const var2973!1 var2465)
(assert true)
(define-const var3117 var3590 (getApplicationConfig/-1342331182 var830!1)) ; Statement: r22 = specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.ApplicationConfig getApplicationConfig()>() 
(define-const var2823 var2343 var2343-init) ; Statement: $r23 = new org.apache.dubbo.config.ServiceConfig 
(assert true)
;(assert (<init>/-1544369510 var2823)) ; Statement: specialinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void <init>()>() 

(declare-const var2823!1 var2343)
(define-const var2632 var493 (applicationModel/1679408145 var830!1)) ; Statement: $r24 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
(define-const var1052 var2857 (getInternalModule/890555230 var2632)) ; Statement: $r25 = virtualinvoke $r24.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>() 
(assert true)
;(assert (setScopeModel/-330737779 (cast-from-var2343-to-var2983 var2823!1) (cast-from-var2857-to-var1535 var1052))) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r25) 

(declare-const var2823!2 var2343)
(declare-const var1052!1 var2857)
(assert true)
;(assert (setApplication/-1646744778 (cast-from-var2343-to-var2525 var2823!2) var3117)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setApplication(org.apache.dubbo.config.ApplicationConfig)>(r22) 

(declare-const var2823!3 var2343)
(declare-const var3117!1 var3590)
(define-const var164 var773 var773-init) ; Statement: $r26 = new org.apache.dubbo.config.RegistryConfig 
(assert true)
;(assert (<init>/-1236919578 var164)) ; Statement: specialinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void <init>()>() 

(declare-const var164!1 var773)
(assert true)
;(assert (refresh/-1420329662 (cast-from-var773-to-var2983 var164!1))) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void refresh()>() 

(declare-const var164!2 var773)
(assert true)
;(assert (setNeedRefresh/2137881272 (cast-from-var773-to-var2983 var164!2) (ite (= 1 0) true false))) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setNeedRefresh(boolean)>(0) 

(declare-const var164!3 var773)
(declare-const var3625 Int)
(define-const var2675 String (registryId/1679408145 var830!1)) ; Statement: $r27 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String registryId> 
(assert true)
;(assert (setId/369852133 (cast-from-var773-to-var2983 var164!3) var2675)) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setId(java.lang.String)>($r27) 

(declare-const var164!4 var773)
(declare-const var2675!1 String)
(assert true)
;(assert (setAddress/937761227 var164!4 "N/A")) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setAddress(java.lang.String)>("N/A") 

(declare-const var164!5 var773)
(declare-const var3042 String)
(define-const var1194 var493 (applicationModel/1679408145 var830!1)) ; Statement: $r28 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> 
(assert true)
;(assert (setScopeModel/-330737779 (cast-from-var773-to-var2983 var164!5) (cast-from-var493-to-var1535 var1194))) ; Statement: virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r28) 

(declare-const var164!6 var773)
(declare-const var1194!1 var493)
(assert true)
;(assert (setRegistry/2051566610 (cast-from-var2343-to-var2525 var2823!3) var164!6)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegistry(org.apache.dubbo.config.RegistryConfig)>($r26) 

(declare-const var2823!4 var2343)
(declare-const var164!7 var773)
(define-const var433 var2678 (var2678_valueOf/1602327315 (ite (= 1 0) true false))) ; Statement: $r29 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0) 
(assert true)
;(assert (setRegister/1766462515 (cast-from-var2343-to-var3864 var2823!4) var433)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegister(java.lang.Boolean)>($r29) 

(declare-const var2823!5 var2343)
(declare-const var433!1 var2678)
(assert true)
;(assert (setProtocol/-57857418 (cast-from-var2343-to-var3864 var2823!5) var3249!3)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setProtocol(org.apache.dubbo.config.ProtocolConfig)>($r0) 

(declare-const var2823!6 var2343)
(declare-const var3249!4 var1921)
(define-const var3906 Int (Int_valueOf/-1371140006 0)) ; Statement: $r30 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0) 
(assert true)
;(assert (setDelay/1793925547 (cast-from-var2343-to-var3864 var2823!6) var3906)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setDelay(java.lang.Integer)>($r30) 

(declare-const var2823!7 var2343)
(declare-const var3906!1 Int)
(define-const var2235 ClassObject (interfaceClass/1679408145 var830!1)) ; Statement: $r31 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass> 
(assert true)
;(assert (setInterface/-223027320 (cast-from-var2343-to-var1757 var2823!7) var2235)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setInterface(java.lang.Class)>($r31) 

(declare-const var2823!8 var2343)
(declare-const var2235!1 ClassObject)
(define-const var515 var548 (ref/1679408145 var830!1)) ; Statement: $r32 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Object ref> 
(assert true)
;(assert (setRef/-1853520609 (cast-from-var2343-to-var1757 var2823!8) var515)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRef(java.lang.Object)>($r32) 

(declare-const var2823!9 var2343)
(declare-const var515!1 var548)
(assert true)
(define-const var3187 String (getName/922463553 var3117!1)) ; Statement: $r33 = virtualinvoke r22.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>() 
(assert true)
;(assert (setGroup/767739090 (cast-from-var2343-to-var3864 var2823!9) var3187)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setGroup(java.lang.String)>($r33) 

(declare-const var2823!10 var2343)
(declare-const var3187!1 String)
(define-const var2635 String (version/1679408145 var830!1)) ; Statement: $r34 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String version> 
(define-const var2719 Bool (var747_isNotEmpty/-1251449450 var2635)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r34) 
 ; Statement: if $z0 == 0 goto virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>("1.0.0") 
(assert (not (= (ite var2719 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var895 String (version/1679408145 var830!1)) ; Statement: $r37 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String version> 
(assert true)
;(assert (setVersion/28300825 (cast-from-var2343-to-var3864 var2823!10) var895)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>($r37) 

(declare-const var2823!11 var2343)
(declare-const var895!1 String)
 ; Statement: goto [?= virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setFilter(java.lang.String)>("-default")] 
(assert true) ; Non Conditional
(assert true)
;(assert (setFilter/-549200969 (cast-from-var2343-to-var2525 var2823!11) "-default")) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setFilter(java.lang.String)>("-default") 

(declare-const var2823!12 var2343)
(declare-const var1608 String)
(define-const var3121 var3406 (executor/1679408145 var830!1)) ; Statement: $r35 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.util.concurrent.Executor executor> 
(assert true)
;(assert (setExecutor/1452101433 (cast-from-var2343-to-var3864 var2823!12) var3121)) ; Statement: virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setExecutor(java.util.concurrent.Executor)>($r35) 

(declare-const var2823!13 var2343)
(declare-const var3121!1 var3406)
 ; Statement: if null == r36 goto return $r23 
(assert (= null-var2465 var1930)) ; Cond: null == r36 
 ; Statement: return $r23 
(check-sat)
; {var1921-init=([], org.apache.dubbo.config.ProtocolConfig), <init>/1138455297=([org.apache.dubbo.config.ProtocolConfig], void), protocol/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), setName/-777255745=([org.apache.dubbo.config.ProtocolConfig, java.lang.String], void), port/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.Integer), setPort/-255570608=([org.apache.dubbo.config.ProtocolConfig, java.lang.Integer], void), nullAssert/-1712169857=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], void), logger/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceClass/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), getPort/-726260002=([org.apache.dubbo.config.ProtocolConfig], java.lang.Integer), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var548=([java.lang.Integer], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var416_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var1378-to-var416=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), applicationModel/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.rpc.model.ApplicationModel), getApplicationConfigManager/1850072349=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.config.context.ConfigManager), getProtocol/-806407548=([org.apache.dubbo.config.context.ConfigManager, java.lang.String], java.util.Optional), var1197_bootstrap$/-1357636845=([org.apache.dubbo.config.ProtocolConfig], java.util.function.Consumer), ifPresent/-1974843347=([java.util.Optional, java.util.function.Consumer], void), getApplicationConfig/-1342331182=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], org.apache.dubbo.config.ApplicationConfig), var2343-init=([], org.apache.dubbo.config.ServiceConfig), <init>/-1544369510=([org.apache.dubbo.config.ServiceConfig], void), getInternalModule/890555230=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ModuleModel), setScopeModel/-330737779=([org.apache.dubbo.config.AbstractConfig, org.apache.dubbo.rpc.model.ScopeModel], void), cast-from-var2343-to-var2983=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractConfig), cast-from-var2857-to-var1535=([org.apache.dubbo.rpc.model.ModuleModel], org.apache.dubbo.rpc.model.ScopeModel), setApplication/-1646744778=([org.apache.dubbo.config.AbstractInterfaceConfig, org.apache.dubbo.config.ApplicationConfig], void), cast-from-var2343-to-var2525=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var773-init=([], org.apache.dubbo.config.RegistryConfig), <init>/-1236919578=([org.apache.dubbo.config.RegistryConfig], void), refresh/-1420329662=([org.apache.dubbo.config.AbstractConfig], void), cast-from-var773-to-var2983=([org.apache.dubbo.config.RegistryConfig], org.apache.dubbo.config.AbstractConfig), setNeedRefresh/2137881272=([org.apache.dubbo.config.AbstractConfig, boolean], void), registryId/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), setId/369852133=([org.apache.dubbo.config.AbstractConfig, java.lang.String], void), setAddress/937761227=([org.apache.dubbo.config.RegistryConfig, java.lang.String], void), cast-from-var493-to-var1535=([org.apache.dubbo.rpc.model.ApplicationModel], org.apache.dubbo.rpc.model.ScopeModel), setRegistry/2051566610=([org.apache.dubbo.config.AbstractInterfaceConfig, org.apache.dubbo.config.RegistryConfig], void), var2678_valueOf/1602327315=([boolean], java.lang.Boolean), setRegister/1766462515=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.Boolean], void), cast-from-var2343-to-var3864=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractServiceConfig), setProtocol/-57857418=([org.apache.dubbo.config.AbstractServiceConfig, org.apache.dubbo.config.ProtocolConfig], void), Int_valueOf/-1371140006=([int], java.lang.Integer), setDelay/1793925547=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.Integer], void), setInterface/-223027320=([org.apache.dubbo.config.ServiceConfigBase, java.lang.Class], void), cast-from-var2343-to-var1757=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.ServiceConfigBase), ref/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.Object), setRef/-1853520609=([org.apache.dubbo.config.ServiceConfigBase, java.lang.Object], void), getName/922463553=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), setGroup/767739090=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.String], void), version/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.lang.String), var747_isNotEmpty/-1251449450=([java.lang.String], boolean), setVersion/28300825=([org.apache.dubbo.config.AbstractServiceConfig, java.lang.String], void), setFilter/-549200969=([org.apache.dubbo.config.AbstractInterfaceConfig, java.lang.String], void), executor/1679408145=([org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder], java.util.concurrent.Executor), setExecutor/1452101433=([org.apache.dubbo.config.AbstractServiceConfig, java.util.concurrent.Executor], void)}
; {var2780=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder, var830=r1, var2465=java.util.function.Consumer, var1930=r36, var1921=org.apache.dubbo.config.ProtocolConfig, var3249=$r0, var2415=$r2, var1259=$r3, var1378=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2922=$r5, var2100=$r4, var2968=$r7, var1471=$r6, var2113=$r8, var299=$r11, var2190=$r9, var1690=$r10, var2215=$r12, var3979=$r14, var3510=$r13, var548=java.lang.Object, var1043=$r15, var2444=$r16, var416=org.apache.dubbo.common.logger.Logger, var493=org.apache.dubbo.rpc.model.ApplicationModel, var1127=$r17, var2574=org.apache.dubbo.config.context.ConfigManager, var3825=$r19, var3207=$r18, var3077=java.util.Optional, var3579=$r21, var1197=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500, var2973=$r20, var3590=org.apache.dubbo.config.ApplicationConfig, var3117=r22, var2343=org.apache.dubbo.config.ServiceConfig, var2823=$r23, var2632=$r24, var2857=org.apache.dubbo.rpc.model.ModuleModel, var1052=$r25, var2983=org.apache.dubbo.config.AbstractConfig, var1535=org.apache.dubbo.rpc.model.ScopeModel, var2525=org.apache.dubbo.config.AbstractInterfaceConfig, var773=org.apache.dubbo.config.RegistryConfig, var164=$r26, var3625=0, var2675=$r27, var3042="N/A", var1194=$r28, var2678=java.lang.Boolean, var433=$r29, var3864=org.apache.dubbo.config.AbstractServiceConfig, var3906=$r30, var2235=$r31, var1757=org.apache.dubbo.config.ServiceConfigBase, var515=$r32, var3187=$r33, var2635=$r34, var747=org.apache.dubbo.common.utils.StringUtils, var2719=$z0, var895=$r37, var1608="-default", var3406=java.util.concurrent.Executor, var3121=$r35}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder=var2780, r1=var830, java.util.function.Consumer=var2465, r36=var1930, org.apache.dubbo.config.ProtocolConfig=var1921, $r0=var3249, $r2=var2415, $r3=var1259, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1378, $r5=var2922, $r4=var2100, $r7=var2968, $r6=var1471, $r8=var2113, $r11=var299, $r9=var2190, $r10=var1690, $r12=var2215, $r14=var3979, $r13=var3510, java.lang.Object=var548, $r15=var1043, $r16=var2444, org.apache.dubbo.common.logger.Logger=var416, org.apache.dubbo.rpc.model.ApplicationModel=var493, $r17=var1127, org.apache.dubbo.config.context.ConfigManager=var2574, $r19=var3825, $r18=var3207, java.util.Optional=var3077, $r21=var3579, org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500=var1197, $r20=var2973, org.apache.dubbo.config.ApplicationConfig=var3590, r22=var3117, org.apache.dubbo.config.ServiceConfig=var2343, $r23=var2823, $r24=var2632, org.apache.dubbo.rpc.model.ModuleModel=var2857, $r25=var1052, org.apache.dubbo.config.AbstractConfig=var2983, org.apache.dubbo.rpc.model.ScopeModel=var1535, org.apache.dubbo.config.AbstractInterfaceConfig=var2525, org.apache.dubbo.config.RegistryConfig=var773, $r26=var164, 0=var3625, $r27=var2675, "N/A"=var3042, $r28=var1194, java.lang.Boolean=var2678, $r29=var433, org.apache.dubbo.config.AbstractServiceConfig=var3864, $r30=var3906, $r31=var2235, org.apache.dubbo.config.ServiceConfigBase=var1757, $r32=var515, $r33=var3187, $r34=var2635, org.apache.dubbo.common.utils.StringUtils=var747, $z0=var2719, $r37=var895, "-default"=var1608, java.util.concurrent.Executor=var3406, $r35=var3121}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder;	r36 := @parameter0: java.util.function.Consumer;	$r0 = new org.apache.dubbo.config.ProtocolConfig;	specialinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void <init>()>();	$r2 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol>;	virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setName(java.lang.String)>($r2);	$r3 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Integer port>;	virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: void setPort(java.lang.Integer)>($r3);	specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: void nullAssert()>();	$r5 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Using ");	$r6 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r11 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" protocol to export ");	$r9 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass>;	$r10 = virtualinvoke $r9.<java.lang.Class: java.lang.String getName()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" service on port ");	$r13 = virtualinvoke $r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.Integer getPort()>();	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r16);	$r17 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r19 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.config.context.ConfigManager getApplicationConfigManager()>();	$r18 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String protocol>;	$r21 = virtualinvoke $r19.<org.apache.dubbo.config.context.ConfigManager: java.util.Optional getProtocol(java.lang.String)>($r18);	$r20 = staticinvoke <org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$lambda_build_5__500: java.util.function.Consumer bootstrap$(org.apache.dubbo.config.ProtocolConfig)>($r0);	virtualinvoke $r21.<java.util.Optional: void ifPresent(java.util.function.Consumer)>($r20);	r22 = specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.config.ApplicationConfig getApplicationConfig()>();	$r23 = new org.apache.dubbo.config.ServiceConfig;	specialinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void <init>()>();	$r24 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	$r25 = virtualinvoke $r24.<org.apache.dubbo.rpc.model.ApplicationModel: org.apache.dubbo.rpc.model.ModuleModel getInternalModule()>();	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r25);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setApplication(org.apache.dubbo.config.ApplicationConfig)>(r22);	$r26 = new org.apache.dubbo.config.RegistryConfig;	specialinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void <init>()>();	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void refresh()>();	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setNeedRefresh(boolean)>(0);	$r27 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String registryId>;	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setId(java.lang.String)>($r27);	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setAddress(java.lang.String)>("N/A");	$r28 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: org.apache.dubbo.rpc.model.ApplicationModel applicationModel>;	virtualinvoke $r26.<org.apache.dubbo.config.RegistryConfig: void setScopeModel(org.apache.dubbo.rpc.model.ScopeModel)>($r28);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegistry(org.apache.dubbo.config.RegistryConfig)>($r26);	$r29 = staticinvoke <java.lang.Boolean: java.lang.Boolean valueOf(boolean)>(0);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRegister(java.lang.Boolean)>($r29);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setProtocol(org.apache.dubbo.config.ProtocolConfig)>($r0);	$r30 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(0);	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setDelay(java.lang.Integer)>($r30);	$r31 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Class interfaceClass>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setInterface(java.lang.Class)>($r31);	$r32 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.Object ref>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setRef(java.lang.Object)>($r32);	$r33 = virtualinvoke r22.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>();	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setGroup(java.lang.String)>($r33);	$r34 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String version>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r34);	if $z0 == 0 goto virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>("1.0.0");	$r37 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.lang.String version>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setVersion(java.lang.String)>($r37);	goto [?= virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setFilter(java.lang.String)>("-default")];	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setFilter(java.lang.String)>("-default");	$r35 = r1.<org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder: java.util.concurrent.Executor executor>;	virtualinvoke $r23.<org.apache.dubbo.config.ServiceConfig: void setExecutor(java.util.concurrent.Executor)>($r35);	if null == r36 goto return $r23;	return $r23
;block_num 4