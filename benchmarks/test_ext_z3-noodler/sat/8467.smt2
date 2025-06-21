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

(declare-sort var3536 0)
(declare-sort var601 0)
(declare-sort var2787 0)
(declare-sort var619 0)
(declare-sort var3254 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var601_getBeanDefinitionNames/996619370 (var601) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun logger/-593625347 (var3536) var619)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3254) String)
(declare-fun cast-from-var2787-to-var3254 (var2787) var3254)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var619_warn/1431914100 (var619 String String String String) void)
(declare-const null-var3536 var3536)
(declare-const null-var601 var601)
(declare-const null-var2787 var2787)
(declare-const var1593 var3536) ; Statement: r2 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor 
(assert (not (= var1593 null-var3536)))
(declare-const var3187 var601) ; Statement: r0 := @parameter0: org.springframework.beans.factory.config.ConfigurableListableBeanFactory 
(assert (not (= var3187 null-var601)))
(define-const var603 (Array Int String) (var601_getBeanDefinitionNames/996619370 var3187)) ; Statement: r1 = interfaceinvoke r0.<org.springframework.beans.factory.config.ConfigurableListableBeanFactory: java.lang.String[] getBeanDefinitionNames()>() 
(define-const var134 Int (getLength-Arr-String-1 var603)) ; Statement: i0 = lengthof r1 
(define-const var3734 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $z0 = r0 instanceof org.springframework.beans.factory.support.AbstractBeanFactory 
(assert (>= var3734 var134)) ; Cond: i1 >= i0 
(define-const var2235 Bool true) ; Statement: $z0 = r0 instanceof org.springframework.beans.factory.support.AbstractBeanFactory 
 ; Statement: if $z0 == 0 goto $r26 = r2.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.springframework.context.ApplicationContext applicationContext> 
(assert (not (= (ite var2235 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var771 var2787) ; Statement: $r10 := @caughtexception 
(assert (not (= var771 null-var2787)))
(define-const var435 var619 (logger/-593625347 var1593)) ; Statement: $r12 = r2.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3722 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3722)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3722!1 String)
(assert (= var3722!1 ""))
(assert true)
(define-const var2016 String (append/672562846 var3722!1 "publish early application event failed, please upgrade spring version to 4.2.x or later: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("publish early application event failed, please upgrade spring version to 4.2.x or later: ") 
(declare-const var3722!2 String)
(assert (= var3722!2 (str.++ var3722!1 "publish early application event failed, please upgrade spring version to 4.2.x or later: ")))
(assert true)
(define-const var2013 String (append/-1031950772 var2016 (cast-from-var2787-to-var3254 var771))) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10) 
(declare-const var2016!1 String)
(assert (str.prefixof var2016 var2016!1))
(assert true)
(define-const var3503 String (toString/-2075883882 var2013)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var619_warn/1431914100 var435 "5-39" "" "" var3503)) ; Statement: interfaceinvoke $r12.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-39", "", "", $r15) 

(declare-const var435!1 var619)
(declare-const var246 String)
(declare-const var2476 String)
(declare-const var2476!1 String)
(declare-const var3503!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var601_getBeanDefinitionNames/996619370=([org.springframework.beans.factory.config.ConfigurableListableBeanFactory], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), logger/-593625347=([org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2787-to-var3254=([java.lang.Exception], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var619_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var3536=org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor, var1593=r2, var601=org.springframework.beans.factory.config.ConfigurableListableBeanFactory, var3187=r0, var603=r1, var134=i0, var3734=i1, var2235=$z0, var2787=java.lang.Exception, var771=$r10, var619=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var435=$r12, var3722=$r11, var2016=$r13, var3254=java.lang.Object, var2013=$r14, var3503=$r15, var246="5-39", var2476=""}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor=var3536, r2=var1593, org.springframework.beans.factory.config.ConfigurableListableBeanFactory=var601, r0=var3187, r1=var603, i0=var134, i1=var3734, $z0=var2235, java.lang.Exception=var2787, $r10=var771, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var619, $r12=var435, $r11=var3722, $r13=var2016, java.lang.Object=var3254, $r14=var2013, $r15=var3503, "5-39"=var246, ""=var2476}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor;	r0 := @parameter0: org.springframework.beans.factory.config.ConfigurableListableBeanFactory;	r1 = interfaceinvoke r0.<org.springframework.beans.factory.config.ConfigurableListableBeanFactory: java.lang.String[] getBeanDefinitionNames()>();	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $z0 = r0 instanceof org.springframework.beans.factory.support.AbstractBeanFactory;	$z0 = r0 instanceof org.springframework.beans.factory.support.AbstractBeanFactory;	if $z0 == 0 goto $r26 = r2.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.springframework.context.ApplicationContext applicationContext>;	$r10 := @caughtexception;	$r12 = r2.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("publish early application event failed, please upgrade spring version to 4.2.x or later: ");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r10);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r12.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("5-39", "", "", $r15);	return
;block_num 5