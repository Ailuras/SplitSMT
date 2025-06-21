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

(declare-sort var3174 0)
(declare-sort var185 0)
(declare-sort var2306 0)
(declare-sort var1796 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2306_isEmpty/-813097145 (String) Bool)
(declare-fun dubboConfigFile/-775390699 (var3174) var1796)
(declare-fun var1796_getContent/1649106723 (var1796) String)
(declare-const null-var3174 var3174)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1493 var3174) ; Statement: r1 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration 
(assert (not (= var1493 null-var3174)))
(declare-const var3610 String) ; Statement: r18 := @parameter0: java.lang.String 
(assert (not (= var3610 null-String)))
(declare-const var116 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var116 null-String)))
(declare-const var1200 Int) ; Statement: l0 := @parameter2: long 
(assert (not (= var1200 null-Int)))
(define-const var3001 Bool (var2306_isEmpty/-813097145 var116)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.common.URL url> 
(assert (not (= (ite var3001 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var824 var1796 (dubboConfigFile/-775390699 var1493)) ; Statement: $r16 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.ConfigFile dubboConfigFile> 
(define-const var3422 String (var1796_getContent/1649106723 var824)) ; Statement: $r17 = interfaceinvoke $r16.<com.ctrip.framework.apollo.ConfigFile: java.lang.String getContent()>() 
 ; Statement: return $r17 
(check-sat)
; {var2306_isEmpty/-813097145=([java.lang.String], boolean), dubboConfigFile/-775390699=([org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration], com.ctrip.framework.apollo.ConfigFile), var1796_getContent/1649106723=([com.ctrip.framework.apollo.ConfigFile], java.lang.String)}
; {var3174=org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration, var1493=r1, var3610=r18, var185=null_type, var116=r0, var1200=l0, var2306=org.apache.dubbo.common.utils.StringUtils, var3001=$z0, var1796=com.ctrip.framework.apollo.ConfigFile, var824=$r16, var3422=$r17}
; {org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration=var3174, r1=var1493, r18=var3610, null_type=var185, r0=var116, l0=var1200, org.apache.dubbo.common.utils.StringUtils=var2306, $z0=var3001, com.ctrip.framework.apollo.ConfigFile=var1796, $r16=var824, $r17=var3422}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration;	r18 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	l0 := @parameter2: long;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: org.apache.dubbo.common.URL url>;	$r16 = r1.<org.apache.dubbo.configcenter.support.apollo.ApolloDynamicConfiguration: com.ctrip.framework.apollo.ConfigFile dubboConfigFile>;	$r17 = interfaceinvoke $r16.<com.ctrip.framework.apollo.ConfigFile: java.lang.String getContent()>();	return $r17
;block_num 2