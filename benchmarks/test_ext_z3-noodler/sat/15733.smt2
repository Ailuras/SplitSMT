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

(declare-sort var1595 0)
(declare-sort var3229 0)
(declare-sort var2805 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getUrl/-950407827 (var2805) var3229)
(declare-fun cast-from-var1595-to-var2805 (var1595) var2805)
(declare-fun getAddress/-2093578336 (var3229) String)
(declare-fun toString/-2141463265 (var2805) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1595 var1595)
(declare-const var3048 var1595) ; Statement: r1 := @this: org.apache.dubbo.registry.integration.RegistryDirectory 
(assert (not (= var3048 null-var1595)))
(define-const var1020 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1020)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1020!1 String)
(assert (= var1020!1 ""))
(assert true)
(define-const var1439 String (append/672562846 var1020!1 "RegistryDirectory(registry: ")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("RegistryDirectory(registry: ") 
(declare-const var1020!2 String)
(assert (= var1020!2 (str.++ var1020!1 "RegistryDirectory(registry: ")))
(assert true)
(define-const var1406 var3229 (getUrl/-950407827 (cast-from-var1595-to-var2805 var3048))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var3943 String (getAddress/-2093578336 var1406)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getAddress()>() 
(assert true)
(define-const var289 String (append/672562846 var1439 var3943)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1439!1 String)
(assert (= var1439!1 (str.++ var1439 var3943)))
(assert true)
(define-const var839 String (append/672562846 var289 ")-")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")-") 
(declare-const var289!1 String)
(assert (= var289!1 (str.++ var289 ")-")))
(assert true)
(define-const var107 String (toString/-2141463265 (cast-from-var1595-to-var2805 var3048))) ; Statement: $r6 = specialinvoke r1.<org.apache.dubbo.registry.integration.DynamicDirectory: java.lang.String toString()>() 
(assert true)
(define-const var2854 String (append/672562846 var839 var107)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var839!1 String)
(assert (= var839!1 (str.++ var839 var107)))
(assert true)
(define-const var607 String (toString/-2075883882 var2854)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getUrl/-950407827=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], org.apache.dubbo.common.URL), cast-from-var1595-to-var2805=([org.apache.dubbo.registry.integration.RegistryDirectory], org.apache.dubbo.rpc.cluster.directory.AbstractDirectory), getAddress/-2093578336=([org.apache.dubbo.common.URL], java.lang.String), toString/-2141463265=([org.apache.dubbo.rpc.cluster.directory.AbstractDirectory], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1595=org.apache.dubbo.registry.integration.RegistryDirectory, var3048=r1, var1020=$r0, var1439=$r4, var3229=org.apache.dubbo.common.URL, var2805=org.apache.dubbo.rpc.cluster.directory.AbstractDirectory, var1406=$r2, var3943=$r3, var289=$r5, var839=$r7, var107=$r6, var2854=$r8, var607=$r9}
; {org.apache.dubbo.registry.integration.RegistryDirectory=var1595, r1=var3048, $r0=var1020, $r4=var1439, org.apache.dubbo.common.URL=var3229, org.apache.dubbo.rpc.cluster.directory.AbstractDirectory=var2805, $r2=var1406, $r3=var3943, $r5=var289, $r7=var839, $r6=var107, $r8=var2854, $r9=var607}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.rpc.cluster.directory.AbstractDirectory: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.integration.RegistryDirectory;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("RegistryDirectory(registry: ");	$r2 = virtualinvoke r1.<org.apache.dubbo.registry.integration.RegistryDirectory: org.apache.dubbo.common.URL getUrl()>();	$r3 = virtualinvoke $r2.<org.apache.dubbo.common.URL: java.lang.String getAddress()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")-");	$r6 = specialinvoke r1.<org.apache.dubbo.registry.integration.DynamicDirectory: java.lang.String toString()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1