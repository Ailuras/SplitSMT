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

(declare-sort var3978 0)
(declare-sort var3527 0)
(declare-sort var1588 0)
(declare-sort var1361 0)
(declare-sort var945 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/-950407827 (var1588) var3527)
(declare-fun cast-from-var3978-to-var1588 (var3978) var1588)
(declare-fun getAddress/-2093578336 (var3527) String)
(declare-fun serviceListener/2129308851 (var945) var1361)
(declare-fun cast-from-var3978-to-var945 (var3978) var945)
(declare-fun getConsumerUrl/1674456727 (var945) var3527)
(declare-fun getServiceKey/1456125852 (var3527) String)
(declare-fun toString/-2141463265 (var1588) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3978 var3978)
(declare-const null-var1361 var1361)
(declare-const var1278 var3978) ; Statement: r1 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory 
(assert (not (= var1278 null-var3978)))
(define-const var736 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var736)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var736!1 String)
(assert (= var736!1 ""))
(assert true)
(define-const var2340 String (append/672562846 var736!1 "ServiceDiscoveryRegistryDirectory(registry: ")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceDiscoveryRegistryDirectory(registry: ") 
(declare-const var736!2 String)
(assert (= var736!2 (str.++ var736!1 "ServiceDiscoveryRegistryDirectory(registry: ")))
(assert true)
(define-const var1252 var3527 (getUrl/-950407827 (cast-from-var3978-to-var1588 var1278))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var837 String (getAddress/-2093578336 var1252)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var3342 String (append/672562846 var2340 var837)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var2340!1 String)
(assert (= var2340!1 (str.++ var2340 var837)))
(assert true)
(define-const var2877 String (append/672562846 var3342 ", subscribed key: ")) ; Statement: $r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", subscribed key: ") 
(declare-const var3342!1 String)
(assert (= var3342!1 (str.++ var3342 ", subscribed key: ")))
(define-const var3554 var1361 (serviceListener/2129308851 (cast-from-var3978-to-var945 var1278))) ; Statement: $r6 = r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener serviceListener> 
 ; Statement: if $r6 == null goto $r7 = virtualinvoke r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert (= var3554 null-var1361)) ; Cond: $r6 == null 
(assert true)
(define-const var3827 var3527 (getConsumerUrl/1674456727 (cast-from-var3978-to-var945 var1278))) ; Statement: $r7 = virtualinvoke r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL getConsumerUrl()>() 
(assert true)
(define-const var1827 String (getServiceKey/1456125852 var3827)) ; Statement: $r18 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
 ; Statement: goto [?= $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18)] 
(assert true) ; Non Conditional
(assert true)
(define-const var3941 String (append/672562846 var2877 var1827)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var2877!1 String)
(assert (= var2877!1 (str.++ var2877 var1827)))
(assert true)
(define-const var1141 String (append/672562846 var3941 ")-")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")-") 
(declare-const var3941!1 String)
(assert (= var3941!1 (str.++ var3941 ")-")))
(assert true)
(define-const var2200 String (toString/-2141463265 (cast-from-var3978-to-var1588 var1278))) ; Statement: $r10 = specialinvoke r1.<org.apache.dubbo.registry.integration.DynamicDirectory: java.lang.String toString()>() 
(assert true)
(define-const var482 String (append/672562846 var1141 var2200)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var1141!1 String)
(assert (= var1141!1 (str.++ var1141 var2200)))
(assert true)
(define-const var1488 String (toString/-2075883882 var482)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/-950407827=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), cast-from-var3978-to-var1588=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), serviceListener/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener), cast-from-var3978-to-var945=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory], org.apache.dubbo.registry.integration.DynamicDirectory), getConsumerUrl/1674456727=([org.apache.dubbo.registry.integration.DynamicDirectory], org.apache.dubbo.common.URL), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), toString/-2141463265=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3978=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory, var1278=r1, var736=$r0, var2340=$r4, var3527=org.apache.dubbo.common.URL, var1588=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var1252=$r2, var837=$r3, var3342=$r5, var2877=$r8, var1361=org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener, var945=org.apache.dubbo.registry.integration.DynamicDirectory, var3554=$r6, var3827=$r7, var1827=$r18, var3941=$r9, var1141=$r11, var2200=$r10, var482=$r12, var1488=$r13}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory=var3978, r1=var1278, $r0=var736, $r4=var2340, org.apache.dubbo.common.URL=var3527, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var1588, $r2=var1252, $r3=var837, $r5=var3342, $r8=var2877, org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener=var1361, org.apache.dubbo.registry.integration.DynamicDirectory=var945, $r6=var3554, $r7=var3827, $r18=var1827, $r9=var3941, $r11=var1141, $r10=var2200, $r12=var482, $r13=var1488}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ServiceDiscoveryRegistryDirectory(registry: ");	$r2 = virtualinvoke r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL getUrl()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r8 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", subscribed key: ");	$r6 = r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.registry.client.event.listener.ServiceInstancesChangedListener serviceListener>;	if $r6 == null goto $r7 = virtualinvoke r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r7 = virtualinvoke r1.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory: org.apache.dubbo.common.URL getConsumerUrl()>();	$r18 = virtualinvoke $r7.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	goto [?= $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18)];	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")-");	$r10 = specialinvoke r1.<org.apache.dubbo.registry.integration.DynamicDirectory: java.lang.String toString()>();	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 3