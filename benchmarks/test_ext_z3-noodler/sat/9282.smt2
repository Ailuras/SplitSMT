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

(declare-sort var2493 0)
(declare-sort var3169 0)
(declare-sort var1649 0)
(declare-sort var577 0)
(declare-sort var1184 0)
(declare-sort var1780 0)
(declare-sort var1154 0)
(declare-sort var3298 0)
(declare-sort var1760 0)
(declare-sort var94 0)
(declare-sort var3507 0)
(declare-sort var198 0)
(declare-sort var1066 0)
(declare-sort var27 0)
(declare-sort var3534 0)
(declare-sort var1596 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1184!class ClassObject)
(declare-fun var577_rootBeanDefinition/-2083243456 (ClassObject) var577)
(declare-fun getBeanDefinition/-852694211 (var577) var1780)
(declare-fun setAutowireMode/1470613957 (var1780 Int) void)
(declare-fun getPropertyValues/363138209 (var1780) var1154)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var1760_of/-18932069 ((Array Int var3298)) (Array Int var3298))
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3298__ ((Array Int String)) (Array Int var3298))
(declare-fun cast-from-__Array__Int__var3298__-to-__Array__Int__String__ ((Array Int var3298)) (Array Int String))
(declare-fun var94-init () var94)
(declare-fun environment/1179755747 (var2493) var3507)
(declare-fun cast-from-var3507-to-var198 (var3507) var198)
(declare-fun <init>/-346017378 (var94 var3169 var198 (Array Int String)) void)
(declare-fun addPropertyValues/-125451784 (var1154 var1066) var1154)
(declare-fun cast-from-var94-to-var1066 (var94) var1066)
(declare-fun addPropertyReference/225689486 (var2493 var577 String String) void)
(declare-fun addPropertyValue/1589292204 (var577 String var3298) var577)
(declare-fun cast-from-String-to-var3298 (String) var3298)
(declare-fun var3169_get/1088891777 (var3169 var3298) var3298)
(declare-fun cast-from-var3298-to-__Array__Int__String__ (var3298) (Array Int String))
(declare-fun var27_convertParameters/424806178 ((Array Int String)) var3169)
(declare-fun cast-from-var3169-to-var3298 (var3169) var3298)
(declare-fun convertMethodConfigs/-990368556 (var2493 var3298) var3534)
(declare-fun var3534_isEmpty/-153543822 (var3534) Bool)
(declare-fun cast-from-var3298-to-String (var3298) String)
(declare-fun var1596_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun setLazyInit/-416882191 (var577 Bool) var577)
(declare-const null-var2493 var2493)
(declare-const null-var3169 var3169)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3160 var2493) ; Statement: r8 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor 
(assert (not (= var3160 null-var2493)))
(declare-const var1128 var3169) ; Statement: r7 := @parameter0: java.util.Map 
(assert (not (= var1128 null-var3169)))
(declare-const var764 String) ; Statement: r11 := @parameter1: java.lang.String 
(assert (not (= var764 null-String)))
(declare-const var2976 String) ; Statement: r10 := @parameter2: java.lang.String 
(assert (not (= var2976 null-String)))
(define-const var54 var577 (var577_rootBeanDefinition/-2083243456 var1184!class)) ; Statement: r0 = staticinvoke <org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder rootBeanDefinition(java.lang.Class)>(class "Lorg/apache/dubbo/config/spring/ServiceBean;") 
(assert true)
(define-const var2450 var1780 (getBeanDefinition/-852694211 var54)) ; Statement: r1 = virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.AbstractBeanDefinition getBeanDefinition()>() 
(assert true)
;(assert (setAutowireMode/1470613957 var2450 3)) ; Statement: virtualinvoke r1.<org.springframework.beans.factory.support.AbstractBeanDefinition: void setAutowireMode(int)>(3) 

