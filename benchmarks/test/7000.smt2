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

(declare-sort var3178 0)
(declare-sort var3959 0)
(declare-sort var359 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun group/1833650063 (var3959) String)
(declare-fun cast-from-var3178-to-var3959 (var3178) var3959)
(declare-fun var359_isEmpty/-813097145 (String) Bool)
(declare-const null-var3178 var3178)
(declare-const var1247 var3178) ; Statement: r0 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var1247 null-var3178)))
(define-const var3593 String (group/1833650063 (cast-from-var3178-to-var3959 var1247))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String group> 
(define-const var2443 Bool (var359_isEmpty/-813097145 var3593)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String group> 
(assert (= (ite var2443 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2800 String (group/1833650063 (cast-from-var3178-to-var3959 var1247))) ; Statement: $r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String group> 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {group/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.String), cast-from-var3178-to-var3959=([org.apache.dubbo.config.ServiceConfigBase], org.apache.dubbo.config.AbstractServiceConfig), var359_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3178=org.apache.dubbo.config.ServiceConfigBase, var1247=r0, var3959=org.apache.dubbo.config.AbstractServiceConfig, var3593=$r1, var359=org.apache.dubbo.common.utils.StringUtils, var2443=$z0, var2800=$r4}
; {org.apache.dubbo.config.ServiceConfigBase=var3178, r0=var1247, org.apache.dubbo.config.AbstractServiceConfig=var3959, $r1=var3593, org.apache.dubbo.common.utils.StringUtils=var359, $z0=var2443, $r4=var2800}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ServiceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String group>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String group>;	$r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String group>;	return $r4
;block_num 3