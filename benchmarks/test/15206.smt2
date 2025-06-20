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

(declare-sort var1054 0)
(declare-sort var521 0)
(declare-sort var207 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var521 String) String)
(declare-fun toServiceStringWithoutResolving/1917959024 (var521) String)
(declare-fun var521_valueOf/-778994652 (String) var521)
(declare-fun var207_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toFullString/-798704221 (var521) String)
(declare-const null-var1054 var1054)
(declare-const null-var521 var521)
(declare-const var639 var1054) ; Statement: r3 := @this: org.apache.dubbo.registry.nacos.NacosRegistryFactory 
(assert (not (= var639 null-var1054)))
(declare-const var2429 var521) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2429 null-var521)))
(assert true)
(define-const var499 String (getParameter/-1307325648 var2429 "namespace")) ; Statement: r0 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace") 
(assert true)
(define-const var675 String (toServiceStringWithoutResolving/1917959024 var2429)) ; Statement: $r1 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String toServiceStringWithoutResolving()>() 
(define-const var2967 var521 (var521_valueOf/-778994652 var675)) ; Statement: r5 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r1) 
(define-const var2227 Bool (var207_isNotEmpty/-1251449450 var499)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert (= (ite var2227 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2720 String (toFullString/-798704221 var2967)) ; Statement: $r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
 ; Statement: return $r2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), toServiceStringWithoutResolving/1917959024=([org.apache.dubbo.common.URL], java.lang.String), var521_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL), var207_isNotEmpty/-1251449450=([java.lang.String], boolean), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String)}
; {var1054=org.apache.dubbo.registry.nacos.NacosRegistryFactory, var639=r3, var521=org.apache.dubbo.common.URL, var2429=r4, var499=r0, var675=$r1, var2967=r5, var207=org.apache.dubbo.common.utils.StringUtils, var2227=$z0, var2720=$r2}
; {org.apache.dubbo.registry.nacos.NacosRegistryFactory=var1054, r3=var639, org.apache.dubbo.common.URL=var521, r4=var2429, r0=var499, $r1=var675, r5=var2967, org.apache.dubbo.common.utils.StringUtils=var207, $z0=var2227, $r2=var2720}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.nacos.NacosRegistryFactory;	r4 := @parameter0: org.apache.dubbo.common.URL;	r0 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace");	$r1 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String toServiceStringWithoutResolving()>();	r5 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	return $r2
;block_num 2