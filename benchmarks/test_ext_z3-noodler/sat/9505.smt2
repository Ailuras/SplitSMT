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

(declare-sort var3502 0)
(declare-sort var1292 0)
(declare-sort var1216 0)
(declare-sort var3212 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1216_isNotEmpty/-1251449450 (String) Bool)
(declare-fun dubboConfig/-775390699 (var3502) var3212)
(declare-fun var3212_getProperty/957142193 (var3212 String String) String)
(declare-const null-var3502 var3502)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var469 var3502) ; Statement: r1 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var469 null-var3502)))
(declare-const var2301 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2301 null-String)))
(declare-const var3795 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3795 null-String)))
(declare-const var2219 Int) ; Statement: l0 := @parameter2: long 
(assert (not (= var2219 null-Int)))
(define-const var642 Bool (var1216_isNotEmpty/-1251449450 var3795)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> 
(assert (= (ite var642 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3080 var3212 (dubboConfig/-775390699 var469)) ; Statement: $r3 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig> 
(define-const var2699 String (var3212_getProperty/957142193 var3080 var2301 null-String)) ; Statement: $r4 = interfaceinvoke $r3.<com.ctrip.framework.apollo.Config: java.lang.String getProperty(java.lang.String,java.lang.String)>(r2, null) 
 ; Statement: return $r4 
(check-sat)
; {var1216_isNotEmpty/-1251449450=([java.lang.String], boolean), dubboConfig/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.Config), var3212_getProperty/957142193=([com.ctrip.framework.apollo.Config, java.lang.String, java.lang.String], java.lang.String)}
; {var3502=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var469=r1, var2301=r2, var1292=null_type, var3795=r0, var2219=l0, var1216=org.apache.dubbo.common.utils.StringUtils, var642=$z0, var3212=com.ctrip.framework.apollo.Config, var3080=$r3, var2699=$r4}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var3502, r1=var469, r2=var2301, null_type=var1292, r0=var3795, l0=var2219, org.apache.dubbo.common.utils.StringUtils=var1216, $z0=var642, com.ctrip.framework.apollo.Config=var3212, $r3=var3080, $r4=var2699}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	l0 := @parameter2: long;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig>;	$r3 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.Config dubboConfig>;	$r4 = interfaceinvoke $r3.<com.ctrip.framework.apollo.Config: java.lang.String getProperty(java.lang.String,java.lang.String)>(r2, null);	return $r4
;block_num 2