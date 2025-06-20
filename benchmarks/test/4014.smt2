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

(declare-sort var12 0)
(declare-sort var3258 0)
(declare-sort var225 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3258!class ClassObject)
(declare-fun var12_simpleClassName/822183132 (ClassObject) String)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var225_error/-110665684 (var225 String String String String) void)
(declare-const var3258-logger var225)
(define-const var2067 String (var12_simpleClassName/822183132 var3258!class)) ; Statement: r0 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String simpleClassName(java.lang.Class)>(class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;") 
(define-const var2337 var225 var3258-logger) ; Statement: $r2 = <org.apache.dubbo.common.timer.HashedWheelTimer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1148 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1148)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1148!1 String)
(assert (= var1148!1 ""))
(assert true)
(define-const var3267 String (append/672562846 var1148!1 "You are creating too many ")) ; Statement: $r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("You are creating too many ") 
(declare-const var1148!2 String)
(assert (= var1148!2 (str.++ var1148!1 "You are creating too many ")))
(assert true)
(define-const var275 String (append/672562846 var3267 var2067)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var3267!1 String)
(assert (= var3267!1 (str.++ var3267 var2067)))
(assert true)
(define-const var1960 String (append/672562846 var275 " instances. ")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" instances. ") 
(declare-const var275!1 String)
(assert (= var275!1 (str.++ var275 " instances. ")))
(assert true)
(define-const var1984 String (append/672562846 var1960 var2067)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1960!1 String)
(assert (= var1960!1 (str.++ var1960 var2067)))
(assert true)
(define-const var488 String (append/672562846 var1984 " is a shared resource that must be reused across the JVM, so that only a few instances are created.")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is a shared resource that must be reused across the JVM, so that only a few instances are created.") 
(declare-const var1984!1 String)
(assert (= var1984!1 (str.++ var1984 " is a shared resource that must be reused across the JVM, so that only a few instances are created.")))
(assert true)
(define-const var59 String (toString/-2075883882 var488)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var225_error/-110665684 var2337 "0-21" "" "" var59)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-21", "", "", $r8) 

(declare-const var2337!1 var225)
(declare-const var2659 String)
(declare-const var825 String)
(declare-const var825!1 String)
(declare-const var59!1 String)
 ; Statement: return 
(check-sat)
; {var12_simpleClassName/822183132=([java.lang.Class], java.lang.String), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var225_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var12=org.apache.dubbo.common.utils.ClassUtils, var3258=org.apache.dubbo.common.timer.HashedWheelTimer, var2067=r0, var225=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2337=$r2, var1148=$r1, var3267=$r3, var275=$r4, var1960=$r5, var1984=$r6, var488=$r7, var59=$r8, var2659="0-21", var825=""}
; {org.apache.dubbo.common.utils.ClassUtils=var12, org.apache.dubbo.common.timer.HashedWheelTimer=var3258, r0=var2067, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var225, $r2=var2337, $r1=var1148, $r3=var3267, $r4=var275, $r5=var1960, $r6=var1984, $r7=var488, $r8=var59, "0-21"=var2659, ""=var825}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 = staticinvoke <org.apache.dubbo.common.utils.ClassUtils: java.lang.String simpleClassName(java.lang.Class)>(class "Lorg/apache/dubbo/common/timer/HashedWheelTimer;");	$r2 = <org.apache.dubbo.common.timer.HashedWheelTimer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("You are creating too many ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" instances. ");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" is a shared resource that must be reused across the JVM, so that only a few instances are created.");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-21", "", "", $r8);	return
;block_num 1