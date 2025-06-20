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

(declare-sort var3139 0)
(declare-sort var1978 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun var1978_getServiceName/657674380 (var1978) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1978_getAddress/1858264696 (var1978) String)
(declare-fun var863_getExportedServicesRevision/-768249 (var1978) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3139 var3139)
(declare-const null-var1978 var1978)
(declare-const var3082 var3139) ; Statement: r11 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery 
(assert (not (= var3082 null-var3139)))
(declare-const var1510 var1978) ; Statement: r1 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance 
(assert (not (= var1510 null-var1978)))
(define-const var2180 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2180)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2180!1 String)
(assert (= var2180!1 ""))
(define-const var1912 String (var1978_getServiceName/657674380 var1510)) ; Statement: $r2 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getServiceName()>() 
(assert true)
(define-const var3759 String (append/672562846 var2180!1 var1912)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2180!2 String)
(assert (= var2180!2 (str.++ var2180!1 var1912)))
(assert true)
(define-const var1623 String (append/672562846 var3759 "##")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("##") 
(declare-const var3759!1 String)
(assert (= var3759!1 (str.++ var3759 "##")))
(define-const var1415 String (var1978_getAddress/1858264696 var1510)) ; Statement: $r4 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getAddress()>() 
(assert true)
(define-const var2277 String (append/672562846 var1623 var1415)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1623!1 String)
(assert (= var1623!1 (str.++ var1623 var1415)))
(assert true)
(define-const var1327 String (append/672562846 var2277 "##")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("##") 
(declare-const var2277!1 String)
(assert (= var2277!1 (str.++ var2277 "##")))
(define-const var1183 String (var863_getExportedServicesRevision/-768249 var1510)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r1) 
(assert true)
(define-const var2057 String (append/672562846 var1327 var1183)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1327!1 String)
(assert (= var1327!1 (str.++ var1327 var1183)))
(assert true)
(define-const var1711 String (toString/-2075883882 var2057)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), var1978_getServiceName/657674380=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1978_getAddress/1858264696=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), var863_getExportedServicesRevision/-768249=([org.apache.dubbo.registry.client.ServiceInstance], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3139=org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery, var3082=r11, var1978=org.apache.dubbo.registry.client.ServiceInstance, var1510=r1, var2180=$r0, var1912=$r2, var3759=$r3, var1623=$r5, var1415=$r4, var2277=$r6, var1327=$r8, var863=org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils, var1183=$r7, var2057=$r9, var1711=$r10}
; {org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery=var3139, r11=var3082, org.apache.dubbo.registry.client.ServiceInstance=var1978, r1=var1510, $r0=var2180, $r2=var1912, $r3=var3759, $r5=var1623, $r4=var1415, $r6=var2277, $r8=var1327, org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils=var863, $r7=var1183, $r9=var2057, $r10=var1711}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r11 := @this: org.apache.dubbo.registry.client.ReflectionBasedServiceDiscovery;	r1 := @parameter0: org.apache.dubbo.registry.client.ServiceInstance;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getServiceName()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("##");	$r4 = interfaceinvoke r1.<org.apache.dubbo.registry.client.ServiceInstance: java.lang.String getAddress()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("##");	$r7 = staticinvoke <org.apache.dubbo.registry.client.metadata.ServiceInstanceMetadataUtils: java.lang.String getExportedServicesRevision(org.apache.dubbo.registry.client.ServiceInstance)>(r1);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1