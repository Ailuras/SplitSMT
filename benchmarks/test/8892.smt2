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

(declare-sort var483 0)
(declare-sort var2249 0)
(declare-sort var3801 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3801!class ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var2249_getBeanClassName/712102600 (var2249) String)
(declare-const null-var483 var483)
(declare-const null-var2249 var2249)
(declare-const var3027 var483) ; Statement: r4 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor 
(assert (not (= var3027 null-var483)))
(declare-const var3225 var2249) ; Statement: r1 := @parameter0: org.springframework.beans.factory.config.BeanDefinition 
(assert (not (= var3225 null-var2249)))
(define-const var2123 ClassObject var3801!class) ; Statement: $r0 = class "Lorg/apache/dubbo/config/spring/ReferenceBean;" 
(assert true)
(define-const var928 String (getName/-1958580599 var2123)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.Class: java.lang.String getName()>() 
(define-const var76 String (var2249_getBeanClassName/712102600 var3225)) ; Statement: $r2 = interfaceinvoke r1.<org.springframework.beans.factory.config.BeanDefinition: java.lang.String getBeanClassName()>() 
(assert true)
(define-const var3256 Bool (= var928 var76)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getName/-1958580599=([java.lang.Class], java.lang.String), var2249_getBeanClassName/712102600=([org.springframework.beans.factory.config.BeanDefinition], java.lang.String)}
; {var483=org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor, var3027=r4, var2249=org.springframework.beans.factory.config.BeanDefinition, var3225=r1, var3801=org.apache.dubbo.config.spring.ReferenceBean, var2123=$r0, var928=$r3, var76=$r2, var3256=$z0}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor=var483, r4=var3027, org.springframework.beans.factory.config.BeanDefinition=var2249, r1=var3225, org.apache.dubbo.config.spring.ReferenceBean=var3801, $r0=var2123, $r3=var928, $r2=var76, $z0=var3256}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r4 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor;	r1 := @parameter0: org.springframework.beans.factory.config.BeanDefinition;	$r0 = class "Lorg/apache/dubbo/config/spring/ReferenceBean;";	$r3 = virtualinvoke $r0.<java.lang.Class: java.lang.String getName()>();	$r2 = interfaceinvoke r1.<org.springframework.beans.factory.config.BeanDefinition: java.lang.String getBeanClassName()>();	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1