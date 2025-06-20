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

(declare-sort var1259 0)
(declare-sort var561 0)
(declare-sort var53 0)
(declare-sort var3116 0)
(declare-sort var1312 0)
(declare-sort var2337 0)
(declare-sort var3999 0)
(declare-sort var839 0)
(declare-sort var968 0)
(declare-sort var376 0)
(declare-sort var2478 0)
(declare-sort var3585 0)
(declare-sort var2085 0)
(declare-sort var2412 0)
(declare-sort var3834 0)
(declare-sort var1803 0)
(declare-sort var1299 0)
(declare-sort var1199 0)
(declare-sort var3030 0)
(declare-sort var1698 0)
(declare-sort var3015 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-1029467046 (var53 var561) void)
(declare-fun cast-from-var1259-to-var53 (var1259) var53)
(declare-fun var3116-init () var3116)
(declare-fun <init>/169859851 (var3116) void)
(declare-fun var1312-init () var1312)
(declare-fun <init>/726770977 (var1312 String) void)
(declare-fun add/1448863245 (var3116 var2337) void)
(declare-fun cast-from-var1312-to-var2337 (var1312) var2337)
(declare-fun var3999-init () var3999)
(declare-fun var839-init () var839)
(declare-fun <init>/-2075632278 (var839 var376 (Array Int var968)) void)
(declare-fun <init>/1828495323 (var3999 var839 var3585) void)
(declare-fun cast-from-var3116-to-var3585 (var3116) var3585)
(declare-fun var2085-init () var2085)
(declare-fun arr-var3999-init () (Array Int var3999))
(declare-fun <init>/1310643706 (var2085 (Array Int var3999)) void)
(declare-fun accessControlContext/1094165038 (var1259) var2085)
(declare-fun setUrl/1814894165 (var53 var561) void)
(declare-fun getEngine/598019551 (var1259 var561) var2412)
(declare-fun engine/1094165038 (var1259) var2412)
(declare-fun getRule/1429782886 (var1259 var561) String)
(declare-fun rule/1094165038 (var1259) String)
(declare-fun cast-from-var2412-to-var3834 (var2412) var3834)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3030_getServiceContext/735675290 () var1199)
(declare-fun getUrl/1783180996 (var1199) var561)
(declare-fun append/-1031950772 (String var1698) String)
(declare-fun cast-from-var561-to-var1698 (var561) var1698)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1299_error/377575788 (var1299 String String String String var3015) void)
(declare-fun cast-from-var1803-to-var3015 (var1803) var3015)
(declare-const null-var1259 var1259)
(declare-const null-var561 var561)
(declare-const null-__Array__Int__var968__ (Array Int var968))
(declare-const null-NullType var2478)
(declare-const null-var376 var376)
(declare-const null-__Array__Int__var3999__ (Array Int var3999))
(declare-const null-var1803 var1803)
(declare-const var1259-logger var1299)
(declare-const var3344 var1259) ; Statement: r0 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter 
(assert (not (= var3344 null-var1259)))
(declare-const var3727 var561) ; Statement: r1 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3727 null-var561)))
(assert true)
;(assert (<init>/-1029467046 (cast-from-var1259-to-var53 var3344) var3727)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter: void <init>(org.apache.dubbo.common.URL)>(r1) 

(declare-const var3344!1 var1259)
(declare-const var3727!1 var561)
(define-const var3872 var3116 var3116-init) ; Statement: $r2 = new java.security.Permissions 
(assert true)
;(assert (<init>/169859851 var3872)) ; Statement: specialinvoke $r2.<java.security.Permissions: void <init>()>() 

(declare-const var3872!1 var3116)
(define-const var3074 var1312 var1312-init) ; Statement: $r3 = new java.lang.RuntimePermission 
(assert true)
;(assert (<init>/726770977 var3074 "accessDeclaredMembers")) ; Statement: specialinvoke $r3.<java.lang.RuntimePermission: void <init>(java.lang.String)>("accessDeclaredMembers") 

(declare-const var3074!1 var1312)
(declare-const var273 String)
(assert true)
;(assert (add/1448863245 var3872!1 (cast-from-var1312-to-var2337 var3074!1))) ; Statement: virtualinvoke $r2.<java.security.Permissions: void add(java.security.Permission)>($r3) 

(declare-const var3872!2 var3116)
(declare-const var3074!2 var1312)
(define-const var2963 var3999 var3999-init) ; Statement: $r4 = new java.security.ProtectionDomain 
(define-const var3294 var839 var839-init) ; Statement: $r5 = new java.security.CodeSource 
(define-const var301 (Array Int var968) null-__Array__Int__var968__) ; Statement: $r6 = (java.security.cert.Certificate[]) null 
(assert true)
;(assert (<init>/-2075632278 var3294 null-var376 var301)) ; Statement: specialinvoke $r5.<java.security.CodeSource: void <init>(java.net.URL,java.security.cert.Certificate[])>(null, $r6) 

(declare-const var3294!1 var839)
(declare-const var1473 var2478)
(declare-const var301!1 (Array Int var968))
(assert true)
;(assert (<init>/1828495323 var2963 var3294!1 (cast-from-var3116-to-var3585 var3872!2))) ; Statement: specialinvoke $r4.<java.security.ProtectionDomain: void <init>(java.security.CodeSource,java.security.PermissionCollection)>($r5, $r2) 

(declare-const var2963!1 var3999)
(declare-const var3294!2 var839)
(declare-const var3872!3 var3116)
(define-const var1039 var2085 var2085-init) ; Statement: $r7 = new java.security.AccessControlContext 
(define-const var478 (Array Int var3999) arr-var3999-init) ; Statement: $r8 = newarray (java.security.ProtectionDomain)[1] 
(declare-const var478!1 (Array Int var3999))
(assert (not (= var478!1 null-__Array__Int__var3999__)))
(assert (= (select var478!1 0) var2963!1)) ; Statement: $r8[0] = $r4 
(assert true)
;(assert (<init>/1310643706 var1039 var478!1)) ; Statement: specialinvoke $r7.<java.security.AccessControlContext: void <init>(java.security.ProtectionDomain[])>($r8) 

(declare-const var1039!1 var2085)
(declare-const var478!2 (Array Int var3999))
(declare-const var3344!2 var1259)
(assert (not (= var3344!2 null-var1259)))
(assert (= (accessControlContext/1094165038 var3344!2) var1039!1)) ; Statement: r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.security.AccessControlContext accessControlContext> = $r7 
(assert true)
;(assert (setUrl/1814894165 (cast-from-var1259-to-var53 var3344!2) var3727!1)) ; Statement: virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: void setUrl(org.apache.dubbo.common.URL)>(r1) 

(declare-const var3344!3 var1259)
(declare-const var3727!2 var561)
(assert true)
(define-const var3137 var2412 (getEngine/598019551 var3344!3 var3727!2)) ; Statement: $r9 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.ScriptEngine getEngine(org.apache.dubbo.common.URL)>(r1) 
(declare-const var3344!4 var1259)
(assert (not (= var3344!4 null-var1259)))
(assert (= (engine/1094165038 var3344!4) var3137)) ; Statement: r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.ScriptEngine engine> = $r9 
(assert true)
(define-const var89 String (getRule/1429782886 var3344!4 var3727!2)) ; Statement: $r10 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String getRule(org.apache.dubbo.common.URL)>(r1) 
(declare-const var3344!5 var1259)
(assert (not (= var3344!5 null-var1259)))
(assert (= (rule/1094165038 var3344!5) var89)) ; Statement: r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule> = $r10 
(define-const var3929 var2412 (engine/1094165038 var3344!5)) ; Statement: $r11 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.ScriptEngine engine> 
(define-const var1193 var3834 (cast-from-var2412-to-var3834 var3929)) ; Statement: r25 = (javax.script.Compilable) $r11 
(define-const var1687 String (rule/1094165038 var3344!5)) ; Statement: $r12 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1818 var1803) ; Statement: $r14 := @caughtexception 
(assert (not (= var1818 null-var1803)))
(define-const var3968 var1299 var1259-logger) ; Statement: $r16 = <org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3337 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3337)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3337!1 String)
(assert (= var3337!1 ""))
(assert true)
(define-const var579 String (append/672562846 var3337!1 "script route error, rule has been ignored. rule: ")) ; Statement: $r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("script route error, rule has been ignored. rule: ") 
(declare-const var3337!2 String)
(assert (= var3337!2 (str.++ var3337!1 "script route error, rule has been ignored. rule: ")))
(define-const var1463 String (rule/1094165038 var3344!5)) ; Statement: $r17 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule> 
(assert true)
(define-const var3829 String (append/672562846 var579 var1463)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var579!1 String)
(assert (= var579!1 (str.++ var579 var1463)))
(assert true)
(define-const var617 String (append/672562846 var3829 ", url: ")) ; Statement: $r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", url: ") 
(declare-const var3829!1 String)
(assert (= var3829!1 (str.++ var3829 ", url: ")))
(define-const var1577 var1199 var3030_getServiceContext/735675290) ; Statement: $r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var3497 var561 (getUrl/1783180996 var1577)) ; Statement: $r21 = virtualinvoke $r20.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var748 String (append/-1031950772 var617 (cast-from-var561-to-var1698 var3497))) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r21) 
(declare-const var617!1 String)
(assert (str.prefixof var617 var617!1))
(assert true)
(define-const var2654 String (toString/-2075883882 var748)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1299_error/377575788 var3968 "2-14" "script route rule invalid" "" var2654 (cast-from-var1803-to-var3015 var1818))) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-14", "script route rule invalid", "", $r24, $r14) 

