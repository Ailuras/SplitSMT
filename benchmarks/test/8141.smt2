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

(declare-sort var2709 0)
(declare-sort var1788 0)
(declare-sort var2460 0)
(declare-sort var3593 0)
(declare-sort var997 0)
(declare-sort var2323 0)
(declare-sort var405 0)
(declare-sort var2963 0)
(declare-sort var3560 0)
(declare-sort var1560 0)
(declare-sort var3518 0)
(declare-sort var619 0)
(declare-sort var3072 0)
(declare-sort var1146 0)
(declare-sort var3968 0)
(declare-sort var3232 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1788-init () var1788)
(declare-fun <init>/613807010 (var1788 Int) void)
(declare-fun interfaceName/2049477907 (var2460) String)
(declare-fun cast-from-var2709-to-var2460 (var2709) var2460)
(declare-fun var3593_put/1464166817 (var3593 var997 var997) var997)
(declare-fun cast-from-var1788-to-var3593 (var1788) var3593)
(declare-fun cast-from-String-to-var997 (String) var997)
(declare-fun var2460_appendRuntimeParameters/596205890 (var3593) void)
(declare-fun generic/974719397 (var2323) String)
(declare-fun cast-from-var2709-to-var2323 (var2709) var2323)
(declare-fun var405_isGeneric/-443667814 (String) Bool)
(declare-fun getApplication/-260200206 (var2460) var2963)
(declare-fun var3560_appendParameters/-678393988 (var3593 var997) void)
(declare-fun cast-from-var2963-to-var997 (var2963) var997)
(declare-fun getModule/-1066595094 (var2460) var1560)
(declare-fun cast-from-var1560-to-var997 (var1560) var997)
(declare-fun consumer/1800549272 (var619) var3518)
(declare-fun cast-from-var2709-to-var619 (var2709) var619)
(declare-fun cast-from-var3518-to-var997 (var3518) var997)
(declare-fun cast-from-var2709-to-var997 (var2709) var997)
(declare-fun var3072_getSystemProperty/1777521604 (String) String)
(declare-fun var1146_isEmpty/-813097145 (String) Bool)
(declare-fun var3968_isInvalidLocalHost/244948788 (String) Bool)
(declare-fun var3232-init () var3232)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3232 String) void)
(declare-const null-var2709 var2709)
(declare-const var355 var2709) ; Statement: r1 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var355 null-var2709)))
(define-const var920 var1788 var1788-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var920 16)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>(int)>(16) 

(declare-const var920!1 var1788)
(declare-const var2844 Int)
(define-const var1556 String (interfaceName/2049477907 (cast-from-var2709-to-var2460 var355))) ; Statement: $r2 = r1.<org.apache.dubbo.config.ReferenceConfig: java.lang.String interfaceName> 
;(assert (var3593_put/1464166817 (cast-from-var1788-to-var3593 var920!1) (cast-from-String-to-var997 "interface") (cast-from-String-to-var997 var1556))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r2) 

(declare-const var920!2 var1788)
(declare-const var1420 String)
(declare-const var1556!1 String)
;(assert (var3593_put/1464166817 (cast-from-var1788-to-var3593 var920!2) (cast-from-String-to-var997 "side") (cast-from-String-to-var997 "consumer"))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("side", "consumer") 

(declare-const var920!3 var1788)
(declare-const var2103 String)
(declare-const var3868 String)
;(assert (var2460_appendRuntimeParameters/596205890 (cast-from-var1788-to-var3593 var920!3))) ; Statement: staticinvoke <org.apache.dubbo.config.ReferenceConfigBase: void appendRuntimeParameters(java.util.Map)>($r0) 

(declare-const var920!4 var1788)
(define-const var522 String (generic/974719397 (cast-from-var2709-to-var2323 var355))) ; Statement: $r3 = r1.<org.apache.dubbo.config.ReferenceConfig: java.lang.String generic> 
(define-const var3196 Bool (var405_isGeneric/-443667814 var522)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>($r3) 
 ; Statement: if $z0 != 0 goto $r42 = virtualinvoke r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ApplicationConfig getApplication()>() 
(assert (not (= (ite var3196 1 0) 0))) ; Cond: $z0 != 0 
(assert true)
(define-const var1846 var2963 (getApplication/-260200206 (cast-from-var2709-to-var2460 var355))) ; Statement: $r42 = virtualinvoke r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ApplicationConfig getApplication()>() 
;(assert (var3560_appendParameters/-678393988 (cast-from-var1788-to-var3593 var920!4) (cast-from-var2963-to-var997 var1846))) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, $r42) 

(declare-const var920!5 var1788)
(declare-const var1846!1 var2963)
(assert true)
(define-const var867 var1560 (getModule/-1066595094 (cast-from-var2709-to-var2460 var355))) ; Statement: $r43 = virtualinvoke r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ModuleConfig getModule()>() 
;(assert (var3560_appendParameters/-678393988 (cast-from-var1788-to-var3593 var920!5) (cast-from-var1560-to-var997 var867))) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, $r43) 

