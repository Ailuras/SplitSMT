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

(declare-sort var1716 0)
(declare-sort var787 0)
(declare-sort var2494 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun version/1833650063 (var787) String)
(declare-fun cast-from-var1716-to-var787 (var1716) var787)
(declare-fun var2494_isEmpty/-813097145 (String) Bool)
(declare-const null-var1716 var1716)
(declare-const var2825 var1716) ; Statement: r0 := @this: org.apache.dubbo.config.ServiceConfigBase 
(assert (not (= var2825 null-var1716)))
(define-const var3738 String (version/1833650063 (cast-from-var1716-to-var787 var2825))) ; Statement: $r1 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String version> 
(define-const var11 Bool (var2494_isEmpty/-813097145 var3738)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String version> 
(assert (= (ite var11 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2883 String (version/1833650063 (cast-from-var1716-to-var787 var2825))) ; Statement: $r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String version> 
(assert true) ; Non Conditional
 ; Statement: return $r4 
(check-sat)
; {version/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.String), cast-from-var1716-to-var787=([org.apache.dubbo.config.ServiceConfigBase], org.apache.dubbo.config.AbstractServiceConfig), var2494_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1716=org.apache.dubbo.config.ServiceConfigBase, var2825=r0, var787=org.apache.dubbo.config.AbstractServiceConfig, var3738=$r1, var2494=org.apache.dubbo.common.utils.StringUtils, var11=$z0, var2883=$r4}
; {org.apache.dubbo.config.ServiceConfigBase=var1716, r0=var2825, org.apache.dubbo.config.AbstractServiceConfig=var787, $r1=var3738, org.apache.dubbo.common.utils.StringUtils=var2494, $z0=var11, $r4=var2883}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ServiceConfigBase;	$r1 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String version>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String version>;	$r4 = r0.<org.apache.dubbo.config.ServiceConfigBase: java.lang.String version>;	return $r4
;block_num 3