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

(declare-sort var2600 0)
(declare-sort var2270 0)
(declare-sort var2047 0)
(declare-sort var1663 0)
(declare-sort var1807 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun application/-1975054663 (var2600) String)
(declare-fun var2270_isNotEmpty/-1251449450 (String) Bool)
(declare-fun getRuleRepository/-74457875 (var1663) var2047)
(declare-fun cast-from-var2600-to-var1663 (var2600) var1663)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2047_removeListener/-314952793 (var2047 String var1807) void)
(declare-fun cast-from-var2600-to-var1807 (var2600) var1807)
(declare-const null-var2600 var2600)
(declare-const var210 var2600) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter 
(assert (not (= var210 null-var2600)))
(define-const var3756 String (application/-1975054663 var210)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: java.lang.String application> 
(define-const var3280 Bool (var2270_isNotEmpty/-1251449450 var3756)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var3280 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var3641 var2047 (getRuleRepository/-74457875 (cast-from-var2600-to-var1663 var210))) ; Statement: $r7 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository getRuleRepository()>() 
(define-const var3798 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3798)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3798!1 String)
(assert (= var3798!1 ""))
(define-const var3484 String (application/-1975054663 var210)) ; Statement: $r3 = r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: java.lang.String application> 
(assert true)
(define-const var1696 String (append/672562846 var3798!1 var3484)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3798!2 String)
(assert (= var3798!2 (str.++ var3798!1 var3484)))
(assert true)
(define-const var2275 String (append/672562846 var1696 ".script-router")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".script-router") 
(declare-const var1696!1 String)
(assert (= var1696!1 (str.++ var1696 ".script-router")))
(assert true)
(define-const var1738 String (toString/-2075883882 var2275)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2047_removeListener/-314952793 var3641 var1738 (cast-from-var2600-to-var1807 var210))) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void removeListener(java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>($r6, r0) 

(declare-const var3641!1 var2047)
(declare-const var1738!1 String)
(declare-const var210!1 var2600)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {application/-1975054663=([org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter], java.lang.String), var2270_isNotEmpty/-1251449450=([java.lang.String], boolean), getRuleRepository/-74457875=([org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter], org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository), cast-from-var2600-to-var1663=([org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter], org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2047_removeListener/-314952793=([org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, java.lang.String, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), cast-from-var2600-to-var1807=([org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter], org.apache.dubbo.common.config.configcenter.ConfigurationListener)}
; {var2600=org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter, var210=r0, var3756=$r1, var2270=org.apache.dubbo.common.utils.StringUtils, var3280=$z0, var2047=org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, var1663=org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter, var3641=$r7, var3798=$r2, var3484=$r3, var1696=$r4, var2275=$r5, var1738=$r6, var1807=org.apache.dubbo.common.config.configcenter.ConfigurationListener}
; {org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter=var2600, r0=var210, $r1=var3756, org.apache.dubbo.common.utils.StringUtils=var2270, $z0=var3280, org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository=var2047, org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter=var1663, $r7=var3641, $r2=var3798, $r3=var3484, $r4=var1696, $r5=var2275, $r6=var1738, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var1807}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter;	$r1 = r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: java.lang.String application>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 == 0 goto return;	$r7 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository getRuleRepository()>();	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = r0.<org.apache.dubbo.rpc.cluster.router.script.config.AppScriptStateRouter: java.lang.String application>;	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".script-router");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r7.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void removeListener(java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>($r6, r0);	return
;block_num 3