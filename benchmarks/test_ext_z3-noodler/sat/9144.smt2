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

(declare-sort var1674 0)
(declare-sort var2464 0)
(declare-sort var719 0)
(declare-sort var1278 0)
(declare-sort var726 0)
(declare-sort var3264 0)
(declare-sort var1753 0)
(declare-sort var3288 0)
(declare-sort var1774 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2464-init () var2464)
(declare-fun <init>/-1081908235 (var2464) void)
(declare-fun build/1682295194 (var719 var1278) void)
(declare-fun cast-from-var1674-to-var719 (var1674) var719)
(declare-fun cast-from-var2464-to-var1278 (var2464) var1278)
(declare-fun name/1068058779 (var1674) String)
(declare-fun setName/1475189323 (var2464 String) void)
(declare-fun metadata/1068058779 (var1674) String)
(declare-fun setMetadataType/380523789 (var2464 String) void)
(declare-fun version/1068058779 (var1674) String)
(declare-fun setVersion/-1167085066 (var2464 String) void)
(declare-fun owner/1068058779 (var1674) String)
(declare-fun setOwner/1875182395 (var2464 String) void)
(declare-fun organization/1068058779 (var1674) String)
(declare-fun setOrganization/-1958993245 (var2464 String) void)
(declare-fun architecture/1068058779 (var1674) String)
(declare-fun setArchitecture/-1138363773 (var2464 String) void)
(declare-fun environment/1068058779 (var1674) String)
(declare-fun setEnvironment/-1598791973 (var2464 String) void)
(declare-fun compiler/1068058779 (var1674) String)
(declare-fun setCompiler/-1102287433 (var2464 String) void)
(declare-fun logger/1068058779 (var1674) String)
(declare-fun setLogger/1700704806 (var2464 String) void)
(declare-fun registries/1068058779 (var1674) var726)
(declare-fun setRegistries/-688534476 (var2464 var726) void)
(declare-fun registryIds/1068058779 (var1674) String)
(declare-fun setRegistryIds/-28113229 (var2464 String) void)
(declare-fun monitor/1068058779 (var1674) var3264)
(declare-fun setMonitor/-800795247 (var2464 var3264) void)
(declare-fun isDefault/1068058779 (var1674) var1753)
(declare-fun setDefault/1415602176 (var1278 var1753) void)
(declare-fun dumpDirectory/1068058779 (var1674) String)
(declare-fun setDumpDirectory/325207381 (var2464 String) void)
(declare-fun qosEnable/1068058779 (var1674) var1753)
(declare-fun setQosEnable/1148293773 (var2464 var1753) void)
(declare-fun qosPort/1068058779 (var1674) Int)
(declare-fun setQosPort/1549531233 (var2464 Int) void)
(declare-fun qosAcceptForeignIp/1068058779 (var1674) var1753)
(declare-fun setQosAcceptForeignIp/-545263157 (var2464 var1753) void)
(declare-fun metadataServicePort/1068058779 (var1674) Int)
(declare-fun setMetadataServicePort/273502674 (var2464 Int) void)
(declare-fun livenessProbe/1068058779 (var1674) String)
(declare-fun setLivenessProbe/1215147905 (var2464 String) void)
(declare-fun readinessProbe/1068058779 (var1674) String)
(declare-fun setReadinessProbe/-1306369904 (var2464 String) void)
(declare-fun startupProbe/1068058779 (var1674) String)
(declare-fun setStartupProbe/949859491 (var2464 String) void)
(declare-fun parameters/1068058779 (var1674) var3288)
(declare-fun setParameters/2143984607 (var2464 var3288) void)
(declare-fun shutwait/1068058779 (var1674) String)
(declare-fun var1774_isEmpty/-813097145 (String) Bool)
(declare-const null-var1674 var1674)
(declare-const var2511 var1674) ; Statement: r1 := @this: org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder 
(assert (not (= var2511 null-var1674)))
(define-const var2241 var2464 var2464-init) ; Statement: $r0 = new org.apache.dubbo.config.ApplicationConfig 
(assert true)
;(assert (<init>/-1081908235 var2241)) ; Statement: specialinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void <init>()>() 

(declare-const var2241!1 var2464)
(assert true)
;(assert (build/1682295194 (cast-from-var1674-to-var719 var2511) (cast-from-var2464-to-var1278 var2241!1))) ; Statement: specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: void build(org.apache.dubbo.config.AbstractConfig)>($r0) 

