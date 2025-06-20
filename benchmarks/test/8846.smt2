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

(declare-sort var3190 0)
(declare-sort var3768 0)
(declare-sort var1943 0)
(declare-sort var1494 0)
(declare-sort var806 0)
(declare-sort var3859 0)
(declare-sort var3356 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3859-init () var3859)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getAnnotationType/-589297086 (var3356) ClassObject)
(declare-fun cast-from-var3190-to-var3356 (var3190) var3356)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1478018781 (var3859 String String var806) void)
(declare-fun cast-from-var3859-to-var806 (var3859) var806)
(declare-const null-var3190 var3190)
(declare-const null-var3768 var3768)
(declare-const null-var1943 var1943)
(declare-const null-String String)
(declare-const null-var806 var806)
(declare-const var843 var3190) ; Statement: r0 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor 
(assert (not (= var843 null-var3190)))
(declare-const var3961 var3768) ; Statement: r3 := @parameter0: org.springframework.beans.PropertyValues 
(assert (not (= var3961 null-var3768)))
(declare-const var1939 var1943) ; Statement: r2 := @parameter1: java.lang.Object 
(assert (not (= var1939 null-var1943)))
(declare-const var3619 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3619 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var329 var806) ; Statement: $r5 := @caughtexception 
(assert (not (= var329 null-var806)))
(define-const var1219 var3859 var3859-init) ; Statement: $r17 = new org.springframework.beans.factory.BeanCreationException 
(define-const var1699 String String-init) ; Statement: $r16 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1699)) ; Statement: specialinvoke $r16.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1699!1 String)
(assert (= var1699!1 ""))
(assert true)
(define-const var1691 String (append/672562846 var1699!1 "Injection of @")) ; Statement: $r10 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Injection of @") 
(declare-const var1699!2 String)
(assert (= var1699!2 (str.++ var1699!1 "Injection of @")))
(assert true)
(define-const var1427 ClassObject (getAnnotationType/-589297086 (cast-from-var3190-to-var3356 var843))) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.Class getAnnotationType()>() 
(assert true)
(define-const var2686 String (getSimpleName/-390194377 var1427)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var303 String (append/672562846 var1691 var2686)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1691!1 String)
(assert (= var1691!1 (str.++ var1691 var2686)))
(assert true)
(define-const var135 String (append/672562846 var303 " dependencies is failed")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" dependencies is failed") 
(declare-const var303!1 String)
(assert (= var303!1 (str.++ var303 " dependencies is failed")))
(assert true)
(define-const var1638 String (toString/-2075883882 var135)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1478018781 var1219 var3619 var1638 var329)) ; Statement: specialinvoke $r17.<org.springframework.beans.factory.BeanCreationException: void <init>(java.lang.String,java.lang.String,java.lang.Throwable)>(r1, $r13, $r5) 

(declare-const var1219!1 var3859)
(declare-const var3619!1 String)
(declare-const var1638!1 String)
(declare-const var329!1 var806)
(define-const var3284 var806 (cast-from-var3859-to-var806 var1219!1)) ; Statement: $r18 = (java.lang.Throwable) $r17 
 ; Statement: throw $r18 
(check-sat)
; {var3859-init=([], org.springframework.beans.factory.BeanCreationException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getAnnotationType/-589297086=([org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor], java.lang.Class), cast-from-var3190-to-var3356=([org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor], org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor), getSimpleName/-390194377=([java.lang.Class], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1478018781=([org.springframework.beans.factory.BeanCreationException, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var3859-to-var806=([org.springframework.beans.factory.BeanCreationException], java.lang.Throwable)}
; {var3190=org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor, var843=r0, var3768=org.springframework.beans.PropertyValues, var3961=r3, var1943=java.lang.Object, var1939=r2, var3619=r1, var1494=null_type, var806=java.lang.Throwable, var329=$r5, var3859=org.springframework.beans.factory.BeanCreationException, var1219=$r17, var1699=$r16, var1691=$r10, var3356=org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor, var1427=$r8, var2686=$r9, var303=$r11, var135=$r12, var1638=$r13, var3284=$r18}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor=var3190, r0=var843, org.springframework.beans.PropertyValues=var3768, r3=var3961, java.lang.Object=var1943, r2=var1939, r1=var3619, null_type=var1494, java.lang.Throwable=var806, $r5=var329, org.springframework.beans.factory.BeanCreationException=var3859, $r17=var1219, $r16=var1699, $r10=var1691, org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor=var3356, $r8=var1427, $r9=var2686, $r11=var303, $r12=var135, $r13=var1638, $r18=var3284}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor;	r3 := @parameter0: org.springframework.beans.PropertyValues;	r2 := @parameter1: java.lang.Object;	r1 := @parameter2: java.lang.String;	$r5 := @caughtexception;	$r17 = new org.springframework.beans.factory.BeanCreationException;	$r16 = new java.lang.StringBuilder;	specialinvoke $r16.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Injection of @");	$r8 = virtualinvoke r0.<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.Class getAnnotationType()>();	$r9 = virtualinvoke $r8.<java.lang.Class: java.lang.String getSimpleName()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" dependencies is failed");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r17.<org.springframework.beans.factory.BeanCreationException: void <init>(java.lang.String,java.lang.String,java.lang.Throwable)>(r1, $r13, $r5);	$r18 = (java.lang.Throwable) $r17;	throw $r18
;block_num 2