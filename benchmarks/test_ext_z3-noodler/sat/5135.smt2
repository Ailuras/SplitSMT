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

(declare-sort var1852 0)
(declare-sort var1893 0)
(declare-sort var3496 0)
(declare-sort var3949 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun interfaceName/2049477907 (var1852) String)
(declare-fun var3949_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1852 var1852)
(declare-const null-String String)
(declare-const null-var3496 var3496)
(declare-const var1081 var1852) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var1081 null-var1852)))
(declare-const var638 String) ; Statement: r9 := @parameter0: java.lang.String 
(assert (not (= var638 null-String)))
(declare-const var2354 var3496) ; Statement: r4 := @parameter1: org.apache.dubbo.common.config.InmemoryConfiguration 
(assert (not (= var2354 null-var3496)))
(define-const var1243 String (interfaceName/2049477907 var1081)) ; Statement: $r1 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String interfaceName> 
(define-const var2860 Bool (var3949_hasText/853333513 (cast-from-String-to-String var1243))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2860 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var3949_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1852=org.apache.dubbo.config.AbstractInterfaceConfig, var1081=r0, var638=r9, var1893=null_type, var3496=org.apache.dubbo.common.config.InmemoryConfiguration, var2354=r4, var1243=$r1, var3949=org.apache.dubbo.common.utils.StringUtils, var2860=$z0}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var1852, r0=var1081, r9=var638, null_type=var1893, org.apache.dubbo.common.config.InmemoryConfiguration=var3496, r4=var2354, $r1=var1243, org.apache.dubbo.common.utils.StringUtils=var3949, $z0=var2860}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r9 := @parameter0: java.lang.String;	r4 := @parameter1: org.apache.dubbo.common.config.InmemoryConfiguration;	$r1 = r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String interfaceName>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>($r1);	if $z0 == 0 goto return;	return
;block_num 2