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

(declare-sort var2157 0)
(declare-sort var1879 0)
(declare-sort var3309 0)
(declare-sort var3962 0)
(declare-sort var2085 0)
(declare-sort var3067 0)
(declare-sort var3538 0)
(declare-sort var1362 0)
(declare-sort var3177 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1879_get/1088891777 (var1879 var3962) var3962)
(declare-fun cast-from-String-to-var3962 (String) var3962)
(declare-fun cast-from-var3962-to-String (var3962) String)
(declare-fun var2085_hasText/2115555376 (String) Bool)
(declare-fun var3067_rootBeanDefinition/-2083243456 (ClassObject) var3067)
(declare-fun getRawBeanDefinition/-1364723377 (var3067) var3538)
(declare-fun cast-from-var3538-to-var1362 (var3538) var1362)
(declare-fun var3177_generateBeanName/1062428058 (var1362 var3309) String)
(declare-const null-var2157 var2157)
(declare-const null-var1879 var1879)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3309 var3309)
(declare-const var1610 var2157) ; Statement: r6 := @this: org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar 
(assert (not (= var1610 null-var2157)))
(declare-const var2975 var1879) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var2975 null-var1879)))
(declare-const var2075 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var2075 null-ClassObject)))
(declare-const var3219 var3309) ; Statement: r4 := @parameter2: org.springframework.beans.factory.support.BeanDefinitionRegistry 
(assert (not (= var3219 null-var3309)))
(define-const var1750 var3962 (var1879_get/1088891777 var2975 (cast-from-String-to-var3962 "id"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("id") 
(define-const var65 String (cast-from-var3962-to-String var1750)) ; Statement: r7 = (java.lang.String) $r1 
(define-const var3234 Bool (var2085_hasText/2115555376 var65)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r7) 
 ; Statement: if $z0 != 0 goto return r7 
(assert (not (not (= (ite var3234 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var564 var3067 (var3067_rootBeanDefinition/-2083243456 var2075)) ; Statement: r3 = staticinvoke <org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder rootBeanDefinition(java.lang.Class)>(r2) 
(assert true)
(define-const var2366 var3538 (getRawBeanDefinition/-1364723377 var564)) ; Statement: $r5 = virtualinvoke r3.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.AbstractBeanDefinition getRawBeanDefinition()>() 
(define-const var869 var1362 (cast-from-var3538-to-var1362 var2366)) ; Statement: $r8 = (org.springframework.beans.factory.config.BeanDefinition) $r5 
(define-const var65!1 String (var3177_generateBeanName/1062428058 var869 var3219)) ; Statement: r7 = staticinvoke <org.springframework.beans.factory.support.BeanDefinitionReaderUtils: java.lang.String generateBeanName(org.springframework.beans.factory.config.BeanDefinition,org.springframework.beans.factory.support.BeanDefinitionRegistry)>($r8, r4) 
(assert true) ; Non Conditional
 ; Statement: return r7 
(check-sat)
; {var1879_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3962=([java.lang.String], java.lang.Object), cast-from-var3962-to-String=([java.lang.Object], java.lang.String), var2085_hasText/2115555376=([java.lang.String], boolean), var3067_rootBeanDefinition/-2083243456=([java.lang.Class], org.springframework.beans.factory.support.BeanDefinitionBuilder), getRawBeanDefinition/-1364723377=([org.springframework.beans.factory.support.BeanDefinitionBuilder], org.springframework.beans.factory.support.AbstractBeanDefinition), cast-from-var3538-to-var1362=([org.springframework.beans.factory.support.AbstractBeanDefinition], org.springframework.beans.factory.config.BeanDefinition), var3177_generateBeanName/1062428058=([org.springframework.beans.factory.config.BeanDefinition, org.springframework.beans.factory.support.BeanDefinitionRegistry], java.lang.String)}
; {var2157=org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar, var1610=r6, var1879=java.util.Map, var2975=r0, var2075=r2, var3309=org.springframework.beans.factory.support.BeanDefinitionRegistry, var3219=r4, var3962=java.lang.Object, var1750=$r1, var65=r7, var2085=org.springframework.util.StringUtils, var3234=$z0, var3067=org.springframework.beans.factory.support.BeanDefinitionBuilder, var564=r3, var3538=org.springframework.beans.factory.support.AbstractBeanDefinition, var2366=$r5, var1362=org.springframework.beans.factory.config.BeanDefinition, var869=$r8, var3177=org.springframework.beans.factory.support.BeanDefinitionReaderUtils}
; {org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar=var2157, r6=var1610, java.util.Map=var1879, r0=var2975, r2=var2075, org.springframework.beans.factory.support.BeanDefinitionRegistry=var3309, r4=var3219, java.lang.Object=var3962, $r1=var1750, r7=var65, org.springframework.util.StringUtils=var2085, $z0=var3234, org.springframework.beans.factory.support.BeanDefinitionBuilder=var3067, r3=var564, org.springframework.beans.factory.support.AbstractBeanDefinition=var3538, $r5=var2366, org.springframework.beans.factory.config.BeanDefinition=var1362, $r8=var869, org.springframework.beans.factory.support.BeanDefinitionReaderUtils=var3177}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar;	r0 := @parameter0: java.util.Map;	r2 := @parameter1: java.lang.Class;	r4 := @parameter2: org.springframework.beans.factory.support.BeanDefinitionRegistry;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("id");	r7 = (java.lang.String) $r1;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r7);	if $z0 != 0 goto return r7;	r3 = staticinvoke <org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder rootBeanDefinition(java.lang.Class)>(r2);	$r5 = virtualinvoke r3.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.AbstractBeanDefinition getRawBeanDefinition()>();	$r8 = (org.springframework.beans.factory.config.BeanDefinition) $r5;	r7 = staticinvoke <org.springframework.beans.factory.support.BeanDefinitionReaderUtils: java.lang.String generateBeanName(org.springframework.beans.factory.config.BeanDefinition,org.springframework.beans.factory.support.BeanDefinitionRegistry)>($r8, r4);	return r7
;block_num 3