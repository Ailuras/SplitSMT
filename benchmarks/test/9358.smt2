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

(declare-sort var3640 0)
(declare-sort var1434 0)
(declare-sort var2066 0)
(declare-sort var1374 0)
(declare-sort var1687 0)
(declare-sort var3613 0)
(declare-sort var760 0)
(declare-sort var1887 0)
(declare-sort var2293 0)
(declare-sort var3040 0)
(declare-sort var1296 0)
(declare-sort var3006 0)
(declare-sort var680 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1374) void)
(declare-fun cast-from-var3640-to-var1374 (var3640) var1374)
(declare-fun var1687-init () var1687)
(declare-fun <init>/-2175807 (var1687) void)
(declare-fun cast-from-var1687-to-var3613 (var1687) var3613)
(declare-fun listeners/-775390699 (var3640) var3613)
(declare-fun url/-775390699 (var3640) var1434)
(declare-fun applicationModel/-775390699 (var3640) var2066)
(declare-fun getParameter/-1307325648 (var1434 String) String)
(declare-fun getAddressWithProtocolPrefix/-818322071 (var3640 var1434) String)
(declare-fun var760_getSystemProperty/1393069448 (String) String)
(declare-fun var1887_isEmpty/-813097145 (String) Bool)
(declare-fun getParameter/506106603 (var1434 String String) String)
(declare-fun getGroup/-953511910 (var1434 String) String)
(declare-fun var3040_getConfig/1309559845 (String) var2293)
(declare-fun dubboConfig/-775390699 (var3640) var2293)
(declare-fun var3040_getConfigFile/-1400254899 (String var1296) var3006)
(declare-fun dubboConfigFile/-775390699 (var3640) var3006)
(declare-fun getParameter/2144001655 (var1434 String Bool) Bool)
(declare-fun var2293_getSourceType/23764747 (var2293) var680)
(declare-const null-var3640 var3640)
(declare-const null-var1434 var1434)
(declare-const null-var2066 var2066)
(declare-const var1296-Properties var1296)
(declare-const var680-REMOTE var680)
(declare-const var1854 var3640) ; Statement: r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var1854 null-var3640)))
(declare-const var2108 var1434) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2108 null-var1434)))
(declare-const var1222 var2066) ; Statement: r3 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var1222 null-var2066)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3640-to-var1374 var1854))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1854!1 var3640)
(define-const var265 var1687 var1687-init) ; Statement: $r1 = new java.util.concurrent.ConcurrentHashMap 
(assert true)
;(assert (<init>/-2175807 var265)) ; Statement: specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>() 

