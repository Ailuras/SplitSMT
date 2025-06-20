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

(declare-sort var103 0)
(declare-sort var1900 0)
(declare-sort var2457 0)
(declare-sort var2870 0)
(declare-sort var1005 0)
(declare-sort var3530 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun protocolIds/1833650063 (var1900) String)
(declare-fun cast-from-var103-to-var1900 (var103) var1900)
(declare-fun var2457_isEmpty/-813097145 (String) Bool)
(declare-fun protocols/1833650063 (var1900) var2870)
(declare-fun var1005_isEmpty/73262611 (var3530) Bool)
(declare-fun cast-from-var2870-to-var3530 (var2870) var3530)
(declare-const null-var103 var103)
(declare-const var962 var103) ; Statement: r0 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var962 null-var103)))
(define-const var863 String (protocolIds/1833650063 (cast-from-var103-to-var1900 var962))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String protocolIds> 
(define-const var567 Bool (var2457_isEmpty/-813097145 var863)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN> 
(assert (not (= (ite var567 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3529 var2870 (protocols/1833650063 (cast-from-var103-to-var1900 var962))) ; Statement: $r19 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.util.List protocols> 
(define-const var2132 Bool (var1005_isEmpty/73262611 (cast-from-var2870-to-var3530 var3529))) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19) 
 ; Statement: if $z3 == 0 goto return 
(assert (= (ite var2132 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: return 
(check-sat)
; {protocolIds/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.String), cast-from-var103-to-var1900=([org.apache.dubbo.config.ServiceConfigBase], org.apache.dubbo.config.AbstractServiceConfig), var2457_isEmpty/-813097145=([java.lang.String], boolean), protocols/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.util.List), var1005_isEmpty/73262611=([java.util.Collection], boolean), cast-from-var2870-to-var3530=([java.util.List], java.util.Collection)}
; {var103=org.apache.dubbo.config.ServiceConfigBase, var962=r0, var1900=org.apache.dubbo.config.AbstractServiceConfig, var863=$r1, var2457=org.apache.dubbo.common.utils.StringUtils, var567=$z0, var2870=java.util.List, var3529=$r19, var1005=org.apache.dubbo.common.utils.CollectionUtils, var3530=java.util.Collection, var2132=$z3}
; {org.apache.dubbo.config.ServiceConfigBase=var103, r0=var962, org.apache.dubbo.config.AbstractServiceConfig=var1900, $r1=var863, org.apache.dubbo.common.utils.StringUtils=var2457, $z0=var567, java.util.List=var2870, $r19=var3529, org.apache.dubbo.common.utils.CollectionUtils=var1005, java.util.Collection=var3530, $z3=var2132}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ServiceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String protocolIds>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r3 = <org.apache.dubbo.common.constants.CommonConstants: java.util.regex.Pattern COMMA_SPLIT_PATTERN>;	$r19 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.util.List protocols>;	$z3 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmpty(java.util.Collection)>($r19);	if $z3 == 0 goto return;	return
;block_num 3