(declare-const var2450!1 var1780)
(declare-const var437 Int)
(assert true)
(define-const var803 var1154 (getPropertyValues/363138209 var2450!1)) ; Statement: r2 = virtualinvoke r1.<org.springframework.beans.factory.support.AbstractBeanDefinition: org.springframework.beans.MutablePropertyValues getPropertyValues()>() 
(define-const var3837 (Array Int String) arr-String-init) ; Statement: $r3 = newarray (java.lang.String)[10] 
(declare-const var3837!1 (Array Int String))
(assert (not (= var3837!1 null-__Array__Int__String__)))
(assert (= (select var3837!1 0) "provider")) ; Statement: $r3[0] = "provider" 
(declare-const var3837!2 (Array Int String))
(assert (not (= var3837!2 null-__Array__Int__String__)))
(assert (= (select var3837!2 1) "monitor")) ; Statement: $r3[1] = "monitor" 
(declare-const var3837!3 (Array Int String))
(assert (not (= var3837!3 null-__Array__Int__String__)))
(assert (= (select var3837!3 2) "application")) ; Statement: $r3[2] = "application" 
(declare-const var3837!4 (Array Int String))
(assert (not (= var3837!4 null-__Array__Int__String__)))
(assert (= (select var3837!4 3) "module")) ; Statement: $r3[3] = "module" 
(declare-const var3837!5 (Array Int String))
(assert (not (= var3837!5 null-__Array__Int__String__)))
(assert (= (select var3837!5 4) "registry")) ; Statement: $r3[4] = "registry" 
(declare-const var3837!6 (Array Int String))
(assert (not (= var3837!6 null-__Array__Int__String__)))
(assert (= (select var3837!6 5) "protocol")) ; Statement: $r3[5] = "protocol" 
(declare-const var3837!7 (Array Int String))
(assert (not (= var3837!7 null-__Array__Int__String__)))
(assert (= (select var3837!7 6) "methods")) ; Statement: $r3[6] = "methods" 
(declare-const var3837!8 (Array Int String))
(assert (not (= var3837!8 null-__Array__Int__String__)))
(assert (= (select var3837!8 7) "interfaceName")) ; Statement: $r3[7] = "interfaceName" 
(declare-const var3837!9 (Array Int String))
(assert (not (= var3837!9 null-__Array__Int__String__)))
(assert (= (select var3837!9 8) "parameters")) ; Statement: $r3[8] = "parameters" 
(declare-const var3837!10 (Array Int String))
(assert (not (= var3837!10 null-__Array__Int__String__)))
(assert (= (select var3837!10 9) "executor")) ; Statement: $r3[9] = "executor" 
(define-const var1496 (Array Int var3298) (var1760_of/-18932069 (cast-from-__Array__Int__String__-to-__Array__Int__var3298__ var3837!10))) ; Statement: $r4 = staticinvoke <org.apache.dubbo.config.spring.util.ObjectUtils: java.lang.Object[] of(java.lang.Object[])>($r3) 
(define-const var721 (Array Int String) (cast-from-__Array__Int__var3298__-to-__Array__Int__String__ var1496)) ; Statement: r5 = (java.lang.String[]) $r4 
(define-const var2776 var94 var94-init) ; Statement: $r34 = new org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter 
(define-const var1436 var3507 (environment/1179755747 var3160)) ; Statement: $r9 = r8.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.core.env.Environment environment> 
(define-const var3552 var198 (cast-from-var3507-to-var198 var1436)) ; Statement: $r36 = (org.springframework.core.env.PropertyResolver) $r9 
(assert true)
;(assert (<init>/-346017378 var2776 var1128 var3552 var721)) ; Statement: specialinvoke $r34.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AnnotationPropertyValuesAdapter: void <init>(java.util.Map,org.springframework.core.env.PropertyResolver,java.lang.String[])>(r7, $r36, r5) 

