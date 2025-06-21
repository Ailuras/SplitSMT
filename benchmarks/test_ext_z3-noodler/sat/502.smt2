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

(declare-sort var1017 0)
(declare-sort var3060 0)
(declare-sort var71 0)
(declare-sort var3587 0)
(declare-sort var2841 0)
(declare-sort var685 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun ruleRepository/-1763037024 (var1017) var3587)
(declare-fun var3587_removeListener/-1531669504 (var3587 String String var2841) void)
(declare-fun cast-from-var71-to-var2841 (var71) var2841)
(declare-fun envListeners/-1763037024 (var1017) var685)
(declare-fun var685_iterator/1911472585 (var685) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var1017 var1017)
(declare-const null-String String)
(declare-const null-var71 var71)
(declare-const var977 var1017) ; Statement: r5 := @this: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager 
(assert (not (= var977 null-var1017)))
(declare-const var3494 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3494 null-String)))
(declare-const var1446 var71) ; Statement: r6 := @parameter1: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener 
(assert (not (= var1446 null-var71)))
(define-const var2085 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2085)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2085!1 String)
(assert (= var2085!1 ""))
(assert true)
(define-const var1141 String (append/672562846 var2085!1 var3494)) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2085!2 String)
(assert (= var2085!2 (str.++ var2085!1 var3494)))
(assert true)
(define-const var2795 String (append/672562846 var1141 ".MESHAPPRULE")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".MESHAPPRULE") 
(declare-const var1141!1 String)
(assert (= var1141!1 (str.++ var1141 ".MESHAPPRULE")))
(assert true)
(define-const var681 String (toString/-2075883882 var2795)) ; Statement: r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3446 var3587 (ruleRepository/-1763037024 var977)) ; Statement: $r7 = r5.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository> 
;(assert (var3587_removeListener/-1531669504 var3446 var681 "dubbo" (cast-from-var71-to-var2841 var1446))) ; Statement: interfaceinvoke $r7.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void removeListener(java.lang.String,java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r4, "dubbo", r6) 

(declare-const var3446!1 var3587)
(declare-const var681!1 String)
(declare-const var2520 String)
(declare-const var1446!1 var71)
(define-const var1687 var685 (envListeners/-1763037024 var977)) ; Statement: $r8 = r5.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.Set envListeners> 
(define-const var3525 Iterator (var685_iterator/1911472585 var1687)) ; Statement: r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2190 Bool (Iterator_hasNext/-1669924200 var3525)) ; Statement: $z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2190 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), ruleRepository/-1763037024=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager], org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository), var3587_removeListener/-1531669504=([org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, java.lang.String, java.lang.String, org.apache.dubbo.common.config.configcenter.ConfigurationListener], void), cast-from-var71-to-var2841=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener], org.apache.dubbo.common.config.configcenter.ConfigurationListener), envListeners/-1763037024=([org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager], java.util.Set), var685_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var1017=org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager, var977=r5, var3494=r1, var3060=null_type, var71=org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener, var1446=r6, var2085=$r0, var1141=$r2, var2795=$r3, var681=r4, var3587=org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository, var3446=$r7, var2841=org.apache.dubbo.common.config.configcenter.ConfigurationListener, var2520="dubbo", var685=java.util.Set, var1687=$r8, var3525=r9, var2190=$z0}
; {org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager=var1017, r5=var977, r1=var3494, null_type=var3060, org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener=var71, r6=var1446, $r0=var2085, $r2=var1141, $r3=var2795, r4=var681, org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository=var3587, $r7=var3446, org.apache.dubbo.common.config.configcenter.ConfigurationListener=var2841, "dubbo"=var2520, java.util.Set=var685, $r8=var1687, r9=var3525, $z0=var2190}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r5 := @this: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager;	r1 := @parameter0: java.lang.String;	r6 := @parameter1: org.apache.dubbo.rpc.cluster.router.mesh.route.MeshAppRuleListener;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".MESHAPPRULE");	r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = r5.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository ruleRepository>;	interfaceinvoke $r7.<org.apache.dubbo.rpc.cluster.governance.GovernanceRuleRepository: void removeListener(java.lang.String,java.lang.String,org.apache.dubbo.common.config.configcenter.ConfigurationListener)>(r4, "dubbo", r6);	$r8 = r5.<org.apache.dubbo.rpc.cluster.router.mesh.route.MeshRuleManager: java.util.Set envListeners>;	r9 = interfaceinvoke $r8.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r9.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	return
;block_num 3