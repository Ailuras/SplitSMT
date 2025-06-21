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

(declare-sort var1507 0)
(declare-sort var2740 0)
(declare-sort var1361 0)
(declare-sort var2267 0)
(declare-sort var3465 0)
(declare-sort var189 0)
(declare-sort var3729 0)
(declare-sort var2383 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun setStarting/-110753059 (var2740) void)
(declare-fun cast-from-var1507-to-var2740 (var1507) var2740)
(declare-fun var1361-init () var1361)
(declare-fun <init>/-2088142221 (var1361) void)
(declare-fun startFuture/-1953096320 (var1507) var1361)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getIdentifier/-338683473 (var2740) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3465_info/484404803 (var3465 String) void)
(declare-fun cast-from-var2267-to-var3465 (var2267) var3465)
(declare-fun applicationDeployer/-1953096320 (var1507) var189)
(declare-fun moduleModel/-1953096320 (var1507) var3729)
(declare-fun var189_notifyModuleChanged/-1282065665 (var189 var3729 var2383) void)
(declare-const null-var1507 var1507)
(declare-const var1507-logger var2267)
(declare-const var2383-STARTING var2383)
(declare-const var3167 var1507) ; Statement: r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer 
(assert (not (= var3167 null-var1507)))
(assert true)
;(assert (setStarting/-110753059 (cast-from-var1507-to-var2740 var3167))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: void setStarting()>() 

(declare-const var3167!1 var1507)
(define-const var58 var1361 var1361-init) ; Statement: $r1 = new java.util.concurrent.CompletableFuture 
(assert true)
;(assert (<init>/-2088142221 var58)) ; Statement: specialinvoke $r1.<java.util.concurrent.CompletableFuture: void <init>()>() 

(declare-const var58!1 var1361)
(declare-const var3167!2 var1507)
(assert (not (= var3167!2 null-var1507)))
(assert (= (startFuture/-1953096320 var3167!2) var58!1)) ; Statement: r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.util.concurrent.CompletableFuture startFuture> = $r1 
(define-const var3564 var2267 var1507-logger) ; Statement: $r3 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2526 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2526)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2526!1 String)
(assert (= var2526!1 ""))
(assert true)
(define-const var3991 String (getIdentifier/-338683473 (cast-from-var1507-to-var2740 var3167!2))) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>() 
(assert true)
(define-const var3525 String (append/672562846 var2526!1 var3991)) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2526!2 String)
(assert (= var2526!2 (str.++ var2526!1 var3991)))
(assert true)
(define-const var75 String (append/672562846 var3525 " is starting.")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is starting.") 
(declare-const var3525!1 String)
(assert (= var3525!1 (str.++ var3525 " is starting.")))
(assert true)
(define-const var1270 String (toString/-2075883882 var75)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3465_info/484404803 (cast-from-var2267-to-var3465 var3564) var1270)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7) 

(declare-const var3564!1 var2267)
(declare-const var1270!1 String)
(define-const var595 var189 (applicationDeployer/-1953096320 var3167!2)) ; Statement: $r10 = r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.deploy.ApplicationDeployer applicationDeployer> 
(define-const var3353 var3729 (moduleModel/-1953096320 var3167!2)) ; Statement: $r9 = r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.rpc.model.ModuleModel moduleModel> 
(define-const var3994 var2383 var2383-STARTING) ; Statement: $r8 = <org.apache.dubbo.common.deploy.DeployState: org.apache.dubbo.common.deploy.DeployState STARTING> 
;(assert (var189_notifyModuleChanged/-1282065665 var595 var3353 var3994)) ; Statement: interfaceinvoke $r10.<org.apache.dubbo.common.deploy.ApplicationDeployer: void notifyModuleChanged(org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.common.deploy.DeployState)>($r9, $r8) 

(declare-const var595!1 var189)
(declare-const var3353!1 var3729)
(declare-const var3994!1 var2383)
 ; Statement: return 
(check-sat)
; {setStarting/-110753059=([org.apache.dubbo.common.deploy.AbstractDeployer], void), cast-from-var1507-to-var2740=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.AbstractDeployer), var1361-init=([], java.util.concurrent.CompletableFuture), <init>/-2088142221=([java.util.concurrent.CompletableFuture], void), startFuture/-1953096320=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], java.util.concurrent.CompletableFuture), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getIdentifier/-338683473=([org.apache.dubbo.common.deploy.AbstractDeployer], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3465_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2267-to-var3465=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), applicationDeployer/-1953096320=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.common.deploy.ApplicationDeployer), moduleModel/-1953096320=([org.apache.dubbo.config.deploy.DefaultModuleDeployer], org.apache.dubbo.rpc.model.ModuleModel), var189_notifyModuleChanged/-1282065665=([org.apache.dubbo.common.deploy.ApplicationDeployer, org.apache.dubbo.rpc.model.ModuleModel, org.apache.dubbo.common.deploy.DeployState], void)}
; {var1507=org.apache.dubbo.config.deploy.DefaultModuleDeployer, var3167=r0, var2740=org.apache.dubbo.common.deploy.AbstractDeployer, var1361=java.util.concurrent.CompletableFuture, var58=$r1, var2267=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3564=$r3, var2526=$r2, var3991=$r4, var3525=$r5, var75=$r6, var1270=$r7, var3465=org.apache.dubbo.common.logger.Logger, var189=org.apache.dubbo.common.deploy.ApplicationDeployer, var595=$r10, var3729=org.apache.dubbo.rpc.model.ModuleModel, var3353=$r9, var2383=org.apache.dubbo.common.deploy.DeployState, var3994=$r8}
; {org.apache.dubbo.config.deploy.DefaultModuleDeployer=var1507, r0=var3167, org.apache.dubbo.common.deploy.AbstractDeployer=var2740, java.util.concurrent.CompletableFuture=var1361, $r1=var58, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2267, $r3=var3564, $r2=var2526, $r4=var3991, $r5=var3525, $r6=var75, $r7=var1270, org.apache.dubbo.common.logger.Logger=var3465, org.apache.dubbo.common.deploy.ApplicationDeployer=var189, $r10=var595, org.apache.dubbo.rpc.model.ModuleModel=var3729, $r9=var3353, org.apache.dubbo.common.deploy.DeployState=var2383, $r8=var3994}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.deploy.DefaultModuleDeployer;	virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: void setStarting()>();	$r1 = new java.util.concurrent.CompletableFuture;	specialinvoke $r1.<java.util.concurrent.CompletableFuture: void <init>()>();	r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.util.concurrent.CompletableFuture startFuture> = $r1;	$r3 = <org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: java.lang.String getIdentifier()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is starting.");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7);	$r10 = r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.common.deploy.ApplicationDeployer applicationDeployer>;	$r9 = r0.<org.apache.dubbo.config.deploy.DefaultModuleDeployer: org.apache.dubbo.rpc.model.ModuleModel moduleModel>;	$r8 = <org.apache.dubbo.common.deploy.DeployState: org.apache.dubbo.common.deploy.DeployState STARTING>;	interfaceinvoke $r10.<org.apache.dubbo.common.deploy.ApplicationDeployer: void notifyModuleChanged(org.apache.dubbo.rpc.model.ModuleModel,org.apache.dubbo.common.deploy.DeployState)>($r9, $r8);	return
;block_num 1