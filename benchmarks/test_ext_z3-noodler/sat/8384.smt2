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

(declare-sort var1029 0)
(declare-sort var1212 0)
(declare-sort var563 0)
(declare-sort var460 0)
(declare-sort var2986 0)
(declare-sort var425 0)
(declare-sort var3402 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkRegistry/-1349273017 (var563) void)
(declare-fun cast-from-var1029-to-var563 (var1029) var563)
(declare-fun var2986_loadRegistries/-1857565534 (var563 Bool) var460)
(declare-fun var425_isNotEmpty/-572947236 (var3402) Bool)
(declare-fun cast-from-var460-to-var3402 (var460) var3402)
(declare-fun urls/2049477907 (var563) var460)
(declare-fun var460_isEmpty/-153543822 (var460) Bool)
(declare-const null-var1029 var1029)
(declare-const null-var1212 var1212)
(declare-const var1058 var1029) ; Statement: r0 := @this: org.apache.dubbo.config.ReferenceConfig 
(assert (not (= var1058 null-var1029)))
(declare-const var487 var1212) ; Statement: r16 := @parameter0: java.util.Map 
(assert (not (= var487 null-var1212)))
(assert true)
;(assert (checkRegistry/-1349273017 (cast-from-var1029-to-var563 var1058))) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void checkRegistry()>() 

(declare-const var1058!1 var1029)
(define-const var2999 var460 (var2986_loadRegistries/-1857565534 (cast-from-var1029-to-var563 var1058!1) (ite (= 1 0) true false))) ; Statement: r1 = staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: java.util.List loadRegistries(org.apache.dubbo.config.AbstractInterfaceConfig,boolean)>(r0, 0) 
(define-const var1849 Bool (var425_isNotEmpty/-572947236 (cast-from-var460-to-var3402 var2999))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(assert (= (ite var1849 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3076 var460 (urls/2049477907 (cast-from-var1029-to-var563 var1058!1))) ; Statement: $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(define-const var893 Bool (var460_isEmpty/-153543822 var3076)) ; Statement: $z1 = interfaceinvoke $r2.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z1 == 0 goto $r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(assert (= (ite var893 1 0) 0)) ; Cond: $z1 == 0 
(define-const var1800 var460 (urls/2049477907 (cast-from-var1029-to-var563 var1058!1))) ; Statement: $r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls> 
(define-const var533 Bool (var460_isEmpty/-153543822 var1800)) ; Statement: $z5 = interfaceinvoke $r40.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z5 == 0 goto return 
(assert (= (ite var533 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: return 
(check-sat)
; {checkRegistry/-1349273017=([org.apache.dubbo.config.AbstractInterfaceConfig], void), cast-from-var1029-to-var563=([org.apache.dubbo.config.ReferenceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var2986_loadRegistries/-1857565534=([org.apache.dubbo.config.AbstractInterfaceConfig, boolean], java.util.List), var425_isNotEmpty/-572947236=([java.util.Collection], boolean), cast-from-var460-to-var3402=([java.util.List], java.util.Collection), urls/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.util.List), var460_isEmpty/-153543822=([java.util.List], boolean)}
; {var1029=org.apache.dubbo.config.ReferenceConfig, var1058=r0, var1212=java.util.Map, var487=r16, var563=org.apache.dubbo.config.AbstractInterfaceConfig, var460=java.util.List, var2986=org.apache.dubbo.config.utils.ConfigValidationUtils, var2999=r1, var425=org.apache.dubbo.common.utils.CollectionUtils, var3402=java.util.Collection, var1849=$z0, var3076=$r2, var893=$z1, var1800=$r40, var533=$z5}
; {org.apache.dubbo.config.ReferenceConfig=var1029, r0=var1058, java.util.Map=var1212, r16=var487, org.apache.dubbo.config.AbstractInterfaceConfig=var563, java.util.List=var460, org.apache.dubbo.config.utils.ConfigValidationUtils=var2986, r1=var2999, org.apache.dubbo.common.utils.CollectionUtils=var425, java.util.Collection=var3402, $z0=var1849, $r2=var3076, $z1=var893, $r40=var1800, $z5=var533}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.config.ReferenceConfig;	r16 := @parameter0: java.util.Map;	virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfig: void checkRegistry()>();	r1 = staticinvoke <org.apache.dubbo.config.utils.ConfigValidationUtils: java.util.List loadRegistries(org.apache.dubbo.config.AbstractInterfaceConfig,boolean)>(r0, 0);	$z0 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r1);	if $z0 == 0 goto $r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$r2 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$z1 = interfaceinvoke $r2.<java.util.List: boolean isEmpty()>();	if $z1 == 0 goto $r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$r40 = r0.<org.apache.dubbo.config.ReferenceConfig: java.util.List urls>;	$z5 = interfaceinvoke $r40.<java.util.List: boolean isEmpty()>();	if $z5 == 0 goto return;	return
;block_num 4