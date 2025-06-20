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

(declare-sort var609 0)
(declare-sort var3554 0)
(declare-sort var2565 0)
(declare-sort var143 0)
(declare-sort var745 0)
(declare-sort var2284 0)
(declare-sort var1324 0)
(declare-sort var1840 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getContent/-1672188143 (var3554) String)
(declare-fun var2565_isEmpty/-813097145 (String) Bool)
(declare-fun ruleQueue/-1750759578 (var609) var143)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2284_error/377575788 (var2284 String String String String var1324) void)
(declare-fun cast-from-var745-to-var1324 (var745) var1324)
(declare-fun executorSubmit/-1750759578 (var609) var1840)
(declare-fun compareAndSet/-351715474 (var1840 Bool Bool) Bool)
(declare-const null-var609 var609)
(declare-const null-var3554 var3554)
(declare-const null-var745 var745)
(declare-const var609-logger var2284)
(declare-const var17 var609) ; Statement: r1 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var17 null-var609)))
(declare-const var493 var3554) ; Statement: r0 := @parameter0: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent 
(assert (not (= var493 null-var3554)))
(assert true)
(define-const var3032 String (getContent/-1672188143 var493)) ; Statement: r13 = virtualinvoke r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String getContent()>() 
(define-const var2722 Bool (var2565_isEmpty/-813097145 var3032)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13) 
 ; Statement: if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.LinkedBlockingQueue ruleQueue> 
(assert (= (ite var2722 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3452 var143 (ruleQueue/-1750759578 var17)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.LinkedBlockingQueue ruleQueue> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3658 var745) ; Statement: $r7 := @caughtexception 
(assert (not (= var3658 null-var745)))
(define-const var3185 var2284 var609-logger) ; Statement: $r9 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var3106 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3106)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3106!1 String)
(assert (= var3106!1 ""))
(assert true)
(define-const var3800 String (append/672562846 var3106!1 "Put rawRule to rule management queue failed. rawRule: ")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Put rawRule to rule management queue failed. rawRule: ") 
(declare-const var3106!2 String)
(assert (= var3106!2 (str.++ var3106!1 "Put rawRule to rule management queue failed. rawRule: ")))
(assert true)
(define-const var3963 String (append/672562846 var3800 var3032)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r13) 
(declare-const var3800!1 String)
(assert (= var3800!1 (str.++ var3800 var3032)))
(assert true)
(define-const var1356 String (toString/-2075883882 var3963)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2284_error/377575788 var3185 "0-6" "" "" var1356 (cast-from-var745-to-var1324 var3658))) ; Statement: interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-6", "", "", $r12, $r7) 

(declare-const var3185!1 var2284)
(declare-const var3480 String)
(declare-const var2420 String)
(declare-const var2420!1 String)
(declare-const var1356!1 String)
(declare-const var3658!1 var745)
(assert true) ; Non Conditional
(define-const var145 var1840 (executorSubmit/-1750759578 var17)) ; Statement: $r3 = r1.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.atomic.AtomicBoolean executorSubmit> 
(assert true)
(define-const var1647 Bool (compareAndSet/-351715474 var145 (ite (= 1 0) true false) (ite (= 1 1) true false))) ; Statement: $z1 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicBoolean: boolean compareAndSet(boolean,boolean)>(0, 1) 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var1647 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {getContent/-1672188143=([org.apache.dubbo.common.config.configcenter.ConfigChangedEvent], java.lang.String), var2565_isEmpty/-813097145=([java.lang.String], boolean), ruleQueue/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.util.concurrent.LinkedBlockingQueue), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2284_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var745-to-var1324=([java.lang.InterruptedException], java.lang.Throwable), executorSubmit/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.util.concurrent.atomic.AtomicBoolean), compareAndSet/-351715474=([java.util.concurrent.atomic.AtomicBoolean, boolean, boolean], boolean)}
; {var609=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var17=r1, var3554=org.apache.dubbo.common.config.configcenter.ConfigChangedEvent, var493=r0, var3032=r13, var2565=org.apache.dubbo.common.utils.StringUtils, var2722=$z0, var143=java.util.concurrent.LinkedBlockingQueue, var3452=$r2, var745=java.lang.InterruptedException, var3658=$r7, var2284=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3185=$r9, var3106=$r8, var3800=$r10, var3963=$r11, var1356=$r12, var1324=java.lang.Throwable, var3480="0-6", var2420="", var1840=java.util.concurrent.atomic.AtomicBoolean, var145=$r3, var1647=$z1}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var609, r1=var17, org.apache.dubbo.common.config.configcenter.ConfigChangedEvent=var3554, r0=var493, r13=var3032, org.apache.dubbo.common.utils.StringUtils=var2565, $z0=var2722, java.util.concurrent.LinkedBlockingQueue=var143, $r2=var3452, java.lang.InterruptedException=var745, $r7=var3658, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var2284, $r9=var3185, $r8=var3106, $r10=var3800, $r11=var3963, $r12=var1356, java.lang.Throwable=var1324, "0-6"=var3480, ""=var2420, java.util.concurrent.atomic.AtomicBoolean=var1840, $r3=var145, $z1=var1647}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r0 := @parameter0: org.apache.dubbo.common.config.configcenter.ConfigChangedEvent;	r13 = virtualinvoke r0.<org.apache.dubbo.common.config.configcenter.ConfigChangedEvent: java.lang.String getContent()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r13);	if $z0 == 0 goto $r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.LinkedBlockingQueue ruleQueue>;	$r2 = r1.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.LinkedBlockingQueue ruleQueue>;	$r7 := @caughtexception;	$r9 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Put rawRule to rule management queue failed. rawRule: ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r13);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r9.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-6", "", "", $r12, $r7);	$r3 = r1.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.atomic.AtomicBoolean executorSubmit>;	$z1 = virtualinvoke $r3.<java.util.concurrent.atomic.AtomicBoolean: boolean compareAndSet(boolean,boolean)>(0, 1);	if $z1 == 0 goto return;	return
;block_num 5