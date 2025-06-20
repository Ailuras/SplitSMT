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

(declare-sort var2254 0)
(declare-sort var1154 0)
(declare-sort var960 0)
(declare-sort var1490 0)
(declare-sort var1826 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var1826) String)
(declare-fun cast-from-var960-to-var1826 (var960) var1826)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1490_warn/1431914100 (var1490 String String String String) void)
(declare-const null-var2254 var2254)
(declare-const null-String String)
(declare-const null-var960 var960)
(declare-const var2254-logger var1490)
(declare-const var2479 var2254) ; Statement: r2 := @this: org.apache.dubbo.registry.integration.AbstractConfiguratorListener 
(assert (not (= var2479 null-var2254)))
(declare-const var123 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var123 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3868 var960) ; Statement: $r14 := @caughtexception 
(assert (not (= var3868 null-var960)))
(define-const var755 var1490 var2254-logger) ; Statement: $r16 = <org.apache.dubbo.registry.integration.AbstractConfiguratorListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2436 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2436)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2436!1 String)
(assert (= var2436!1 ""))
(assert true)
(define-const var1459 String (append/672562846 var2436!1 "Failed to parse raw dynamic config and it will not take effect, the raw config is: ")) ; Statement: $r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to parse raw dynamic config and it will not take effect, the raw config is: ") 
(declare-const var2436!2 String)
(assert (= var2436!2 (str.++ var2436!1 "Failed to parse raw dynamic config and it will not take effect, the raw config is: ")))
(assert true)
(define-const var3497 String (append/672562846 var1459 var123)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1459!1 String)
(assert (= var1459!1 (str.++ var1459 var123)))
(assert true)
(define-const var3921 String (append/672562846 var3497 ", cause: ")) ; Statement: $r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ") 
(declare-const var3497!1 String)
(assert (= var3497!1 (str.++ var3497 ", cause: ")))
(assert true)
(define-const var1547 String (getMessage/849299655 (cast-from-var960-to-var1826 var3868))) ; Statement: $r19 = virtualinvoke $r14.<java.lang.Exception: java.lang.String getMessage()>() 
(assert true)
(define-const var1055 String (append/672562846 var3921 var1547)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19) 
(declare-const var3921!1 String)
(assert (= var3921!1 (str.++ var3921 var1547)))
(assert true)
(define-const var1260 String (toString/-2075883882 var1055)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1490_warn/1431914100 var755 "1-14" "" "" var1260)) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-14", "", "", $r22) 

(declare-const var755!1 var1490)
(declare-const var2876 String)
(declare-const var1191 String)
(declare-const var1191!1 String)
(declare-const var1260!1 String)
 ; Statement: return 0 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), cast-from-var960-to-var1826=([java.lang.Exception], java.lang.Throwable), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1490_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2254=org.apache.dubbo.registry.integration.AbstractConfiguratorListener, var2479=r2, var123=r0, var1154=null_type, var960=java.lang.Exception, var3868=$r14, var1490=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var755=$r16, var2436=$r15, var1459=$r17, var3497=$r18, var3921=$r20, var1826=java.lang.Throwable, var1547=$r19, var1055=$r21, var1260=$r22, var2876="1-14", var1191=""}
; {org.apache.dubbo.registry.integration.AbstractConfiguratorListener=var2254, r2=var2479, r0=var123, null_type=var1154, java.lang.Exception=var960, $r14=var3868, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1490, $r16=var755, $r15=var2436, $r17=var1459, $r18=var3497, $r20=var3921, java.lang.Throwable=var1826, $r19=var1547, $r21=var1055, $r22=var1260, "1-14"=var2876, ""=var1191}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.integration.AbstractConfiguratorListener;	r0 := @parameter0: java.lang.String;	$r14 := @caughtexception;	$r16 = <org.apache.dubbo.registry.integration.AbstractConfiguratorListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to parse raw dynamic config and it will not take effect, the raw config is: ");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r20 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: ");	$r19 = virtualinvoke $r14.<java.lang.Exception: java.lang.String getMessage()>();	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r19);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-14", "", "", $r22);	return 0
;block_num 2