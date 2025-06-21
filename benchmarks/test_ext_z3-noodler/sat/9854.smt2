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

(declare-sort var339 0)
(declare-sort var2045 0)
(declare-sort var3144 0)
(declare-sort var879 0)
(declare-sort var1898 0)
(declare-sort var67 0)
(declare-sort var763 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun registry/1179755747 (var339) var879)
(declare-fun var879_containsBeanDefinition/-1518014895 (var879 String) Bool)
(declare-fun cast-from-var3144-to-var1898 (var3144) var1898)
(declare-fun var879_registerBeanDefinition/1733208276 (var879 String var1898) void)
(declare-fun logger/1179755747 (var339) var67)
(declare-fun var763_isInfoEnabled/-651841081 (var763) Bool)
(declare-fun cast-from-var67-to-var763 (var67) var763)
(declare-const null-var339 var339)
(declare-const null-String String)
(declare-const null-var3144 var3144)
(declare-const var3002 var339) ; Statement: r0 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor 
(assert (not (= var3002 null-var339)))
(declare-const var2475 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2475 null-String)))
(declare-const var1580 var3144) ; Statement: r3 := @parameter1: org.springframework.beans.factory.support.AbstractBeanDefinition 
(assert (not (= var1580 null-var3144)))
(declare-const var2285 String) ; Statement: r16 := @parameter2: java.lang.String 
(assert (not (= var2285 null-String)))
(define-const var1461 var879 (registry/1179755747 var3002)) ; Statement: $r2 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry> 
(define-const var2313 Bool (var879_containsBeanDefinition/-1518014895 var1461 var2475)) ; Statement: $z0 = interfaceinvoke $r2.<org.springframework.beans.factory.support.BeanDefinitionRegistry: boolean containsBeanDefinition(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry> 
(assert (= (ite var2313 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3762 var879 (registry/1179755747 var3002)) ; Statement: $r4 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry> 
(define-const var3806 var1898 (cast-from-var3144-to-var1898 var1580)) ; Statement: $r34 = (org.springframework.beans.factory.config.BeanDefinition) r3 
;(assert (var879_registerBeanDefinition/1733208276 var3762 var2475 var3806)) ; Statement: interfaceinvoke $r4.<org.springframework.beans.factory.support.BeanDefinitionRegistry: void registerBeanDefinition(java.lang.String,org.springframework.beans.factory.config.BeanDefinition)>(r1, $r34) 

(declare-const var3762!1 var879)
(declare-const var2475!1 String)
(declare-const var3806!1 var1898)
(define-const var2359 var67 (logger/1179755747 var3002)) ; Statement: $r5 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2196 Bool (var763_isInfoEnabled/-651841081 (cast-from-var67-to-var763 var2359))) ; Statement: $z1 = interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>() 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var2196 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {registry/1179755747=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor], org.springframework.beans.factory.support.BeanDefinitionRegistry), var879_containsBeanDefinition/-1518014895=([org.springframework.beans.factory.support.BeanDefinitionRegistry, java.lang.String], boolean), cast-from-var3144-to-var1898=([org.springframework.beans.factory.support.AbstractBeanDefinition], org.springframework.beans.factory.config.BeanDefinition), var879_registerBeanDefinition/1733208276=([org.springframework.beans.factory.support.BeanDefinitionRegistry, java.lang.String, org.springframework.beans.factory.config.BeanDefinition], void), logger/1179755747=([org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), var763_isInfoEnabled/-651841081=([org.apache.dubbo.common.logger.Logger], boolean), cast-from-var67-to-var763=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger)}
; {var339=org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor, var3002=r0, var2475=r1, var2045=null_type, var3144=org.springframework.beans.factory.support.AbstractBeanDefinition, var1580=r3, var2285=r16, var879=org.springframework.beans.factory.support.BeanDefinitionRegistry, var1461=$r2, var2313=$z0, var3762=$r4, var1898=org.springframework.beans.factory.config.BeanDefinition, var3806=$r34, var67=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2359=$r5, var763=org.apache.dubbo.common.logger.Logger, var2196=$z1}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor=var339, r0=var3002, r1=var2475, null_type=var2045, org.springframework.beans.factory.support.AbstractBeanDefinition=var3144, r3=var1580, r16=var2285, org.springframework.beans.factory.support.BeanDefinitionRegistry=var879, $r2=var1461, $z0=var2313, $r4=var3762, org.springframework.beans.factory.config.BeanDefinition=var1898, $r34=var3806, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var67, $r5=var2359, org.apache.dubbo.common.logger.Logger=var763, $z1=var2196}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ServiceAnnotationPostProcessor;	r1 := @parameter0: java.lang.String;	r3 := @parameter1: org.springframework.beans.factory.support.AbstractBeanDefinition;	r16 := @parameter2: java.lang.String;	$r2 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry>;	$z0 = interfaceinvoke $r2.<org.springframework.beans.factory.support.BeanDefinitionRegistry: boolean containsBeanDefinition(java.lang.String)>(r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry>;	$r4 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.springframework.beans.factory.support.BeanDefinitionRegistry registry>;	$r34 = (org.springframework.beans.factory.config.BeanDefinition) r3;	interfaceinvoke $r4.<org.springframework.beans.factory.support.BeanDefinitionRegistry: void registerBeanDefinition(java.lang.String,org.springframework.beans.factory.config.BeanDefinition)>(r1, $r34);	$r5 = r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ServiceAnnotationPostProcessor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$z1 = interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: boolean isInfoEnabled()>();	if $z1 == 0 goto return;	return
;block_num 3