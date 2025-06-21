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

(declare-sort var945 0)
(declare-sort var3863 0)
(declare-sort var2437 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3863 String) String)
(declare-fun toServiceStringWithoutResolving/1917959024 (var3863) String)
(declare-fun var3863_valueOf/-778994652 (String) var3863)
(declare-fun var2437_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toFullString/-798704221 (var3863) String)
(declare-const null-var945 var945)
(declare-const null-var3863 var3863)
(declare-const var1547 var945) ; Statement: r3 := @this: org.apache.dubbo.registry.nacos.NacosServiceDiscoveryFactory 
(assert (not (= var1547 null-var945)))
(declare-const var3763 var3863) ; Statement: r4 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3763 null-var3863)))
(assert true)
(define-const var1083 String (getParameter/-1307325648 var3763 "namespace")) ; Statement: r0 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace") 
(assert true)
(define-const var316 String (toServiceStringWithoutResolving/1917959024 var3763)) ; Statement: $r1 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String toServiceStringWithoutResolving()>() 
(define-const var132 var3863 (var3863_valueOf/-778994652 var316)) ; Statement: r5 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r1) 
(define-const var3657 Bool (var2437_isNotEmpty/-1251449450 var1083)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert (= (ite var3657 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1233 String (toFullString/-798704221 var132)) ; Statement: $r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
 ; Statement: return $r2 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), toServiceStringWithoutResolving/1917959024=([org.apache.dubbo.common.URL], java.lang.String), var3863_valueOf/-778994652=([java.lang.String], org.apache.dubbo.common.URL), var2437_isNotEmpty/-1251449450=([java.lang.String], boolean), toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String)}
; {var945=org.apache.dubbo.registry.nacos.NacosServiceDiscoveryFactory, var1547=r3, var3863=org.apache.dubbo.common.URL, var3763=r4, var1083=r0, var316=$r1, var132=r5, var2437=org.apache.dubbo.common.utils.StringUtils, var3657=$z0, var1233=$r2}
; {org.apache.dubbo.registry.nacos.NacosServiceDiscoveryFactory=var945, r3=var1547, org.apache.dubbo.common.URL=var3863, r4=var3763, r0=var1083, $r1=var316, r5=var132, org.apache.dubbo.common.utils.StringUtils=var2437, $z0=var3657, $r2=var1233}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.nacos.NacosServiceDiscoveryFactory;	r4 := @parameter0: org.apache.dubbo.common.URL;	r0 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("namespace");	$r1 = virtualinvoke r4.<org.apache.dubbo.common.URL: java.lang.String toServiceStringWithoutResolving()>();	r5 = staticinvoke <org.apache.dubbo.common.URL: org.apache.dubbo.common.URL valueOf(java.lang.String)>($r1);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r2 = virtualinvoke r5.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	return $r2
;block_num 2