(declare-const var2776!1 var94)
(declare-const var1128!1 var3169)
(declare-const var3552!1 var198)
(declare-const var721!1 (Array Int String))
(assert true)
;(assert (addPropertyValues/-125451784 var803 (cast-from-var94-to-var1066 var2776!1))) ; Statement: virtualinvoke r2.<org.springframework.beans.MutablePropertyValues: org.springframework.beans.MutablePropertyValues addPropertyValues(org.springframework.beans.PropertyValues)>($r34) 

(declare-const var803!1 var1154)
(declare-const var2776!2 var94)
(assert true)
;(assert (addPropertyReference/225689486 var3160 var54 "ref" var2976)) ; Statement: specialinvoke r8.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: void addPropertyReference(org.springframework.beans.factory.support.BeanDefinitionBuilder,java.lang.String,java.lang.String)>(r0, "ref", r10) 

(declare-const var3160!1 var2493)
(declare-const var54!1 var577)
(declare-const var1724 String)
(declare-const var2976!1 String)
(assert true)
;(assert (addPropertyValue/1589292204 var54!1 "interface" (cast-from-String-to-var3298 var764))) ; Statement: virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder addPropertyValue(java.lang.String,java.lang.Object)>("interface", r11) 

(declare-const var54!2 var577)
(declare-const var3366 String)
(declare-const var764!1 String)
(define-const var2453 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "parameters"))) ; Statement: $r12 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("parameters") 
(define-const var887 (Array Int String) (cast-from-var3298-to-__Array__Int__String__ var2453)) ; Statement: $r13 = (java.lang.String[]) $r12 
(define-const var3713 var3169 (var27_convertParameters/424806178 var887)) ; Statement: $r14 = staticinvoke <org.apache.dubbo.config.spring.util.DubboAnnotationUtils: java.util.Map convertParameters(java.lang.String[])>($r13) 
(assert true)
;(assert (addPropertyValue/1589292204 var54!2 "parameters" (cast-from-var3169-to-var3298 var3713))) ; Statement: virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder addPropertyValue(java.lang.String,java.lang.Object)>("parameters", $r14) 

(declare-const var54!3 var577)
(declare-const var2206 String)
(declare-const var3713!1 var3169)
(define-const var3983 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "methods"))) ; Statement: $r15 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("methods") 
(assert true)
(define-const var3704 var3534 (convertMethodConfigs/-990368556 var3160!1 var3983)) ; Statement: r16 = specialinvoke r8.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: java.util.List convertMethodConfigs(java.lang.Object)>($r15) 
(define-const var2083 Bool (var3534_isEmpty/-153543822 var3704)) ; Statement: $z0 = interfaceinvoke r16.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 != 0 goto $r28 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("provider") 
(assert (not (= (ite var2083 1 0) 0))) ; Cond: $z0 != 0 
(define-const var10 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "provider"))) ; Statement: $r28 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("provider") 
(define-const var3810 String (cast-from-var3298-to-String var10)) ; Statement: $r29 = (java.lang.String) $r28 
(define-const var751 Bool (var1596_hasText/853333513 (cast-from-String-to-String var3810))) ; Statement: $z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r29) 
 ; Statement: if $z4 == 0 goto $r17 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(assert (= (ite var751 1 0) 0)) ; Cond: $z4 == 0 
(define-const var2694 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "registry"))) ; Statement: $r17 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry") 
(define-const var2423 (Array Int String) (cast-from-var3298-to-__Array__Int__String__ var2694)) ; Statement: $r25 = (java.lang.String[]) $r17 
 ; Statement: if $r25 == null goto $r30 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(assert (= var2423 null-__Array__Int__String__)) ; Cond: $r25 == null 
(define-const var853 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "protocol"))) ; Statement: $r30 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol") 
(define-const var744 (Array Int String) (cast-from-var3298-to-__Array__Int__String__ var853)) ; Statement: $r31 = (java.lang.String[]) $r30 
 ; Statement: if $r31 == null goto $r32 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("monitor") 
