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

(declare-sort var935 0)
(declare-sort var601 0)
(declare-sort var3905 0)
(declare-sort var895 0)
(declare-sort var3018 0)
(declare-sort var194 0)
(declare-sort var1404 0)
(declare-sort var529 0)
(declare-sort var1049 0)
(declare-sort var2935 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3905-init () var3905)
(declare-fun <init>/-1874992186 (var3905 String) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3018_error/377575788 (var3018 String String String String var895) void)
(declare-fun ruleRepository/-1763037024 (var935) var194)
(declare-fun var194_addListener/-2050198517 (var194 String String var1404) void)
(declare-fun cast-from-var3905-to-var1404 (var3905) var1404)
(declare-fun envListeners/-1763037024 (var935) var529)
(declare-fun var529_iterator/1911472585 (var529) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun APP_RULE_LISTENERS/-1763037024 (var935) var1049)
(declare-fun put/-1753019971 (var1049 var2935 var2935) var2935)
(declare-fun cast-from-String-to-var2935 (String) var2935)
(declare-fun cast-from-var3905-to-var2935 (var3905) var2935)
(declare-const null-var935 var935)
(declare-const null-String String)
(declare-const null-var895 var895)
(declare-const var935-logger var3018)
(declare-const var1315 var935) ; Statement: r6 := @this: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager 
(assert (not (= var1315 null-var935)))
(declare-const var81 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var81 null-String)))
(define-const var2284 var3905 var3905-init) ; Statement: $r0 = new org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener 
(assert true)
;(assert (<init>/-1874992186 var2284 var81)) ; Statement: specialinvoke $r0.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: void <init>(java.lang.String)>(r1) 

(declare-const var2284!1 var3905)
(declare-const var81!1 String)
(define-const var2749 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2749)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2749!1 String)
(assert (= var2749!1 ""))
(assert true)
(define-const var1019 String (append/672562846 var2749!1 var81!1)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2749!2 String)
(assert (= var2749!2 (str.++ var2749!1 var81!1)))
(assert true)
(define-const var2778 String (append/672562846 var1019 ".MESHAPPRULE")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".MESHAPPRULE") 
(declare-const var1019!1 String)
(assert (= var1019!1 (str.++ var1019 ".MESHAPPRULE")))
(assert true)
(define-const var2059 String (toString/-2075883882 var2778)) ; Statement: r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2943 var895) ; Statement: $r13 := @caughtexception 
(assert (not (= var2943 null-var895)))
(define-const var2653 var3018 var935-logger) ; Statement: $r14 = <org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3018_error/377575788 var2653 "2-13" "failed to get mesh app route rule" "" "get MeshRuleManager app rule failed." var2943)) ; Statement: interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-13", "failed to get mesh app route rule", "", "get MeshRuleManager app rule failed.", $r13) 

(declare-const var2653!1 var3018)
(declare-const var2565 String)
(declare-const var831 String)
(declare-const var3735 String)
(declare-const var3861 String)
(declare-const var2943!1 var895)
(assert true) ; Non Conditional
(define-const var2966 var194 (ruleRepository/-1763037024 var1315)) ; Statement: $r8 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository> 
;(assert (var194_addListener/-2050198517 var2966 var2059 "dubbo" (cast-from-var3905-to-var1404 var2284!1))) ; Statement: interfaceinvoke $r8.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void addListener(java.lang.String,java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r5, "dubbo", $r0) 

