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

(declare-sort var3438 0)
(declare-sort var2754 0)
(declare-sort var1919 0)
(declare-sort var1738 0)
(declare-sort var1027 0)
(declare-sort var3304 0)
(declare-sort var3955 0)
(declare-sort var1328 0)
(declare-sort var2687 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun registry/1179755747 (var3438) var1738)
(declare-fun var1738_containsBeanDefinition/-1518014895 (var1738 String) Bool)
(declare-fun var1738_getBeanDefinition/-726687993 (var1738 String) var1027)
(declare-fun var1027_equals/-810247786 (var1027 var3304) Bool)
(declare-fun cast-from-var1919-to-var3304 (var1919) var3304)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3304) String)
(declare-fun cast-from-var1027-to-var3304 (var1027) var3304)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun logger/1179755747 (var3438) var3955)
(declare-fun var3955_error/-110665684 (var3955 String String String String) void)
(declare-fun var1328-init () var1328)
(declare-fun getResourceDescription/1913712230 (var1919) String)
(declare-fun <init>/-828575923 (var1328 String String String) void)
(declare-fun cast-from-var1328-to-var2687 (var1328) var2687)
(declare-const null-var3438 var3438)
(declare-const null-String String)
(declare-const null-var1919 var1919)
(declare-const var524 var3438) ; Statement: r0 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor 
(assert (not (= var524 null-var3438)))
(declare-const var1700 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1700 null-String)))
(declare-const var1035 var1919) ; Statement: r3 := @parameter1: org.springframework.beans.factory.support.AbstractBeanDefinition 
(assert (not (= var1035 null-var1919)))
(declare-const var974 String) ; Statement: r16 := @parameter2: java.lang.String 
(assert (not (= var974 null-String)))
(define-const var1914 var1738 (registry/1179755747 var524)) ; Statement: $r2 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry> 
(define-const var2209 Bool (var1738_containsBeanDefinition/-1518014895 var1914 var1700)) ; Statement: $z0 = interfaceinvoke $r2.<org.springframework.beans.factory.support.BeanDefinitionRegistry: boolean containsBeanDefinition(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry> 
(assert (not (= (ite var2209 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3482 var1738 (registry/1179755747 var524)) ; Statement: $r13 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry> 
(define-const var2909 var1027 (var1738_getBeanDefinition/-726687993 var3482 var1700)) ; Statement: r14 = interfaceinvoke $r13.<org.springframework.beans.factory.support.BeanDefinitionRegistry: org.springframework.beans.factory.config.BeanDefinition getBeanDefinition(java.lang.String)>(r1) 
(define-const var1099 Bool (var1027_equals/-810247786 var2909 (cast-from-var1919-to-var3304 var1035))) ; Statement: $z2 = interfaceinvoke r14.<org.springframework.beans.factory.config.BeanDefinition: boolean equals(java.lang.Object)>(r3) 
 ; Statement: if $z2 == 0 goto $r30 = new java.lang.StringBuilder 
(assert (= (ite var1099 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2405 String String-init) ; Statement: $r30 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2405)) ; Statement: specialinvoke $r30.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2405!1 String)
(assert (= var2405!1 ""))
(assert true)
(define-const var3764 String (append/672562846 var2405!1 "Found duplicated BeanDefinition of service interface [")) ; Statement: $r17 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Found duplicated BeanDefinition of service interface [") 
(declare-const var2405!2 String)
(assert (= var2405!2 (str.++ var2405!1 "Found duplicated BeanDefinition of service interface [")))
(assert true)
(define-const var2478 String (append/672562846 var3764 var974)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r16) 
(declare-const var3764!1 String)
(assert (= var3764!1 (str.++ var3764 var974)))
(assert true)
(define-const var2844 String (append/672562846 var2478 "] with bean name [")) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] with bean name [") 
(declare-const var2478!1 String)
(assert (= var2478!1 (str.++ var2478 "] with bean name [")))
(assert true)
(define-const var3337 String (append/672562846 var2844 var1700)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2844!1 String)
(assert (= var2844!1 (str.++ var2844 var1700)))
(assert true)
(define-const var1377 String (append/672562846 var3337 "], existing definition [ ")) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("], existing definition [ ") 
(declare-const var3337!1 String)
(assert (= var3337!1 (str.++ var3337 "], existing definition [ ")))
(assert true)
(define-const var658 String (append/-1031950772 var1377 (cast-from-var1027-to-var3304 var2909))) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r14) 
(declare-const var1377!1 String)
(assert (str.prefixof var1377 var1377!1))
(assert true)
(define-const var840 String (append/672562846 var658 "], new definition [")) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("], new definition [") 
(declare-const var658!1 String)
(assert (= var658!1 (str.++ var658 "], new definition [")))
(assert true)
(define-const var298 String (append/-1031950772 var840 (cast-from-var1919-to-var3304 var1035))) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var840!1 String)
(assert (str.prefixof var840 var840!1))
(assert true)
(define-const var818 String (append/672562846 var298 "]")) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var298!1 String)
(assert (= var298!1 (str.++ var298 "]")))
(assert true)
(define-const var706 String (toString/-2075883882 var818)) ; Statement: r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var3671 var3955 (logger/1179755747 var524)) ; Statement: $r27 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3955_error/-110665684 var3671 "5-30" "" "" var706)) ; Statement: interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-30", "", "", r26) 

