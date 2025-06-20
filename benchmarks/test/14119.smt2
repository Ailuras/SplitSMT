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

(declare-sort var1315 0)
(declare-sort var1756 0)
(declare-sort var1637 0)
(declare-sort var1187 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun url/480148646 (var1315) var1756)
(declare-fun var1637_getRuleKey/876266182 (var1756) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun stopListen/1940503391 (var1187 String) void)
(declare-fun cast-from-var1315-to-var1187 (var1315) var1187)
(declare-const null-var1315 var1315)
(declare-const var49 var1315) ; Statement: r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener 
(assert (not (= var49 null-var1315)))
(define-const var1612 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1612)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1612!1 String)
(assert (= var1612!1 ""))
(define-const var688 var1756 (url/480148646 var49)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url> 
(define-const var3277 String (var1637_getRuleKey/876266182 var688)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>($r2) 
(assert true)
(define-const var2467 String (append/672562846 var1612!1 var3277)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var1612!2 String)
(assert (= var1612!2 (str.++ var1612!1 var3277)))
(assert true)
(define-const var894 String (append/672562846 var2467 ".configurators")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators") 
(declare-const var2467!1 String)
(assert (= var2467!1 (str.++ var2467 ".configurators")))
(assert true)
(define-const var2563 String (toString/-2075883882 var894)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (stopListen/1940503391 (cast-from-var1315-to-var1187 var49) var2563)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: void stopListen(java.lang.String)>($r6) 

(declare-const var49!1 var1315)
(declare-const var2563!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), url/480148646=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.common.URL), var1637_getRuleKey/876266182=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), stopListen/1940503391=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, java.lang.String], void), cast-from-var1315-to-var1187=([org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.integration.AbstractConfiguratorListener)}
; {var1315=org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener, var49=r0, var1612=$r1, var1756=org.apache.dubbo.common.URL, var688=$r2, var1637=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var3277=$r3, var2467=$r4, var894=$r5, var2563=$r6, var1187=org.apache.dubbo.registry.integration.AbstractConfiguratorListener}
; {org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener=var1315, r0=var49, $r1=var1612, org.apache.dubbo.common.URL=var1756, $r2=var688, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var1637, $r3=var3277, $r4=var2467, $r5=var894, $r6=var2563, org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var1187}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url>;	$r3 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>($r2);	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<org.apache.dubbo.registry.client.ServiceDiscoveryRegistryDirectory$ReferenceConfigurationListener: void stopListen(java.lang.String)>($r6);	return
;block_num 1