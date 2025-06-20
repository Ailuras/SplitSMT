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

(declare-sort var3525 0)
(declare-sort var3385 0)
(declare-sort var598 0)
(declare-sort var2229 0)
(declare-sort var587 0)
(declare-sort var177 0)
(declare-sort var3674 0)
(declare-sort var3408 0)
(declare-sort var3027 0)
(declare-sort var1122 0)
(declare-sort var2264 0)
(declare-sort var2537 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3385_getKey/-33423493 (var3385) var598)
(declare-fun cast-from-var598-to-var2229 (var598) var2229)
(declare-fun var177_getUrl/-275947851 (var177) var587)
(declare-fun cast-from-var2229-to-var177 (var2229) var177)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var598) String)
(declare-fun cast-from-var587-to-var598 (var587) var598)
(declare-fun var3674-init () var3674)
(declare-fun <init>/-201242697 (var3674) void)
(declare-fun toString/-2052709774 (var587) String)
(declare-fun var3525_put/1464166817 (var3525 var598 var598) var598)
(declare-fun cast-from-String-to-var598 (String) var598)
(declare-fun cast-from-var3674-to-var598 (var3674) var598)
(declare-fun var3385_getValue/381491177 (var3385) var598)
(declare-fun cast-from-var598-to-var3408 (var598) var3408)
(declare-fun getMigrationStep/1412971044 (var3408) var3027)
(declare-fun cast-from-var3027-to-var598 (var3027) var598)
(declare-fun cast-from-var3674-to-var3525 (var3674) var3525)
(declare-fun var2264_getServiceContext/735675290 () var1122)
(declare-fun getConsumerUrl/-1021200294 (var1122) var587)
(declare-fun getConsumerUrl/542104958 (var3408) var587)
(declare-fun setConsumerUrl/-1757805552 (var1122 var587) void)
(declare-fun var2537_appendInterfaceLevel/549842160 (String var3408 var3525) void)
(declare-fun var2537_appendAppLevel/1133721736 (String var3408 var3525) void)
(declare-const null-String String)
(declare-const null-var3525 var3525)
(declare-const null-var3385 var3385)
(declare-const var3818 String) ; Statement: r4 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3818 null-String)))
(declare-const var1534 var3525) ; Statement: r8 := @parameter1: java.util.Map 
(assert (not (= var1534 null-var3525)))
(declare-const var693 var3385) ; Statement: r0 := @parameter2: java.util.Map$Entry 
(assert (not (= var693 null-var3385)))
(define-const var1898 var598 (var3385_getKey/-33423493 var693)) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>() 
(define-const var2796 var2229 (cast-from-var598-to-var2229 var1898)) ; Statement: $r2 = (org.apache.dubbo.registry.Registry) $r1 
(define-const var2189 var587 (var177_getUrl/-275947851 (cast-from-var2229-to-var177 var2796))) ; Statement: r3 = interfaceinvoke $r2.<org.apache.dubbo.registry.Registry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var685 String (append/672562846 var3818 "Registry: ")) ; Statement: $r5 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Registry: ") 
(declare-const var3818!1 String)
(assert (= var3818!1 (str.++ var3818 "Registry: ")))
(assert true)
(define-const var2552 String (append/-1031950772 var685 (cast-from-var587-to-var598 var2189))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var685!1 String)
(assert (str.prefixof var685 var685!1))
(assert true)
;(assert (append/672562846 var2552 "\n")) ; Statement: virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(declare-const var2552!1 String)
(assert (= var2552!1 (str.++ var2552 "\n")))
(define-const var133 var3674 var3674-init) ; Statement: $r7 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var133)) ; Statement: specialinvoke $r7.<java.util.HashMap: void <init>()>() 

(declare-const var133!1 var3674)
(assert true)
(define-const var1186 String (toString/-2052709774 var2189)) ; Statement: $r9 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.String toString()>() 
;(assert (var3525_put/1464166817 var1534 (cast-from-String-to-var598 var1186) (cast-from-var3674-to-var598 var133!1))) ; Statement: interfaceinvoke r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r9, $r7) 

(declare-const var1534!1 var3525)
(declare-const var1186!1 String)
(declare-const var133!2 var3674)
(define-const var502 var598 (var3385_getValue/381491177 var693)) ; Statement: $r10 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getValue()>() 
(define-const var3187 var3408 (cast-from-var598-to-var3408 var502)) ; Statement: r11 = (org.apache.dubbo.registry.client.migration.MigrationInvoker) $r10 
(assert true)
(define-const var3271 var3027 (getMigrationStep/1412971044 var3187)) ; Statement: r12 = virtualinvoke r11.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.registry.client.migration.model.MigrationStep getMigrationStep()>() 
(assert true)
(define-const var3858 String (append/672562846 var3818!1 "MigrationStep: ")) ; Statement: $r13 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MigrationStep: ") 
(declare-const var3818!2 String)
(assert (= var3818!2 (str.++ var3818!1 "MigrationStep: ")))
(assert true)
(define-const var1536 String (append/-1031950772 var3858 (cast-from-var3027-to-var598 var3271))) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r12) 
(declare-const var3858!1 String)
(assert (str.prefixof var3858 var3858!1))
(assert true)
;(assert (append/672562846 var1536 "\n\n")) ; Statement: virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n") 
(declare-const var1536!1 String)
(assert (= var1536!1 (str.++ var1536 "\n\n")))
;(assert (var3525_put/1464166817 (cast-from-var3674-to-var3525 var133!2) (cast-from-String-to-var598 "MigrationStep") (cast-from-var3027-to-var598 var3271))) ; Statement: interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("MigrationStep", r12) 

