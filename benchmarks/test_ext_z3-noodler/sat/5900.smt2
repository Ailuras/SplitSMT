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

(declare-sort var2527 0)
(declare-sort var948 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/-392511114 (var2527) String)
(declare-fun var948_isNotEmpty/-1251449450 (String) Bool)
(declare-fun protocol/-392511114 (var2527) String)
(declare-const null-var2527 var2527)
(declare-const var638 var2527) ; Statement: r0 := @this: org.apache.dubbo.config.MonitorConfig 
(assert (not (= var638 null-var2527)))
(define-const var3486 String (address/-392511114 var638)) ; Statement: $r1 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String address> 
(define-const var625 Bool (var948_isNotEmpty/-1251449450 var3486)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (not (= (ite var625 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1952 String "registry") ; Statement: $r3 = "registry" 
(define-const var2172 String (protocol/-392511114 var638)) ; Statement: $r2 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String protocol> 
(assert true)
(define-const var324 Bool (= var1952 var2172)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (not (= (ite var324 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1219 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {address/-392511114=([org.apache.dubbo.config.MonitorConfig], java.lang.String), var948_isNotEmpty/-1251449450=([java.lang.String], boolean), protocol/-392511114=([org.apache.dubbo.config.MonitorConfig], java.lang.String)}
; {var2527=org.apache.dubbo.config.MonitorConfig, var638=r0, var3486=$r1, var948=org.apache.dubbo.common.utils.StringUtils, var625=$z0, var1952=$r3, var2172=$r2, var324=$z1, var1219=$z2}
; {org.apache.dubbo.config.MonitorConfig=var2527, r0=var638, $r1=var3486, org.apache.dubbo.common.utils.StringUtils=var948, $z0=var625, $r3=var1952, $r2=var2172, $z1=var324, $z2=var1219}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.MonitorConfig;	$r1 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 != 0 goto $z2 = 1;	$r3 = "registry";	$r2 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String protocol>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $z2 = 0;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 4