(declare-const var920!6 var1788)
(declare-const var867!1 var1560)
(define-const var3077 var3518 (consumer/1800549272 (cast-from-var2709-to-var619 var355))) ; Statement: $r44 = r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ConsumerConfig consumer> 
;(assert (var3560_appendParameters/-678393988 (cast-from-var1788-to-var3593 var920!6) (cast-from-var3518-to-var997 var3077))) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, $r44) 

(declare-const var920!7 var1788)
(declare-const var3077!1 var3518)
;(assert (var3560_appendParameters/-678393988 (cast-from-var1788-to-var3593 var920!7) (cast-from-var2709-to-var997 var355))) ; Statement: staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, r1) 

(declare-const var920!8 var1788)
(declare-const var355!1 var2709)
(define-const var2759 String (var3072_getSystemProperty/1777521604 "DUBBO_IP_TO_REGISTRY")) ; Statement: $r45 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("DUBBO_IP_TO_REGISTRY") 
(define-const var2155 String var2759) ; Statement: r46 = $r45 
(define-const var150 Bool (var1146_isEmpty/-813097145 var2759)) ; Statement: $z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r45) 
 ; Statement: if $z7 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>($r45) 
(assert (= (ite var150 1 0) 0)) ; Cond: $z7 == 0 
(define-const var345 Bool (var3968_isInvalidLocalHost/244948788 var2759)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>($r45) 
 ; Statement: if $z1 == 0 goto interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("register.ip", r46) 
(assert (not (= (ite var345 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2404 var3232 var3232-init) ; Statement: $r22 = new java.lang.IllegalArgumentException 
(define-const var1803 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1803)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1803!1 String)
(assert (= var1803!1 ""))
(assert true)
(define-const var2192 String (append/672562846 var1803!1 "Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:") 
(declare-const var1803!2 String)
(assert (= var1803!2 (str.++ var1803!1 "Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:")))
(assert true)
(define-const var667 String (append/672562846 var2192 var2759)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r45) 
(declare-const var2192!1 String)
(assert (= var2192!1 (str.++ var2192 var2759)))
(assert true)
(define-const var1286 String (toString/-2075883882 var667)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2404 var1286)) ; Statement: specialinvoke $r22.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r26) 

(declare-const var2404!1 var3232)
(declare-const var1286!1 String)
 ; Statement: throw $r22 
(check-sat)
; {var1788-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var2709-to-var2460=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var3593_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-var1788-to-var3593=([java.util.HashMap], java.util.Map), cast-from-String-to-var997=([java.lang.String], java.lang.Object), var2460_appendRuntimeParameters/596205890=([java.util.Map], void), generic/974719397=([org.apache.dubbo.config.AbstractReferenceConfig], java.lang.String), cast-from-var2709-to-var2323=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractReferenceConfig), var405_isGeneric/-443667814=([java.lang.String], boolean), getApplication/-260200206=([org.apache.dubbo.config.AbstractInterfaceConfig], org.apache.dubbo.config.ApplicationConfig), var3560_appendParameters/-678393988=([java.util.Map, java.lang.Object], void), cast-from-var2963-to-var997=([org.apache.dubbo.config.ApplicationConfig], java.lang.Object), getModule/-1066595094=([org.apache.dubbo.config.AbstractInterfaceConfig], org.apache.dubbo.config.ModuleConfig), cast-from-var1560-to-var997=([org.apache.dubbo.config.ModuleConfig], java.lang.Object), consumer/1800549272=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.ConsumerConfig), cast-from-var2709-to-var619=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.ReferenceConfigBase), cast-from-var3518-to-var997=([org.apache.dubbo.config.ConsumerConfig], java.lang.Object), cast-from-var2709-to-var997=([org.apache.dubbo.config.ReferenceConfig], java.lang.Object), var3072_getSystemProperty/1777521604=([java.lang.String], java.lang.String), var1146_isEmpty/-813097145=([java.lang.String], boolean), var3968_isInvalidLocalHost/244948788=([java.lang.String], boolean), var3232-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2709=org.apache.dubbo.config.ReferenceConfig, var355=r1, var1788=java.util.HashMap, var920=$r0, var2844=16, var2460=org.apache.dubbo.config.AbstractInterfaceConfig, var1556=$r2, var3593=java.util.Map, var997=java.lang.Object, var1420="interface", var2103="side", var3868="consumer", var2323=org.apache.dubbo.config.AbstractReferenceConfig, var522=$r3, var405=org.apache.dubbo.rpc.support.ProtocolUtils, var3196=$z0, var2963=org.apache.dubbo.config.ApplicationConfig, var1846=$r42, var3560=org.apache.dubbo.config.AbstractConfig, var1560=org.apache.dubbo.config.ModuleConfig, var867=$r43, var3518=org.apache.dubbo.config.ConsumerConfig, var619=org.apache.dubbo.config.ReferenceConfigBase, var3077=$r44, var3072=org.apache.dubbo.common.utils.ConfigUtils, var2759=$r45, var2155=r46, var1146=org.apache.dubbo.common.utils.StringUtils, var150=$z7, var3968=org.apache.dubbo.common.utils.NetUtils, var345=$z1, var3232=java.lang.IllegalArgumentException, var2404=$r22, var1803=$r23, var2192=$r24, var667=$r25, var1286=$r26}
; {org.apache.dubbo.config.ReferenceConfig=var2709, r1=var355, java.util.HashMap=var1788, $r0=var920, 16=var2844, org.apache.dubbo.config.AbstractInterfaceConfig=var2460, $r2=var1556, java.util.Map=var3593, java.lang.Object=var997, "interface"=var1420, "side"=var2103, "consumer"=var3868, org.apache.dubbo.config.AbstractReferenceConfig=var2323, $r3=var522, org.apache.dubbo.rpc.support.ProtocolUtils=var405, $z0=var3196, org.apache.dubbo.config.ApplicationConfig=var2963, $r42=var1846, org.apache.dubbo.config.AbstractConfig=var3560, org.apache.dubbo.config.ModuleConfig=var1560, $r43=var867, org.apache.dubbo.config.ConsumerConfig=var3518, org.apache.dubbo.config.ReferenceConfigBase=var619, $r44=var3077, org.apache.dubbo.common.utils.ConfigUtils=var3072, $r45=var2759, r46=var2155, org.apache.dubbo.common.utils.StringUtils=var1146, $z7=var150, org.apache.dubbo.common.utils.NetUtils=var3968, $z1=var345, java.lang.IllegalArgumentException=var3232, $r22=var2404, $r23=var1803, $r24=var2192, $r25=var667, $r26=var1286}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.config.ReferenceConfig;	$r0 = new java.util.HashMap;	specialinvoke $r0.<java.util.HashMap: void <init>(int)>(16);	$r2 = r1.<org.apache.dubbo.config.ReferenceConfig: java.lang.String interfaceName>;	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("interface", $r2);	interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("side", "consumer");	staticinvoke <org.apache.dubbo.config.ReferenceConfigBase: void appendRuntimeParameters(java.util.Map)>($r0);	$r3 = r1.<org.apache.dubbo.config.ReferenceConfig: java.lang.String generic>;	$z0 = staticinvoke <org.apache.dubbo.rpc.support.ProtocolUtils: boolean isGeneric(java.lang.String)>($r3);	if $z0 != 0 goto $r42 = virtualinvoke r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ApplicationConfig getApplication()>();	$r42 = virtualinvoke r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ApplicationConfig getApplication()>();	staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, $r42);	$r43 = virtualinvoke r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ModuleConfig getModule()>();	staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, $r43);	$r44 = r1.<org.apache.dubbo.config.ReferenceConfig: org.apache.dubbo.config.ConsumerConfig consumer>;	staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, $r44);	staticinvoke <org.apache.dubbo.config.AbstractConfig: void appendParameters(java.util.Map,java.lang.Object)>($r0, r1);	$r45 = staticinvoke <org.apache.dubbo.common.utils.ConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("DUBBO_IP_TO_REGISTRY");	r46 = $r45;	$z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r45);	if $z7 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>($r45);	$z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean isInvalidLocalHost(java.lang.String)>($r45);	if $z1 == 0 goto interfaceinvoke $r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("register.ip", r46);	$r22 = new java.lang.IllegalArgumentException;	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Specified invalid registry ip from property:DUBBO_IP_TO_REGISTRY, value:");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r45);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r22.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r26);	throw $r22
;block_num 4