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

(declare-sort var213 0)
(declare-sort var3984 0)
(declare-sort var3222 0)
(declare-sort var3412 0)
(declare-sort var735 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun defaultCheckStatus/-647195865 (var213) var3984)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/1633728430 (var3412) String)
(declare-fun cast-from-var3984-to-var3412 (var3984) var3412)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var735_info/484404803 (var735 String) void)
(declare-fun cast-from-var3222-to-var735 (var3222) var735)
(declare-fun notifyCheckStatus/796516367 (var213) void)
(declare-const null-var213 var213)
(declare-const null-var3984 var3984)
(declare-const var213-logger var3222)
(declare-const var646 var213) ; Statement: r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager 
(assert (not (= var646 null-var213)))
(declare-const var2793 var3984) ; Statement: r1 := @parameter0: org.apache.dubbo.common.utils.SerializeCheckStatus 
(assert (not (= var2793 null-var3984)))
(declare-const var646!1 var213)
(assert (not (= var646!1 null-var213)))
(assert (= (defaultCheckStatus/-647195865 var646!1) var2793)) ; Statement: r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus defaultCheckStatus> = r1 
(define-const var3795 var3222 var213-logger) ; Statement: $r3 = <org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3946 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3946)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3946!1 String)
(assert (= var3946!1 ""))
(assert true)
(define-const var3601 String (append/672562846 var3946!1 "Serialize check default level: ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialize check default level: ") 
(declare-const var3946!2 String)
(assert (= var3946!2 (str.++ var3946!1 "Serialize check default level: ")))
(assert true)
(define-const var2257 String (name/1633728430 (cast-from-var3984-to-var3412 var2793))) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.utils.SerializeCheckStatus: java.lang.String name()>() 
(assert true)
(define-const var829 String (append/672562846 var3601 var2257)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var3601!1 String)
(assert (= var3601!1 (str.++ var3601 var2257)))
(assert true)
(define-const var2093 String (toString/-2075883882 var829)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var735_info/484404803 (cast-from-var3222-to-var735 var3795) var2093)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7) 

(declare-const var3795!1 var3222)
(declare-const var2093!1 String)
(assert true)
;(assert (notifyCheckStatus/796516367 var646!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: void notifyCheckStatus()>() 

(declare-const var646!2 var213)
 ; Statement: return 
(check-sat)
; {defaultCheckStatus/-647195865=([org.apache.dubbo.common.utils.SerializeSecurityManager], org.apache.dubbo.common.utils.SerializeCheckStatus), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var3984-to-var3412=([org.apache.dubbo.common.utils.SerializeCheckStatus], java.lang.Enum), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var735_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3222-to-var735=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), notifyCheckStatus/796516367=([org.apache.dubbo.common.utils.SerializeSecurityManager], void)}
; {var213=org.apache.dubbo.common.utils.SerializeSecurityManager, var646=r0, var3984=org.apache.dubbo.common.utils.SerializeCheckStatus, var2793=r1, var3222=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3795=$r3, var3946=$r2, var3601=$r5, var3412=java.lang.Enum, var2257=$r4, var829=$r6, var2093=$r7, var735=org.apache.dubbo.common.logger.Logger}
; {org.apache.dubbo.common.utils.SerializeSecurityManager=var213, r0=var646, org.apache.dubbo.common.utils.SerializeCheckStatus=var3984, r1=var2793, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3222, $r3=var3795, $r2=var3946, $r5=var3601, java.lang.Enum=var3412, $r4=var2257, $r6=var829, $r7=var2093, org.apache.dubbo.common.logger.Logger=var735}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.common.utils.SerializeSecurityManager;	r1 := @parameter0: org.apache.dubbo.common.utils.SerializeCheckStatus;	r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.utils.SerializeCheckStatus defaultCheckStatus> = r1;	$r3 = <org.apache.dubbo.common.utils.SerializeSecurityManager: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Serialize check default level: ");	$r4 = virtualinvoke r1.<org.apache.dubbo.common.utils.SerializeCheckStatus: java.lang.String name()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>($r7);	specialinvoke r0.<org.apache.dubbo.common.utils.SerializeSecurityManager: void notifyCheckStatus()>();	return
;block_num 1