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

(declare-sort var3059 0)
(declare-sort var176 0)
(declare-sort var2079 0)
(declare-sort var3267 0)
(declare-sort var856 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3267_isEmpty/-813097145 (String) Bool)
(declare-fun getOptionalBeanByType/-511266471 (var3059 var176 ClassObject) var856)
(declare-const null-var3059 var3059)
(declare-const null-var176 var176)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var3543 var3059) ; Statement: r4 := @this: org.apache.dubbo.config.spring.extension.SpringExtensionInjector 
(assert (not (= var3543 null-var3059)))
(declare-const var1837 var176) ; Statement: r1 := @parameter0: org.springframework.beans.factory.ListableBeanFactory 
(assert (not (= var1837 null-var176)))
(declare-const var3348 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3348 null-String)))
(declare-const var2097 ClassObject) ; Statement: r2 := @parameter2: java.lang.Class 
(assert (not (= var2097 null-ClassObject)))
(define-const var518 Bool (var3267_isEmpty/-813097145 var3348)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = interfaceinvoke r1.<org.springframework.beans.factory.ListableBeanFactory: boolean containsBean(java.lang.String)>(r0) 
(assert (not (= (ite var518 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2793 var856 (getOptionalBeanByType/-511266471 var3543 var1837 var2097)) ; Statement: $r5 = specialinvoke r4.<org.apache.dubbo.config.spring.extension.SpringExtensionInjector: java.lang.Object getOptionalBeanByType(org.springframework.beans.factory.ListableBeanFactory,java.lang.Class)>(r1, r2) 
 ; Statement: return $r5 
(check-sat)
; {var3267_isEmpty/-813097145=([java.lang.String], boolean), getOptionalBeanByType/-511266471=([org.apache.dubbo.config.spring.extension.SpringExtensionInjector, org.springframework.beans.factory.ListableBeanFactory, java.lang.Class], java.lang.Object)}
; {var3059=org.apache.dubbo.config.spring.extension.SpringExtensionInjector, var3543=r4, var176=org.springframework.beans.factory.ListableBeanFactory, var1837=r1, var3348=r0, var2079=null_type, var2097=r2, var3267=org.apache.dubbo.common.utils.StringUtils, var518=$z0, var856=java.lang.Object, var2793=$r5}
; {org.apache.dubbo.config.spring.extension.SpringExtensionInjector=var3059, r4=var3543, org.springframework.beans.factory.ListableBeanFactory=var176, r1=var1837, r0=var3348, null_type=var2079, r2=var2097, org.apache.dubbo.common.utils.StringUtils=var3267, $z0=var518, java.lang.Object=var856, $r5=var2793}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.config.spring.extension.SpringExtensionInjector;	r1 := @parameter0: org.springframework.beans.factory.ListableBeanFactory;	r0 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.Class;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = interfaceinvoke r1.<org.springframework.beans.factory.ListableBeanFactory: boolean containsBean(java.lang.String)>(r0);	$r5 = specialinvoke r4.<org.apache.dubbo.config.spring.extension.SpringExtensionInjector: java.lang.Object getOptionalBeanByType(org.springframework.beans.factory.ListableBeanFactory,java.lang.Class)>(r1, r2);	return $r5
;block_num 2