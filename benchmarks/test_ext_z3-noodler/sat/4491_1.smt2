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

(declare-sort var2895 0)
(declare-sort var3216 0)
(declare-sort var2150 0)
(declare-sort var1416 0)
(declare-sort var3943 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkStatus/-647195865 (var2895) var3216)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1633728430 (var1416) String)
(declare-fun cast-from-var3216-to-var1416 (var3216) var1416)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3943_info/484404803 (var3943 String) void)
(declare-fun cast-from-var2150-to-var3943 (var2150) var3943)
(declare-fun notifyCheckStatus/796516367 (var2895) void)
(declare-const null-var2895 var2895)
(declare-const null-var3216 var3216)
(declare-const var2895-logger var2150)
(declare-const var3126 var2895) ; Statement: r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager 
(assert (not (= var3126 null-var2895)))
(declare-const var2203 var3216) ; Statement: r3 := @parameter0: org.apache.dubbo.common.utils.SerializeCheckStatus 
(assert (not (= var2203 null-var3216)))
(define-const var1199 var3216 (checkStatus/-647195865 var3126)) ; Statement: $r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus checkStatus> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus checkStatus> 
(assert (not (not (= var1199 null-var3216)))) ; Negate: Cond: $r1 != null  
(declare-const var3126!1 var2895)
(assert (not (= var3126!1 null-var2895)))
(assert (= (checkStatus/-647195865 var3126!1) var2203)) ; Statement: r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus checkStatus> = r3 
(define-const var3700 var2150 var2895-logger) ; Statement: $r11 = <org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2822 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2822)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2822!1 String)
(assert (= var2822!1 ""))
(assert true)
(define-const var2654 String (append/672562846 var2822!1 "Serialize check level: ")) ; Statement: $r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialize check level: ") 
(declare-const var2822!2 String)
(assert (= var2822!2 (str.++ var2822!1 "Serialize check level: ")))
(assert true)
(define-const var2943 String (name/1633728430 (cast-from-var3216-to-var1416 var2203))) ; Statement: $r12 = virtualinvoke r3.<org.apache.dubbo.common.utils.SerializeCheckStatus: java.lang.String name()>() 
(assert true)
(define-const var1912 String (append/672562846 var2654 var2943)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2654!1 String)
(assert (= var2654!1 (str.++ var2654 var2943)))
(assert true)
(define-const var1858 String (toString/-2075883882 var1912)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3943_info/484404803 (cast-from-var2150-to-var3943 var3700) var1858)) ; Statement: interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r15) 

(declare-const var3700!1 var2150)
(declare-const var1858!1 String)
(assert true)
;(assert (notifyCheckStatus/796516367 var3126!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: void notifyCheckStatus()>() 

(declare-const var3126!2 var2895)
 ; Statement: return 
(check-sat)
; {checkStatus/-647195865=([org.apache.dubbo.common.utils.SerializeSecurityManager], org.apache.dubbo.common.utils.SerializeCheckStatus), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var3216-to-var1416=([org.apache.dubbo.common.utils.SerializeCheckStatus], java.lang.Enum), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3943_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var2150-to-var3943=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), notifyCheckStatus/796516367=([org.apache.dubbo.common.utils.SerializeSecurityManager], void)}
; {var2895=org.apache.dubbo.common.utils.SerializeSecurityManager, var3126=r0, var3216=org.apache.dubbo.common.utils.SerializeCheckStatus, var2203=r3, var1199=$r1, var2150=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3700=$r11, var2822=$r10, var2654=$r13, var1416=java.lang.Enum, var2943=$r12, var1912=$r14, var1858=$r15, var3943=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.common.utils.SerializeSecurityManager=var2895, r0=var3126, org.apache.dubbo.common.utils.SerializeCheckStatus=var3216, r3=var2203, $r1=var1199, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2150, $r11=var3700, $r10=var2822, $r13=var2654, java.lang.Enum=var1416, $r12=var2943, $r14=var1912, $r15=var1858, org.apache.dubbo.common.logger.Logger=var3943}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager;	r3 := @parameter0: org.apache.dubbo.common.utils.SerializeCheckStatus;	$r1 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus checkStatus>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus checkStatus>;	r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus checkStatus> = r3;	$r11 = <org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialize check level: ");	$r12 = virtualinvoke r3.<org.apache.dubbo.common.utils.SerializeCheckStatus: java.lang.String name()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r11.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r15);	specialinvoke r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: void notifyCheckStatus()>();	return
;block_num 2