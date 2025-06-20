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

(declare-sort var3786 0)
(declare-sort var2329 0)
(declare-sort var264 0)
(declare-sort var614 0)
(declare-sort var1711 0)
(declare-sort var1105 0)
(declare-sort var3744 0)
(declare-sort var3478 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var614_hasLength/1919161111 (String) Bool)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun injectionMetadataCache/-1376096324 (var3786) var1711)
(declare-fun var3744_get/1088891777 (var3744 var1105) var1105)
(declare-fun cast-from-var1711-to-var3744 (var1711) var3744)
(declare-fun cast-from-String-to-var1105 (String) var1105)
(declare-fun cast-from-var1105-to-var3478 (var1105) var3478)
(declare-fun needsRefreshInjectionMetadata/1891088353 (var3786 var3478 ClassObject) Bool)
(declare-const null-var3786 var3786)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const null-var264 var264)
(declare-const var3170 var3786) ; Statement: r3 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor 
(assert (not (= var3170 null-var3786)))
(declare-const var3771 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3771 null-String)))
(declare-const var2988 ClassObject) ; Statement: r1 := @parameter1: java.lang.Class 
(assert (not (= var2988 null-ClassObject)))
(declare-const var736 var264) ; Statement: r10 := @parameter2: org.springframework.beans.PropertyValues 
(assert (not (= var736 null-var264)))
(define-const var65 Bool (var614_hasLength/1919161111 var3771)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r22 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert (= (ite var65 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2939 String (getName/-1958580599 var2988)) ; Statement: $r22 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>() 
(assert true) ; Non Conditional
(define-const var647 String var2939) ; Statement: r2 = $r22 
(define-const var195 var1711 (injectionMetadataCache/-1376096324 var3170)) ; Statement: $r4 = r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: java.util.concurrent.ConcurrentMap injectionMetadataCache> 
(define-const var426 var1105 (var3744_get/1088891777 (cast-from-var1711-to-var3744 var195) (cast-from-String-to-var1105 var2939))) ; Statement: $r5 = interfaceinvoke $r4.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r22) 
(define-const var726 var3478 (cast-from-var1105-to-var3478 var426)) ; Statement: $r12 = (org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata) $r5 
(define-const var2838 var3478 var726) ; Statement: r23 = $r12 
(assert true)
(define-const var3861 Bool (needsRefreshInjectionMetadata/1891088353 var3170 var726 var2988)) ; Statement: $z1 = specialinvoke r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: boolean needsRefreshInjectionMetadata(org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata,java.lang.Class)>($r12, r1) 
 ; Statement: if $z1 == 0 goto return r23 
(assert (= (ite var3861 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return r23 
(check-sat)
; {var614_hasLength/1919161111=([java.lang.String], boolean), getName/-1958580599=([java.lang.Class], java.lang.String), injectionMetadataCache/-1376096324=([org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor], java.util.concurrent.ConcurrentMap), var3744_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1711-to-var3744=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1105=([java.lang.String], java.lang.Object), cast-from-var1105-to-var3478=([java.lang.Object], org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata), needsRefreshInjectionMetadata/1891088353=([org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor, org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata, java.lang.Class], boolean)}
; {var3786=org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor, var3170=r3, var3771=r0, var2329=null_type, var2988=r1, var264=org.springframework.beans.PropertyValues, var736=r10, var614=org.springframework.util.StringUtils, var65=$z0, var2939=$r22, var647=r2, var1711=java.util.concurrent.ConcurrentMap, var195=$r4, var1105=java.lang.Object, var3744=java.util.Map, var426=$r5, var3478=org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata, var726=$r12, var2838=r23, var3861=$z1}
; {org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor=var3786, r3=var3170, r0=var3771, null_type=var2329, r1=var2988, org.springframework.beans.PropertyValues=var264, r10=var736, org.springframework.util.StringUtils=var614, $z0=var65, $r22=var2939, r2=var647, java.util.concurrent.ConcurrentMap=var1711, $r4=var195, java.lang.Object=var1105, java.util.Map=var3744, $r5=var426, org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata=var3478, $r12=var726, r23=var2838, $z1=var3861}
;seq <org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.Class;	r10 := @parameter2: org.springframework.beans.PropertyValues;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasLength(java.lang.String)>(r0);	if $z0 == 0 goto $r22 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	$r22 = virtualinvoke r1.<java.lang.Class: java.lang.String getName()>();	r2 = $r22;	$r4 = r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: java.util.concurrent.ConcurrentMap injectionMetadataCache>;	$r5 = interfaceinvoke $r4.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r22);	$r12 = (org.apache.dubbo.config.spring.beans.factory.annotation.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata) $r5;	r23 = $r12;	$z1 = specialinvoke r3.<org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor: boolean needsRefreshInjectionMetadata(org.apache.dubbo.config.spring.beans.factory.'annotation'.AbstractAnnotationBeanPostProcessor$AnnotatedInjectionMetadata,java.lang.Class)>($r12, r1);	if $z1 == 0 goto return r23;	return r23
;block_num 4