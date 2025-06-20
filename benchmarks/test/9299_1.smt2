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

(declare-sort var774 0)
(declare-sort var2742 0)
(declare-sort var3400 0)
(declare-sort var1886 0)
(declare-sort var2341 0)
(declare-sort var2512 0)
(declare-sort var108 0)
(declare-sort var2837 0)
(declare-sort var2085 0)
(declare-sort var2334 0)
(declare-sort var1307 0)
(declare-sort var981 0)
(declare-sort var3360 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2341_resolveAttribute/1636794963 (var774 String var2742) String)
(declare-fun var2512_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun setAttribute/-1339057839 (var3400 String var2837) void)
(declare-fun cast-from-String-to-var2837 (String) var2837)
(declare-fun var2085_determineInterfaceClass/1880354061 (String String) ClassObject)
(declare-fun cast-from-ClassObject-to-var2837 (ClassObject) var2837)
(declare-fun var2334-init () var2334)
(declare-fun <init>/1679066158 (var2334) void)
(declare-fun setBeanClass/63732 (var2334 ClassObject) void)
(declare-fun getAttribute/-1749250965 (var3400 String) var2837)
(declare-fun cast-from-var2837-to-String (var2837) String)
(declare-fun var1307-init () var1307)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-var2334-to-var1886 (var2334) var1886)
(declare-fun <init>/-1014300730 (var1307 var1886 String) void)
(declare-fun setDecoratedDefinition/1438804714 (var3400 var1307) void)
(declare-fun getPropertyValues/571780577 (var3400) var981)
(declare-fun getPropertyValueList/-1297969268 (var981) var3360)
(declare-fun var3360_iterator/-912451715 (var3360) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var774 var774)
(declare-const null-var2742 var2742)
(declare-const null-var3400 var3400)
(declare-const null-var1886 var1886)
(declare-const null-String String)
(declare-const var740 var774) ; Statement: r0 := @parameter0: org.w3c.dom.Element 
(assert (not (= var740 null-var774)))
(declare-const var2473 var2742) ; Statement: r1 := @parameter1: org.springframework.beans.factory.xml.ParserContext 
(assert (not (= var2473 null-var2742)))
(declare-const var2762 var3400) ; Statement: r3 := @parameter2: org.springframework.beans.factory.support.RootBeanDefinition 
(assert (not (= var2762 null-var3400)))
(declare-const var2465 var1886) ; Statement: r19 := @parameter3: org.springframework.beans.factory.config.BeanDefinition 
(assert (not (= var2465 null-var1886)))
(define-const var1109 String (var2341_resolveAttribute/1636794963 var740 "interface" var2473)) ; Statement: r2 = staticinvoke <org.apache.dubbo.config.spring.schema.DubboBeanDefinitionParser: java.lang.String resolveAttribute(org.w3c.dom.Element,java.lang.String,org.springframework.beans.factory.xml.ParserContext)>(r0, "interface", r1) 
(define-const var930 String (var2341_resolveAttribute/1636794963 var740 "generic" var2473)) ; Statement: r22 = staticinvoke <org.apache.dubbo.config.spring.schema.DubboBeanDefinitionParser: java.lang.String resolveAttribute(org.w3c.dom.Element,java.lang.String,org.springframework.beans.factory.xml.ParserContext)>(r0, "generic", r1) 
(define-const var364 Bool (var2512_isBlank/-523695098 (cast-from-String-to-String var930))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r22) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var364 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if r22 == null goto virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("interfaceName", r2) 
(assert (= var930 null-String)) ; Cond: r22 == null 
(assert true)
;(assert (setAttribute/-1339057839 var2762 "interfaceName" (cast-from-String-to-var2837 var1109))) ; Statement: virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("interfaceName", r2) 

