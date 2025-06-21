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

(declare-sort var2617 0)
(declare-sort var2893 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/-392511114 (var2617) String)
(declare-fun var2893_isNotEmpty/-1251449450 (String) Bool)
(declare-fun protocol/-392511114 (var2617) String)
(declare-const null-var2617 var2617)
(declare-const var1156 var2617) ; Statement: r0 := @this: org.apache.dubbo.config.MonitorConfig 
(assert (not (= var1156 null-var2617)))
(define-const var1063 String (address/-392511114 var1156)) ; Statement: $r1 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String address> 
(define-const var3820 Bool (var2893_isNotEmpty/-1251449450 var1063)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (not (= (ite var3820 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1587 String "registry") ; Statement: $r3 = "registry" 
(define-const var3463 String (protocol/-392511114 var1156)) ; Statement: $r2 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String protocol> 
(assert true)
(define-const var3893 Bool (= var1587 var3463)) ; Statement: $z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: if $z1 == 0 goto $z2 = 0 
(assert (= (ite var3893 1 0) 0)) ; Cond: $z1 == 0 
(define-const var458 Bool (ite (= 1 0) true false)) ; Statement: $z2 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {address/-392511114=([org.apache.dubbo.config.MonitorConfig], java.lang.String), var2893_isNotEmpty/-1251449450=([java.lang.String], boolean), protocol/-392511114=([org.apache.dubbo.config.MonitorConfig], java.lang.String)}
; {var2617=org.apache.dubbo.config.MonitorConfig, var1156=r0, var1063=$r1, var2893=org.apache.dubbo.common.utils.StringUtils, var3820=$z0, var1587=$r3, var3463=$r2, var3893=$z1, var458=$z2}
; {org.apache.dubbo.config.MonitorConfig=var2617, r0=var1156, $r1=var1063, org.apache.dubbo.common.utils.StringUtils=var2893, $z0=var3820, $r3=var1587, $r2=var3463, $z1=var3893, $z2=var458}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.MonitorConfig;	$r1 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r1);	if $z0 != 0 goto $z2 = 1;	$r3 = "registry";	$r2 = r0.<org.apache.dubbo.config.MonitorConfig: java.lang.String protocol>;	$z1 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	if $z1 == 0 goto $z2 = 0;	$z2 = 0;	return $z2
;block_num 4