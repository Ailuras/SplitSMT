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

(declare-sort var3933 0)
(declare-sort var10 0)
(declare-sort var3476 0)
(declare-sort var3599 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var10) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3476_error/377575788 (var3476 String String String String var10) void)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var10 var10)
(declare-const var3599-logger var3476)
(declare-const var577 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var577 null-ClassObject)))
(declare-const var468 String) ; Statement: r4 := @parameter1: java.lang.String 
(assert (not (= var468 null-String)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1216 var10) ; Statement: $r22 := @caughtexception 
(assert (not (= var1216 null-var10)))
(define-const var3182 var3476 var3599-logger) ; Statement: $r24 = <org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3979 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3979)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3979!1 String)
(assert (= var3979!1 ""))
(assert true)
(define-const var219 String (append/672562846 var3979!1 "return default version, ignore exception ")) ; Statement: $r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("return default version, ignore exception ") 
(declare-const var3979!2 String)
(assert (= var3979!2 (str.++ var3979!1 "return default version, ignore exception ")))
(assert true)
(define-const var2393 String (getMessage/849299655 var1216)) ; Statement: $r25 = virtualinvoke $r22.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var3030 String (append/672562846 var219 var2393)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var219!1 String)
(assert (= var219!1 (str.++ var219 var2393)))
(assert true)
(define-const var224 String (toString/-2075883882 var3030)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3476_error/377575788 var3182 "0-12" "" "" var224 var1216)) ; Statement: interfaceinvoke $r24.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-12", "", "", $r28, $r22) 

(declare-const var3182!1 var3476)
(declare-const var3401 String)
(declare-const var1630 String)
(declare-const var1630!1 String)
(declare-const var224!1 String)
(declare-const var1216!1 var10)
 ; Statement: return r4 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3476_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var577=r0, var468=r4, var3933=null_type, var10=java.lang.Throwable, var1216=$r22, var3476=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3599=org.apache.dubbo.common.Version, var3182=$r24, var3979=$r23, var219=$r26, var2393=$r25, var3030=$r27, var224=$r28, var3401="0-12", var1630=""}
; {r0=var577, r4=var468, null_type=var3933, java.lang.Throwable=var10, $r22=var1216, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3476, org.apache.dubbo.common.Version=var3599, $r24=var3182, $r23=var3979, $r26=var219, $r25=var2393, $r27=var3030, $r28=var224, "0-12"=var3401, ""=var1630}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r4 := @parameter1: java.lang.String;	$r22 := @caughtexception;	$r24 = <org.apache.dubbo.common.Version: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r26 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("return default version, ignore exception ");	$r25 = virtualinvoke $r22.<java.lang.Throwable: java.lang.String getMessage()>();	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r24.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-12", "", "", $r28, $r22);	return r4
;block_num 2