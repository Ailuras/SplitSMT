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

(declare-sort var1393 0)
(declare-sort var2118 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/-392511114 (var1393) String)
(declare-fun var2118_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1393 var1393)
(declare-const var2023 var1393) ; Statement: r0 := @this: org.apache.dubbo.config.MonitorConfig 
(assert (not (= var2023 null-var1393)))
(define-const var3607 String (address/-392511114 var2023)) ; Statement: $r1 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String address> 
(define-const var3713 Bool (var2118_isNotEmpty/-1251449450 var3607)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var3713 1 0) 0))) ; Cond: $z0 != 0 
(define-const var894 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {address/-392511114=([org.apache.dubbo.config.MonitorConfig], java.lang.String), var2118_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1393=org.apache.dubbo.config.MonitorConfig, var2023=r0, var3607=$r1, var2118=org.apache.dubbo.common.utils.StringUtils, var3713=$z0, var894=$z2}
; {org.apache.dubbo.config.MonitorConfig=var1393, r0=var2023, $r1=var3607, org.apache.dubbo.common.utils.StringUtils=var2118, $z0=var3713, $z2=var894}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.MonitorConfig;	$r1 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3