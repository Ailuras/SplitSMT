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

(declare-sort var1515 0)
(declare-sort var1699 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1699-init () var1699)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var1515_getClass/785077192 (var1515) ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1699 String) void)
(declare-const null-var1515 var1515)
(declare-const var3210 var1515) ; Statement: r0 := @parameter0: org.springframework.beans.factory.support.BeanDefinitionRegistry 
(assert (not (= var3210 null-var1515)))
(define-const var2454 Bool true) ; Statement: $z0 = r0 instanceof org.springframework.beans.factory.config.ConfigurableListableBeanFactory 
 ; Statement: if $z0 == 0 goto $z1 = r0 instanceof org.springframework.context.support.GenericApplicationContext 
(assert (= (ite var2454 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3066 Bool true) ; Statement: $z1 = r0 instanceof org.springframework.context.support.GenericApplicationContext 
 ; Statement: if $z1 == 0 goto $r1 = new java.lang.IllegalStateException 
(assert (= (ite var3066 1 0) 0)) ; Cond: $z1 == 0 
(define-const var268 var1699 var1699-init) ; Statement: $r1 = new java.lang.IllegalStateException 
(define-const var1305 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1305)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1305!1 String)
(assert (= var1305!1 ""))
(assert true)
(define-const var3567 String (append/672562846 var1305!1 "Can not find Spring BeanFactory from registry: ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can not find Spring BeanFactory from registry: ") 
(declare-const var1305!2 String)
(assert (= var1305!2 (str.++ var1305!1 "Can not find Spring BeanFactory from registry: ")))
(define-const var3991 ClassObject (var1515_getClass/785077192 var3210)) ; Statement: $r3 = interfaceinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionRegistry: java.lang.Class getClass()>() 
(assert true)
(define-const var1304 String (getName/-1958580599 var3991)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1186 String (append/672562846 var3567 var1304)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3567!1 String)
(assert (= var3567!1 (str.++ var3567 var1304)))
(assert true)
(define-const var719 String (toString/-2075883882 var1186)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var268 var719)) ; Statement: specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r7) 

(declare-const var268!1 var1699)
(declare-const var719!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var1699-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var1515_getClass/785077192=([org.springframework.beans.factory.support.BeanDefinitionRegistry], java.lang.Class), getName/-1958580599=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var1515=org.springframework.beans.factory.support.BeanDefinitionRegistry, var3210=r0, var2454=$z0, var3066=$z1, var1699=java.lang.IllegalStateException, var268=$r1, var1305=$r2, var3567=$r5, var3991=$r3, var1304=$r4, var1186=$r6, var719=$r7}
; {org.springframework.beans.factory.support.BeanDefinitionRegistry=var1515, r0=var3210, $z0=var2454, $z1=var3066, java.lang.IllegalStateException=var1699, $r1=var268, $r2=var1305, $r5=var3567, $r3=var3991, $r4=var1304, $r6=var1186, $r7=var719}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: org.springframework.beans.factory.support.BeanDefinitionRegistry;	$z0 = r0 instanceof org.springframework.beans.factory.config.ConfigurableListableBeanFactory;	if $z0 == 0 goto $z1 = r0 instanceof org.springframework.context.support.GenericApplicationContext;	$z1 = r0 instanceof org.springframework.context.support.GenericApplicationContext;	if $z1 == 0 goto $r1 = new java.lang.IllegalStateException;	$r1 = new java.lang.IllegalStateException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can not find Spring BeanFactory from registry: ");	$r3 = interfaceinvoke r0.<org.springframework.beans.factory.support.BeanDefinitionRegistry: java.lang.Class getClass()>();	$r4 = virtualinvoke $r3.<java.lang.Class: java.lang.String getName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r7);	throw $r1
;block_num 3