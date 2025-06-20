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

(declare-sort var457 0)
(declare-sort var1403 0)
(declare-sort var3864 0)
(declare-sort var604 0)
(declare-sort var347 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun computeValidRegistryIds/-1727795882 (var457) void)
(declare-fun registryIds/2049477907 (var457) String)
(declare-fun var1403_isEmpty/-813097145 (String) Bool)
(declare-fun registries/2049477907 (var457) var3864)
(declare-fun var604_isEmpty/73262611 (var347) Bool)
(declare-fun cast-from-var3864-to-var347 (var3864) var347)
(declare-const null-var457 var457)
(declare-const var2760 var457) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var2760 null-var457)))
(assert true)
;(assert (computeValidRegistryIds/-1727795882 var2760)) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void computeValidRegistryIds()>() 

(declare-const var2760!1 var457)
(define-const var3273 String (registryIds/2049477907 var2760!1)) ; Statement: $r1 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String registryIds> 
(define-const var2765 Bool (var1403_isEmpty/-813097145 var3273)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var2765 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var605 var3864 (registries/2049477907 var2760!1)) ; Statement: $r7 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.util.List registries> 
(define-const var383 Bool (var604_isEmpty/73262611 (cast-from-var3864-to-var347 var605))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r7) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var383 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {computeValidRegistryIds/-1727795882=([org.apache.dubbo.config.AbstractInterfaceConfig], void), registryIds/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var1403_isEmpty/-813097145=([java.lang.String], boolean), registries/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.util.List), var604_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var3864-to-var347=([java.util.List], java.util.Collection)}
; {var457=org.apache.dubbo.config.AbstractInterfaceConfig, var2760=r0, var3273=$r1, var1403=org.apache.dubbo.common.utils.StringUtils, var2765=$z0, var3864=java.util.List, var605=$r7, var604=org.apache.dubbo.common.utils.CollectionUtils, var347=java.util.Collection, var383=$z1}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var457, r0=var2760, $r1=var3273, org.apache.dubbo.common.utils.StringUtils=var1403, $z0=var2765, java.util.List=var3864, $r7=var605, org.apache.dubbo.common.utils.CollectionUtils=var604, java.util.Collection=var347, $z1=var383}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void computeValidRegistryIds()>();	$r1 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String registryIds>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r7 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.util.List registries>;	$z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r7);	if $z1 == 0 goto return;	return
;block_num 3