(declare-const var2511!1 var1674)
(declare-const var2241!2 var2464)
(define-const var1134 String (name/1068058779 var2511!1)) ; Statement: $r2 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String name> 
(assert true)
;(assert (setName/1475189323 var2241!2 var1134)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setName(java.lang.String)>($r2) 

(declare-const var2241!3 var2464)
(declare-const var1134!1 String)
(define-const var3939 String (metadata/1068058779 var2511!1)) ; Statement: $r3 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String metadata> 
(assert true)
;(assert (setMetadataType/380523789 var2241!3 var3939)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setMetadataType(java.lang.String)>($r3) 

(declare-const var2241!4 var2464)
(declare-const var3939!1 String)
(define-const var2793 String (version/1068058779 var2511!1)) ; Statement: $r4 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String version> 
(assert true)
;(assert (setVersion/-1167085066 var2241!4 var2793)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setVersion(java.lang.String)>($r4) 

(declare-const var2241!5 var2464)
(declare-const var2793!1 String)
(define-const var309 String (owner/1068058779 var2511!1)) ; Statement: $r5 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String owner> 
(assert true)
;(assert (setOwner/1875182395 var2241!5 var309)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setOwner(java.lang.String)>($r5) 

(declare-const var2241!6 var2464)
(declare-const var309!1 String)
(define-const var3003 String (organization/1068058779 var2511!1)) ; Statement: $r6 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String organization> 
(assert true)
;(assert (setOrganization/-1958993245 var2241!6 var3003)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setOrganization(java.lang.String)>($r6) 

(declare-const var2241!7 var2464)
(declare-const var3003!1 String)
(define-const var1819 String (architecture/1068058779 var2511!1)) ; Statement: $r7 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String architecture> 
(assert true)
;(assert (setArchitecture/-1138363773 var2241!7 var1819)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setArchitecture(java.lang.String)>($r7) 

(declare-const var2241!8 var2464)
(declare-const var1819!1 String)
(define-const var244 String (environment/1068058779 var2511!1)) ; Statement: $r8 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String environment> 
(assert true)
;(assert (setEnvironment/-1598791973 var2241!8 var244)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setEnvironment(java.lang.String)>($r8) 

(declare-const var2241!9 var2464)
(declare-const var244!1 String)
(define-const var1507 String (compiler/1068058779 var2511!1)) ; Statement: $r9 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String compiler> 
(assert true)
;(assert (setCompiler/-1102287433 var2241!9 var1507)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setCompiler(java.lang.String)>($r9) 

(declare-const var2241!10 var2464)
(declare-const var1507!1 String)
(define-const var3468 String (logger/1068058779 var2511!1)) ; Statement: $r10 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String logger> 
(assert true)
;(assert (setLogger/1700704806 var2241!10 var3468)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setLogger(java.lang.String)>($r10) 

(declare-const var2241!11 var2464)
(declare-const var3468!1 String)
(define-const var3273 var726 (registries/1068058779 var2511!1)) ; Statement: $r11 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.util.List registries> 
(assert true)
;(assert (setRegistries/-688534476 var2241!11 var3273)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setRegistries(java.util.List)>($r11) 

(declare-const var2241!12 var2464)
(declare-const var3273!1 var726)
(define-const var874 String (registryIds/1068058779 var2511!1)) ; Statement: $r12 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String registryIds> 
(assert true)
;(assert (setRegistryIds/-28113229 var2241!12 var874)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setRegistryIds(java.lang.String)>($r12) 

(declare-const var2241!13 var2464)
(declare-const var874!1 String)
(define-const var783 var3264 (monitor/1068058779 var2511!1)) ; Statement: $r13 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: org.apache.dubbo.config.MonitorConfig monitor> 
(assert true)
;(assert (setMonitor/-800795247 var2241!13 var783)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setMonitor(org.apache.dubbo.config.MonitorConfig)>($r13) 

(declare-const var2241!14 var2464)
(declare-const var783!1 var3264)
(define-const var3161 var1753 (isDefault/1068058779 var2511!1)) ; Statement: $r14 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Boolean isDefault> 
(assert true)
;(assert (setDefault/1415602176 (cast-from-var2464-to-var1278 var2241!14) var3161)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setDefault(java.lang.Boolean)>($r14) 

(declare-const var2241!15 var2464)
(declare-const var3161!1 var1753)
(define-const var2852 String (dumpDirectory/1068058779 var2511!1)) ; Statement: $r15 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String dumpDirectory> 
(assert true)
;(assert (setDumpDirectory/325207381 var2241!15 var2852)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setDumpDirectory(java.lang.String)>($r15) 

(declare-const var2241!16 var2464)
(declare-const var2852!1 String)
(define-const var677 var1753 (qosEnable/1068058779 var2511!1)) ; Statement: $r16 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Boolean qosEnable> 
(assert true)
;(assert (setQosEnable/1148293773 var2241!16 var677)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setQosEnable(java.lang.Boolean)>($r16) 

(declare-const var2241!17 var2464)
(declare-const var677!1 var1753)
(define-const var207 Int (qosPort/1068058779 var2511!1)) ; Statement: $r17 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Integer qosPort> 
(assert true)
;(assert (setQosPort/1549531233 var2241!17 var207)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setQosPort(java.lang.Integer)>($r17) 

(declare-const var2241!18 var2464)
(declare-const var207!1 Int)
(define-const var1716 var1753 (qosAcceptForeignIp/1068058779 var2511!1)) ; Statement: $r18 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Boolean qosAcceptForeignIp> 
(assert true)
;(assert (setQosAcceptForeignIp/-545263157 var2241!18 var1716)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setQosAcceptForeignIp(java.lang.Boolean)>($r18) 

(declare-const var2241!19 var2464)
(declare-const var1716!1 var1753)
(define-const var3031 Int (metadataServicePort/1068058779 var2511!1)) ; Statement: $r19 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Integer metadataServicePort> 
(assert true)
;(assert (setMetadataServicePort/273502674 var2241!19 var3031)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setMetadataServicePort(java.lang.Integer)>($r19) 

(declare-const var2241!20 var2464)
(declare-const var3031!1 Int)
(define-const var913 String (livenessProbe/1068058779 var2511!1)) ; Statement: $r20 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String livenessProbe> 
(assert true)
;(assert (setLivenessProbe/1215147905 var2241!20 var913)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setLivenessProbe(java.lang.String)>($r20) 

(declare-const var2241!21 var2464)
(declare-const var913!1 String)
(define-const var3956 String (readinessProbe/1068058779 var2511!1)) ; Statement: $r21 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String readinessProbe> 
(assert true)
;(assert (setReadinessProbe/-1306369904 var2241!21 var3956)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setReadinessProbe(java.lang.String)>($r21) 

(declare-const var2241!22 var2464)
(declare-const var3956!1 String)
(define-const var3429 String (startupProbe/1068058779 var2511!1)) ; Statement: $r22 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String startupProbe> 
(assert true)
;(assert (setStartupProbe/949859491 var2241!22 var3429)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setStartupProbe(java.lang.String)>($r22) 

(declare-const var2241!23 var2464)
(declare-const var3429!1 String)
(define-const var3818 var3288 (parameters/1068058779 var2511!1)) ; Statement: $r23 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.util.Map parameters> 
(assert true)
;(assert (setParameters/2143984607 var2241!23 var3818)) ; Statement: virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setParameters(java.util.Map)>($r23) 

(declare-const var2241!24 var2464)
(declare-const var3818!1 var3288)
(define-const var1911 String (shutwait/1068058779 var2511!1)) ; Statement: $r24 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String shutwait> 
(define-const var3510 Bool (var1774_isEmpty/-813097145 var1911)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r24) 
 ; Statement: if $z0 != 0 goto return $r0 
(assert (not (= (ite var3510 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return $r0 
(check-sat)
; {var2464-init=([], org.apache.dubbo.config.ApplicationConfig), <init>/-1081908235=([org.apache.dubbo.config.ApplicationConfig], void), build/1682295194=([org.apache.dubbo.config.bootstrap.builders.AbstractBuilder, org.apache.dubbo.config.AbstractConfig], void), cast-from-var1674-to-var719=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], org.apache.dubbo.config.bootstrap.builders.AbstractBuilder), cast-from-var2464-to-var1278=([org.apache.dubbo.config.ApplicationConfig], org.apache.dubbo.config.AbstractConfig), name/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setName/1475189323=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), metadata/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setMetadataType/380523789=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), version/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setVersion/-1167085066=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), owner/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setOwner/1875182395=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), organization/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setOrganization/-1958993245=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), architecture/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setArchitecture/-1138363773=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), environment/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setEnvironment/-1598791973=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), compiler/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setCompiler/-1102287433=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), logger/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setLogger/1700704806=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), registries/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.util.List), setRegistries/-688534476=([org.apache.dubbo.config.ApplicationConfig, java.util.List], void), registryIds/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setRegistryIds/-28113229=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), monitor/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], org.apache.dubbo.config.MonitorConfig), setMonitor/-800795247=([org.apache.dubbo.config.ApplicationConfig, org.apache.dubbo.config.MonitorConfig], void), isDefault/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.Boolean), setDefault/1415602176=([org.apache.dubbo.config.AbstractConfig, java.lang.Boolean], void), dumpDirectory/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setDumpDirectory/325207381=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), qosEnable/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.Boolean), setQosEnable/1148293773=([org.apache.dubbo.config.ApplicationConfig, java.lang.Boolean], void), qosPort/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.Integer), setQosPort/1549531233=([org.apache.dubbo.config.ApplicationConfig, java.lang.Integer], void), qosAcceptForeignIp/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.Boolean), setQosAcceptForeignIp/-545263157=([org.apache.dubbo.config.ApplicationConfig, java.lang.Boolean], void), metadataServicePort/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.Integer), setMetadataServicePort/273502674=([org.apache.dubbo.config.ApplicationConfig, java.lang.Integer], void), livenessProbe/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setLivenessProbe/1215147905=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), readinessProbe/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setReadinessProbe/-1306369904=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), startupProbe/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), setStartupProbe/949859491=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), parameters/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.util.Map), setParameters/2143984607=([org.apache.dubbo.config.ApplicationConfig, java.util.Map], void), shutwait/1068058779=([org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder], java.lang.String), var1774_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1674=org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder, var2511=r1, var2464=org.apache.dubbo.config.ApplicationConfig, var2241=$r0, var719=org.apache.dubbo.config.bootstrap.builders.AbstractBuilder, var1278=org.apache.dubbo.config.AbstractConfig, var1134=$r2, var3939=$r3, var2793=$r4, var309=$r5, var3003=$r6, var1819=$r7, var244=$r8, var1507=$r9, var3468=$r10, var726=java.util.List, var3273=$r11, var874=$r12, var3264=org.apache.dubbo.config.MonitorConfig, var783=$r13, var1753=java.lang.Boolean, var3161=$r14, var2852=$r15, var677=$r16, var207=$r17, var1716=$r18, var3031=$r19, var913=$r20, var3956=$r21, var3429=$r22, var3288=java.util.Map, var3818=$r23, var1911=$r24, var1774=org.apache.dubbo.common.utils.StringUtils, var3510=$z0}
; {org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder=var1674, r1=var2511, org.apache.dubbo.config.ApplicationConfig=var2464, $r0=var2241, org.apache.dubbo.config.bootstrap.builders.AbstractBuilder=var719, org.apache.dubbo.config.AbstractConfig=var1278, $r2=var1134, $r3=var3939, $r4=var2793, $r5=var309, $r6=var3003, $r7=var1819, $r8=var244, $r9=var1507, $r10=var3468, java.util.List=var726, $r11=var3273, $r12=var874, org.apache.dubbo.config.MonitorConfig=var3264, $r13=var783, java.lang.Boolean=var1753, $r14=var3161, $r15=var2852, $r16=var677, $r17=var207, $r18=var1716, $r19=var3031, $r20=var913, $r21=var3956, $r22=var3429, java.util.Map=var3288, $r23=var3818, $r24=var1911, org.apache.dubbo.common.utils.StringUtils=var1774, $z0=var3510}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder;	$r0 = new org.apache.dubbo.config.ApplicationConfig;	specialinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void <init>()>();	specialinvoke r1.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: void build(org.apache.dubbo.config.AbstractConfig)>($r0);	$r2 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String name>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setName(java.lang.String)>($r2);	$r3 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String metadata>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setMetadataType(java.lang.String)>($r3);	$r4 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String version>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setVersion(java.lang.String)>($r4);	$r5 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String owner>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setOwner(java.lang.String)>($r5);	$r6 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String organization>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setOrganization(java.lang.String)>($r6);	$r7 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String architecture>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setArchitecture(java.lang.String)>($r7);	$r8 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String environment>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setEnvironment(java.lang.String)>($r8);	$r9 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String compiler>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setCompiler(java.lang.String)>($r9);	$r10 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String logger>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setLogger(java.lang.String)>($r10);	$r11 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.util.List registries>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setRegistries(java.util.List)>($r11);	$r12 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String registryIds>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setRegistryIds(java.lang.String)>($r12);	$r13 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: org.apache.dubbo.config.MonitorConfig monitor>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setMonitor(org.apache.dubbo.config.MonitorConfig)>($r13);	$r14 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Boolean isDefault>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setDefault(java.lang.Boolean)>($r14);	$r15 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String dumpDirectory>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setDumpDirectory(java.lang.String)>($r15);	$r16 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Boolean qosEnable>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setQosEnable(java.lang.Boolean)>($r16);	$r17 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Integer qosPort>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setQosPort(java.lang.Integer)>($r17);	$r18 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Boolean qosAcceptForeignIp>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setQosAcceptForeignIp(java.lang.Boolean)>($r18);	$r19 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.Integer metadataServicePort>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setMetadataServicePort(java.lang.Integer)>($r19);	$r20 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String livenessProbe>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setLivenessProbe(java.lang.String)>($r20);	$r21 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String readinessProbe>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setReadinessProbe(java.lang.String)>($r21);	$r22 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String startupProbe>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setStartupProbe(java.lang.String)>($r22);	$r23 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.util.Map parameters>;	virtualinvoke $r0.<org.apache.dubbo.config.ApplicationConfig: void setParameters(java.util.Map)>($r23);	$r24 = r1.<org.apache.dubbo.config.bootstrap.builders.ApplicationBuilder: java.lang.String shutwait>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r24);	if $z0 != 0 goto return $r0;	return $r0
;block_num 2