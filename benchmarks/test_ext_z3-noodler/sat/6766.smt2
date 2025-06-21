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

(declare-sort var760 0)
(declare-sort var3116 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/-1013415841 (var760) String)
(declare-fun var3116_isEmpty/-813097145 (String) Bool)
(declare-const null-var760 var760)
(declare-const var1435 var760) ; Statement: r0 := @this: org.apache.dubbo.config.ConfigCenterConfig 
(assert (not (= var1435 null-var760)))
(define-const var2527 String (address/-1013415841 var1435)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address> 
(define-const var2562 Bool (var3116_isEmpty/-813097145 var2527)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address> 
(assert (not (= (ite var2562 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {address/-1013415841=([org.apache.dubbo.config.ConfigCenterConfig], java.lang.String), var3116_isEmpty/-813097145=([java.lang.String], boolean)}
; {var760=org.apache.dubbo.config.ConfigCenterConfig, var1435=r0, var2527=$r1, var3116=org.apache.dubbo.common.utils.StringUtils, var2562=$z0}
; {org.apache.dubbo.config.ConfigCenterConfig=var760, r0=var1435, $r1=var2527, org.apache.dubbo.common.utils.StringUtils=var3116, $z0=var2562}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ConfigCenterConfig;	$r1 = r0.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.config.ConfigCenterConfig: java.lang.String address>;	return 0
;block_num 2