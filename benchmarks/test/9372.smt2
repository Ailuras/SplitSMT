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

(declare-sort var2585 0)
(declare-sort var1537 0)
(declare-sort var3648 0)
(declare-sort var259 0)
(declare-sort var2293 0)
(declare-sort var2931 0)
(declare-sort var3335 0)
(declare-sort var3970 0)
(declare-sort var2836 0)
(declare-sort var2835 0)
(declare-sort var2560 0)
(declare-sort var835 0)
(declare-sort var1903 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var259) void)
(declare-fun cast-from-var2585-to-var259 (var2585) var259)
(declare-fun var2293-init () var2293)
(declare-fun <init>/-2175807 (var2293) void)
(declare-fun cast-from-var2293-to-var2931 (var2293) var2931)
(declare-fun listeners/-775390699 (var2585) var2931)
(declare-fun url/-775390699 (var2585) var1537)
(declare-fun applicationModel/-775390699 (var2585) var3648)
(declare-fun getParameter/-1307325648 (var1537 String) String)
(declare-fun getAddressWithProtocolPrefix/-818322071 (var2585 var1537) String)
(declare-fun var3335_getSystemProperty/1393069448 (String) String)
(declare-fun var3970_isEmpty/-813097145 (String) Bool)
(declare-fun getParameter/506106603 (var1537 String String) String)
(declare-fun var2835_getConfig/1309559845 (String) var2836)
(declare-fun dubboConfig/-775390699 (var2585) var2836)
(declare-fun var2835_getConfigFile/-1400254899 (String var2560) var835)
(declare-fun dubboConfigFile/-775390699 (var2585) var835)
(declare-fun getParameter/2144001655 (var1537 String Bool) Bool)
(declare-fun var2836_getSourceType/23764747 (var2836) var1903)
(declare-const null-var2585 var2585)
(declare-const null-var1537 var1537)
(declare-const null-var3648 var3648)
(declare-const var2560-Properties var2560)
(declare-const var1903-REMOTE var1903)
(declare-const var923 var2585) ; Statement: r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var923 null-var2585)))
(declare-const var424 var1537) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var424 null-var1537)))
(declare-const var3965 var3648) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var3965 null-var3648)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var2585-to-var259 var923))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var923!1 var2585)
(define-const var2077 var2293 var2293-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var2077)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var2077!1 var2293)
(declare-const var923!2 var2585)
(assert (not (= var923!2 null-var2585)))
(assert (= (listeners/-775390699 var923!2) (cast-from-var2293-to-var2931 var2077!1))) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners> = $r1 
(declare-const var923!3 var2585)
(assert (not (= var923!3 null-var2585)))
(assert (= (url/-775390699 var923!3) var424)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.common.URL url> = r2 
(declare-const var923!4 var2585)
(assert (not (= var923!4 null-var2585)))
(assert (= (applicationModel/-775390699 var923!4) var3965)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> = r3 
(assert true)
(define-const var1519 String (getParameter/-1307325648 var424 "env")) ; Statement: r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("env") 
(assert true)
(define-const var3757 String (getAddressWithProtocolPrefix/-818322071 var923!4 var424)) ; Statement: r5 = specialinvoke r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.lang.String getAddressWithProtocolPrefix(org.apache.dubbo.common.URL)>(r2) 
(assert true)
(define-const var3050 String (getParameter/-1307325648 var424 "cluster")) ; Statement: r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("cluster") 
(assert true)
(define-const var1885 String (getParameter/-1307325648 var424 "app.id")) ; Statement: r7 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("app.id") 
(define-const var1795 String (var3335_getSystemProperty/1393069448 "env")) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("env") 
(define-const var1704 Bool (var3970_isEmpty/-813097145 var1795)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8) 
 ; Statement: if $z0 == 0 goto $r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta") 
(assert (= (ite var1704 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3368 String (var3335_getSystemProperty/1393069448 "apollo.meta")) ; Statement: $r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta") 
(define-const var6 Bool (var3970_isEmpty/-813097145 var3368)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28) 
 ; Statement: if $z5 == 0 goto $r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster") 
(assert (= (ite var6 1 0) 0)) ; Cond: $z5 == 0 
(define-const var565 String (var3335_getSystemProperty/1393069448 "apollo.cluster")) ; Statement: $r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster") 
(define-const var713 Bool (var3970_isEmpty/-813097145 var565)) ; Statement: $z6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r29) 
 ; Statement: if $z6 == 0 goto $r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id") 
(assert (= (ite var713 1 0) 0)) ; Cond: $z6 == 0 
(define-const var2259 String (var3335_getSystemProperty/1393069448 "app.id")) ; Statement: $r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id") 
(define-const var107 Bool (var3970_isEmpty/-813097145 var2259)) ; Statement: $z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r30) 
 ; Statement: if $z7 == 0 goto $r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo") 
(assert (= (ite var107 1 0) 0)) ; Cond: $z7 == 0 
(assert true)
(define-const var915 String (getParameter/506106603 var424 "namespace" "dubbo")) ; Statement: $r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo") 
(define-const var3772 Bool (var3970_isEmpty/-813097145 var915)) ; Statement: $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r31) 
 ; Statement: if $z8 == 0 goto $r32 = $r31 
(assert (= (ite var3772 1 0) 0)) ; Cond: $z8 == 0 
(define-const var491 String var915) ; Statement: $r32 = $r31 
(assert true) ; Non Conditional
(define-const var3402 var2836 (var2835_getConfig/1309559845 var491)) ; Statement: $r9 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.Config getConfig(java.lang.String)>($r32) 
(declare-const var923!5 var2585)
(assert (not (= var923!5 null-var2585)))
(assert (= (dubboConfig/-775390699 var923!5) var3402)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> = $r9 
(define-const var3696 var2560 var2560-Properties) ; Statement: $r10 = <com.ctrip.framework.apollo.core.enums.ConfigFileFormat: com.ctrip.framework.apollo.core.enums.ConfigFileFormat Properties> 
(define-const var1507 var835 (var2835_getConfigFile/-1400254899 var491 var3696)) ; Statement: $r11 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.ConfigFile getConfigFile(java.lang.String,com.ctrip.framework.apollo.core.enums.ConfigFileFormat)>($r32, $r10) 
(declare-const var923!6 var2585)
(assert (not (= var923!6 null-var2585)))
(assert (= (dubboConfigFile/-775390699 var923!6) var1507)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.ConfigFile dubboConfigFile> = $r11 
(assert true)
(define-const var1694 Bool (getParameter/2144001655 var424 "check" (ite (= 1 1) true false))) ; Statement: $z3 = virtualinvoke r2.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("check", 1) 
(define-const var1036 var2836 (dubboConfig/-775390699 var923!6)) ; Statement: $r12 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> 
(define-const var405 var1903 (var2836_getSourceType/23764747 var1036)) ; Statement: $r14 = interfaceinvoke $r12.<com.ctrip.framework.apollo.Config: com.ctrip.framework.apollo.enums.ConfigSourceType getSourceType()>() 
(define-const var1865 var1903 var1903-REMOTE) ; Statement: $r13 = <com.ctrip.framework.apollo.enums.ConfigSourceType: com.ctrip.framework.apollo.enums.ConfigSourceType REMOTE> 
 ; Statement: if $r14 == $r13 goto return 
(assert (= var405 var1865)) ; Cond: $r14 == $r13 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var2585-to-var259=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], java.lang.Object), var2293-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var2293-to-var2931=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), listeners/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], java.util.concurrent.ConcurrentMap), url/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], org.apache.dubbo.common.URL), applicationModel/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], org.apache.dubbo.rpc.model.ApplicationModel), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getAddressWithProtocolPrefix/-818322071=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, org.apache.dubbo.common.URL], java.lang.String), var3335_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var3970_isEmpty/-813097145=([java.lang.String], boolean), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2835_getConfig/1309559845=([java.lang.String], com.ctrip.framework.apollo.Config), dubboConfig/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.Config), var2835_getConfigFile/-1400254899=([java.lang.String, com.ctrip.framework.apollo.core.enums.ConfigFileFormat], com.ctrip.framework.apollo.ConfigFile), dubboConfigFile/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.ConfigFile), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), var2836_getSourceType/23764747=([com.ctrip.framework.apollo.Config], com.ctrip.framework.apollo.enums.ConfigSourceType)}
; {var2585=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var923=r0, var1537=org.apache.dubbo.common.URL, var424=r2, var3648=org.apache.dubbo.rpc.model.ApplicationModel, var3965=r3, var259=java.lang.Object, var2293=java.util.concurrent.ConcurrentHashMap, var2077=$r1, var2931=java.util.concurrent.ConcurrentMap, var1519=r4, var3757=r5, var3050=r6, var1885=r7, var3335=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1795=$r8, var3970=org.apache.dubbo.common.utils.StringUtils, var1704=$z0, var3368=$r28, var6=$z5, var565=$r29, var713=$z6, var2259=$r30, var107=$z7, var915=$r31, var3772=$z8, var491=$r32, var2836=com.ctrip.framework.apollo.Config, var2835=com.ctrip.framework.apollo.ConfigService, var3402=$r9, var2560=com.ctrip.framework.apollo.core.enums.ConfigFileFormat, var3696=$r10, var835=com.ctrip.framework.apollo.ConfigFile, var1507=$r11, var1694=$z3, var1036=$r12, var1903=com.ctrip.framework.apollo.enums.ConfigSourceType, var405=$r14, var1865=$r13}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var2585, r0=var923, org.apache.dubbo.common.URL=var1537, r2=var424, org.apache.dubbo.rpc.model.ApplicationModel=var3648, r3=var3965, java.lang.Object=var259, java.util.concurrent.ConcurrentHashMap=var2293, $r1=var2077, java.util.concurrent.ConcurrentMap=var2931, r4=var1519, r5=var3757, r6=var3050, r7=var1885, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var3335, $r8=var1795, org.apache.dubbo.common.utils.StringUtils=var3970, $z0=var1704, $r28=var3368, $z5=var6, $r29=var565, $z6=var713, $r30=var2259, $z7=var107, $r31=var915, $z8=var3772, $r32=var491, com.ctrip.framework.apollo.Config=var2836, com.ctrip.framework.apollo.ConfigService=var2835, $r9=var3402, com.ctrip.framework.apollo.core.enums.ConfigFileFormat=var2560, $r10=var3696, com.ctrip.framework.apollo.ConfigFile=var835, $r11=var1507, $z3=var1694, $r12=var1036, com.ctrip.framework.apollo.enums.ConfigSourceType=var1903, $r14=var405, $r13=var1865}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 5}
;stmts r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r2 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners> = $r1;	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.common.URL url> = r2;	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> = r3;	r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("env");	r5 = specialinvoke r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.lang.String getAddressWithProtocolPrefix(org.apache.dubbo.common.URL)>(r2);	r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("cluster");	r7 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("app.id");	$r8 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("env");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8);	if $z0 == 0 goto $r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta");	$r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta");	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28);	if $z5 == 0 goto $r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster");	$r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster");	$z6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r29);	if $z6 == 0 goto $r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id");	$r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id");	$z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r30);	if $z7 == 0 goto $r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo");	$r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo");	$z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r31);	if $z8 == 0 goto $r32 = $r31;	$r32 = $r31;	$r9 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.Config getConfig(java.lang.String)>($r32);	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> = $r9;	$r10 = <com.ctrip.framework.apollo.core.enums.ConfigFileFormat: com.ctrip.framework.apollo.core.enums.ConfigFileFormat Properties>;	$r11 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.ConfigFile getConfigFile(java.lang.String,com.ctrip.framework.apollo.core.enums.ConfigFileFormat)>($r32, $r10);	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.ConfigFile dubboConfigFile> = $r11;	$z3 = virtualinvoke r2.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("check", 1);	$r12 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig>;	$r14 = interfaceinvoke $r12.<com.ctrip.framework.apollo.Config: com.ctrip.framework.apollo.enums.ConfigSourceType getSourceType()>();	$r13 = <com.ctrip.framework.apollo.enums.ConfigSourceType: com.ctrip.framework.apollo.enums.ConfigSourceType REMOTE>;	if $r14 == $r13 goto return;	return
;block_num 8