(declare-const var2762!1 var3400)
(declare-const var3440 String)
(declare-const var1109!1 String)
(define-const var1002 ClassObject (var2085_determineInterfaceClass/1880354061 var930 var1109!1)) ; Statement: $r15 = staticinvoke <org.apache.dubbo.config.ReferenceConfig: java.lang.Class determineInterfaceClass(java.lang.String,java.lang.String)>(r22, r2) 
(assert true)
;(assert (setAttribute/-1339057839 var2762!1 "interfaceClass" (cast-from-ClassObject-to-var2837 var1002))) ; Statement: virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("interfaceClass", $r15) 

(declare-const var2762!2 var3400)
(declare-const var2187 String)
(declare-const var1002!1 ClassObject)
(define-const var3280 var2334 var2334-init) ; Statement: $r23 = new org.springframework.beans.factory.support.GenericBeanDefinition 
(assert true)
;(assert (<init>/1679066158 var3280)) ; Statement: specialinvoke $r23.<org.springframework.beans.factory.support.GenericBeanDefinition: void <init>()>() 

(declare-const var3280!1 var2334)
(assert true)
;(assert (setBeanClass/63732 var3280!1 var1002!1)) ; Statement: virtualinvoke $r23.<org.springframework.beans.factory.support.GenericBeanDefinition: void setBeanClass(java.lang.Class)>($r15) 

(declare-const var3280!2 var2334)
(declare-const var1002!2 ClassObject)
(assert true)
(define-const var475 var2837 (getAttribute/-1749250965 var2762!2 "BEAN_NAME")) ; Statement: $r5 = virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: java.lang.Object getAttribute(java.lang.String)>("BEAN_NAME") 
(define-const var2944 String (cast-from-var2837-to-String var475)) ; Statement: $r16 = (java.lang.String) $r5 
(define-const var360 var1307 var1307-init) ; Statement: $r25 = new org.springframework.beans.factory.config.BeanDefinitionHolder 
(define-const var1625 String String-init) ; Statement: $r24 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1625)) ; Statement: specialinvoke $r24.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1625!1 String)
(assert (= var1625!1 ""))
(assert true)
(define-const var3900 String (append/672562846 var1625!1 var2944)) ; Statement: $r8 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var1625!2 String)
(assert (= var1625!2 (str.++ var1625!1 var2944)))
(assert true)
(define-const var3812 String (append/672562846 var3900 "_decorated")) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_decorated") 
(declare-const var3900!1 String)
(assert (= var3900!1 (str.++ var3900 "_decorated")))
(assert true)
(define-const var2398 String (toString/-2075883882 var3812)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var542 var1886 (cast-from-var2334-to-var1886 var3280!2)) ; Statement: $r27 = (org.springframework.beans.factory.config.BeanDefinition) $r23 
(assert true)
;(assert (<init>/-1014300730 var360 var542 var2398)) ; Statement: specialinvoke $r25.<org.springframework.beans.factory.config.BeanDefinitionHolder: void <init>(org.springframework.beans.factory.config.BeanDefinition,java.lang.String)>($r27, $r10) 

(declare-const var360!1 var1307)
(declare-const var542!1 var1886)
(declare-const var2398!1 String)
(assert true)
;(assert (setDecoratedDefinition/1438804714 var2762!2 var360!1)) ; Statement: virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setDecoratedDefinition(org.springframework.beans.factory.config.BeanDefinitionHolder)>($r25) 

(declare-const var2762!3 var3400)
(declare-const var360!2 var1307)
(assert true)
;(assert (setAttribute/-1339057839 var2762!3 "factoryBeanObjectType" (cast-from-ClassObject-to-var2837 var1002!2))) ; Statement: virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("factoryBeanObjectType", $r15) 

