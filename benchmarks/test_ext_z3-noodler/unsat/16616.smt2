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

(declare-sort var1316 0)
(declare-sort var3768 0)
(declare-sort var2578 0)
(declare-sort var3262 0)
(declare-sort var3403 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3403_getClass/1258963082 (var3403) ClassObject)
(declare-fun cast-from-var3768-to-var3403 (var3768) var3403)
(declare-fun append/-1031950772 (String var3403) String)
(declare-fun cast-from-ClassObject-to-var3403 (ClassObject) var3403)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3262_error/-110665684 (var3262 String String String String) void)
(declare-const null-var1316 var1316)
(declare-const null-var3768 var3768)
(declare-const null-var2578 var2578)
(declare-const var1316-logger var3262)
(declare-const var2965 var1316) ; Statement: r9 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var2965 null-var1316)))
(declare-const var3785 var3768) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.cluster.ClusterInvoker 
(assert (not (= var3785 null-var3768)))
(declare-const var45 var2578) ; Statement: r2 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var45 null-var2578)))
(define-const var1345 Bool true) ; Statement: $z0 = r0 instanceof org.apache.dubbo.registry.client.migration.MigrationClusterInvoker 
 ; Statement: if $z0 != 0 goto r1 = (org.apache.dubbo.registry.client.migration.MigrationClusterInvoker) r0 
(assert (not (not (= (ite var1345 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3689 var3262 var1316-logger) ; Statement: $r4 = <org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1188 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1188)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1188!1 String)
(assert (= var1188!1 ""))
(assert true)
(define-const var2740 String (append/672562846 var1188!1 "Only invoker type of MigrationClusterInvoker supports reRefer, current invoker is ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Only invoker type of MigrationClusterInvoker supports reRefer, current invoker is ") 
(declare-const var1188!2 String)
(assert (= var1188!2 (str.++ var1188!1 "Only invoker type of MigrationClusterInvoker supports reRefer, current invoker is ")))
(define-const var2808 ClassObject (var3403_getClass/1258963082 (cast-from-var3768-to-var3403 var3785))) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.cluster.ClusterInvoker: java.lang.Class getClass()>() 
(assert true)
(define-const var2316 String (append/-1031950772 var2740 (cast-from-ClassObject-to-var3403 var2808))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var2740!1 String)
(assert (str.prefixof var2740 var2740!1))
(assert true)
(define-const var2966 String (toString/-2075883882 var2316)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3262_error/-110665684 var3689 "1-16" "" "" var2966)) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-16", "", "", $r8) 

(declare-const var3689!1 var3262)
(declare-const var2685 String)
(declare-const var1500 String)
(declare-const var1500!1 String)
(declare-const var2966!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3403_getClass/1258963082=([java.lang.Object], java.lang.Class), cast-from-var3768-to-var3403=([org.apache.dubbo.rpc.cluster.ClusterInvoker], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-ClassObject-to-var3403=([java.lang.Class], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3262_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var1316=org.apache.dubbo.registry.integration.RegistryProtocol, var2965=r9, var3768=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3785=r0, var2578=org.apache.dubbo.common.URL, var45=r2, var1345=$z0, var3262=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3689=$r4, var1188=$r3, var2740=$r6, var3403=java.lang.Object, var2808=$r5, var2316=$r7, var2966=$r8, var2685="1-16", var1500=""}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var1316, r9=var2965, org.apache.dubbo.rpc.cluster.ClusterInvoker=var3768, r0=var3785, org.apache.dubbo.common.URL=var2578, r2=var45, $z0=var1345, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3262, $r4=var3689, $r3=var1188, $r6=var2740, java.lang.Object=var3403, $r5=var2808, $r7=var2316, $r8=var2966, "1-16"=var2685, ""=var1500}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r9 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.rpc.cluster.ClusterInvoker;	r2 := @parameter1: org.apache.dubbo.common.URL;	$z0 = r0 instanceof org.apache.dubbo.registry.client.migration.MigrationClusterInvoker;	if $z0 != 0 goto r1 = (org.apache.dubbo.registry.client.migration.MigrationClusterInvoker) r0;	$r4 = <org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Only invoker type of MigrationClusterInvoker supports reRefer, current invoker is ");	$r5 = interfaceinvoke r0.<org.apache.dubbo.rpc.cluster.ClusterInvoker: java.lang.Class getClass()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-16", "", "", $r8);	return
;block_num 2