(declare-const var2966!1 var194)
(declare-const var2059!1 String)
(declare-const var1191 String)
(declare-const var2284!2 var3905)
(define-const var1630 var529 (envListeners/-1763037024 var1315)) ; Statement: $r9 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.Set envListeners> 
(define-const var1918 Iterator (var529_iterator/1911472585 var1630)) ; Statement: $r15 = interfaceinvoke $r9.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var867 Bool (Iterator_hasNext/-1669924200 var1918)) ; Statement: $z1 = interfaceinvoke $r15.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 == 0 goto $r10 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.concurrent.ConcurrentHashMap APP_RULE_LISTENERS> 
(assert (= (ite var867 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3265 var1049 (APP_RULE_LISTENERS/-1763037024 var1315)) ; Statement: $r10 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.concurrent.ConcurrentHashMap APP_RULE_LISTENERS> 
(assert true)
;(assert (put/-1753019971 var3265 (cast-from-String-to-var2935 var81!1) (cast-from-var3905-to-var2935 var2284!2))) ; Statement: virtualinvoke $r10.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, $r0) 

(declare-const var3265!1 var1049)
(declare-const var81!2 String)
(declare-const var2284!3 var3905)
 ; Statement: return $r0 
(check-sat)
; {var3905-init=([], org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener), <init>/-1874992186=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener, java.lang.String], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3018_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), ruleRepository/-1763037024=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager], org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository), var194_addListener/-2050198517=([org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, java.lang.String, java.lang.String, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), cast-from-var3905-to-var1404=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener], org.apache.dubbo.common.config.configcenter.ConfigurationListener), envListeners/-1763037024=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager], java.util.Set), var529_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), APP_RULE_LISTENERS/-1763037024=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager], java.util.concurrent.ConcurrentHashMap), put/-1753019971=([java.util.concurrent.ConcurrentHashMap, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2935=([java.lang.String], java.lang.Object), cast-from-var3905-to-var2935=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener], java.lang.Object)}
; {var935=org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager, var1315=r6, var81=r1, var601=null_type, var3905=org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener, var2284=$r0, var2749=$r2, var1019=$r3, var2778=$r4, var2059=r5, var895=java.lang.Throwable, var2943=$r13, var3018=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2653=$r14, var2565="2-13", var831="failed to get mesh app route rule", var3735="", var3861="get MeshRuleManager app rule failed.", var194=org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, var2966=$r8, var1404=org.apache.dubbo.common.config.configcenter.ConfigurationListener, var1191="dubbo", var529=java.util.Set, var1630=$r9, var1918=$r15, var867=$z1, var1049=java.util.concurrent.ConcurrentHashMap, var3265=$r10, var2935=java.lang.Object}
; {org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager=var935, r6=var1315, r1=var81, null_type=var601, org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener=var3905, $r0=var2284, $r2=var2749, $r3=var1019, $r4=var2778, r5=var2059, java.lang.Throwable=var895, $r13=var2943, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3018, $r14=var2653, "2-13"=var2565, "failed to get mesh app route rule"=var831, ""=var3735, "get MeshRuleManager app rule failed."=var3861, org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository=var194, $r8=var2966, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var1404, "dubbo"=var1191, java.util.Set=var529, $r9=var1630, $r15=var1918, $z1=var867, java.util.concurrent.ConcurrentHashMap=var1049, $r10=var3265, java.lang.Object=var2935}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager;	r1 := @parameter0: java.lang.String;	$r0 = new org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener;	specialinvoke $r0.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener: void <init>(java.lang.String)>(r1);	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".MESHAPPRULE");	r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	$r13 := @caughtexception;	$r14 = <org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r14.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-13", "failed to get mesh app route rule", "", "get MeshRuleManager app rule failed.", $r13);	$r8 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository>;	interfaceinvoke $r8.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void addListener(java.lang.String,java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r5, "dubbo", $r0);	$r9 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.Set envListeners>;	$r15 = interfaceinvoke $r9.<java.util.Set: java.util.Iterator iterator()>();	$z1 = interfaceinvoke $r15.<java.util.Iterator: boolean hasNext()>();	if $z1 == 0 goto $r10 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.concurrent.ConcurrentHashMap APP_RULE_LISTENERS>;	$r10 = r6.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.concurrent.ConcurrentHashMap APP_RULE_LISTENERS>;	virtualinvoke $r10.<java.util.concurrent.ConcurrentHashMap: java.lang.Object put(java.lang.Object,java.lang.Object)>(r1, $r0);	return $r0
;block_num 5