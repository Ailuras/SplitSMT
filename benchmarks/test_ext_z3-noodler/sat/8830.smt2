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

(declare-sort var417 0)
(declare-sort var2264 0)
(declare-sort var3459 0)
(declare-sort var3991 0)
(declare-sort var1921 0)
(declare-sort var1855 0)
(declare-sort var1660 0)
(declare-sort var3873 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3991_hasLength/1919161111 (String) Bool)
(declare-fun injectionMetadataCache/-1376096324 (var417) var1921)
(declare-fun var1660_get/1088891777 (var1660 var1855) var1855)
(declare-fun cast-from-var1921-to-var1660 (var1921) var1660)
(declare-fun cast-from-String-to-var1855 (String) var1855)
(declare-fun cast-from-var1855-to-var3873 (var1855) var3873)
(declare-fun needsRefreshInjectionMetadata/1891088353 (var417 var3873 ClassObject) Bool)
(declare-const null-var417 var417)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var3459 var3459)
(declare-const var2493 var417) ; Statement: r3 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor 
(assert (not (= var2493 null-var417)))
(declare-const var1809 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1809 null-String)))
(declare-const var528 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var528 null-ClassObject)))
(declare-const var550 var3459) ; Statement: r10 := @parameter2: org.springframework.beans.PropertyValues 
(assert (not (= var550 null-var3459)))
(define-const var1744 Bool (var3991_hasLength/1919161111 var1809)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r22 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert (not (= (ite var1744 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2900 String var1809) ; Statement: $r22 = r0 
 ; Statement: goto [?= r2 = $r22] 
(assert true) ; Non Conditional
(define-const var430 String var2900) ; Statement: r2 = $r22 
(define-const var2714 var1921 (injectionMetadataCache/-1376096324 var2493)) ; Statement: $r4 = r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: java.util.concurrent.ConcurrentMap injectionMetadataCache> 
(define-const var2755 var1855 (var1660_get/1088891777 (cast-from-var1921-to-var1660 var2714) (cast-from-String-to-var1855 var2900))) ; Statement: $r5 = interfaceinvoke $r4.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r22) 
(define-const var647 var3873 (cast-from-var1855-to-var3873 var2755)) ; Statement: $r12 = (org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata) $r5 
(define-const var1886 var3873 var647) ; Statement: r23 = $r12 
(assert true)
(define-const var1771 Bool (needsRefreshInjectionMetadata/1891088353 var2493 var647 var528)) ; Statement: $z1 = specialinvoke r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: boolean needsRefreshInjectionMetadata(org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata,java.lang.Class)>($r12, r1) 
 ; Statement: if $z1 == 0 goto return r23 
(assert (= (ite var1771 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r23 
(check-sat)
; {var3991_hasLength/1919161111=([java.lang.String], boolean), injectionMetadataCache/-1376096324=([org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor], java.util.concurrent.ConcurrentMap), var1660_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1921-to-var1660=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1855=([java.lang.String], java.lang.Object), cast-from-var1855-to-var3873=([java.lang.Object], org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata), needsRefreshInjectionMetadata/1891088353=([org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor, org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata, java.lang.Class], boolean)}
; {var417=org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor, var2493=r3, var1809=r0, var2264=null_type, var528=r1, var3459=org.springframework.beans.PropertyValues, var550=r10, var3991=org.springframework.util.StringUtils, var1744=$z0, var2900=$r22, var430=r2, var1921=java.util.concurrent.ConcurrentMap, var2714=$r4, var1855=java.lang.Object, var1660=java.util.Map, var2755=$r5, var3873=org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata, var647=$r12, var1886=r23, var1771=$z1}
; {org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor=var417, r3=var2493, r0=var1809, null_type=var2264, r1=var528, org.springframework.beans.PropertyValues=var3459, r10=var550, org.springframework.util.StringUtils=var3991, $z0=var1744, $r22=var2900, r2=var430, java.util.concurrent.ConcurrentMap=var1921, $r4=var2714, java.lang.Object=var1855, java.util.Map=var1660, $r5=var2755, org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata=var3873, $r12=var647, r23=var1886, $z1=var1771}
;seq <org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Class;	r10 := @parameter2: org.springframework.beans.PropertyValues;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>(r0);	if $z0 == 0 goto $r22 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r22 = r0;	goto [?= r2 = $r22];	r2 = $r22;	$r4 = r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: java.util.concurrent.ConcurrentMap injectionMetadataCache>;	$r5 = interfaceinvoke $r4.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r22);	$r12 = (org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata) $r5;	r23 = $r12;	$z1 = specialinvoke r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: boolean needsRefreshInjectionMetadata(org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata,java.lang.Class)>($r12, r1);	if $z1 == 0 goto return r23;	return r23
;block_num 4