(declare-const var133!3 var3674)
(declare-const var1597 String)
(declare-const var3271!1 var3027)
(define-const var1166 var3674 var3674-init) ; Statement: $r15 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var1166)) ; Statement: specialinvoke $r15.<java.util.HashMap: void <init>()>() 

(declare-const var1166!1 var3674)
;(assert (var3525_put/1464166817 (cast-from-var3674-to-var3525 var133!3) (cast-from-String-to-var598 "Invokers") (cast-from-var3674-to-var598 var1166!1))) ; Statement: interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Invokers", $r15) 

(declare-const var133!4 var3674)
(declare-const var1981 String)
(declare-const var1166!2 var3674)
(define-const var1436 var1122 var2264_getServiceContext/735675290) ; Statement: $r16 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var7 var587 (getConsumerUrl/-1021200294 var1436)) ; Statement: r17 = virtualinvoke $r16.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>() 
(define-const var283 var1122 var2264_getServiceContext/735675290) ; Statement: $r19 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
(define-const var772 var587 (getConsumerUrl/542104958 var3187)) ; Statement: $r18 = virtualinvoke r11.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert true)
;(assert (setConsumerUrl/-1757805552 var283 var772)) ; Statement: virtualinvoke $r19.<org.apache.dubbo.rpc.RpcServiceContext: void setConsumerUrl(org.apache.dubbo.common.URL)>($r18) 

(declare-const var283!1 var1122)
(declare-const var772!1 var587)
;(assert (var2537_appendInterfaceLevel/549842160 var3818!2 var3187 (cast-from-var3674-to-var3525 var1166!2))) ; Statement: staticinvoke <org.apache.dubbo.qos.command.impl.GetAddress: void appendInterfaceLevel(java.lang.StringBuilder,org.apache.dubbo.registry.client.migration.MigrationInvoker,java.util.Map)>(r4, r11, $r15) 

(declare-const var3818!3 String)
(declare-const var3187!1 var3408)
(declare-const var1166!3 var3674)
;(assert (var2537_appendAppLevel/1133721736 var3818!3 var3187!1 (cast-from-var3674-to-var3525 var1166!3))) ; Statement: staticinvoke <org.apache.dubbo.qos.command.impl.GetAddress: void appendAppLevel(java.lang.StringBuilder,org.apache.dubbo.registry.client.migration.MigrationInvoker,java.util.Map)>(r4, r11, $r15) 

(declare-const var3818!4 String)
(declare-const var3187!2 var3408)
(declare-const var1166!4 var3674)
(define-const var2538 var1122 var2264_getServiceContext/735675290) ; Statement: $r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>() 
(assert true)
;(assert (setConsumerUrl/-1757805552 var2538 var7)) ; Statement: virtualinvoke $r20.<org.apache.dubbo.rpc.RpcServiceContext: void setConsumerUrl(org.apache.dubbo.common.URL)>(r17) 

(declare-const var2538!1 var1122)
(declare-const var7!1 var587)
 ; Statement: return 
