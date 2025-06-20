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

(declare-sort var3826 0)
(declare-sort var2813 0)
(declare-sort var583 0)
(declare-sort var3705 0)
(declare-sort var1397 0)
(declare-sort var3576 0)
(declare-sort var3615 0)
(declare-sort var931 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerUrl/1343906212 (var3826) var3705)
(declare-fun getDelay/-515333076 (var2813 var3705) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun logger/1343906212 (var3826) var3615)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var931) String)
(declare-fun cast-from-var3576-to-var931 (var3576) var931)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3615_error/-110665684 (var3615 String String String String) void)
(declare-const null-var3826 var3826)
(declare-const null-var2813 var2813)
(declare-const null-var583 var583)
(declare-const var1397-SECONDS var1397)
(declare-const null-var3576 var3576)
(declare-const var298 var3826) ; Statement: r1 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker 
(assert (not (= var298 null-var3826)))
(declare-const var220 var2813) ; Statement: r0 := @parameter0: org.apache.dubbo.registry.client.migration.model.MigrationRule 
(assert (not (= var220 null-var2813)))
(declare-const var3399 var583) ; Statement: r3 := @parameter1: java.util.concurrent.CountDownLatch 
(assert (not (= var3399 null-var583)))
(define-const var61 var3705 (consumerUrl/1343906212 var298)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL consumerUrl> 
(assert true)
(define-const var936 Int (getDelay/-515333076 var220 var61)) ; Statement: i2 = virtualinvoke r0.<org.apache.dubbo.registry.client.migration.model.MigrationRule: int getDelay(org.apache.dubbo.common.URL)>($r2) 
 ; Statement: if i2 <= 0 goto i2 = 0 
(assert (<= var936 0)) ; Cond: i2 <= 0 
(define-const var936!1 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var2876 Int (cast-from-Int-to-Int var936!1)) ; Statement: $l3 = (long) i2 
(define-const var3025 var1397 var1397-SECONDS) ; Statement: $r16 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit SECONDS> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3081 var3576) ; Statement: $r4 := @caughtexception 
(assert (not (= var3081 null-var3576)))
(define-const var3756 var3615 (logger/1343906212 var298)) ; Statement: $r6 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var1190 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1190)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1190!1 String)
(assert (= var1190!1 ""))
(assert true)
(define-const var1296 String (append/672562846 var1190!1 "Interrupted when waiting for address notify!")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Interrupted when waiting for address notify!") 
(declare-const var1190!2 String)
(assert (= var1190!2 (str.++ var1190!1 "Interrupted when waiting for address notify!")))
(assert true)
(define-const var276 String (append/-1031950772 var1296 (cast-from-var3576-to-var931 var3081))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var1296!1 String)
(assert (str.prefixof var1296 var1296!1))
(assert true)
(define-const var3964 String (toString/-2075883882 var276)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3615_error/-110665684 var3756 "1-7" "" "" var3964)) ; Statement: interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-7", "", "", $r9) 

(declare-const var3756!1 var3615)
(declare-const var338 String)
(declare-const var2407 String)
(declare-const var2407!1 String)
(declare-const var3964!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {consumerUrl/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.URL), getDelay/-515333076=([org.apache.dubbo.registry.client.migration.model.MigrationRule, org.apache.dubbo.common.URL], int), cast-from-Int-to-Int=([int], long), logger/1343906212=([org.apache.dubbo.registry.client.migration.MigrationInvoker], org.apache.dubbo.common.logger.ErrorTypeAwareLogger), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3576-to-var931=([java.lang.InterruptedException], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3615_error/-110665684=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var3826=org.apache.dubbo.registry.client.migration.MigrationInvoker, var298=r1, var2813=org.apache.dubbo.registry.client.migration.model.MigrationRule, var220=r0, var583=java.util.concurrent.CountDownLatch, var3399=r3, var3705=org.apache.dubbo.common.URL, var61=$r2, var936=i2, var2876=$l3, var1397=java.util.concurrent.TimeUnit, var3025=$r16, var3576=java.lang.InterruptedException, var3081=$r4, var3615=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3756=$r6, var1190=$r5, var1296=$r7, var931=java.lang.Object, var276=$r8, var3964=$r9, var338="1-7", var2407=""}
; {org.apache.dubbo.registry.client.migration.MigrationInvoker=var3826, r1=var298, org.apache.dubbo.registry.client.migration.model.MigrationRule=var2813, r0=var220, java.util.concurrent.CountDownLatch=var583, r3=var3399, org.apache.dubbo.common.URL=var3705, $r2=var61, i2=var936, $l3=var2876, java.util.concurrent.TimeUnit=var1397, $r16=var3025, java.lang.InterruptedException=var3576, $r4=var3081, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3615, $r6=var3756, $r5=var1190, $r7=var1296, java.lang.Object=var931, $r8=var276, $r9=var3964, "1-7"=var338, ""=var2407}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.migration.MigrationInvoker;	r0 := @parameter0: org.apache.dubbo.registry.client.migration.model.MigrationRule;	r3 := @parameter1: java.util.concurrent.CountDownLatch;	$r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.URL consumerUrl>;	i2 = virtualinvoke r0.<org.apache.dubbo.registry.client.migration.model.MigrationRule: int getDelay(org.apache.dubbo.common.URL)>($r2);	if i2 <= 0 goto i2 = 0;	i2 = 0;	$l3 = (long) i2;	$r16 = <java.util.concurrent.TimeUnit: java.util.concurrent.TimeUnit SECONDS>;	$r4 := @caughtexception;	$r6 = r1.<org.apache.dubbo.registry.client.migration.MigrationInvoker: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Interrupted when waiting for address notify!");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r6.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-7", "", "", $r9);	return
;block_num 5