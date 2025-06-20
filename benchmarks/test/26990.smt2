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

(declare-sort var2684 0)
(declare-sort var1755 0)
(declare-sort var1094 0)
(declare-sort var2359 0)
(declare-sort var3773 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1094_getSystemProperty/1393069448 (String) String)
(declare-fun var2359_isNotEmpty/-1251449450 (String) Bool)
(declare-fun createDefaultSerializerFactory/705275923 (var2684 var1755) var3773)
(declare-const null-var2684 var2684)
(declare-const null-var1755 var1755)
(declare-const var1639 var2684) ; Statement: r1 := @this: org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager 
(assert (not (= var1639 null-var2684)))
(declare-const var3840 var1755) ; Statement: r2 := @parameter0: java.lang.ClassLoader 
(assert (not (= var3840 null-var1755)))
(define-const var2813 String (var1094_getSystemProperty/1393069448 "dubbo.application.hessian2.whitelist")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.whitelist") 
(define-const var3466 Bool (var2359_isNotEmpty/-1251449450 var2813)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = specialinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createDefaultSerializerFactory(java.lang.ClassLoader)>(r2) 
(assert (= (ite var3466 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3532 var3773 (createDefaultSerializerFactory/705275923 var1639 var3840)) ; Statement: $r3 = specialinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createDefaultSerializerFactory(java.lang.ClassLoader)>(r2) 
 ; Statement: return $r3 
(check-sat)
; {var1094_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var2359_isNotEmpty/-1251449450=([java.lang.String], boolean), createDefaultSerializerFactory/705275923=([org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager, java.lang.ClassLoader], com.alibaba.com.caucho.hessian.io.SerializerFactory)}
; {var2684=org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager, var1639=r1, var1755=java.lang.ClassLoader, var3840=r2, var1094=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var2813=r0, var2359=org.apache.dubbo.common.utils.StringUtils, var3466=$z0, var3773=com.alibaba.com.caucho.hessian.io.SerializerFactory, var3532=$r3}
; {org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager=var2684, r1=var1639, java.lang.ClassLoader=var1755, r2=var3840, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var1094, r0=var2813, org.apache.dubbo.common.utils.StringUtils=var2359, $z0=var3466, com.alibaba.com.caucho.hessian.io.SerializerFactory=var3773, $r3=var3532}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager;	r2 := @parameter0: java.lang.ClassLoader;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.whitelist");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = specialinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createDefaultSerializerFactory(java.lang.ClassLoader)>(r2);	$r3 = specialinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createDefaultSerializerFactory(java.lang.ClassLoader)>(r2);	return $r3
;block_num 2