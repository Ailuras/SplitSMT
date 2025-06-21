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

(declare-sort var3451 0)
(declare-sort var3813 0)
(declare-sort var3426 0)
(declare-sort var3563 0)
(declare-sort var1546 0)
(declare-sort var2082 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getSide/-520240817 (var3813) String)
(declare-fun acceptable/-1931755004 (var3426 var3813) Bool)
(declare-fun cast-from-var3451-to-var3426 (var3451) var3426)
(declare-fun logger/787708432 (var3451) var3563)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1546) String)
(declare-fun cast-from-var3813-to-var1546 (var3813) var1546)
(declare-fun getUrl/866469067 (var3426) var3813)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2082_info/484404803 (var2082 String) void)
(declare-fun cast-from-var3563-to-var2082 (var3563) var2082)
(declare-const null-var3451 var3451)
(declare-const null-var3813 var3813)
(declare-const var2686 var3451) ; Statement: r3 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry 
(assert (not (= var2686 null-var3451)))
(declare-const var1534 var3813) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1534 null-var3813)))
(assert true)
(define-const var2675 String (getSide/-520240817 var1534)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>() 
(define-const var138 String "provider") ; Statement: $r2 = "provider" 
(assert true)
(define-const var2615 Bool (= var138 var2675)) ; Statement: z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: if z0 != 0 goto $z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0) 
(assert (not (= (ite var2615 1 0) 0))) ; Cond: z0 != 0 
(assert true)
(define-const var3005 Bool (acceptable/-1931755004 (cast-from-var3451-to-var3426 var2686) var1534)) ; Statement: $z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: if $z2 != 0 goto return z0 
(assert (not (not (= (ite var3005 1 0) 0)))) ; Negate: Cond: $z2 != 0  
(define-const var2400 var3563 (logger/787708432 var2686)) ; Statement: $r5 = r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3296 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3296)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3296!1 String)
(assert (= var3296!1 ""))
(assert true)
(define-const var2572 String (append/672562846 var3296!1 "URL ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("URL ") 
(declare-const var3296!2 String)
(assert (= var3296!2 (str.++ var3296!1 "URL ")))
(assert true)
(define-const var1412 String (append/-1031950772 var2572 (cast-from-var3813-to-var1546 var1534))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0) 
(declare-const var2572!1 String)
(assert (str.prefixof var2572 var2572!1))
(assert true)
(define-const var1425 String (append/672562846 var1412 " will not be registered to Registry. Registry ")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" will not be registered to Registry. Registry ") 
(declare-const var1412!1 String)
(assert (= var1412!1 (str.++ var1412 " will not be registered to Registry. Registry ")))
(assert true)
(define-const var1517 var3813 (getUrl/866469067 (cast-from-var3451-to-var3426 var2686))) ; Statement: $r8 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: org.apache.dubbo.common.URL getUrl()>() 
(assert true)
(define-const var1043 String (append/-1031950772 var1425 (cast-from-var3813-to-var1546 var1517))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var1425!1 String)
(assert (str.prefixof var1425 var1425!1))
(assert true)
(define-const var134 String (append/672562846 var1043 " does not accept service of this protocol type.")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" does not accept service of this protocol type.") 
(declare-const var1043!1 String)
(assert (= var1043!1 (str.++ var1043 " does not accept service of this protocol type.")))
(assert true)
(define-const var1044 String (toString/-2075883882 var134)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2082_info/484404803 (cast-from-var3563-to-var2082 var2400) var1044)) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r12) 

(declare-const var2400!1 var3563)
(declare-const var1044!1 String)
 ; Statement: return 0 
(check-sat)
; {getSide/-520240817=([org.apache.dubbo.common.URL], java.lang.String), acceptable/-1931755004=([org.apache.dubbo.registry.support.AbstractRegistry, org.apache.dubbo.common.URL], boolean), cast-from-var3451-to-var3426=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry], org.apache.dubbo.registry.support.AbstractRegistry), logger/787708432=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistry], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3813-to-var1546=([org.apache.dubbo.common.URL], java.lang.Object), getUrl/866469067=([org.apache.dubbo.registry.support.AbstractRegistry], org.apache.dubbo.common.URL), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2082_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3563-to-var2082=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var3451=org.apache.dubbo.registry.client.ServiceDiscoveryRegistry, var2686=r3, var3813=org.apache.dubbo.common.URL, var1534=r0, var2675=r1, var138=$r2, var2615=z0, var3426=org.apache.dubbo.registry.support.AbstractRegistry, var3005=$z2, var3563=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2400=$r5, var3296=$r4, var2572=$r6, var1546=java.lang.Object, var1412=$r7, var1425=$r9, var1517=$r8, var1043=$r10, var134=$r11, var1044=$r12, var2082=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistry=var3451, r3=var2686, org.apache.dubbo.common.URL=var3813, r0=var1534, r1=var2675, $r2=var138, z0=var2615, org.apache.dubbo.registry.support.AbstractRegistry=var3426, $z2=var3005, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3563, $r5=var2400, $r4=var3296, $r6=var2572, java.lang.Object=var1546, $r7=var1412, $r9=var1425, $r8=var1517, $r10=var1043, $r11=var134, $r12=var1044, org.apache.dubbo.common.logger.Logger=var2082}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getSide()>();	$r2 = "provider";	z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	if z0 != 0 goto $z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0);	$z2 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: boolean acceptable(org.apache.dubbo.common.URL)>(r0);	if $z2 != 0 goto return z0;	$r5 = r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("URL ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r0);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" will not be registered to Registry. Registry ");	$r8 = virtualinvoke r3.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistry: org.apache.dubbo.common.URL getUrl()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" does not accept service of this protocol type.");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r12);	return 0
;block_num 3