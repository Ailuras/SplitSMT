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

(declare-sort var634 0)
(declare-sort var3980 0)
(declare-sort var2805 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun group/2049477907 (var3980) String)
(declare-fun cast-from-var634-to-var3980 (var634) var3980)
(declare-fun var2805_isEmpty/-813097145 (String) Bool)
(declare-const null-var634 var634)
(declare-const var74 var634) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var74 null-var634)))
(define-const var1998 String (group/2049477907 (cast-from-var634-to-var3980 var74))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String group> 
(define-const var2029 Bool (var2805_isEmpty/-813097145 var1998)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String group> 
(assert (= (ite var2029 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1419 String (group/2049477907 (cast-from-var634-to-var3980 var74))) ; Statement: $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String group> 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {group/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var634-to-var3980=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), var2805_isEmpty/-813097145=([java.lang.String], boolean)}
; {var634=org.apache.dubbo.config.ReferenceConfigBase, var74=r0, var3980=org.apache.dubbo.config.AbstractInterfaceConfig, var1998=$r1, var2805=org.apache.dubbo.common.utils.StringUtils, var2029=$z0, var1419=$r4}
; {org.apache.dubbo.config.ReferenceConfigBase=var634, r0=var74, org.apache.dubbo.config.AbstractInterfaceConfig=var3980, $r1=var1998, org.apache.dubbo.common.utils.StringUtils=var2805, $z0=var2029, $r4=var1419}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String group>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String group>;	$r4 = r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String group>;	return $r4
;block_num 3