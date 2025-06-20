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

(declare-sort var3985 0)
(declare-sort var2729 0)
(declare-sort var1242 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun serviceKey/2129308851 (var3985) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var1242_warn/126438324 (var1242 String String String String var2729) void)
(declare-const null-var3985 var3985)
(declare-const null-var2729 var2729)
(declare-const var3985-logger var1242)
(declare-const var3829 var3985) ; Statement: r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory 
(assert (not (= var3829 null-var3985)))
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1632 var2729) ; Statement: $r1 := @caughtexception 
(assert (not (= var1632 null-var2729)))
(define-const var565 var1242 var3985-logger) ; Statement: $r3 = <org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3627 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3627)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3627!1 String)
(assert (= var3627!1 ""))
(assert true)
(define-const var1333 String (append/672562846 var3627!1 "Failed to destroy service ")) ; Statement: $r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to destroy service ") 
(declare-const var3627!2 String)
(assert (= var3627!2 (str.++ var3627!1 "Failed to destroy service ")))
(define-const var3244 String (serviceKey/2129308851 var3829)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: java.lang.String serviceKey> 
(assert true)
(define-const var162 String (append/672562846 var1333 var3244)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1333!1 String)
(assert (= var1333!1 (str.++ var1333 var3244)))
(assert true)
(define-const var3216 String (toString/-2075883882 var162)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var1242_warn/126438324 var565 "1-15" "" "" var3216 var1632)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-15", "", "", $r7, $r1) 

(declare-const var565!1 var1242)
(declare-const var214 String)
(declare-const var1731 String)
(declare-const var1731!1 String)
(declare-const var3216!1 String)
(declare-const var1632!1 var2729)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), serviceKey/2129308851=([org.apache.dubbo.registry.integration.DynamicDirectory], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var1242_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void)}
; {var3985=org.apache.dubbo.registry.integration.DynamicDirectory, var3829=r0, var2729=java.lang.Throwable, var1632=$r1, var1242=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var565=$r3, var3627=$r2, var1333=$r5, var3244=$r4, var162=$r6, var3216=$r7, var214="1-15", var1731=""}
; {org.apache.dubbo.registry.integration.DynamicDirectory=var3985, r0=var3829, java.lang.Throwable=var2729, $r1=var1632, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1242, $r3=var565, $r2=var3627, $r5=var1333, $r4=var3244, $r6=var162, $r7=var3216, "1-15"=var214, ""=var1731}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.integration.DynamicDirectory;	$r1 := @caughtexception;	$r3 = <org.apache.dubbo.registry.integration.DynamicDirectory: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Failed to destroy service ");	$r4 = r0.<org.apache.dubbo.registry.integration.DynamicDirectory: java.lang.String serviceKey>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("1-15", "", "", $r7, $r1);	return
;block_num 3