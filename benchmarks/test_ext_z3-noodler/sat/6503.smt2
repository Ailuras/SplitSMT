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

(declare-sort var2531 0)
(declare-sort var2693 0)
(declare-sort var2765 0)
(declare-sort var3419 0)
(declare-sort var1205 0)
(declare-sort var1757 0)
(declare-sort var30 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2693_getPluralTagName/631574667 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun environment/208128580 (var2531) var2765)
(declare-fun getConfigurationMaps/-938771446 (var2765) var3419)
(declare-fun var1757_getSubIds/753749180 (var30 String) var1205)
(declare-fun cast-from-var3419-to-var30 (var3419) var30)
(declare-const null-var2531 var2531)
(declare-const null-ClassObject ClassObject)
(declare-const var2778 var2531) ; Statement: r7 := @this: org.apache.dubbo.config.context.AbstractConfigManager 
(assert (not (= var2778 null-var2531)))
(declare-const var590 ClassObject) ; Statement: r1 := @parameter0: java.lang.Class 
(assert (not (= var590 null-ClassObject)))
(define-const var3731 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3731)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3731!1 String)
(assert (= var3731!1 ""))
(assert true)
(define-const var327 String (append/672562846 var3731!1 "dubbo.")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.") 
(declare-const var3731!2 String)
(assert (= var3731!2 (str.++ var3731!1 "dubbo.")))
(define-const var207 String (var2693_getPluralTagName/631574667 var590)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getPluralTagName(java.lang.Class)>(r1) 
(assert true)
(define-const var3364 String (append/672562846 var327 var207)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var327!1 String)
(assert (= var327!1 (str.++ var327 var207)))
(assert true)
(define-const var1943 String (append/672562846 var3364 ".")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var3364!1 String)
(assert (= var3364!1 (str.++ var3364 ".")))
(assert true)
(define-const var2798 String (toString/-2075883882 var1943)) ; Statement: r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var1138 var2765 (environment/208128580 var2778)) ; Statement: $r8 = r7.<org.apache.dubbo.config.context.AbstractConfigManager: org.apache.dubbo.common.config.Environment environment> 
(assert true)
(define-const var3805 var3419 (getConfigurationMaps/-938771446 var1138)) ; Statement: $r9 = virtualinvoke $r8.<org.apache.dubbo.common.config.Environment: java.util.List getConfigurationMaps()>() 
(define-const var3051 var1205 (var1757_getSubIds/753749180 (cast-from-var3419-to-var30 var3805) var2798)) ; Statement: $r10 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set getSubIds(java.util.Collection,java.lang.String)>($r9, r6) 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2693_getPluralTagName/631574667=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), environment/208128580=([org.apache.dubbo.config.context.AbstractConfigManager], org.apache.dubbo.common.config.Environment), getConfigurationMaps/-938771446=([org.apache.dubbo.common.config.Environment], java.util.List), var1757_getSubIds/753749180=([java.util.Collection, java.lang.String], java.util.Set), cast-from-var3419-to-var30=([java.util.List], java.util.Collection)}
; {var2531=org.apache.dubbo.config.context.AbstractConfigManager, var2778=r7, var590=r1, var3731=$r0, var327=$r3, var2693=org.apache.dubbo.config.AbstractConfig, var207=$r2, var3364=$r4, var1943=$r5, var2798=r6, var2765=org.apache.dubbo.common.config.Environment, var1138=$r8, var3419=java.util.List, var3805=$r9, var1205=java.util.Set, var1757=org.apache.dubbo.common.config.ConfigurationUtils, var30=java.util.Collection, var3051=$r10}
; {org.apache.dubbo.config.context.AbstractConfigManager=var2531, r7=var2778, r1=var590, $r0=var3731, $r3=var327, org.apache.dubbo.config.AbstractConfig=var2693, $r2=var207, $r4=var3364, $r5=var1943, r6=var2798, org.apache.dubbo.common.config.Environment=var2765, $r8=var1138, java.util.List=var3419, $r9=var3805, java.util.Set=var1205, org.apache.dubbo.common.config.ConfigurationUtils=var1757, java.util.Collection=var30, $r10=var3051}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.config.context.AbstractConfigManager;	r1 := @parameter0: java.lang.Class;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("dubbo.");	$r2 = staticinvoke <org.apache.dubbo.config.AbstractConfig: java.lang.String getPluralTagName(java.lang.Class)>(r1);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r8 = r7.<org.apache.dubbo.config.context.AbstractConfigManager: org.apache.dubbo.common.config.Environment environment>;	$r9 = virtualinvoke $r8.<org.apache.dubbo.common.config.Environment: java.util.List getConfigurationMaps()>();	$r10 = staticinvoke <org.apache.dubbo.common.config.ConfigurationUtils: java.util.Set getSubIds(java.util.Collection,java.lang.String)>($r9, r6);	return $r10
;block_num 1