(assert (= var744 null-__Array__Int__String__)) ; Cond: $r31 == null 
(define-const var2604 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "monitor"))) ; Statement: $r32 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("monitor") 
(define-const var1497 String (cast-from-var3298-to-String var2604)) ; Statement: $r33 = (java.lang.String) $r32 
(define-const var414 Bool (var1596_hasText/853333513 (cast-from-String-to-String var1497))) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r33) 
 ; Statement: if $z5 == 0 goto $r18 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("module") 
(assert (= (ite var414 1 0) 0)) ; Cond: $z5 == 0 
(define-const var897 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "module"))) ; Statement: $r18 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("module") 
(define-const var227 String (cast-from-var3298-to-String var897)) ; Statement: $r22 = (java.lang.String) $r18 
(define-const var3610 Bool (var1596_hasText/853333513 (cast-from-String-to-String var227))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r22) 
 ; Statement: if $z1 == 0 goto $r19 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("executor") 
(assert (= (ite var3610 1 0) 0)) ; Cond: $z1 == 0 
(define-const var2994 var3298 (var3169_get/1088891777 var1128!1 (cast-from-String-to-var3298 "executor"))) ; Statement: $r19 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("executor") 
(define-const var2681 String (cast-from-var3298-to-String var2994)) ; Statement: $r21 = (java.lang.String) $r19 
(define-const var1196 Bool (var1596_hasText/853333513 (cast-from-String-to-String var2681))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r21) 
 ; Statement: if $z2 == 0 goto virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder setLazyInit(boolean)>(0) 
(assert (= (ite var1196 1 0) 0)) ; Cond: $z2 == 0 
(assert true)
;(assert (setLazyInit/-416882191 var54!3 (ite (= 1 0) true false))) ; Statement: virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder setLazyInit(boolean)>(0) 

(declare-const var54!4 var577)
(declare-const var2935 Int)
(assert true)
(define-const var2187 var1780 (getBeanDefinition/-852694211 var54!4)) ; Statement: $r20 = virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.AbstractBeanDefinition getBeanDefinition()>() 
 ; Statement: return $r20 
