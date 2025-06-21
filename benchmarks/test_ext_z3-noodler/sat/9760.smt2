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

(declare-sort var2516 0)
(declare-sort var1160 0)
(declare-sort var313 0)
(declare-sort var98 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun refresh/-1420329662 (var1160) void)
(declare-fun cast-from-var2516-to-var1160 (var2516) var1160)
(declare-fun appendEnvironmentProperties/1892471079 (var2516) void)
(declare-fun getName/922463553 (var2516) String)
(declare-fun var313_isEmpty/-813097145 (String) Bool)
(declare-fun setName/1475189323 (var2516 String) void)
(declare-fun var98_warn/1431914100 (var98 String String String String) void)
(declare-const null-var2516 var2516)
(declare-const var2516-LOGGER var98)
(declare-const var3515 var2516) ; Statement: r0 := @this: org.apache.dubbo.config.ApplicationConfig 
(assert (not (= var3515 null-var2516)))
(assert true)
;(assert (refresh/-1420329662 (cast-from-var2516-to-var1160 var3515))) ; Statement: specialinvoke r0.<org.apache.dubbo.config.AbstractConfig: void refresh()>() 

(declare-const var3515!1 var2516)
(assert true)
;(assert (appendEnvironmentProperties/1892471079 var3515!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.config.ApplicationConfig: void appendEnvironmentProperties()>() 

(declare-const var3515!2 var2516)
(assert true)
(define-const var978 String (getName/922463553 var3515!2)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>() 
(define-const var2456 Bool (var313_isEmpty/-813097145 var978)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var2456 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (setName/1475189323 var3515!2 "DEFAULT_DUBBO_APP")) ; Statement: virtualinvoke r0.<org.apache.dubbo.config.ApplicationConfig: void setName(java.lang.String)>("DEFAULT_DUBBO_APP") 

(declare-const var3515!3 var2516)
(declare-const var1754 String)
(define-const var2310 var98 var2516-LOGGER) ; Statement: $r2 = <org.apache.dubbo.config.ApplicationConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
;(assert (var98_warn/1431914100 var2310 "0-12" "" "" "No application name was set, \u0027DEFAULT_DUBBO_APP\u0027 will be used as the default application name, it\u0027s highly recommended to set a unique and customized name for it can be critical for some service governance features.")) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-12", "", "", "No application name was set, \'DEFAULT_DUBBO_APP\' will be used as the default application name, it\'s highly recommended to set a unique and customized name for it can be critical for some service governance features.") 

(declare-const var2310!1 var98)
(declare-const var3985 String)
(declare-const var3439 String)
(declare-const var3439!1 String)
(declare-const var2536 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {refresh/-1420329662=([org.apache.dubbo.config.AbstractConfig], void), cast-from-var2516-to-var1160=([org.apache.dubbo.config.ApplicationConfig], org.apache.dubbo.config.AbstractConfig), appendEnvironmentProperties/1892471079=([org.apache.dubbo.config.ApplicationConfig], void), getName/922463553=([org.apache.dubbo.config.ApplicationConfig], java.lang.String), var313_isEmpty/-813097145=([java.lang.String], boolean), setName/1475189323=([org.apache.dubbo.config.ApplicationConfig, java.lang.String], void), var98_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2516=org.apache.dubbo.config.ApplicationConfig, var3515=r0, var1160=org.apache.dubbo.config.AbstractConfig, var978=$r1, var313=org.apache.dubbo.common.utils.StringUtils, var2456=$z0, var1754="DEFAULT_DUBBO_APP", var98=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2310=$r2, var3985="0-12", var3439="", var2536="No application name was set, \'DEFAULT_DUBBO_APP\' will be used as the default application name, it\'s highly recommended to set a unique and customized name for it can be critical for some service governance features."}
; {org.apache.dubbo.config.ApplicationConfig=var2516, r0=var3515, org.apache.dubbo.config.AbstractConfig=var1160, $r1=var978, org.apache.dubbo.common.utils.StringUtils=var313, $z0=var2456, "DEFAULT_DUBBO_APP"=var1754, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var98, $r2=var2310, "0-12"=var3985, ""=var3439, "No application name was set, \'DEFAULT_DUBBO_APP\' will be used as the default application name, it\'s highly recommended to set a unique and customized name for it can be critical for some service governance features."=var2536}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ApplicationConfig;	specialinvoke r0.<org.apache.dubbo.config.AbstractConfig: void refresh()>();	specialinvoke r0.<org.apache.dubbo.config.ApplicationConfig: void appendEnvironmentProperties()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ApplicationConfig: java.lang.String getName()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto return;	virtualinvoke r0.<org.apache.dubbo.config.ApplicationConfig: void setName(java.lang.String)>("DEFAULT_DUBBO_APP");	$r2 = <org.apache.dubbo.config.ApplicationConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-12", "", "", "No application name was set, \'DEFAULT_DUBBO_APP\' will be used as the default application name, it\'s highly recommended to set a unique and customized name for it can be critical for some service governance features.");	return
;block_num 3