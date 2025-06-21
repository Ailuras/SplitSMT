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

(declare-sort var1449 0)
(declare-sort var3208 0)
(declare-sort var2414 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun refresh/-1420329662 (var3208) void)
(declare-fun cast-from-var1449-to-var3208 (var1449) var3208)
(declare-fun appendEnvironmentProperties/1892471079 (var1449) void)
(declare-fun getName/922463553 (var1449) String)
(declare-fun var2414_isEmpty/-813097145 (String) Bool)
(declare-const null-var1449 var1449)
(declare-const var2710 var1449) ; Statement: r0 := @this: org.apache.dubbo.config.ApplicationConfig 
(assert (not (= var2710 null-var1449)))
(assert true)
;(assert (refresh/-1420329662 (cast-from-var1449-to-var3208 var2710))) ; Statement: specialinvoke r0.<org.apache.dubbo.config.AbstractConfig: void refresh()>() 

(declare-const var2710!1 var1449)
(assert true)
;(assert (appendEnvironmentProperties/1892471079 var2710!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ApplicationConfig: void appendEnvironmentProperties()>() 

(declare-const var2710!2 var1449)
(assert true)
(define-const var1122 String (getName/922463553 var2710!2)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>() 
(define-const var3002 Bool (var2414_isEmpty/-813097145 var1122)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3002 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {refresh/-1420329662=([org.apache.dubbo.config.AbstractConfig], void), cast-from-var1449-to-var3208=([org.apache.dubbo.config.ApplicationConfig], org.apache.dubbo.config.AbstractConfig), appendEnvironmentProperties/1892471079=([org.apache.dubbo.config.ApplicationConfig], void), getName/922463553=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), var2414_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1449=org.apache.dubbo.config.ApplicationConfig, var2710=r0, var3208=org.apache.dubbo.config.AbstractConfig, var1122=$r1, var2414=org.apache.dubbo.common.utils.StringUtils, var3002=$z0}
; {org.apache.dubbo.config.ApplicationConfig=var1449, r0=var2710, org.apache.dubbo.config.AbstractConfig=var3208, $r1=var1122, org.apache.dubbo.common.utils.StringUtils=var2414, $z0=var3002}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ApplicationConfig;	specialinvoke r0.<org.apache.dubbo.config.AbstractConfig: void refresh()>();	specialinvoke r0.<org.apache.dubbo.config.ApplicationConfig: void appendEnvironmentProperties()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto return;	return
;block_num 2