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

(declare-sort var654 0)
(declare-sort var417 0)
(declare-sort var3871 0)
(declare-sort var1855 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRuleRepository/-74457875 (var3871) var417)
(declare-fun cast-from-var654-to-var3871 (var654) var3871)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun ruleKey/2011034306 (var654) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var417_removeListener/-314952793 (var417 String var1855) void)
(declare-fun cast-from-var654-to-var1855 (var654) var1855)
(declare-const null-var654 var654)
(declare-const var95 var654) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter 
(assert (not (= var95 null-var654)))
(assert true)
(define-const var843 var417 (getRuleRepository/-74457875 (cast-from-var654-to-var3871 var95))) ; Statement: $r6 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository getRuleRepository()>() 
(define-const var1254 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1254)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1254!1 String)
(assert (= var1254!1 ""))
(define-const var237 String (ruleKey/2011034306 var95)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: java.lang.String ruleKey> 
(assert true)
(define-const var2290 String (append/672562846 var1254!1 var237)) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1254!2 String)
(assert (= var1254!2 (str.++ var1254!1 var237)))
(assert true)
(define-const var0 String (append/672562846 var2290 ".condition-router")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".condition-router") 
(declare-const var2290!1 String)
(assert (= var2290!1 (str.++ var2290 ".condition-router")))
(assert true)
(define-const var3927 String (toString/-2075883882 var0)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var417_removeListener/-314952793 var843 var3927 (cast-from-var654-to-var1855 var95))) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void removeListener(java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>($r5, r0) 

(declare-const var843!1 var417)
(declare-const var3927!1 String)
(declare-const var95!1 var654)
 ; Statement: return 
(check-sat)
; {getRuleRepository/-74457875=([org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter], org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository), cast-from-var654-to-var3871=([org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter], org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), ruleKey/2011034306=([org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var417_removeListener/-314952793=([org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, java.lang.String, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), cast-from-var654-to-var1855=([org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter], org.apache.dubbo.common.config.configcenter.ConfigurationListener)}
; {var654=org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter, var95=r0, var417=org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, var3871=org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter, var843=$r6, var1254=$r1, var237=$r2, var2290=$r3, var0=$r4, var3927=$r5, var1855=org.apache.dubbo.common.config.configcenter.ConfigurationListener}
; {org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter=var654, r0=var95, org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository=var417, org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter=var3871, $r6=var843, $r1=var1254, $r2=var237, $r3=var2290, $r4=var0, $r5=var3927, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var1855}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter;	$r6 = virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository getRuleRepository()>();	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = r0.<org.apache.dubbo.rpc.cluster.router.condition.config.ListenableStateRouter: java.lang.String ruleKey>;	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".condition-router");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void removeListener(java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>($r5, r0);	return
;block_num 1