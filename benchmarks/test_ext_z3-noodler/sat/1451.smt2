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

(declare-sort var2199 0)
(declare-sort var1705 0)
(declare-sort var889 0)
(declare-sort var2301 0)
(declare-sort var1633 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun prefix/-286024106 (var2199) String)
(declare-fun var889_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun origin/-286024106 (var2199) var2301)
(declare-fun var2301_getInternalProperty/867465790 (var2301 String) var1633)
(declare-const null-var2199 var2199)
(declare-const null-String String)
(declare-const var2060 var2199) ; Statement: r0 := @this: org.apache.dubbo.common.config.PrefixedConfiguration 
(assert (not (= var2060 null-var2199)))
(declare-const var1994 String) ; Statement: r6 := @parameter0: java.lang.String 
(assert (not (= var1994 null-String)))
(define-const var1309 String (prefix/-286024106 var2060)) ; Statement: $r1 = r0.<org.apache.dubbo.common.config.PrefixedConfiguration: java.lang.String prefix> 
(define-const var1222 Bool (var889_isBlank/-523695098 (cast-from-String-to-String var1309))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.config.PrefixedConfiguration: org.apache.dubbo.common.config.Configuration origin> 
(assert (not (= (ite var1222 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2713 var2301 (origin/-286024106 var2060)) ; Statement: $r11 = r0.<org.apache.dubbo.common.config.PrefixedConfiguration: org.apache.dubbo.common.config.Configuration origin> 
(define-const var2371 var1633 (var2301_getInternalProperty/867465790 var2713 var1994)) ; Statement: $r12 = interfaceinvoke $r11.<org.apache.dubbo.common.config.Configuration: java.lang.Object getInternalProperty(java.lang.String)>(r6) 
 ; Statement: return $r12 
(check-sat)
; {prefix/-286024106=([org.apache.dubbo.common.config.PrefixedConfiguration], java.lang.String), var889_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), origin/-286024106=([org.apache.dubbo.common.config.PrefixedConfiguration], org.apache.dubbo.common.config.Configuration), var2301_getInternalProperty/867465790=([org.apache.dubbo.common.config.Configuration, java.lang.String], java.lang.Object)}
; {var2199=org.apache.dubbo.common.config.PrefixedConfiguration, var2060=r0, var1994=r6, var1705=null_type, var1309=$r1, var889=org.apache.dubbo.common.utils.StringUtils, var1222=$z0, var2301=org.apache.dubbo.common.config.Configuration, var2713=$r11, var1633=java.lang.Object, var2371=$r12}
; {org.apache.dubbo.common.config.PrefixedConfiguration=var2199, r0=var2060, r6=var1994, null_type=var1705, $r1=var1309, org.apache.dubbo.common.utils.StringUtils=var889, $z0=var1222, org.apache.dubbo.common.config.Configuration=var2301, $r11=var2713, java.lang.Object=var1633, $r12=var2371}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.config.PrefixedConfiguration;	r6 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.common.config.PrefixedConfiguration: java.lang.String prefix>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r1);	if $z0 == 0 goto $r3 = r0.<org.apache.dubbo.common.config.PrefixedConfiguration: org.apache.dubbo.common.config.Configuration origin>;	$r11 = r0.<org.apache.dubbo.common.config.PrefixedConfiguration: org.apache.dubbo.common.config.Configuration origin>;	$r12 = interfaceinvoke $r11.<org.apache.dubbo.common.config.Configuration: java.lang.Object getInternalProperty(java.lang.String)>(r6);	return $r12
;block_num 2