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

(declare-sort var2868 0)
(declare-sort var1580 0)
(declare-sort var92 0)
(declare-sort var3280 0)
(declare-sort var2053 0)
(declare-sort var826 0)
(declare-sort var694 0)
(declare-sort var2410 0)
(declare-sort var3099 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun forbidden/2129308851 (var2868) Bool)
(declare-fun multiGroup/2129308851 (var2868) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/-950407827 (var2410) var694)
(declare-fun cast-from-var2868-to-var2410 (var2868) var2410)
(declare-fun append/-1031950772 (String var3099) String)
(declare-fun cast-from-var694-to-var3099 (var694) var3099)
(declare-fun getMessage/849299655 (var2053) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var826_error/377575788 (var826 String String String String var2053) void)
(declare-fun var92_emptyList/-142670980 () var92)
(declare-const null-var2868 var2868)
(declare-const null-var1580 var1580)
(declare-const null-var92 var92)
(declare-const null-var3280 var3280)
(declare-const null-var2053 var2053)
(declare-const var2868-logger var826)
(declare-const var3663 var2868) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory 
(assert (not (= var3663 null-var2868)))
(declare-const var1619 var1580) ; Statement: r1 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain 
(assert (not (= var1619 null-var1580)))
(declare-const var3812 var92) ; Statement: r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList 
(assert (not (= var3812 null-var92)))
(declare-const var1434 var3280) ; Statement: r3 := @parameter2: org.apache.dubbo.rpc.Invocation 
(assert (not (= var1434 null-var3280)))
(define-const var3058 Bool (forbidden/2129308851 var3663)) ; Statement: $z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean forbidden> 
 ; Statement: if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup> 
(assert (= (ite var3058 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3228 Bool (multiGroup/2129308851 var3663)) ; Statement: $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup> 
 ; Statement: if $z1 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert (not (= (ite var3228 1 0) 0))) ; Negate: Cond: $z1 == 0  
(declare-const var1920 var2053) ; Statement: $r22 := @caughtexception 
(assert (not (= var1920 null-var2053)))
(define-const var761 var826 var2868-logger) ; Statement: $r24 = <org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3315 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3315)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3315!1 String)
(assert (= var3315!1 ""))
(assert true)
(define-const var698 String (append/672562846 var3315!1 "Failed to execute router: ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to execute router: ") 
(declare-const var3315!2 String)
(assert (= var3315!2 (str.++ var3315!1 "Failed to execute router: ")))
(assert true)
(define-const var839 var694 (getUrl/-950407827 (cast-from-var2868-to-var2410 var3663))) ; Statement: $r25 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1296 String (append/-1031950772 var698 (cast-from-var694-to-var3099 var839))) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25) 
(declare-const var698!1 String)
(assert (str.prefixof var698 var698!1))
(assert true)
(define-const var2087 String (append/672562846 var1296 ", cause: ")) ; Statement: $r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var1296!1 String)
(assert (= var1296!1 (str.++ var1296 ", cause: ")))
(assert true)
(define-const var1111 String (getMessage/849299655 var1920)) ; Statement: $r28 = virtualinvoke $r22.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3454 String (append/672562846 var2087 var1111)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28) 
(declare-const var2087!1 String)
(assert (= var2087!1 (str.++ var2087 var1111)))
(assert true)
(define-const var3466 String (toString/-2075883882 var3454)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var826_error/377575788 var761 "2-1" "" "" var3466 var1920)) ; Statement: interfaceinvoke $r24.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-1", "", "", $r31, $r22) 

(declare-const var761!1 var826)
(declare-const var1850 String)
(declare-const var3864 String)
(declare-const var3864!1 String)
(declare-const var3466!1 String)
(declare-const var1920!1 var2053)
(define-const var3797 var92 var92_emptyList/-142670980) ; Statement: $r32 = staticinvoke <org.apache.dubbo.rpc.cluster.router.state.BitList: org.apache.dubbo.rpc.cluster.router.state.BitList emptyList()>() 
 ; Statement: return $r32 
(check-sat)
; {forbidden/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), multiGroup/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/-950407827=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), cast-from-var2868-to-var2410=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var694-to-var3099=([org.apache.dubbo.common.URL], java.lang.Object), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var826_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), var92_emptyList/-142670980=([], org.apache.dubbo.rpc.cluster.router.state.BitList)}
; {var2868=org.apache.dubbo.registry.integration.DynamicDirectory, var3663=r0, var1580=org.apache.dubbo.rpc.cluster.SingleRouterChain, var1619=r1, var92=org.apache.dubbo.rpc.cluster.router.state.BitList, var3812=r2, var3280=org.apache.dubbo.rpc.Invocation, var1434=r3, var3058=$z0, var3228=$z1, var2053=java.lang.Throwable, var1920=$r22, var826=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var761=$r24, var3315=$r23, var698=$r26, var694=org.apache.dubbo.common.URL, var2410=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var839=$r25, var3099=java.lang.Object, var1296=$r27, var2087=$r29, var1111=$r28, var3454=$r30, var3466=$r31, var1850="2-1", var3864="", var3797=$r32}
; {org.apache.dubbo.registry.integration.DynamicDirectory=var2868, r0=var3663, org.apache.dubbo.rpc.cluster.SingleRouterChain=var1580, r1=var1619, org.apache.dubbo.rpc.cluster.router.state.BitList=var92, r2=var3812, org.apache.dubbo.rpc.Invocation=var3280, r3=var1434, $z0=var3058, $z1=var3228, java.lang.Throwable=var2053, $r22=var1920, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var826, $r24=var761, $r23=var3315, $r26=var698, org.apache.dubbo.common.URL=var694, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var2410, $r25=var839, java.lang.Object=var3099, $r27=var1296, $r29=var2087, $r28=var1111, $r30=var3454, $r31=var3466, "2-1"=var1850, ""=var3864, $r32=var3797}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory;	r1 := @parameter0: org.apache.dubbo.rpc.cluster.SingleRouterChain;	r2 := @parameter1: org.apache.dubbo.rpc.cluster.router.state.BitList;	r3 := @parameter2: org.apache.dubbo.rpc.Invocation;	$z0 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean forbidden>;	if $z0 == 0 goto $z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup>;	$z1 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: boolean multiGroup>;	if $z1 == 0 goto $r4 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r22 := @caughtexception;	$r24 = <org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to execute router: ");	$r25 = virtualinvoke r0.<org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.URL getUrl()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r25);	$r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r28 = virtualinvoke $r22.<java.lang.Throwable: java.lang.String getMessage()>();	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r24.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-1", "", "", $r31, $r22);	$r32 = staticinvoke <org.apache.dubbo.rpc.cluster.router.state.BitList: org.apache.dubbo.rpc.cluster.router.state.BitList emptyList()>();	return $r32
;block_num 3