(declare-const var2762!4 var3400)
(declare-const var2697 String)
(declare-const var1002!3 ClassObject)
(assert true)
(define-const var916 var981 (getPropertyValues/571780577 var2762!4)) ; Statement: $r11 = virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: org.springframework.beans.MutablePropertyValues getPropertyValues()>() 
(assert true)
(define-const var2221 var3360 (getPropertyValueList/-1297969268 var916)) ; Statement: $r17 = virtualinvoke $r11.<org.springframework.beans.MutablePropertyValues: java.util.List getPropertyValueList()>() 
(define-const var781 Iterator (var3360_iterator/-912451715 var2221)) ; Statement: $r18 = interfaceinvoke $r17.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2597 Bool (Iterator_hasNext/-1669924200 var781)) ; Statement: $z1 = interfaceinvoke $r18.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var2597 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {var2341_resolveAttribute/1636794963=([org.w3c.dom.Element, java.lang.String, org.springframework.beans.factory.xml.ParserContext], java.lang.String), var2512_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), setAttribute/-1339057839=([org.springframework.beans.factory.support.RootBeanDefinition, java.lang.String, java.lang.Object], void), cast-from-String-to-var2837=([java.lang.String], java.lang.Object), var2085_determineInterfaceClass/1880354061=([java.lang.String, java.lang.String], java.lang.Class), cast-from-ClassObject-to-var2837=([java.lang.Class], java.lang.Object), var2334-init=([], org.springframework.beans.factory.support.GenericBeanDefinition), <init>/1679066158=([org.springframework.beans.factory.support.GenericBeanDefinition], void), setBeanClass/63732=([org.springframework.beans.factory.support.GenericBeanDefinition, java.lang.Class], void), getAttribute/-1749250965=([org.springframework.beans.factory.support.RootBeanDefinition, java.lang.String], java.lang.Object), cast-from-var2837-to-String=([java.lang.Object], java.lang.String), var1307-init=([], org.springframework.beans.factory.config.BeanDefinitionHolder), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-var2334-to-var1886=([org.springframework.beans.factory.support.GenericBeanDefinition], org.springframework.beans.factory.config.BeanDefinition), <init>/-1014300730=([org.springframework.beans.factory.config.BeanDefinitionHolder, org.springframework.beans.factory.config.BeanDefinition, java.lang.String], void), setDecoratedDefinition/1438804714=([org.springframework.beans.factory.support.RootBeanDefinition, org.springframework.beans.factory.config.BeanDefinitionHolder], void), getPropertyValues/571780577=([org.springframework.beans.factory.support.RootBeanDefinition], org.springframework.beans.MutablePropertyValues), getPropertyValueList/-1297969268=([org.springframework.beans.MutablePropertyValues], java.util.List), var3360_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var774=org.w3c.dom.Element, var740=r0, var2742=org.springframework.beans.factory.xml.ParserContext, var2473=r1, var3400=org.springframework.beans.factory.support.RootBeanDefinition, var2762=r3, var1886=org.springframework.beans.factory.config.BeanDefinition, var2465=r19, var2341=org.apache.dubbo.config.spring.schema.DubboBeanDefinitionParser, var1109=r2, var930=r22, var2512=org.apache.dubbo.common.utils.StringUtils, var364=$z0, var108=null_type, var2837=java.lang.Object, var3440="interfaceName", var2085=org.apache.dubbo.config.ReferenceConfigBase, var1002=$r15, var2187="interfaceClass", var2334=org.springframework.beans.factory.support.GenericBeanDefinition, var3280=$r23, var475=$r5, var2944=$r16, var1307=org.springframework.beans.factory.config.BeanDefinitionHolder, var360=$r25, var1625=$r24, var3900=$r8, var3812=$r9, var2398=$r10, var542=$r27, var2697="factoryBeanObjectType", var981=org.springframework.beans.MutablePropertyValues, var916=$r11, var3360=java.util.List, var2221=$r17, var781=$r18, var2597=$z1}
; {org.w3c.dom.Element=var774, r0=var740, org.springframework.beans.factory.xml.ParserContext=var2742, r1=var2473, org.springframework.beans.factory.support.RootBeanDefinition=var3400, r3=var2762, org.springframework.beans.factory.config.BeanDefinition=var1886, r19=var2465, org.apache.dubbo.config.spring.schema.DubboBeanDefinitionParser=var2341, r2=var1109, r22=var930, org.apache.dubbo.common.utils.StringUtils=var2512, $z0=var364, null_type=var108, java.lang.Object=var2837, "interfaceName"=var3440, org.apache.dubbo.config.ReferenceConfigBase=var2085, $r15=var1002, "interfaceClass"=var2187, org.springframework.beans.factory.support.GenericBeanDefinition=var2334, $r23=var3280, $r5=var475, $r16=var2944, org.springframework.beans.factory.config.BeanDefinitionHolder=var1307, $r25=var360, $r24=var1625, $r8=var3900, $r9=var3812, $r10=var2398, $r27=var542, "factoryBeanObjectType"=var2697, org.springframework.beans.MutablePropertyValues=var981, $r11=var916, java.util.List=var3360, $r17=var2221, $r18=var781, $z1=var2597}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.w3c.dom.Element;	r1 := @parameter1: org.springframework.beans.factory.xml.ParserContext;	r3 := @parameter2: org.springframework.beans.factory.support.RootBeanDefinition;	r19 := @parameter3: org.springframework.beans.factory.config.BeanDefinition;	r2 = staticinvoke <org.apache.dubbo.config.spring.schema.DubboBeanDefinitionParser: java.lang.String resolveAttribute(org.w3c.dom.Element,java.lang.String,org.springframework.beans.factory.xml.ParserContext)>(r0, "interface", r1);	r22 = staticinvoke <org.apache.dubbo.config.spring.schema.DubboBeanDefinitionParser: java.lang.String resolveAttribute(org.w3c.dom.Element,java.lang.String,org.springframework.beans.factory.xml.ParserContext)>(r0, "generic", r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r22);	if $z0 == 0 goto (branch);	if r22 == null goto virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("interfaceName", r2);	virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("interfaceName", r2);	$r15 = staticinvoke <org.apache.dubbo.config.ReferenceConfig: java.lang.Class determineInterfaceClass(java.lang.String,java.lang.String)>(r22, r2);	virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("interfaceClass", $r15);	$r23 = new org.springframework.beans.factory.support.GenericBeanDefinition;	specialinvoke $r23.<org.springframework.beans.factory.support.GenericBeanDefinition: void <init>()>();	virtualinvoke $r23.<org.springframework.beans.factory.support.GenericBeanDefinition: void setBeanClass(java.lang.Class)>($r15);	$r5 = virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: java.lang.Object getAttribute(java.lang.String)>("BEAN_NAME");	$r16 = (java.lang.String) $r5;	$r25 = new org.springframework.beans.factory.config.BeanDefinitionHolder;	$r24 = new java.lang.StringBuilder;	specialinvoke $r24.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("_decorated");	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	$r27 = (org.springframework.beans.factory.config.BeanDefinition) $r23;	specialinvoke $r25.<org.springframework.beans.factory.config.BeanDefinitionHolder: void <init>(org.springframework.beans.factory.config.BeanDefinition,java.lang.String)>($r27, $r10);	virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setDecoratedDefinition(org.springframework.beans.factory.config.BeanDefinitionHolder)>($r25);	virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: void setAttribute(java.lang.String,java.lang.Object)>("factoryBeanObjectType", $r15);	$r11 = virtualinvoke r3.<org.springframework.beans.factory.support.RootBeanDefinition: org.springframework.beans.MutablePropertyValues getPropertyValues()>();	$r17 = virtualinvoke $r11.<org.springframework.beans.MutablePropertyValues: java.util.List getPropertyValueList()>();	$r18 = interfaceinvoke $r17.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke $r18.<java.util.Iterator: boolean hasNext()>();	if $z1 == 0 goto return;	return
;block_num 5