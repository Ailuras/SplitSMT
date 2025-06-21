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

(declare-sort var2827 0)
(declare-sort var2009 0)
(declare-sort var2355 0)
(declare-sort var681 0)
(declare-sort var2410 0)
(declare-sort var1822 0)
(declare-sort var1634 0)
(declare-sort var3684 0)
(declare-sort var1292 0)
(declare-sort var1207 0)
(declare-sort var1784 0)
(declare-sort var2499 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1822-init () var1822)
(declare-fun getAttributes/-1462259152 (var681) var2410)
(declare-fun <init>/-1344032113 (var1822 var2410) void)
(declare-fun var2410_remove/-1201052315 (var2410 var1634) var1634)
(declare-fun cast-from-var1822-to-var2410 (var1822) var2410)
(declare-fun cast-from-String-to-var1634 (String) var1634)
(declare-fun var2410_get/1088891777 (var2410 var1634) var1634)
(declare-fun cast-from-var1634-to-String (var1634) String)
(declare-fun var3684_isEmpty/-813097145 (String) Bool)
(declare-fun var1292-init () var1292)
(declare-fun getPath/-1129700835 (var2827 var2410 ClassObject) String)
(declare-fun <init>/1683865000 (var1292 String String String String Int String var2410 var2410) void)
(declare-fun putAttribute/-158571106 (var681 String var1634) var681)
(declare-fun cast-from-var1292-to-var1634 (var1292) var1634)
(declare-fun getMigrationInvoker/-574699901 (var2827 var2827 var2009 var2355 ClassObject var681 var681) var1784)
(declare-fun cast-from-var1292-to-var681 (var1292) var681)
(declare-fun interceptInvoker/-513464851 (var2827 var1784 var681 var681) var2499)
(declare-const null-var2827 var2827)
(declare-const null-var2009 var2009)
(declare-const null-var2355 var2355)
(declare-const null-ClassObject ClassObject)
(declare-const null-var681 var681)
(declare-const null-var2410 var2410)
(declare-const null-NullType var1207)
(declare-const null-String String)
(declare-const var3806 var2827) ; Statement: r8 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var3806 null-var2827)))
(declare-const var2836 var2009) ; Statement: r12 := @parameter0: org.apache.dubbo.rpc.cluster.Cluster 
(assert (not (= var2836 null-var2009)))
(declare-const var1904 var2355) ; Statement: r13 := @parameter1: org.apache.dubbo.registry.Registry 
(assert (not (= var1904 null-var2355)))
(declare-const var2255 ClassObject) ; Statement: r9 := @parameter2: java.lang.Class 
(assert (not (= var2255 null-ClassObject)))
(declare-const var2402 var681) ; Statement: r17 := @parameter3: org.apache.dubbo.common.URL 
(assert (not (= var2402 null-var681)))
(declare-const var2408 var2410) ; Statement: r2 := @parameter4: java.util.Map 
(assert (not (= var2408 null-var2410)))
(define-const var1144 var1822 var1822-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
(define-const var3204 var2410 (getAttributes/-1462259152 var2402)) ; Statement: $r1 = virtualinvoke r17.<org.apache.dubbo.common.URL: java.util.Map getAttributes()>() 
(assert true)
;(assert (<init>/-1344032113 var1144 var3204)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>(java.util.Map)>($r1) 

(declare-const var1144!1 var1822)
(declare-const var3204!1 var2410)
;(assert (var2410_remove/-1201052315 (cast-from-var1822-to-var2410 var1144!1) (cast-from-String-to-var1634 "refer"))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("refer") 

(declare-const var1144!2 var1822)
(declare-const var2441 String)
(define-const var1161 var1634 (var2410_get/1088891777 var2408 (cast-from-String-to-var1634 "protocol"))) ; Statement: $r3 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(define-const var3408 String (cast-from-var1634-to-String var1161)) ; Statement: $r4 = (java.lang.String) $r3 
(define-const var2396 Bool (var3684_isEmpty/-813097145 var3408)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto $r5 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(assert (= (ite var2396 1 0) 0)) ; Cond: $z0 == 0 
(define-const var122 var1634 (var2410_get/1088891777 var2408 (cast-from-String-to-var1634 "protocol"))) ; Statement: $r5 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(define-const var3394 String (cast-from-var1634-to-String var122)) ; Statement: $r18 = (java.lang.String) $r5 
(assert true) ; Non Conditional
(define-const var2872 var1292 var1292-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var1763 var1634 (var2410_get/1088891777 var2408 (cast-from-String-to-var1634 "register.ip"))) ; Statement: $r7 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip") 
(define-const var1420 String (cast-from-var1634-to-String var1763)) ; Statement: $r11 = (java.lang.String) $r7 
(assert true)
(define-const var1565 String (getPath/-1129700835 var3806 var2408 var2255)) ; Statement: $r10 = specialinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: java.lang.String getPath(java.util.Map,java.lang.Class)>(r2, r9) 
(assert true)
;(assert (<init>/1683865000 var2872 var3394 null-String null-String var1420 0 var1565 var2408 (cast-from-var1822-to-var2410 var1144!2))) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map,java.util.Map)>($r18, null, null, $r11, 0, $r10, r2, $r0) 

(declare-const var2872!1 var1292)
(declare-const var3394!1 String)
(declare-const var34 var1207)
(declare-const var34!1 var1207)
(declare-const var1420!1 String)
(declare-const var2014 Int)
(declare-const var1565!1 String)
(declare-const var2408!1 var2410)
(declare-const var1144!3 var1822)
(assert true)
(define-const var1357 var681 (putAttribute/-158571106 var2402 "CONSUMER_URL" (cast-from-var1292-to-var1634 var2872!1))) ; Statement: $r15 = virtualinvoke r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL putAttribute(java.lang.String,java.lang.Object)>("CONSUMER_URL", $r6) 
(assert true)
(define-const var2017 var1784 (getMigrationInvoker/-574699901 var3806 var3806 var2836 var1904 var2255 var1357 (cast-from-var1292-to-var681 var2872!1))) ; Statement: $r16 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.cluster.ClusterInvoker getMigrationInvoker(org.apache.dubbo.registry.integration.RegistryProtocol,org.apache.dubbo.rpc.cluster.Cluster,org.apache.dubbo.registry.Registry,java.lang.Class,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>(r8, r12, r13, r9, $r15, $r6) 
(assert true)
(define-const var3809 var2499 (interceptInvoker/-513464851 var3806 var2017 var1357 (cast-from-var1292-to-var681 var2872!1))) ; Statement: $r14 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.Invoker interceptInvoker(org.apache.dubbo.rpc.cluster.ClusterInvoker,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>($r16, $r15, $r6) 
 ; Statement: return $r14 
(check-sat)
; {var1822-init=([], java.util.HashMap), getAttributes/-1462259152=([org.apache.dubbo.common.URL], java.util.Map), <init>/-1344032113=([java.util.HashMap, java.util.Map], void), var2410_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1822-to-var2410=([java.util.HashMap], java.util.Map), cast-from-String-to-var1634=([java.lang.String], java.lang.Object), var2410_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1634-to-String=([java.lang.Object], java.lang.String), var3684_isEmpty/-813097145=([java.lang.String], boolean), var1292-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), getPath/-1129700835=([org.apache.dubbo.registry.integration.RegistryProtocol, java.util.Map, java.lang.Class], java.lang.String), <init>/1683865000=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map, java.util.Map], void), putAttribute/-158571106=([org.apache.dubbo.common.URL, java.lang.String, java.lang.Object], org.apache.dubbo.common.URL), cast-from-var1292-to-var1634=([org.apache.dubbo.common.url.component.ServiceConfigURL], java.lang.Object), getMigrationInvoker/-574699901=([org.apache.dubbo.registry.integration.RegistryProtocol, org.apache.dubbo.registry.integration.RegistryProtocol, org.apache.dubbo.rpc.cluster.Cluster, org.apache.dubbo.registry.Registry, java.lang.Class, org.apache.dubbo.common.URL, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.cluster.ClusterInvoker), cast-from-var1292-to-var681=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), interceptInvoker/-513464851=([org.apache.dubbo.registry.integration.RegistryProtocol, org.apache.dubbo.rpc.cluster.ClusterInvoker, org.apache.dubbo.common.URL, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Invoker)}
; {var2827=org.apache.dubbo.registry.integration.RegistryProtocol, var3806=r8, var2009=org.apache.dubbo.rpc.cluster.Cluster, var2836=r12, var2355=org.apache.dubbo.registry.Registry, var1904=r13, var2255=r9, var681=org.apache.dubbo.common.URL, var2402=r17, var2410=java.util.Map, var2408=r2, var1822=java.util.HashMap, var1144=$r0, var3204=$r1, var1634=java.lang.Object, var2441="refer", var1161=$r3, var3408=$r4, var3684=org.apache.dubbo.common.utils.StringUtils, var2396=$z0, var122=$r5, var3394=$r18, var1292=org.apache.dubbo.common.url.component.ServiceConfigURL, var2872=$r6, var1763=$r7, var1420=$r11, var1565=$r10, var1207=null_type, var34=null, var2014=0, var1357=$r15, var1784=org.apache.dubbo.rpc.cluster.ClusterInvoker, var2017=$r16, var2499=org.apache.dubbo.rpc.Invoker, var3809=$r14}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var2827, r8=var3806, org.apache.dubbo.rpc.cluster.Cluster=var2009, r12=var2836, org.apache.dubbo.registry.Registry=var2355, r13=var1904, r9=var2255, org.apache.dubbo.common.URL=var681, r17=var2402, java.util.Map=var2410, r2=var2408, java.util.HashMap=var1822, $r0=var1144, $r1=var3204, java.lang.Object=var1634, "refer"=var2441, $r3=var1161, $r4=var3408, org.apache.dubbo.common.utils.StringUtils=var3684, $z0=var2396, $r5=var122, $r18=var3394, org.apache.dubbo.common.url.component.ServiceConfigURL=var1292, $r6=var2872, $r7=var1763, $r11=var1420, $r10=var1565, null_type=var1207, null=var34, 0=var2014, $r15=var1357, org.apache.dubbo.rpc.cluster.ClusterInvoker=var1784, $r16=var2017, org.apache.dubbo.rpc.Invoker=var2499, $r14=var3809}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r8 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r12 := @parameter0: org.apache.dubbo.rpc.cluster.Cluster;	r13 := @parameter1: org.apache.dubbo.registry.Registry;	r9 := @parameter2: java.lang.Class;	r17 := @parameter3: org.apache.dubbo.common.URL;	r2 := @parameter4: java.util.Map;	$r0 = new java.util.HashMap;	$r1 = virtualinvoke r17.<org.apache.dubbo.common.URL: java.util.Map getAttributes()>();	specialinvoke $r0.<java.util.HashMap: void <init>(java.util.Map)>($r1);	interfaceinvoke $r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("refer");	$r3 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r4 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto $r5 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r5 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r18 = (java.lang.String) $r5;	$r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r7 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip");	$r11 = (java.lang.String) $r7;	$r10 = specialinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: java.lang.String getPath(java.util.Map,java.lang.Class)>(r2, r9);	specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map,java.util.Map)>($r18, null, null, $r11, 0, $r10, r2, $r0);	$r15 = virtualinvoke r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL putAttribute(java.lang.String,java.lang.Object)>("CONSUMER_URL", $r6);	$r16 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.cluster.ClusterInvoker getMigrationInvoker(org.apache.dubbo.registry.integration.RegistryProtocol,org.apache.dubbo.rpc.cluster.Cluster,org.apache.dubbo.registry.Registry,java.lang.Class,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>(r8, r12, r13, r9, $r15, $r6);	$r14 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.Invoker interceptInvoker(org.apache.dubbo.rpc.cluster.ClusterInvoker,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>($r16, $r15, $r6);	return $r14
;block_num 3