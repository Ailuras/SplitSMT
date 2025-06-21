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

(declare-sort var844 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var844!class ClassObject)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun Int_getInteger/-175998605 (String Int) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-const var844-BEAN_NAME String)
(define-const var920 ClassObject var844!class) ; Statement: $r0 = class "Lorg/apache/dubbo/config/spring/beans/factory/annotation/ReferenceAnnotationBeanPostProcessor;" 
(assert true)
(define-const var779 String (getName/-1958580599 var920)) ; Statement: $r1 = virtualinvoke $r0.<java.lang.Class: java.lang.String getName()>() 
(define-const var2357 String var779) ; Statement: <org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.String BEAN_NAME> = $r1 
(define-const var3432 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3432)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3432!1 String)
(assert (= var3432!1 ""))
(define-const var2250 String var844-BEAN_NAME) ; Statement: $r3 = <org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.String BEAN_NAME> 
(assert true)
(define-const var3628 String (append/672562846 var3432!1 var2250)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3432!2 String)
(assert (= var3432!2 (str.++ var3432!1 var2250)))
(assert true)
(define-const var3239 String (append/672562846 var3628 ".cache.size")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".cache.size") 
(declare-const var3628!1 String)
(assert (= var3628!1 (str.++ var3628 ".cache.size")))
(assert true)
(define-const var641 String (toString/-2075883882 var3239)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2801 Int (Int_getInteger/-175998605 var641 32)) ; Statement: $r7 = staticinvoke <java.lang.Integer: java.lang.Integer getInteger(java.lang.String,int)>($r6, 32) 
(assert true)
(define-const var1485 Int (intValue/-1815674922 var2801)) ; Statement: $i0 = virtualinvoke $r7.<java.lang.Integer: int intValue()>() 
(define-const var1822 Int var1485) ; Statement: <org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: int CACHE_SIZE> = $i0 
 ; Statement: return 
(check-sat)
; {getName/-1958580599=([java.lang.Class], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), Int_getInteger/-175998605=([java.lang.String, int], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int)}
; {var844=org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor, var920=$r0, var779=$r1, var2357=<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.String BEAN_NAME>, var3432=$r2, var2250=$r3, var3628=$r4, var3239=$r5, var641=$r6, var2801=$r7, var1485=$i0, var1822=<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: int CACHE_SIZE>}
; {org.apache.dubbo.config.spring.beans.factory.annotation.ReferenceAnnotationBeanPostProcessor=var844, $r0=var920, $r1=var779, <org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.String BEAN_NAME>=var2357, $r2=var3432, $r3=var2250, $r4=var3628, $r5=var3239, $r6=var641, $r7=var2801, $i0=var1485, <org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: int CACHE_SIZE>=var1822}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts $r0 = class "Lorg/apache/dubbo/config/spring/beans/factory/annotation/ReferenceAnnotationBeanPostProcessor;";	$r1 = virtualinvoke $r0.<java.lang.Class: java.lang.String getName()>();	<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.String BEAN_NAME> = $r1;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = <org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: java.lang.String BEAN_NAME>;	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".cache.size");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = staticinvoke <java.lang.Integer: java.lang.Integer getInteger(java.lang.String,int)>($r6, 32);	$i0 = virtualinvoke $r7.<java.lang.Integer: int intValue()>();	<org.apache.dubbo.config.spring.beans.factory.'annotation'.ReferenceAnnotationBeanPostProcessor: int CACHE_SIZE> = $i0;	return
;block_num 1