(declare-const var3968!1 var1299)
(declare-const var535 String)
(declare-const var1530 String)
(declare-const var3804 String)
(declare-const var2654!1 String)
(declare-const var1818!1 var1803)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {<init>/-1029467046=([org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter, org.apache.dubbo.common.URL], void), cast-from-var1259-to-var53=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter], org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter), var3116-init=([], java.security.Permissions), <init>/169859851=([java.security.Permissions], void), var1312-init=([], java.lang.RuntimePermission), <init>/726770977=([java.lang.RuntimePermission, java.lang.String], void), add/1448863245=([java.security.Permissions, java.security.Permission], void), cast-from-var1312-to-var2337=([java.lang.RuntimePermission], java.security.Permission), var3999-init=([], java.security.ProtectionDomain), var839-init=([], java.security.CodeSource), <init>/-2075632278=([java.security.CodeSource, java.net.URL, java.security.cert.Certificate[]], void), <init>/1828495323=([java.security.ProtectionDomain, java.security.CodeSource, java.security.PermissionCollection], void), cast-from-var3116-to-var3585=([java.security.Permissions], java.security.PermissionCollection), var2085-init=([], java.security.AccessControlContext), arr-var3999-init=([], java.security.ProtectionDomain[]), <init>/1310643706=([java.security.AccessControlContext, java.security.ProtectionDomain[]], void), accessControlContext/1094165038=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter], java.security.AccessControlContext), setUrl/1814894165=([org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter, org.apache.dubbo.common.URL], void), getEngine/598019551=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter, org.apache.dubbo.common.URL], javax.script.ScriptEngine), engine/1094165038=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter], javax.script.ScriptEngine), getRule/1429782886=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter, org.apache.dubbo.common.URL], java.lang.String), rule/1094165038=([org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter], java.lang.String), cast-from-var2412-to-var3834=([javax.script.ScriptEngine], javax.script.Compilable), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3030_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getUrl/1783180996=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var561-to-var1698=([org.apache.dubbo.common.URL], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1299_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var1803-to-var3015=([javax.script.ScriptException], java.lang.Throwable)}
; {var1259=org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter, var3344=r0, var561=org.apache.dubbo.common.URL, var3727=r1, var53=org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter, var3116=java.security.Permissions, var3872=$r2, var1312=java.lang.RuntimePermission, var3074=$r3, var273="accessDeclaredMembers", var2337=java.security.Permission, var3999=java.security.ProtectionDomain, var2963=$r4, var839=java.security.CodeSource, var3294=$r5, var968=java.security.cert.Certificate, var301=$r6, var376=java.net.URL, var1473=null, var2478=null_type, var3585=java.security.PermissionCollection, var2085=java.security.AccessControlContext, var1039=$r7, var478=$r8, var2412=javax.script.ScriptEngine, var3137=$r9, var89=$r10, var3929=$r11, var3834=javax.script.Compilable, var1193=r25, var1687=$r12, var1803=javax.script.ScriptException, var1818=$r14, var1299=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3968=$r16, var3337=$r15, var579=$r18, var1463=$r17, var3829=$r19, var617=$r22, var1199=org.apache.dubbo.rpc.RpcServiceContext, var3030=org.apache.dubbo.rpc.RpcContext, var1577=$r20, var3497=$r21, var1698=java.lang.Object, var748=$r23, var2654=$r24, var3015=java.lang.Throwable, var535="2-14", var1530="script route rule invalid", var3804=""}
; {org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter=var1259, r0=var3344, org.apache.dubbo.common.URL=var561, r1=var3727, org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter=var53, java.security.Permissions=var3116, $r2=var3872, java.lang.RuntimePermission=var1312, $r3=var3074, "accessDeclaredMembers"=var273, java.security.Permission=var2337, java.security.ProtectionDomain=var3999, $r4=var2963, java.security.CodeSource=var839, $r5=var3294, java.security.cert.Certificate=var968, $r6=var301, java.net.URL=var376, null=var1473, null_type=var2478, java.security.PermissionCollection=var3585, java.security.AccessControlContext=var2085, $r7=var1039, $r8=var478, javax.script.ScriptEngine=var2412, $r9=var3137, $r10=var89, $r11=var3929, javax.script.Compilable=var3834, r25=var1193, $r12=var1687, javax.script.ScriptException=var1803, $r14=var1818, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1299, $r16=var3968, $r15=var3337, $r18=var579, $r17=var1463, $r19=var3829, $r22=var617, org.apache.dubbo.rpc.RpcServiceContext=var1199, org.apache.dubbo.rpc.RpcContext=var3030, $r20=var1577, $r21=var3497, java.lang.Object=var1698, $r23=var748, $r24=var2654, java.lang.Throwable=var3015, "2-14"=var535, "script route rule invalid"=var1530, ""=var3804}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter;	r1 := @parameter0: org.apache.dubbo.common.URL;	specialinvoke r0.<org.apache.dubbo.rpc.cluster.router.state.AbstractStateRouter: void <init>(org.apache.dubbo.common.URL)>(r1);	$r2 = new java.security.Permissions;	specialinvoke $r2.<java.security.Permissions: void <init>()>();	$r3 = new java.lang.RuntimePermission;	specialinvoke $r3.<java.lang.RuntimePermission: void <init>(java.lang.String)>("accessDeclaredMembers");	virtualinvoke $r2.<java.security.Permissions: void add(java.security.Permission)>($r3);	$r4 = new java.security.ProtectionDomain;	$r5 = new java.security.CodeSource;	$r6 = (java.security.cert.Certificate[]) null;	specialinvoke $r5.<java.security.CodeSource: void <init>(java.net.URL,java.security.cert.Certificate[])>(null, $r6);	specialinvoke $r4.<java.security.ProtectionDomain: void <init>(java.security.CodeSource,java.security.PermissionCollection)>($r5, $r2);	$r7 = new java.security.AccessControlContext;	$r8 = newarray (java.security.ProtectionDomain)[1];	$r8[0] = $r4;	specialinvoke $r7.<java.security.AccessControlContext: void <init>(java.security.ProtectionDomain[])>($r8);	r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.security.AccessControlContext accessControlContext> = $r7;	virtualinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: void setUrl(org.apache.dubbo.common.URL)>(r1);	$r9 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.ScriptEngine getEngine(org.apache.dubbo.common.URL)>(r1);	r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.ScriptEngine engine> = $r9;	$r10 = specialinvoke r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String getRule(org.apache.dubbo.common.URL)>(r1);	r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule> = $r10;	$r11 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: javax.script.ScriptEngine engine>;	r25 = (javax.script.Compilable) $r11;	$r12 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule>;	$r14 := @caughtexception;	$r16 = <org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("script route error, rule has been ignored. rule: ");	$r17 = r0.<org.apache.dubbo.rpc.cluster.router.script.ScriptStateRouter: java.lang.String rule>;	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r22 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", url: ");	$r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r21 = virtualinvoke $r20.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getUrl()>();	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r21);	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("2-14", "script route rule invalid", "", $r24, $r14);	return
;block_num 3