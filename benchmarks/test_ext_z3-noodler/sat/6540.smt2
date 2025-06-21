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

(declare-sort var3089 0)
(declare-sort var1776 0)
(declare-sort var1290 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun version/2049477907 (var1776) String)
(declare-fun cast-from-var3089-to-var1776 (var3089) var1776)
(declare-fun var1290_isEmpty/-813097145 (String) Bool)
(declare-const null-var3089 var3089)
(declare-const var3332 var3089) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var3332 null-var3089)))
(define-const var2877 String (version/2049477907 (cast-from-var3089-to-var1776 var3332))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String version> 
(define-const var3249 Bool (var1290_isEmpty/-813097145 var2877)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String version> 
(assert (= (ite var3249 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3545 String (version/2049477907 (cast-from-var3089-to-var1776 var3332))) ; Statement: $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String version> 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {version/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var3089-to-var1776=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), var1290_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3089=org.apache.dubbo.config.ReferenceConfigBase, var3332=r0, var1776=org.apache.dubbo.config.AbstractInterfaceConfig, var2877=$r1, var1290=org.apache.dubbo.common.utils.StringUtils, var3249=$z0, var3545=$r4}
; {org.apache.dubbo.config.ReferenceConfigBase=var3089, r0=var3332, org.apache.dubbo.config.AbstractInterfaceConfig=var1776, $r1=var2877, org.apache.dubbo.common.utils.StringUtils=var1290, $z0=var3249, $r4=var3545}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String version>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String version>;	$r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String version>;	return $r4
;block_num 3