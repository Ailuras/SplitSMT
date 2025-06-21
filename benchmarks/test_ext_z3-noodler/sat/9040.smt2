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

(declare-sort var2984 0)
(declare-sort var322 0)
(declare-sort var1468 0)
(declare-sort var131 0)
(declare-sort var2499 0)
(declare-sort var1447 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var322_getAttribute/210607306 (var322 String) String)
(declare-fun var2499_commaDelimitedListToStringArray/872268211 (String) (Array Int String))
(declare-fun var2499_trimArrayElements/-1912070766 ((Array Int String)) (Array Int String))
(declare-fun addConstructorArgValue/647343186 (var131 var1447) var131)
(declare-fun cast-from-__Array__Int__String__-to-var1447 ((Array Int String)) var1447)
(declare-fun setRole/554251850 (var131 Int) var131)
(declare-const null-var2984 var2984)
(declare-const null-var322 var322)
(declare-const null-var1468 var1468)
(declare-const null-var131 var131)
(declare-const var292 var2984) ; Statement: r5 := @this: org.apache.dubbo.config.spring.schema.AnnotationBeanDefinitionParser 
(assert (not (= var292 null-var2984)))
(declare-const var3867 var322) ; Statement: r0 := @parameter0: org.w3c.dom.Element 
(assert (not (= var3867 null-var322)))
(declare-const var2634 var1468) ; Statement: r6 := @parameter1: org.springframework.beans.factory.xml.ParserContext 
(assert (not (= var2634 null-var1468)))
(declare-const var2903 var131) ; Statement: r4 := @parameter2: org.springframework.beans.factory.support.BeanDefinitionBuilder 
(assert (not (= var2903 null-var131)))
(define-const var679 String (var322_getAttribute/210607306 var3867 "package")) ; Statement: r1 = interfaceinvoke r0.<org.w3c.dom.Element: java.lang.String getAttribute(java.lang.String)>("package") 
(define-const var3648 (Array Int String) (var2499_commaDelimitedListToStringArray/872268211 var679)) ; Statement: $r2 = staticinvoke <org.springframework.util.StringUtils: java.lang.String[] commaDelimitedListToStringArray(java.lang.String)>(r1) 
(define-const var276 (Array Int String) (var2499_trimArrayElements/-1912070766 var3648)) ; Statement: r3 = staticinvoke <org.springframework.util.StringUtils: java.lang.String[] trimArrayElements(java.lang.String[])>($r2) 
(assert true)
;(assert (addConstructorArgValue/647343186 var2903 (cast-from-__Array__Int__String__-to-var1447 var276))) ; Statement: virtualinvoke r4.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder addConstructorArgValue(java.lang.Object)>(r3) 

(declare-const var2903!1 var131)
(declare-const var276!1 (Array Int String))
(assert true)
;(assert (setRole/554251850 var2903!1 2)) ; Statement: virtualinvoke r4.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder setRole(int)>(2) 

(declare-const var2903!2 var131)
(declare-const var1257 Int)
 ; Statement: return 
(check-sat)
; {var322_getAttribute/210607306=([org.w3c.dom.Element, java.lang.String], java.lang.String), var2499_commaDelimitedListToStringArray/872268211=([java.lang.String], java.lang.String[]), var2499_trimArrayElements/-1912070766=([java.lang.String[]], java.lang.String[]), addConstructorArgValue/647343186=([org.springframework.beans.factory.support.BeanDefinitionBuilder, java.lang.Object], org.springframework.beans.factory.support.BeanDefinitionBuilder), cast-from-__Array__Int__String__-to-var1447=([java.lang.String[]], java.lang.Object), setRole/554251850=([org.springframework.beans.factory.support.BeanDefinitionBuilder, int], org.springframework.beans.factory.support.BeanDefinitionBuilder)}
; {var2984=org.apache.dubbo.config.spring.schema.AnnotationBeanDefinitionParser, var292=r5, var322=org.w3c.dom.Element, var3867=r0, var1468=org.springframework.beans.factory.xml.ParserContext, var2634=r6, var131=org.springframework.beans.factory.support.BeanDefinitionBuilder, var2903=r4, var679=r1, var2499=org.springframework.util.StringUtils, var3648=$r2, var276=r3, var1447=java.lang.Object, var1257=2}
; {org.apache.dubbo.config.spring.schema.AnnotationBeanDefinitionParser=var2984, r5=var292, org.w3c.dom.Element=var322, r0=var3867, org.springframework.beans.factory.xml.ParserContext=var1468, r6=var2634, org.springframework.beans.factory.support.BeanDefinitionBuilder=var131, r4=var2903, r1=var679, org.springframework.util.StringUtils=var2499, $r2=var3648, r3=var276, java.lang.Object=var1447, 2=var1257}
;seq <org.springframework.util.StringUtils: java.lang.String[] commaDelimitedListToStringArray(java.lang.String)>;	<org.springframework.util.StringUtils: java.lang.String[] trimArrayElements(java.lang.String[])>
;cnt {"<org.springframework.util.StringUtils: java.lang.String[] commaDelimitedListToStringArray(java.lang.String)>": 1,"<org.springframework.util.StringUtils: java.lang.String[] trimArrayElements(java.lang.String[])>": 1}
;stmts r5 := @this: org.apache.dubbo.config.spring.schema.AnnotationBeanDefinitionParser;	r0 := @parameter0: org.w3c.dom.Element;	r6 := @parameter1: org.springframework.beans.factory.xml.ParserContext;	r4 := @parameter2: org.springframework.beans.factory.support.BeanDefinitionBuilder;	r1 = interfaceinvoke r0.<org.w3c.dom.Element: java.lang.String getAttribute(java.lang.String)>("package");	$r2 = staticinvoke <org.springframework.util.StringUtils: java.lang.String[] commaDelimitedListToStringArray(java.lang.String)>(r1);	r3 = staticinvoke <org.springframework.util.StringUtils: java.lang.String[] trimArrayElements(java.lang.String[])>($r2);	virtualinvoke r4.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder addConstructorArgValue(java.lang.Object)>(r3);	virtualinvoke r4.<org.springframework.beans.factory.support.BeanDefinitionBuilder: org.springframework.beans.factory.support.BeanDefinitionBuilder setRole(int)>(2);	return
;block_num 1