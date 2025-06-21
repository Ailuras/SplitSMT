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

(declare-sort var3995 0)
(declare-sort var3550 0)
(declare-sort var2266 0)
(declare-sort var2397 0)
(declare-sort var251 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3550_get/1088891777 (var3550 var2397) var2397)
(declare-fun cast-from-String-to-var2397 (String) var2397)
(declare-fun cast-from-var2397-to-String (var2397) String)
(declare-fun var251_hasText/2115555376 (String) Bool)
(declare-const null-var3995 var3995)
(declare-const null-var3550 var3550)
(declare-const null-ClassObject ClassObject)
(declare-const null-var2266 var2266)
(declare-const var1351 var3995) ; Statement: r6 := @this: org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar 
(assert (not (= var1351 null-var3995)))
(declare-const var2781 var3550) ; Statement: r0 := @parameter0: java.util.Map 
(assert (not (= var2781 null-var3550)))
(declare-const var869 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var869 null-ClassObject)))
(declare-const var2823 var2266) ; Statement: r4 := @parameter2: org.springframework.beans.factory.support.BeanDefinitionRegistry 
(assert (not (= var2823 null-var2266)))
(define-const var2651 var2397 (var3550_get/1088891777 var2781 (cast-from-String-to-var2397 "id"))) ; Statement: $r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("id") 
(define-const var1943 String (cast-from-var2397-to-String var2651)) ; Statement: r7 = (java.lang.String) $r1 
(define-const var2302 Bool (var251_hasText/2115555376 var1943)) ; Statement: $z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r7) 
 ; Statement: if $z0 != 0 goto return r7 
(assert (not (= (ite var2302 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r7 
(check-sat)
; {var3550_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2397=([java.lang.String], java.lang.Object), cast-from-var2397-to-String=([java.lang.Object], java.lang.String), var251_hasText/2115555376=([java.lang.String], boolean)}
; {var3995=org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar, var1351=r6, var3550=java.util.Map, var2781=r0, var869=r2, var2266=org.springframework.beans.factory.support.BeanDefinitionRegistry, var2823=r4, var2397=java.lang.Object, var2651=$r1, var1943=r7, var251=org.springframework.util.StringUtils, var2302=$z0}
; {org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar=var3995, r6=var1351, java.util.Map=var3550, r0=var2781, r2=var869, org.springframework.beans.factory.support.BeanDefinitionRegistry=var2266, r4=var2823, java.lang.Object=var2397, $r1=var2651, r7=var1943, org.springframework.util.StringUtils=var251, $z0=var2302}
;seq <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>
;cnt {"<org.springframework.util.StringUtils: boolean hasText(java.lang.String)>": 1}
;stmts r6 := @this: org.apache.dubbo.config.spring.context.annotation.ConfigurationBeanBindingRegistrar;	r0 := @parameter0: java.util.Map;	r2 := @parameter1: java.lang.Class;	r4 := @parameter2: org.springframework.beans.factory.support.BeanDefinitionRegistry;	$r1 = interfaceinvoke r0.<java.util.Map: java.lang.Object get(java.lang.Object)>("id");	r7 = (java.lang.String) $r1;	$z0 = staticinvoke <org.springframework.util.StringUtils: boolean hasText(java.lang.String)>(r7);	if $z0 != 0 goto return r7;	return r7
;block_num 2