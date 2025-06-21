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

(declare-sort var266 0)
(declare-sort var1968 0)
(declare-sort var2834 0)
(declare-sort var3307 0)
(declare-sort var2451 0)
(declare-sort var807 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun interfaceName/2049477907 (var2451) String)
(declare-fun cast-from-var266-to-var2451 (var266) var2451)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3307_error/377575788 (var3307 String String String String var807) void)
(declare-fun cast-from-var2834-to-var807 (var2834) var807)
(declare-const null-var266 var266)
(declare-const var1968-AUTO_REGISTER var1968)
(declare-const null-var2834 var2834)
(declare-const var266-logger var3307)
(declare-const var1577 var266) ; Statement: r0 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var1577 null-var266)))
(define-const var435 var1968 var1968-AUTO_REGISTER) ; Statement: $r1 = <org.apache.dubbo.common.constants.RegisterTypeEnum: org.apache.dubbo.common.constants.RegisterTypeEnum AUTO_REGISTER> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var257 var2834) ; Statement: $r2 := @caughtexception 
(assert (not (= var257 null-var2834)))
(define-const var2588 var3307 var266-logger) ; Statement: $r4 = <org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var571 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var571)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var571!1 String)
(assert (= var571!1 ""))
(assert true)
(define-const var535 String (append/672562846 var571!1 "Failed to (async)export service config: ")) ; Statement: $r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to (async)export service config: ") 
(declare-const var571!2 String)
(assert (= var571!2 (str.++ var571!1 "Failed to (async)export service config: ")))
(define-const var1174 String (interfaceName/2049477907 (cast-from-var266-to-var2451 var1577))) ; Statement: $r5 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.String interfaceName> 
(assert true)
(define-const var2591 String (append/672562846 var535 var1174)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var535!1 String)
(assert (= var535!1 (str.++ var535 var1174)))
(assert true)
(define-const var3819 String (toString/-2075883882 var2591)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3307_error/377575788 var2588 "5-9" "configuration server disconnected" "" var3819 (cast-from-var2834-to-var807 var257))) ; Statement: interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-9", "configuration server disconnected", "", $r8, $r2) 

(declare-const var2588!1 var3307)
(declare-const var1423 String)
(declare-const var1925 String)
(declare-const var2769 String)
(declare-const var3819!1 String)
(declare-const var257!1 var2834)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), interfaceName/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var266-to-var2451=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3307_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2834-to-var807=([java.lang.Exception], java.lang.Throwable)}
; {var266=org.apache.dubbo.config.ServiceConfig, var1577=r0, var1968=org.apache.dubbo.common.constants.RegisterTypeEnum, var435=$r1, var2834=java.lang.Exception, var257=$r2, var3307=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2588=$r4, var571=$r3, var535=$r6, var2451=org.apache.dubbo.config.AbstractInterfaceConfig, var1174=$r5, var2591=$r7, var3819=$r8, var807=java.lang.Throwable, var1423="5-9", var1925="configuration server disconnected", var2769=""}
; {org.apache.dubbo.config.ServiceConfig=var266, r0=var1577, org.apache.dubbo.common.constants.RegisterTypeEnum=var1968, $r1=var435, java.lang.Exception=var2834, $r2=var257, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3307, $r4=var2588, $r3=var571, $r6=var535, org.apache.dubbo.config.AbstractInterfaceConfig=var2451, $r5=var1174, $r7=var2591, $r8=var3819, java.lang.Throwable=var807, "5-9"=var1423, "configuration server disconnected"=var1925, ""=var2769}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ServiceConfig;	$r1 = <org.apache.dubbo.common.constants.RegisterTypeEnum: org.apache.dubbo.common.constants.RegisterTypeEnum AUTO_REGISTER>;	$r2 := @caughtexception;	$r4 = <org.apache.dubbo.config.ServiceConfig: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to (async)export service config: ");	$r5 = r0.<org.apache.dubbo.config.ServiceConfig: java.lang.String interfaceName>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r4.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("5-9", "configuration server disconnected", "", $r8, $r2);	return
;block_num 3