(declare-const var3671!1 var3955)
(declare-const var3875 String)
(declare-const var660 String)
(declare-const var660!1 String)
(declare-const var706!1 String)
(define-const var3001 var1328 var1328-init) ; Statement: $r31 = new org.springframework.beans.factory.BeanDefinitionStoreException 
(assert true)
(define-const var2488 String (getResourceDescription/1913712230 var1035)) ; Statement: $r29 = virtualinvoke r3.<org.springframework.beans.factory.support.AbstractBeanDefinition: java.lang.String getResourceDescription()>() 
(assert true)
;(assert (<init>/-828575923 var3001 var2488 var1700 var706!1)) ; Statement: specialinvoke $r31.<org.springframework.beans.factory.BeanDefinitionStoreException: void <init>(java.lang.String,java.lang.String,java.lang.String)>($r29, r1, r26) 

(declare-const var3001!1 var1328)
(declare-const var2488!1 String)
(declare-const var1700!1 String)
(declare-const var706!2 String)
(define-const var2696 var2687 (cast-from-var1328-to-var2687 var3001!1)) ; Statement: $r33 = (java.lang.Throwable) $r31 
 ; Statement: throw $r33 
(check-sat)
; {registry/1179755747=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor], org.springframework.beans.factory.support.BeanDefinitionRegistry), var1738_containsBeanDefinition/-1518014895=([org.springframework.beans.factory.support.BeanDefinitionRegistry, java.lang.String], boolean), var1738_getBeanDefinition/-726687993=([org.springframework.beans.factory.support.BeanDefinitionRegistry, java.lang.String], org.springframework.beans.factory.config.BeanDefinition), var1027_equals/-810247786=([org.springframework.beans.factory.config.BeanDefinition, java.lang.Object], boolean), cast-from-var1919-to-var3304=([org.springframework.beans.factory.support.AbstractBeanDefinition], java.lang.Object), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1027-to-var3304=([org.springframework.beans.factory.config.BeanDefinition], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), logger/1179755747=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var3955_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), var1328-init=([], org.springframework.beans.factory.BeanDefinitionStoreException), getResourceDescription/1913712230=([org.springframework.beans.factory.support.AbstractBeanDefinition], java.lang.String), <init>/-828575923=([org.springframework.beans.factory.BeanDefinitionStoreException, java.lang.String, java.lang.String, java.lang.String], void), cast-from-var1328-to-var2687=([org.springframework.beans.factory.BeanDefinitionStoreException], java.lang.Throwable)}
; {var3438=org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor, var524=r0, var1700=r1, var2754=null_type, var1919=org.springframework.beans.factory.support.AbstractBeanDefinition, var1035=r3, var974=r16, var1738=org.springframework.beans.factory.support.BeanDefinitionRegistry, var1914=$r2, var2209=$z0, var3482=$r13, var1027=org.springframework.beans.factory.config.BeanDefinition, var2909=r14, var3304=java.lang.Object, var1099=$z2, var2405=$r30, var3764=$r17, var2478=$r18, var2844=$r19, var3337=$r20, var1377=$r21, var658=$r22, var840=$r23, var298=$r24, var818=$r25, var706=r26, var3955=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3671=$r27, var3875="5-30", var660="", var1328=org.springframework.beans.factory.BeanDefinitionStoreException, var3001=$r31, var2488=$r29, var2687=java.lang.Throwable, var2696=$r33}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor=var3438, r0=var524, r1=var1700, null_type=var2754, org.springframework.beans.factory.support.AbstractBeanDefinition=var1919, r3=var1035, r16=var974, org.springframework.beans.factory.support.BeanDefinitionRegistry=var1738, $r2=var1914, $z0=var2209, $r13=var3482, org.springframework.beans.factory.config.BeanDefinition=var1027, r14=var2909, java.lang.Object=var3304, $z2=var1099, $r30=var2405, $r17=var3764, $r18=var2478, $r19=var2844, $r20=var3337, $r21=var1377, $r22=var658, $r23=var840, $r24=var298, $r25=var818, r26=var706, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3955, $r27=var3671, "5-30"=var3875, ""=var660, org.springframework.beans.factory.BeanDefinitionStoreException=var1328, $r31=var3001, $r29=var2488, java.lang.Throwable=var2687, $r33=var2696}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: org.springframework.beans.factory.support.AbstractBeanDefinition;	r16 := @parameter2: java.lang.String;	$r2 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry>;	$z0 = interfaceinvoke $r2.<org.springframework.beans.factory.support.BeanDefinitionRegistry: boolean containsBeanDefinition(java.lang.String)>(r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry>;	$r13 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry>;	r14 = interfaceinvoke $r13.<org.springframework.beans.factory.support.BeanDefinitionRegistry: org.springframework.beans.factory.config.BeanDefinition getBeanDefinition(java.lang.String)>(r1);	$z2 = interfaceinvoke r14.<org.springframework.beans.factory.config.BeanDefinition: boolean equals(java.lang.Object)>(r3);	if $z2 == 0 goto $r30 = new java.lang.StringBuilder;	$r30 = new java.lang.StringBuilder;	specialinvoke $r30.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Found duplicated BeanDefinition of service interface [");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r16);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] with bean name [");	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("], existing definition [ ");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r14);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("], new definition [");	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	$r27 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r27.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-30", "", "", r26);	$r31 = new org.springframework.beans.factory.BeanDefinitionStoreException;	$r29 = virtualinvoke r3.<org.springframework.beans.factory.support.AbstractBeanDefinition: java.lang.String getResourceDescription()>();	specialinvoke $r31.<org.springframework.beans.factory.BeanDefinitionStoreException: void <init>(java.lang.String,java.lang.String,java.lang.String)>($r29, r1, r26);	$r33 = (java.lang.Throwable) $r31;	throw $r33
;block_num 3