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

(declare-sort var2830 0)
(declare-sort var2249 0)
(declare-sort var685 0)
(declare-sort var1024 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDefault/-1757698556 (var2249) void)
(declare-fun cast-from-var2830-to-var2249 (var2830) var2249)
(declare-fun deprecated/1833650063 (var2830) var685)
(declare-fun dynamic/1833650063 (var2830) var685)
(declare-fun useJavaPackageAsPath/1833650063 (var2830) var685)
(declare-fun preferSerialization/1833650063 (var2830) String)
(declare-fun var1024_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2830 var2830)
(declare-const null-var685 var685)
(declare-const var889 var2830) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractServiceConfig 
(assert (not (= var889 null-var2830)))
(assert true)
;(assert (checkDefault/-1757698556 (cast-from-var2830-to-var2249 var889))) ; Statement: specialinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void checkDefault()>() 

(declare-const var889!1 var2830)
(define-const var3503 var685 (deprecated/1833650063 var889!1)) ; Statement: $r1 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean deprecated> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean dynamic> 
(assert (not (= var3503 null-var685))) ; Cond: $r1 != null 
(define-const var2102 var685 (dynamic/1833650063 var889!1)) ; Statement: $r2 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean dynamic> 
 ; Statement: if $r2 != null goto $r3 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean useJavaPackageAsPath> 
(assert (not (= var2102 null-var685))) ; Cond: $r2 != null 
(define-const var3998 var685 (useJavaPackageAsPath/1833650063 var889!1)) ; Statement: $r3 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean useJavaPackageAsPath> 
 ; Statement: if $r3 != null goto $r4 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.String preferSerialization> 
(assert (not (= var3998 null-var685))) ; Cond: $r3 != null 
(define-const var3344 String (preferSerialization/1833650063 var889!1)) ; Statement: $r4 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.String preferSerialization> 
(define-const var1371 Bool (var1024_isBlank/-523695098 (cast-from-String-to-String var3344))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r4) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var1371 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {checkDefault/-1757698556=([org.apache.dubbo.config.AbstractConfig], void), cast-from-var2830-to-var2249=([org.apache.dubbo.config.AbstractServiceConfig], org.apache.dubbo.config.AbstractConfig), deprecated/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.Boolean), dynamic/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.Boolean), useJavaPackageAsPath/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.Boolean), preferSerialization/1833650063=([org.apache.dubbo.config.AbstractServiceConfig], java.lang.String), var1024_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2830=org.apache.dubbo.config.AbstractServiceConfig, var889=r0, var2249=org.apache.dubbo.config.AbstractConfig, var685=java.lang.Boolean, var3503=$r1, var2102=$r2, var3998=$r3, var3344=$r4, var1024=org.apache.dubbo.common.utils.StringUtils, var1371=$z0}
; {org.apache.dubbo.config.AbstractServiceConfig=var2830, r0=var889, org.apache.dubbo.config.AbstractConfig=var2249, java.lang.Boolean=var685, $r1=var3503, $r2=var2102, $r3=var3998, $r4=var3344, org.apache.dubbo.common.utils.StringUtils=var1024, $z0=var1371}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractServiceConfig;	specialinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: void checkDefault()>();	$r1 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean deprecated>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean dynamic>;	$r2 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean dynamic>;	if $r2 != null goto $r3 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean useJavaPackageAsPath>;	$r3 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.Boolean useJavaPackageAsPath>;	if $r3 != null goto $r4 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.String preferSerialization>;	$r4 = r0.<org.apache.dubbo.config.AbstractServiceConfig: java.lang.String preferSerialization>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r4);	if $z0 == 0 goto return;	return
;block_num 5