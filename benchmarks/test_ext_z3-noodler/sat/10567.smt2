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

(declare-sort var2348 0)
(declare-sort var1344 0)
(declare-sort var645 0)
(declare-sort var956 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMessage/849299655 (var1344) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var645_warn/1431914100 (var645 String String String String) void)
(declare-const null-var2348 var2348)
(declare-const null-var1344 var1344)
(declare-const var956-logger var645)
(declare-const var3183 var2348) ; Statement: r0 := @parameter0: java.lang.Runnable 
(assert (not (= var3183 null-var2348)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1984 var1344) ; Statement: $r1 := @caughtexception 
(assert (not (= var1984 null-var1344)))
(define-const var2154 var645 var956-logger) ; Statement: $r3 = <org.apache.dubbo.metrics.event.MetricsEventBus: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3506 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3506)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3506!1 String)
(assert (= var3506!1 ""))
(assert true)
(define-const var2259 String (append/672562846 var3506!1 "invoke metric event error")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("invoke metric event error") 
(declare-const var3506!2 String)
(assert (= var3506!2 (str.++ var3506!1 "invoke metric event error")))
(assert true)
(define-const var867 String (getMessage/849299655 var1984)) ; Statement: $r4 = virtualinvoke $r1.<java.lang.Throwable: java.lang.String getMessage()>() 
(assert true)
(define-const var1513 String (append/672562846 var2259 var867)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2259!1 String)
(assert (= var2259!1 (str.++ var2259 var867)))
(assert true)
(define-const var1432 String (toString/-2075883882 var1513)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var645_warn/1431914100 var2154 "0-13" "" "" var1432)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-13", "", "", $r7) 

(declare-const var2154!1 var645)
(declare-const var2502 String)
(declare-const var3524 String)
(declare-const var3524!1 String)
(declare-const var1432!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMessage/849299655=([java.lang.Throwable], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var645_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var2348=java.lang.Runnable, var3183=r0, var1344=java.lang.Throwable, var1984=$r1, var645=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var956=org.apache.dubbo.metrics.event.MetricsEventBus, var2154=$r3, var3506=$r2, var2259=$r5, var867=$r4, var1513=$r6, var1432=$r7, var2502="0-13", var3524=""}
; {java.lang.Runnable=var2348, r0=var3183, java.lang.Throwable=var1344, $r1=var1984, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var645, org.apache.dubbo.metrics.event.MetricsEventBus=var956, $r3=var2154, $r2=var3506, $r5=var2259, $r4=var867, $r6=var1513, $r7=var1432, "0-13"=var2502, ""=var3524}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.Runnable;	$r1 := @caughtexception;	$r3 = <org.apache.dubbo.metrics.event.MetricsEventBus: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("invoke metric event error");	$r4 = virtualinvoke $r1.<java.lang.Throwable: java.lang.String getMessage()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("0-13", "", "", $r7);	return
;block_num 3