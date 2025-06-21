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

(declare-sort var3673 0)
(declare-sort var1860 0)
(declare-sort var109 0)
(declare-sort var2143 0)
(declare-sort var2697 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var109_getSystemProperty/1393069448 (String) String)
(declare-fun var2143_isNotEmpty/-1251449450 (String) Bool)
(declare-fun createWhiteListSerializerFactory/-1316338003 (var3673 var1860) var2697)
(declare-const null-var3673 var3673)
(declare-const null-var1860 var1860)
(declare-const var443 var3673) ; Statement: r1 := @this: org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager 
(assert (not (= var443 null-var3673)))
(declare-const var3002 var1860) ; Statement: r2 := @parameter0: java.lang.ClassLoader 
(assert (not (= var3002 null-var1860)))
(define-const var1506 String (var109_getSystemProperty/1393069448 "dubbo.application.hessian2.whitelist")) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.whitelist") 
(define-const var3602 Bool (var2143_isNotEmpty/-1251449450 var1506)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = specialinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createDefaultSerializerFactory(java.lang.ClassLoader)>(r2) 
(assert (not (= (ite var3602 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var471 var2697 (createWhiteListSerializerFactory/-1316338003 var443 var3002)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createWhiteListSerializerFactory(java.lang.ClassLoader)>(r2) 
 ; Statement: return $r4 
(check-sat)
; {var109_getSystemProperty/1393069448=([java.lang.String], java.lang.String), var2143_isNotEmpty/-1251449450=([java.lang.String], boolean), createWhiteListSerializerFactory/-1316338003=([org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager, java.lang.ClassLoader], com.alibaba.com.caucho.hessian.io.SerializerFactory)}
; {var3673=org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager, var443=r1, var1860=java.lang.ClassLoader, var3002=r2, var109=org.apache.dubbo.common.utils.SystemPropertyConfigUtils, var1506=r0, var2143=org.apache.dubbo.common.utils.StringUtils, var3602=$z0, var2697=com.alibaba.com.caucho.hessian.io.SerializerFactory, var471=$r4}
; {org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager=var3673, r1=var443, java.lang.ClassLoader=var1860, r2=var3002, org.apache.dubbo.common.utils.SystemPropertyConfigUtils=var109, r0=var1506, org.apache.dubbo.common.utils.StringUtils=var2143, $z0=var3602, com.alibaba.com.caucho.hessian.io.SerializerFactory=var2697, $r4=var471}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager;	r2 := @parameter0: java.lang.ClassLoader;	r0 = staticinvoke <org.apache.dubbo.common.utils.SystemPropertyConfigUtils: java.lang.String getSystemProperty(java.lang.String)>("dubbo.application.hessian2.whitelist");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = specialinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createDefaultSerializerFactory(java.lang.ClassLoader)>(r2);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.serialize.hessian2.Hessian2FactoryManager: com.alibaba.com.caucho.hessian.io.SerializerFactory createWhiteListSerializerFactory(java.lang.ClassLoader)>(r2);	return $r4
;block_num 2