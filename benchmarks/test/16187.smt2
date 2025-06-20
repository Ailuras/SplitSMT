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

(declare-sort var3917 0)
(declare-sort var1091 0)
(declare-sort var3970 0)
(declare-sort var797 0)
(declare-sort var3903 0)
(declare-sort var3798 0)
(declare-sort var2767 0)
(declare-sort var254 0)
(declare-sort var3493 0)
(declare-sort var1738 0)
(declare-sort var3238 0)
(declare-sort var2818 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3798-init () var3798)
(declare-fun getAttributes/-1462259152 (var797) var3903)
(declare-fun <init>/-1344032113 (var3798 var3903) void)
(declare-fun var3903_remove/-1201052315 (var3903 var2767) var2767)
(declare-fun cast-from-var3798-to-var3903 (var3798) var3903)
(declare-fun cast-from-String-to-var2767 (String) var2767)
(declare-fun var3903_get/1088891777 (var3903 var2767) var2767)
(declare-fun cast-from-var2767-to-String (var2767) String)
(declare-fun var254_isEmpty/-813097145 (String) Bool)
(declare-fun var3493-init () var3493)
(declare-fun getPath/-1129700835 (var3917 var3903 ClassObject) String)
(declare-fun <init>/1683865000 (var3493 String String String String Int String var3903 var3903) void)
(declare-fun putAttribute/-158571106 (var797 String var2767) var797)
(declare-fun cast-from-var3493-to-var2767 (var3493) var2767)
(declare-fun getMigrationInvoker/-574699901 (var3917 var3917 var1091 var3970 ClassObject var797 var797) var3238)
(declare-fun cast-from-var3493-to-var797 (var3493) var797)
(declare-fun interceptInvoker/-513464851 (var3917 var3238 var797 var797) var2818)
(declare-const null-var3917 var3917)
(declare-const null-var1091 var1091)
(declare-const null-var3970 var3970)
(declare-const null-ClassObject ClassObject)
(declare-const null-var797 var797)
(declare-const null-var3903 var3903)
(declare-const null-NullType var1738)
(declare-const null-String String)
(declare-const var566 var3917) ; Statement: r8 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var566 null-var3917)))
(declare-const var2149 var1091) ; Statement: r12 := @parameter0: org.apache.dubbo.rpc.cluster.Cluster 
(assert (not (= var2149 null-var1091)))
(declare-const var886 var3970) ; Statement: r13 := @parameter1: org.apache.dubbo.registry.Registry 
(assert (not (= var886 null-var3970)))
(declare-const var123 ClassObject) ; Statement: r9 := @parameter2: java.lang.Class 
(assert (not (= var123 null-ClassObject)))
(declare-const var2215 var797) ; Statement: r17 := @parameter3: org.apache.dubbo.common.URL 
(assert (not (= var2215 null-var797)))
(declare-const var713 var3903) ; Statement: r2 := @parameter4: java.util.Map 
(assert (not (= var713 null-var3903)))
(define-const var1830 var3798 var3798-init) ; Statement: $r0 = new java.util.HashMap 
(assert true)
(define-const var343 var3903 (getAttributes/-1462259152 var2215)) ; Statement: $r1 = virtualinvoke r17.<org.apache.dubbo.common.URL: java.util.Map getAttributes()>() 
(assert true)
;(assert (<init>/-1344032113 var1830 var343)) ; Statement: specialinvoke $r0.<java.util.HashMap: void <init>(java.util.Map)>($r1) 

(declare-const var1830!1 var3798)
(declare-const var343!1 var3903)
;(assert (var3903_remove/-1201052315 (cast-from-var3798-to-var3903 var1830!1) (cast-from-String-to-var2767 "refer"))) ; Statement: interfaceinvoke $r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("refer") 

