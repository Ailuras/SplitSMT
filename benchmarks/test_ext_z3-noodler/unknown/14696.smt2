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

(declare-sort var3475 0)
(declare-sort var2629 0)
(declare-sort var482 0)
(declare-sort var3445 0)
(declare-sort var1249 0)
(declare-sort var1128 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3445_referMetadataService/2092981275 (var2629) var482)
(declare-fun getInternalProxy/-208446410 (var482) var1249)
(declare-fun var1128-init () var1128)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2629_getServiceName/657674380 (var2629) String)
(declare-fun var2629_getHost/-1322822778 (var2629) String)
(declare-fun var2629_getPort/-1941989909 (var2629) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var1128 String) void)
(declare-const null-var3475 var3475)
(declare-const null-var2629 var2629)
(declare-const var1352 var3475) ; Statement: r15 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var1352 null-var3475)))
(declare-const var2190 var2629) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var2190 null-var2629)))
(define-const var3052 var482 (var3445_referMetadataService/2092981275 var2190)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService referMetadataService(org.apache.dubbo.registry.client.ServiceInstance)>(r0) 
(assert true)
(define-const var2951 var1249 (getInternalProxy/-208446410 var3052)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>() 
(define-const var815 Bool false) ; Statement: $z0 = r2 instanceof org.apache.dubbo.metadata.MetadataService 
 ; Statement: if $z0 == 0 goto $r3 = new java.lang.RuntimeException 
(assert (= (ite var815 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1837 var1128 var1128-init) ; Statement: $r3 = new java.lang.RuntimeException 
(define-const var3686 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3686)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3686!1 String)
(assert (= var3686!1 ""))
(assert true)
(define-const var444 String (append/672562846 var3686!1 "Service ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service ") 
(declare-const var3686!2 String)
(assert (= var3686!2 (str.++ var3686!1 "Service ")))
(define-const var2394 String (var2629_getServiceName/657674380 var2190)) ; Statement: $r5 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getServiceName()>() 
(assert true)
(define-const var2786 String (append/672562846 var444 var2394)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var444!1 String)
(assert (= var444!1 (str.++ var444 var2394)))
(assert true)
(define-const var524 String (append/672562846 var2786 " at ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" at ") 
(declare-const var2786!1 String)
(assert (= var2786!1 (str.++ var2786 " at ")))
(define-const var950 String (var2629_getHost/-1322822778 var2190)) ; Statement: $r8 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getHost()>() 
(assert true)
(define-const var3919 String (append/672562846 var524 var950)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var524!1 String)
(assert (= var524!1 (str.++ var524 var950)))
(assert true)
(define-const var3231 String (append/672562846 var3919 ":")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":") 
(declare-const var3919!1 String)
(assert (= var3919!1 (str.++ var3919 ":")))
(define-const var332 Int (var2629_getPort/-1941989909 var2190)) ; Statement: $i0 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: int getPort()>() 
(assert true)
(define-const var1277 String (append/-1001720160 var3231 var332)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3231!1 String)
(assert (str.prefixof var3231 var3231!1))
(assert true)
(define-const var3450 String (append/672562846 var1277 "are using MetadataServiceV2, which is not support ")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("are using MetadataServiceV2, which is not support ") 
(declare-const var1277!1 String)
(assert (= var1277!1 (str.++ var1277 "are using MetadataServiceV2, which is not support ")))
(assert true)
(define-const var48 String (toString/-2075883882 var3450)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var1837 var48)) ; Statement: specialinvoke $r3.<java.lang.RuntimeException: void <init>(java.lang.String)>($r14) 

(declare-const var1837!1 var1128)
(declare-const var48!1 String)
 ; Statement: throw $r3 
(check-sat)
; {var3445_referMetadataService/2092981275=([org.apache.dubbo.registry.client.ServiceInstance], org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService), getInternalProxy/-208446410=([org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService], java.lang.Object), var1128-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2629_getServiceName/657674380=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), var2629_getHost/-1322822778=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), var2629_getPort/-1941989909=([org.apache.dubbo.registry.client.ServiceInstance], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3475=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var1352=r15, var2629=org.apache.dubbo.registry.client.ServiceInstance, var2190=r0, var482=org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService, var3445=org.apache.dubbo.registry.client.metadata.MetadataUtils, var3052=$r1, var1249=java.lang.Object, var2951=r2, var815=$z0, var1128=java.lang.RuntimeException, var1837=$r3, var3686=$r4, var444=$r6, var2394=$r5, var2786=$r7, var524=$r9, var950=$r8, var3919=$r10, var3231=$r11, var332=$i0, var1277=$r12, var3450=$r13, var48=$r14}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var3475, r15=var1352, org.apache.dubbo.registry.client.ServiceInstance=var2629, r0=var2190, org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService=var482, org.apache.dubbo.registry.client.metadata.MetadataUtils=var3445, $r1=var3052, java.lang.Object=var1249, r2=var2951, $z0=var815, java.lang.RuntimeException=var1128, $r3=var1837, $r4=var3686, $r6=var444, $r5=var2394, $r7=var2786, $r9=var524, $r8=var950, $r10=var3919, $r11=var3231, $i0=var332, $r12=var1277, $r13=var3450, $r14=var48}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r15 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r0 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r1 = staticinvoke <org.apache.dubbo.registry.client.metadata.MetadataUtils: org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService referMetadataService(org.apache.dubbo.registry.client.ServiceInstance)>(r0);	r2 = virtualinvoke $r1.<org.apache.dubbo.registry.client.metadata.MetadataUtils$RemoteMetadataService: java.lang.Object getInternalProxy()>();	$z0 = r2 instanceof org.apache.dubbo.metadata.MetadataService;	if $z0 == 0 goto $r3 = new java.lang.RuntimeException;	$r3 = new java.lang.RuntimeException;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service ");	$r5 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getServiceName()>();	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" at ");	$r8 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getHost()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(":");	$i0 = interfaceinvoke r0.<org.apache.dubbo.registry.client.ServiceInstance: int getPort()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("are using MetadataServiceV2, which is not support ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r3.<java.lang.RuntimeException: void <init>(java.lang.String)>($r14);	throw $r3
;block_num 2