(check-sat)
; {var577_rootBeanDefinition/-2083243456=([java.lang.Class], org.springframework.beans.factory.support.BeanDefinitionBuilder), getBeanDefinition/-852694211=([org.springframework.beans.factory.support.BeanDefinitionBuilder], org.springframework.beans.factory.support.AbstractBeanDefinition), setAutowireMode/1470613957=([org.springframework.beans.factory.support.AbstractBeanDefinition, int], void), getPropertyValues/363138209=([org.springframework.beans.factory.support.AbstractBeanDefinition], org.springframework.beans.MutablePropertyValues), arr-String-init=([], java.lang.String[]), var1760_of/-18932069=([java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__String__-to-__Array__Int__var3298__=([java.lang.String[]], java.lang.Object[]), cast-from-__Array__Int__var3298__-to-__Array__Int__String__=([java.lang.Object[]], java.lang.String[]), var94-init=([], org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter), environment/1179755747=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor], org.springframework.core.env.Environment), cast-from-var3507-to-var198=([org.springframework.core.env.Environment], org.springframework.core.env.PropertyResolver), <init>/-346017378=([org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter, java.util.Map, org.springframework.core.env.PropertyResolver, java.lang.String[]], void), addPropertyValues/-125451784=([org.springframework.beans.MutablePropertyValues, org.springframework.beans.PropertyValues], org.springframework.beans.MutablePropertyValues), cast-from-var94-to-var1066=([org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter], org.springframework.beans.PropertyValues), addPropertyReference/225689486=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor, org.springframework.beans.factory.support.BeanDefinitionBuilder, java.lang.String, java.lang.String], void), addPropertyValue/1589292204=([org.springframework.beans.factory.support.BeanDefinitionBuilder, java.lang.String, java.lang.Object], org.springframework.beans.factory.support.BeanDefinitionBuilder), cast-from-String-to-var3298=([java.lang.String], java.lang.Object), var3169_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3298-to-__Array__Int__String__=([java.lang.Object], java.lang.String[]), var27_convertParameters/424806178=([java.lang.String[]], java.util.Map), cast-from-var3169-to-var3298=([java.util.Map], java.lang.Object), convertMethodConfigs/-990368556=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor, java.lang.Object], java.util.List), var3534_isEmpty/-153543822=([java.util.List], boolean), cast-from-var3298-to-String=([java.lang.Object], java.lang.String), var1596_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), setLazyInit/-416882191=([org.springframework.beans.factory.support.BeanDefinitionBuilder, boolean], org.springframework.beans.factory.support.BeanDefinitionBuilder)}
; {var2493=org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor, var3160=r8, var3169=java.util.Map, var1128=r7, var764=r11, var1649=null_type, var2976=r10, var577=org.springframework.beans.factory.support.BeanDefinitionBuilder, var1184=org.apache.dubbo.config.spring.ServiceBean, var54=r0, var1780=org.springframework.beans.factory.support.AbstractBeanDefinition, var2450=r1, var437=3, var1154=org.springframework.beans.MutablePropertyValues, var803=r2, var3837=$r3, var3298=java.lang.Object, var1760=org.apache.dubbo.config.spring.util.ObjectUtils, var1496=$r4, var721=r5, var94=org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter, var2776=$r34, var3507=org.springframework.core.env.Environment, var1436=$r9, var198=org.springframework.core.env.PropertyResolver, var3552=$r36, var1066=org.springframework.beans.PropertyValues, var1724="ref", var3366="interface", var2453=$r12, var887=$r13, var27=org.apache.dubbo.config.spring.util.DubboAnnotationUtils, var3713=$r14, var2206="parameters", var3983=$r15, var3534=java.util.List, var3704=r16, var2083=$z0, var10=$r28, var3810=$r29, var1596=org.apache.dubbo.common.utils.StringUtils, var751=$z4, var2694=$r17, var2423=$r25, var853=$r30, var744=$r31, var2604=$r32, var1497=$r33, var414=$z5, var897=$r18, var227=$r22, var3610=$z1, var2994=$r19, var2681=$r21, var1196=$z2, var2935=0, var2187=$r20}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor=var2493, r8=var3160, java.util.Map=var3169, r7=var1128, r11=var764, null_type=var1649, r10=var2976, org.springframework.beans.factory.support.BeanDefinitionBuilder=var577, org.apache.dubbo.config.spring.ServiceBean=var1184, r0=var54, org.springframework.beans.factory.support.AbstractBeanDefinition=var1780, r1=var2450, 3=var437, org.springframework.beans.MutablePropertyValues=var1154, r2=var803, $r3=var3837, java.lang.Object=var3298, org.apache.dubbo.config.spring.util.ObjectUtils=var1760, $r4=var1496, r5=var721, org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter=var94, $r34=var2776, org.springframework.core.env.Environment=var3507, $r9=var1436, org.springframework.core.env.PropertyResolver=var198, $r36=var3552, org.springframework.beans.PropertyValues=var1066, "ref"=var1724, "interface"=var3366, $r12=var2453, $r13=var887, org.apache.dubbo.config.spring.util.DubboAnnotationUtils=var27, $r14=var3713, "parameters"=var2206, $r15=var3983, java.util.List=var3534, r16=var3704, $z0=var2083, $r28=var10, $r29=var3810, org.apache.dubbo.common.utils.StringUtils=var1596, $z4=var751, $r17=var2694, $r25=var2423, $r30=var853, $r31=var744, $r32=var2604, $r33=var1497, $z5=var414, $r18=var897, $r22=var227, $z1=var3610, $r19=var2994, $r21=var2681, $z2=var1196, 0=var2935, $r20=var2187}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 4}
;stmts r8 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor;	r7 := @parameter0: java.util.Map;	r11 := @parameter1: java.lang.String;	r10 := @parameter2: java.lang.String;	r0 = staticinvoke <org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder rootBeanDefinition(java.lang.Class)>(class "Lorg/apache/dubbo/config/spring/ServiceBean;");	r1 = virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.AbstractBeanDefinition getBeanDefinition()>();	virtualinvoke r1.<org.springframework.beans.factory.support.AbstractBeanDefinition: void setAutowireMode(int)>(3);	r2 = virtualinvoke r1.<org.springframework.beans.factory.support.AbstractBeanDefinition: org.springframework.beans.MutablePropertyValues getPropertyValues()>();	$r3 = newarray (java.lang.String)[10];	$r3[0] = "provider";	$r3[1] = "monitor";	$r3[2] = "application";	$r3[3] = "module";	$r3[4] = "registry";	$r3[5] = "protocol";	$r3[6] = "methods";	$r3[7] = "interfaceName";	$r3[8] = "parameters";	$r3[9] = "executor";	$r4 = staticinvoke <org.apache.dubbo.config.spring.util.ObjectUtils: java.lang.Object[] of(java.lang.Object[])>($r3);	r5 = (java.lang.String[]) $r4;	$r34 = new org.apache.dubbo.config.spring.beans.factory.annotation.AnnotationPropertyValuesAdapter;	$r9 = r8.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.core.env.Environment environment>;	$r36 = (org.springframework.core.env.PropertyResolver) $r9;	specialinvoke $r34.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AnnotationPropertyValuesAdapter: void <init>(java.util.Map,org.springframework.core.env.PropertyResolver,java.lang.String[])>(r7, $r36, r5);	virtualinvoke r2.<org.springframework.beans.MutablePropertyValues: org.springframework.beans.MutablePropertyValues addPropertyValues(org.springframework.beans.PropertyValues)>($r34);	specialinvoke r8.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: void addPropertyReference(org.springframework.beans.factory.support.BeanDefinitionBuilder,java.lang.String,java.lang.String)>(r0, "ref", r10);	virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder addPropertyValue(java.lang.String,java.lang.Object)>("interface", r11);	$r12 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("parameters");	$r13 = (java.lang.String[]) $r12;	$r14 = staticinvoke <org.apache.dubbo.config.spring.util.DubboAnnotationUtils: java.util.Map convertParameters(java.lang.String[])>($r13);	virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder addPropertyValue(java.lang.String,java.lang.Object)>("parameters", $r14);	$r15 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("methods");	r16 = specialinvoke r8.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: java.util.List convertMethodConfigs(java.lang.Object)>($r15);	$z0 = interfaceinvoke r16.<java.util.List: boolean isEmpty()>();	if $z0 != 0 goto $r28 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("provider");	$r28 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("provider");	$r29 = (java.lang.String) $r28;	$z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r29);	if $z4 == 0 goto $r17 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r17 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("registry");	$r25 = (java.lang.String[]) $r17;	if $r25 == null goto $r30 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r30 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("protocol");	$r31 = (java.lang.String[]) $r30;	if $r31 == null goto $r32 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("monitor");	$r32 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("monitor");	$r33 = (java.lang.String) $r32;	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r33);	if $z5 == 0 goto $r18 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("module");	$r18 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("module");	$r22 = (java.lang.String) $r18;	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r22);	if $z1 == 0 goto $r19 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("executor");	$r19 = interfaceinvoke r7.<java.util.Map: java.lang.Object get(java.lang.Object)>("executor");	$r21 = (java.lang.String) $r19;	$z2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r21);	if $z2 == 0 goto virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder setLazyInit(boolean)>(0);	virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder setLazyInit(boolean)>(0);	$r20 = virtualinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.AbstractBeanDefinition getBeanDefinition()>();	return $r20
;block_num 8