(declare-const var265!1 var1687)
(declare-const var1854!2 var3640)
(assert (not (= var1854!2 null-var3640)))
(assert (= (listeners/-775390699 var1854!2) (cast-from-var1687-to-var3613 var265!1))) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners> = $r1 
(declare-const var1854!3 var3640)
(assert (not (= var1854!3 null-var3640)))
(assert (= (url/-775390699 var1854!3) var2108)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.common.URL url> = r2 
(declare-const var1854!4 var3640)
(assert (not (= var1854!4 null-var3640)))
(assert (= (applicationModel/-775390699 var1854!4) var1222)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> = r3 
(assert true)
(define-const var1573 String (getParameter/-1307325648 var2108 "env")) ; Statement: r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("env") 
(assert true)
(define-const var2483 String (getAddressWithProtocolPrefix/-818322071 var1854!4 var2108)) ; Statement: r5 = specialinvoke r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.lang.String getAddressWithProtocolPrefix(org.apache.dubbo.common.URL)>(r2) 
(assert true)
(define-const var2736 String (getParameter/-1307325648 var2108 "cluster")) ; Statement: r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("cluster") 
(assert true)
(define-const var3554 String (getParameter/-1307325648 var2108 "app.id")) ; Statement: r7 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("app.id") 
(define-const var3160 String (var760_getSystemProperty/1393069448 "env")) ; Statement: $r8 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("env") 
(define-const var94 Bool (var1887_isEmpty/-813097145 var3160)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8) 
 ; Statement: if $z0 == 0 goto $r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta") 
(assert (= (ite var94 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2257 String (var760_getSystemProperty/1393069448 "apollo.meta")) ; Statement: $r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta") 
(define-const var2972 Bool (var1887_isEmpty/-813097145 var2257)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28) 
 ; Statement: if $z5 == 0 goto $r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster") 
(assert (= (ite var2972 1 0) 0)) ; Cond: $z5 == 0 
(define-const var2988 String (var760_getSystemProperty/1393069448 "apollo.cluster")) ; Statement: $r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster") 
(define-const var3284 Bool (var1887_isEmpty/-813097145 var2988)) ; Statement: $z6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r29) 
 ; Statement: if $z6 == 0 goto $r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id") 
(assert (= (ite var3284 1 0) 0)) ; Cond: $z6 == 0 
(define-const var163 String (var760_getSystemProperty/1393069448 "app.id")) ; Statement: $r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id") 
(define-const var3981 Bool (var1887_isEmpty/-813097145 var163)) ; Statement: $z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r30) 
 ; Statement: if $z7 == 0 goto $r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo") 
(assert (= (ite var3981 1 0) 0)) ; Cond: $z7 == 0 
(assert true)
(define-const var3468 String (getParameter/506106603 var2108 "namespace" "dubbo")) ; Statement: $r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo") 
(define-const var645 Bool (var1887_isEmpty/-813097145 var3468)) ; Statement: $z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r31) 
 ; Statement: if $z8 == 0 goto $r32 = $r31 
(assert (not (= (ite var645 1 0) 0))) ; Negate: Cond: $z8 == 0  
(assert true)
(define-const var2666 String (getGroup/-953511910 var2108 "dubbo")) ; Statement: $r32 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getGroup(java.lang.String)>("dubbo") 
 ; Statement: goto [?= $r9 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.Config getConfig(java.lang.String)>($r32)] 
(assert true) ; Non Conditional
(define-const var515 var2293 (var3040_getConfig/1309559845 var2666)) ; Statement: $r9 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.Config getConfig(java.lang.String)>($r32) 
(declare-const var1854!5 var3640)
(assert (not (= var1854!5 null-var3640)))
(assert (= (dubboConfig/-775390699 var1854!5) var515)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> = $r9 
(define-const var1145 var1296 var1296-Properties) ; Statement: $r10 = <com.ctrip.framework.apollo.core.enums.ConfigFileFormat: com.ctrip.framework.apollo.core.enums.ConfigFileFormat Properties> 
(define-const var3311 var3006 (var3040_getConfigFile/-1400254899 var2666 var1145)) ; Statement: $r11 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.ConfigFile getConfigFile(java.lang.String,com.ctrip.framework.apollo.core.enums.ConfigFileFormat)>($r32, $r10) 
(declare-const var1854!6 var3640)
(assert (not (= var1854!6 null-var3640)))
(assert (= (dubboConfigFile/-775390699 var1854!6) var3311)) ; Statement: r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.ConfigFile dubboConfigFile> = $r11 
(assert true)
(define-const var3377 Bool (getParameter/2144001655 var2108 "check" (ite (= 1 1) true false))) ; Statement: $z3 = virtualinvoke r2.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("check", 1) 
(define-const var1103 var2293 (dubboConfig/-775390699 var1854!6)) ; Statement: $r12 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> 
(define-const var2619 var680 (var2293_getSourceType/23764747 var1103)) ; Statement: $r14 = interfaceinvoke $r12.<com.ctrip.framework.apollo.Config: com.ctrip.framework.apollo.enums.ConfigSourceType getSourceType()>() 
(define-const var3203 var680 var680-REMOTE) ; Statement: $r13 = <com.ctrip.framework.apollo.enums.ConfigSourceType: com.ctrip.framework.apollo.enums.ConfigSourceType REMOTE> 
 ; Statement: if $r14 == $r13 goto return 
(assert (= var2619 var3203)) ; Cond: $r14 == $r13 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3640-to-var1374=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], java.lang.Object), var1687-init=([], java.util.concurrent.ConcurrentHashMap), <init>/-2175807=([java.util.concurrent.ConcurrentHashMap], void), cast-from-var1687-to-var3613=([java.util.concurrent.ConcurrentHashMap], java.util.concurrent.ConcurrentMap), listeners/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], java.util.concurrent.ConcurrentMap), url/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], org.apache.dubbo.common.URL), applicationModel/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], org.apache.dubbo.rpc.model.ApplicationModel), getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getAddressWithProtocolPrefix/-818322071=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, org.apache.dubbo.common.URL], java.lang.String), var760_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var1887_isEmpty/-813097145=([java.lang.String], boolean), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), getGroup/-953511910=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), var3040_getConfig/1309559845=([java.lang.String], com.ctrip.framework.apollo.Config), dubboConfig/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.Config), var3040_getConfigFile/-1400254899=([java.lang.String, com.ctrip.framework.apollo.core.enums.ConfigFileFormat], com.ctrip.framework.apollo.ConfigFile), dubboConfigFile/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.ConfigFile), getParameter/2144001655=([org.apache.dubbo.common.URL, java.lang.String, boolean], boolean), var2293_getSourceType/23764747=([com.ctrip.framework.apollo.Config], com.ctrip.framework.apollo.enums.ConfigSourceType)}
; {var3640=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var1854=r0, var1434=org.apache.dubbo.common.URL, var2108=r2, var2066=org.apache.dubbo.rpc.model.ApplicationModel, var1222=r3, var1374=java.lang.Object, var1687=java.util.concurrent.ConcurrentHashMap, var265=$r1, var3613=java.util.concurrent.ConcurrentMap, var1573=r4, var2483=r5, var2736=r6, var3554=r7, var760=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var3160=$r8, var1887=org.apache.dubbo.common.utils.StringUtils, var94=$z0, var2257=$r28, var2972=$z5, var2988=$r29, var3284=$z6, var163=$r30, var3981=$z7, var3468=$r31, var645=$z8, var2666=$r32, var2293=com.ctrip.framework.apollo.Config, var3040=com.ctrip.framework.apollo.ConfigService, var515=$r9, var1296=com.ctrip.framework.apollo.core.enums.ConfigFileFormat, var1145=$r10, var3006=com.ctrip.framework.apollo.ConfigFile, var3311=$r11, var3377=$z3, var1103=$r12, var680=com.ctrip.framework.apollo.enums.ConfigSourceType, var2619=$r14, var3203=$r13}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var3640, r0=var1854, org.apache.dubbo.common.URL=var1434, r2=var2108, org.apache.dubbo.rpc.model.ApplicationModel=var2066, r3=var1222, java.lang.Object=var1374, java.util.concurrent.ConcurrentHashMap=var1687, $r1=var265, java.util.concurrent.ConcurrentMap=var3613, r4=var1573, r5=var2483, r6=var2736, r7=var3554, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var760, $r8=var3160, org.apache.dubbo.common.utils.StringUtils=var1887, $z0=var94, $r28=var2257, $z5=var2972, $r29=var2988, $z6=var3284, $r30=var163, $z7=var3981, $r31=var3468, $z8=var645, $r32=var2666, com.ctrip.framework.apollo.Config=var2293, com.ctrip.framework.apollo.ConfigService=var3040, $r9=var515, com.ctrip.framework.apollo.core.enums.ConfigFileFormat=var1296, $r10=var1145, com.ctrip.framework.apollo.ConfigFile=var3006, $r11=var3311, $z3=var3377, $r12=var1103, com.ctrip.framework.apollo.enums.ConfigSourceType=var680, $r14=var2619, $r13=var3203}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 5}
;stmts r0 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r2 := @parameter0: org.apache.dubbo.common.URL;	r3 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r1 = new java.util.concurrent.ConcurrentHashMap;	specialinvoke $r1.<java.util.concurrent.ConcurrentHashMap: void <init>()>();	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.util.concurrent.ConcurrentMap listeners> = $r1;	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.common.URL url> = r2;	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.rpc.model.ApplicationModel applicationModel> = r3;	r4 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("env");	r5 = specialinvoke r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: java.lang.String getAddressWithProtocolPrefix(org.apache.dubbo.common.URL)>(r2);	r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("cluster");	r7 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("app.id");	$r8 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("env");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r8);	if $z0 == 0 goto $r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta");	$r28 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.meta");	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r28);	if $z5 == 0 goto $r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster");	$r29 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("apollo.cluster");	$z6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r29);	if $z6 == 0 goto $r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id");	$r30 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("app.id");	$z7 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r30);	if $z7 == 0 goto $r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo");	$r31 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("namespace", "dubbo");	$z8 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r31);	if $z8 == 0 goto $r32 = $r31;	$r32 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getGroup(java.lang.String)>("dubbo");	goto [?= $r9 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.Config getConfig(java.lang.String)>($r32)];	$r9 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.Config getConfig(java.lang.String)>($r32);	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> = $r9;	$r10 = <com.ctrip.framework.apollo.core.enums.ConfigFileFormat: com.ctrip.framework.apollo.core.enums.ConfigFileFormat Properties>;	$r11 = staticinvoke <com.ctrip.framework.apollo.ConfigService: com.ctrip.framework.apollo.ConfigFile getConfigFile(java.lang.String,com.ctrip.framework.apollo.core.enums.ConfigFileFormat)>($r32, $r10);	r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.ConfigFile dubboConfigFile> = $r11;	$z3 = virtualinvoke r2.<org.apache.dubbo.common.URL: boolean getParameter(java.lang.String,boolean)>("check", 1);	$r12 = r0.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig>;	$r14 = interfaceinvoke $r12.<com.ctrip.framework.apollo.Config: com.ctrip.framework.apollo.enums.ConfigSourceType getSourceType()>();	$r13 = <com.ctrip.framework.apollo.enums.ConfigSourceType: com.ctrip.framework.apollo.enums.ConfigSourceType REMOTE>;	if $r14 == $r13 goto return;	return
;block_num 8