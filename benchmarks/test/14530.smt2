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

(declare-sort var2874 0)
(declare-sort var3405 0)
(declare-sort var2658 0)
(declare-sort var2100 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun url/-972593768 (var2874) var3405)
(declare-fun var2658_getRuleKey/876266182 (var3405) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun stopListen/1940503391 (var2100 String) void)
(declare-fun cast-from-var2874-to-var2100 (var2874) var2100)
(declare-const null-var2874 var2874)
(declare-const var2219 var2874) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener 
(assert (not (= var2219 null-var2874)))
(define-const var14 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var14)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var14!1 String)
(assert (= var14!1 ""))
(define-const var2265 var3405 (url/-972593768 var2219)) ; Statement: $r2 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url> 
(define-const var2826 String (var2658_getRuleKey/876266182 var2265)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>($r2) 
(assert true)
(define-const var1051 String (append/672562846 var14!1 var2826)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var14!2 String)
(assert (= var14!2 (str.++ var14!1 var2826)))
(assert true)
(define-const var956 String (append/672562846 var1051 ".configurators")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators") 
(declare-const var1051!1 String)
(assert (= var1051!1 (str.++ var1051 ".configurators")))
(assert true)
(define-const var746 String (toString/-2075883882 var956)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (stopListen/1940503391 (cast-from-var2874-to-var2100 var2219) var746)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: void stopListen(java.lang.String)>($r6) 

(declare-const var2219!1 var2874)
(declare-const var746!1 String)
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), url/-972593768=([org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.common.URL), var2658_getRuleKey/876266182=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), stopListen/1940503391=([org.apache.dubbo.registry.integration.AbstractConfiguratorListener, java.lang.String], void), cast-from-var2874-to-var2100=([org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener], org.apache.dubbo.registry.integration.AbstractConfiguratorListener)}
; {var2874=org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener, var2219=r0, var14=$r1, var3405=org.apache.dubbo.common.URL, var2265=$r2, var2658=org.apache.dubbo.common.config.configcenter.DynamicConfiguration, var2826=$r3, var1051=$r4, var956=$r5, var746=$r6, var2100=org.apache.dubbo.registry.integration.AbstractConfiguratorListener}
; {org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener=var2874, r0=var2219, $r1=var14, org.apache.dubbo.common.URL=var3405, $r2=var2265, org.apache.dubbo.common.config.configcenter.DynamicConfiguration=var2658, $r3=var2826, $r4=var1051, $r5=var956, $r6=var746, org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var2100}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r2 = r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: org.apache.dubbo.common.URL url>;	$r3 = staticinvoke <org.apache.dubbo.common.config.configcenter.DynamicConfiguration: java.lang.String getRuleKey(org.apache.dubbo.common.URL)>($r2);	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".configurators");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r0.<org.apache.dubbo.registry.integration.RegistryDirectory$ReferenceConfigurationListener: void stopListen(java.lang.String)>($r6);	return
;block_num 1