(check-sat)
; {var3385_getKey/-33423493=([java.util.Map$Entry], java.lang.Object), cast-from-var598-to-var2229=([java.lang.Object], org.apache.dubbo.registry.Registry), var177_getUrl/-275947851=([org.apache.dubbo.common.Node], org.apache.dubbo.common.URL), cast-from-var2229-to-var177=([org.apache.dubbo.registry.Registry], org.apache.dubbo.common.Node), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var587-to-var598=([org.apache.dubbo.common.URL], java.lang.Object), var3674-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), toString/-2052709774=([org.apache.dubbo.common.URL], java.lang.String), var3525_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var598=([java.lang.String], java.lang.Object), cast-from-var3674-to-var598=([java.util.HashMap], java.lang.Object), var3385_getValue/381491177=([java.util.Map$Entry], java.lang.Object), cast-from-var598-to-var3408=([java.lang.Object], org.apache.dubbo.registry.client.migration.MigrationInvoker), getMigrationStep/1412971044=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.registry.client.migration.model.MigrationStep), cast-from-var3027-to-var598=([org.apache.dubbo.registry.client.migration.model.MigrationStep], java.lang.Object), cast-from-var3674-to-var3525=([java.util.HashMap], java.util.Map), var2264_getServiceContext/735675290=([], org.apache.dubbo.rpc.RpcServiceContext), getConsumerUrl/-1021200294=([org.apache.dubbo.rpc.RpcServiceContext], org.apache.dubbo.common.URL), getConsumerUrl/542104958=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.URL), setConsumerUrl/-1757805552=([org.apache.dubbo.rpc.RpcServiceContext, org.apache.dubbo.common.URL], void), var2537_appendInterfaceLevel/549842160=([java.lang.StringBuilder, org.apache.dubbo.registry.client.migration.MigrationInvoker, java.util.Map], void), var2537_appendAppLevel/1133721736=([java.lang.StringBuilder, org.apache.dubbo.registry.client.migration.MigrationInvoker, java.util.Map], void)}
; {var3818=r4, var3525=java.util.Map, var1534=r8, var3385=java.util.Map$Entry, var693=r0, var598=java.lang.Object, var1898=$r1, var2229=org.apache.dubbo.registry.Registry, var2796=$r2, var587=org.apache.dubbo.common.URL, var177=org.apache.dubbo.common.Node, var2189=r3, var685=$r5, var2552=$r6, var3674=java.util.HashMap, var133=$r7, var1186=$r9, var502=$r10, var3408=org.apache.dubbo.registry.client.migration.MigrationInvoker, var3187=r11, var3027=org.apache.dubbo.registry.client.migration.model.MigrationStep, var3271=r12, var3858=$r13, var1536=$r14, var1597="MigrationStep", var1166=$r15, var1981="Invokers", var1122=org.apache.dubbo.rpc.RpcServiceContext, var2264=org.apache.dubbo.rpc.RpcContext, var1436=$r16, var7=r17, var283=$r19, var772=$r18, var2537=org.apache.dubbo.qos.command.impl.GetAddress, var2538=$r20}
; {r4=var3818, java.util.Map=var3525, r8=var1534, java.util.Map$Entry=var3385, r0=var693, java.lang.Object=var598, $r1=var1898, org.apache.dubbo.registry.Registry=var2229, $r2=var2796, org.apache.dubbo.common.URL=var587, org.apache.dubbo.common.Node=var177, r3=var2189, $r5=var685, $r6=var2552, java.util.HashMap=var3674, $r7=var133, $r9=var1186, $r10=var502, org.apache.dubbo.registry.client.migration.MigrationInvoker=var3408, r11=var3187, org.apache.dubbo.registry.client.migration.model.MigrationStep=var3027, r12=var3271, $r13=var3858, $r14=var1536, "MigrationStep"=var1597, $r15=var1166, "Invokers"=var1981, org.apache.dubbo.rpc.RpcServiceContext=var1122, org.apache.dubbo.rpc.RpcContext=var2264, $r16=var1436, r17=var7, $r19=var283, $r18=var772, org.apache.dubbo.qos.command.impl.GetAddress=var2537, $r20=var2538}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.URL: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2}
;stmts r4 := @parameter0: java.lang.StringBuilder;	r8 := @parameter1: java.util.Map;	r0 := @parameter2: java.util.Map$Entry;	$r1 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getKey()>();	$r2 = (org.apache.dubbo.registry.Registry) $r1;	r3 = interfaceinvoke $r2.<org.apache.dubbo.registry.Registry: org.apache.dubbo.common.URL getUrl()>();	$r5 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Registry: ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	$r7 = new java.util.HashMap;	specialinvoke $r7.<java.util.HashMap: void <init>()>();	$r9 = virtualinvoke r3.<org.apache.dubbo.common.URL: java.lang.String toString()>();	interfaceinvoke r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r9, $r7);	$r10 = interfaceinvoke r0.<java.util.Map$Entry: java.lang.Object getValue()>();	r11 = (org.apache.dubbo.registry.client.migration.MigrationInvoker) $r10;	r12 = virtualinvoke r11.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.registry.client.migration.model.MigrationStep getMigrationStep()>();	$r13 = virtualinvoke r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MigrationStep: ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r12);	virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n");	interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("MigrationStep", r12);	$r15 = new java.util.HashMap;	specialinvoke $r15.<java.util.HashMap: void <init>()>();	interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("Invokers", $r15);	$r16 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	r17 = virtualinvoke $r16.<org.apache.dubbo.rpc.RpcServiceContext: org.apache.dubbo.common.URL getConsumerUrl()>();	$r19 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	$r18 = virtualinvoke r11.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL getConsumerUrl()>();	virtualinvoke $r19.<org.apache.dubbo.rpc.RpcServiceContext: void setConsumerUrl(org.apache.dubbo.common.URL)>($r18);	staticinvoke <org.apache.dubbo.qos.command.impl.GetAddress: void appendInterfaceLevel(java.lang.StringBuilder,org.apache.dubbo.registry.client.migration.MigrationInvoker,java.util.Map)>(r4, r11, $r15);	staticinvoke <org.apache.dubbo.qos.command.impl.GetAddress: void appendAppLevel(java.lang.StringBuilder,org.apache.dubbo.registry.client.migration.MigrationInvoker,java.util.Map)>(r4, r11, $r15);	$r20 = staticinvoke <org.apache.dubbo.rpc.RpcContext: org.apache.dubbo.rpc.RpcServiceContext getServiceContext()>();	virtualinvoke $r20.<org.apache.dubbo.rpc.RpcServiceContext: void setConsumerUrl(org.apache.dubbo.common.URL)>(r17);	return
;block_num 1