(declare-const var1830!2 var3798)
(declare-const var227 String)
(define-const var142 var2767 (var3903_get/1088891777 var713 (cast-from-String-to-var2767 "protocol"))) ; Statement: $r3 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(define-const var1309 String (cast-from-var2767-to-String var142)) ; Statement: $r4 = (java.lang.String) $r3 
(define-const var3215 Bool (var254_isEmpty/-813097145 var1309)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4) 
 ; Statement: if $z0 == 0 goto $r5 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(assert (not (= (ite var3215 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1129 String "consumer") ; Statement: $r18 = "consumer" 
 ; Statement: goto [?= $r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL] 
(assert true) ; Non Conditional
(define-const var587 var3493 var3493-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL 
(define-const var1600 var2767 (var3903_get/1088891777 var713 (cast-from-String-to-var2767 "register.ip"))) ; Statement: $r7 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip") 
(define-const var1516 String (cast-from-var2767-to-String var1600)) ; Statement: $r11 = (java.lang.String) $r7 
(assert true)
(define-const var2218 String (getPath/-1129700835 var566 var713 var123)) ; Statement: $r10 = specialinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: java.lang.String getPath(java.util.Map,java.lang.Class)>(r2, r9) 
(assert true)
;(assert (<init>/1683865000 var587 var1129 null-String null-String var1516 0 var2218 var713 (cast-from-var3798-to-var3903 var1830!2))) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map,java.util.Map)>($r18, null, null, $r11, 0, $r10, r2, $r0) 

(declare-const var587!1 var3493)
(declare-const var1129!1 String)
(declare-const var3836 var1738)
(declare-const var3836!1 var1738)
(declare-const var1516!1 String)
(declare-const var3075 Int)
(declare-const var2218!1 String)
(declare-const var713!1 var3903)
(declare-const var1830!3 var3798)
(assert true)
(define-const var1394 var797 (putAttribute/-158571106 var2215 "CONSUMER_URL" (cast-from-var3493-to-var2767 var587!1))) ; Statement: $r15 = virtualinvoke r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL putAttribute(java.lang.String,java.lang.Object)>("CONSUMER_URL", $r6) 
(assert true)
(define-const var3216 var3238 (getMigrationInvoker/-574699901 var566 var566 var2149 var886 var123 var1394 (cast-from-var3493-to-var797 var587!1))) ; Statement: $r16 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.cluster.ClusterInvoker getMigrationInvoker(org.apache.dubbo.registry.integration.RegistryProtocol,org.apache.dubbo.rpc.cluster.Cluster,org.apache.dubbo.registry.Registry,java.lang.Class,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>(r8, r12, r13, r9, $r15, $r6) 
(assert true)
(define-const var717 var2818 (interceptInvoker/-513464851 var566 var3216 var1394 (cast-from-var3493-to-var797 var587!1))) ; Statement: $r14 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.Invoker interceptInvoker(org.apache.dubbo.rpc.cluster.ClusterInvoker,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>($r16, $r15, $r6) 
 ; Statement: return $r14 
(check-sat)
; {var3798-init=([], java.util.HashMap), getAttributes/-1462259152=([org.apache.dubbo.common.URL], java.util.Map), <init>/-1344032113=([java.util.HashMap, java.util.Map], void), var3903_remove/-1201052315=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3798-to-var3903=([java.util.HashMap], java.util.Map), cast-from-String-to-var2767=([java.lang.String], java.lang.Object), var3903_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var2767-to-String=([java.lang.Object], java.lang.String), var254_isEmpty/-813097145=([java.lang.String], boolean), var3493-init=([], org.apache.dubbo.common.url.component.ServiceConfigURL), getPath/-1129700835=([org.apache.dubbo.registry.integration.RegistryProtocol, java.util.Map, java.lang.Class], java.lang.String), <init>/1683865000=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String, java.lang.String, java.lang.String, java.lang.String, int, java.lang.String, java.util.Map, java.util.Map], void), putAttribute/-158571106=([org.apache.dubbo.common.URL, java.lang.String, java.lang.Object], org.apache.dubbo.common.URL), cast-from-var3493-to-var2767=([org.apache.dubbo.common.url.component.ServiceConfigURL], java.lang.Object), getMigrationInvoker/-574699901=([org.apache.dubbo.registry.integration.RegistryProtocol, org.apache.dubbo.registry.integration.RegistryProtocol, org.apache.dubbo.rpc.cluster.Cluster, org.apache.dubbo.registry.Registry, java.lang.Class, org.apache.dubbo.common.URL, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.cluster.ClusterInvoker), cast-from-var3493-to-var797=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), interceptInvoker/-513464851=([org.apache.dubbo.registry.integration.RegistryProtocol, org.apache.dubbo.rpc.cluster.ClusterInvoker, org.apache.dubbo.common.URL, org.apache.dubbo.common.URL], org.apache.dubbo.rpc.Invoker)}
; {var3917=org.apache.dubbo.registry.integration.RegistryProtocol, var566=r8, var1091=org.apache.dubbo.rpc.cluster.Cluster, var2149=r12, var3970=org.apache.dubbo.registry.Registry, var886=r13, var123=r9, var797=org.apache.dubbo.common.URL, var2215=r17, var3903=java.util.Map, var713=r2, var3798=java.util.HashMap, var1830=$r0, var343=$r1, var2767=java.lang.Object, var227="refer", var142=$r3, var1309=$r4, var254=org.apache.dubbo.common.utils.StringUtils, var3215=$z0, var1129=$r18, var3493=org.apache.dubbo.common.url.component.ServiceConfigURL, var587=$r6, var1600=$r7, var1516=$r11, var2218=$r10, var1738=null_type, var3836=null, var3075=0, var1394=$r15, var3238=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3216=$r16, var2818=org.apache.dubbo.rpc.Invoker, var717=$r14}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var3917, r8=var566, org.apache.dubbo.rpc.cluster.Cluster=var1091, r12=var2149, org.apache.dubbo.registry.Registry=var3970, r13=var886, r9=var123, org.apache.dubbo.common.URL=var797, r17=var2215, java.util.Map=var3903, r2=var713, java.util.HashMap=var3798, $r0=var1830, $r1=var343, java.lang.Object=var2767, "refer"=var227, $r3=var142, $r4=var1309, org.apache.dubbo.common.utils.StringUtils=var254, $z0=var3215, $r18=var1129, org.apache.dubbo.common.url.component.ServiceConfigURL=var3493, $r6=var587, $r7=var1600, $r11=var1516, $r10=var2218, null_type=var1738, null=var3836, 0=var3075, $r15=var1394, org.apache.dubbo.rpc.cluster.ClusterInvoker=var3238, $r16=var3216, org.apache.dubbo.rpc.Invoker=var2818, $r14=var717}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r8 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r12 := @parameter0: org.apache.dubbo.rpc.cluster.Cluster;	r13 := @parameter1: org.apache.dubbo.registry.Registry;	r9 := @parameter2: java.lang.Class;	r17 := @parameter3: org.apache.dubbo.common.URL;	r2 := @parameter4: java.util.Map;	$r0 = new java.util.HashMap;	$r1 = virtualinvoke r17.<org.apache.dubbo.common.URL: java.util.Map getAttributes()>();	specialinvoke $r0.<java.util.HashMap: void <init>(java.util.Map)>($r1);	interfaceinvoke $r0.<java.util.Map: java.lang.Object remove(java.lang.Object)>("refer");	$r3 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r4 = (java.lang.String) $r3;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r4);	if $z0 == 0 goto $r5 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r18 = "consumer";	goto [?= $r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL];	$r6 = new org.apache.dubbo.common.url.component.ServiceConfigURL;	$r7 = interfaceinvoke r2.<java.util.Map: java.lang.Object get(java.lang.Object)>("register.ip");	$r11 = (java.lang.String) $r7;	$r10 = specialinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: java.lang.String getPath(java.util.Map,java.lang.Class)>(r2, r9);	specialinvoke $r6.<org.apache.dubbo.common.url.component.ServiceConfigURL: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String,int,java.lang.String,java.util.Map,java.util.Map)>($r18, null, null, $r11, 0, $r10, r2, $r0);	$r15 = virtualinvoke r17.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL putAttribute(java.lang.String,java.lang.Object)>("CONSUMER_URL", $r6);	$r16 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.cluster.ClusterInvoker getMigrationInvoker(org.apache.dubbo.registry.integration.RegistryProtocol,org.apache.dubbo.rpc.cluster.Cluster,org.apache.dubbo.registry.Registry,java.lang.Class,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>(r8, r12, r13, r9, $r15, $r6);	$r14 = virtualinvoke r8.<org.apache.dubbo.registry.integration.RegistryProtocol: org.apache.dubbo.rpc.Invoker interceptInvoker(org.apache.dubbo.rpc.cluster.ClusterInvoker,org.apache.dubbo.common.URL,org.apache.dubbo.common.URL)>($r16, $r15, $r6);	return $r14
;block_num 3