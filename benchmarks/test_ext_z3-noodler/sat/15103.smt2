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

(declare-sort var41 0)
(declare-sort var692 0)
(declare-sort var2834 0)
(declare-sort var3114 0)
(declare-sort var1394 0)
(declare-sort var736 0)
(declare-sort var1044 0)
(declare-sort var3043 0)
(declare-sort var3630 0)
(declare-sort var3592 0)
(declare-sort var950 0)
(declare-sort var730 0)
(declare-sort var678 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun ruleQueue/-1750759578 (var41) var692)
(declare-fun var3114_error/377575788 (var3114 String String String String var1394) void)
(declare-fun cast-from-var2834-to-var1394 (var2834) var1394)
(declare-fun var736_isEmpty/-813097145 (String) Bool)
(declare-fun rawRule/-1750759578 (var41) String)
(declare-fun var1044_equals/1031735566 (var3043 var3043) Bool)
(declare-fun cast-from-String-to-var3043 (String) var3043)
(declare-fun var3630_info/484404803 (var3630 String) void)
(declare-fun cast-from-var3114-to-var3630 (var3114) var3630)
(declare-fun setRawRule/-1973426308 (var41 String) void)
(declare-fun handlers/-1750759578 (var41) var3592)
(declare-fun var950_isEmptyMap/212689853 (var730) Bool)
(declare-fun cast-from-var3592-to-var730 (var3592) var730)
(declare-const null-var41 var41)
(declare-const null-var2834 var2834)
(declare-const var41-logger var3114)
(declare-const null-var678 var678)
(declare-const null-var1394 var1394)
(declare-const var557 var41) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var557 null-var41)))
(assert true) ; Non Conditional
(define-const var1561 String "") ; Statement: r25 = "" 
(define-const var1841 var692 (ruleQueue/-1750759578 var557)) ; Statement: $r26 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.LinkedBlockingQueue ruleQueue> 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var1206 var2834) ; Statement: $r23 := @caughtexception 
(assert (not (= var1206 null-var2834)))
(define-const var1876 var3114 var41-logger) ; Statement: $r24 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3114_error/377575788 var1876 "0-6" "" "" "Poll Rule from config center failed." (cast-from-var2834-to-var1394 var1206))) ; Statement: interfaceinvoke $r24.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-6", "", "", "Poll Rule from config center failed.", $r23) 

(declare-const var1876!1 var3114)
(declare-const var1104 String)
(declare-const var152 String)
(declare-const var152!1 String)
(declare-const var1400 String)
(declare-const var1206!1 var2834)
(assert true) ; Non Conditional
(define-const var405 Bool (var736_isEmpty/-813097145 var1561)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r25) 
 ; Statement: if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String rawRule> 
(assert (= (ite var405 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2435 String (rawRule/-1750759578 var557)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String rawRule> 
(define-const var3478 Bool (var1044_equals/1031735566 (cast-from-String-to-var3043 var2435) (cast-from-String-to-var3043 var1561))) ; Statement: $z1 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>($r1, r25) 
 ; Statement: if $z1 == 0 goto $r2 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (= (ite var3478 1 0) 0)) ; Cond: $z1 == 0 
(define-const var742 var3114 var41-logger) ; Statement: $r2 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3630_info/484404803 (cast-from-var3114-to-var3630 var742) "Using the following migration rule to migrate:")) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>("Using the following migration rule to migrate:") 

(declare-const var742!1 var3114)
(declare-const var1223 String)
(define-const var1499 var3114 var41-logger) ; Statement: $r3 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3630_info/484404803 (cast-from-var3114-to-var3630 var1499) var1561)) ; Statement: interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>(r25) 

(declare-const var1499!1 var3114)
(declare-const var1561!1 String)
(assert true)
;(assert (setRawRule/-1973426308 var557 var1561!1)) ; Statement: virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>(r25) 

(declare-const var557!1 var41)
(declare-const var1561!2 String)
(define-const var2710 var3592 (handlers/-1750759578 var557!1)) ; Statement: $r4 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.ConcurrentMap handlers> 
(define-const var3321 Bool (var950_isEmptyMap/212689853 (cast-from-var3592-to-var730 var2710))) ; Statement: $z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmptyMap(java.util.Map)>($r4) 
 ; Statement: if $z2 == 0 goto r29 = null 
(assert (= (ite var3321 1 0) 0)) ; Cond: $z2 == 0 
(define-const var3055 var678 null-var678) ; Statement: r29 = null 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3690 var1394) ; Statement: $r15 := @caughtexception 
(assert (not (= var3690 null-var1394)))
(assert true) ; Non Conditional
 ; Statement: if r29 == null goto throw $r15 
(assert (= var3055 null-var678)) ; Cond: r29 == null 
 ; Statement: throw $r15 
(check-sat)
; {ruleQueue/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.util.concurrent.LinkedBlockingQueue), var3114_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2834-to-var1394=([java.lang.InterruptedException], java.lang.Throwable), var736_isEmpty/-813097145=([java.lang.String], boolean), rawRule/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.lang.String), var1044_equals/1031735566=([java.lang.Object, java.lang.Object], boolean), cast-from-String-to-var3043=([java.lang.String], java.lang.Object), var3630_info/484404803=([org.apache.dubbo.common.logger.Logger, java.lang.String], void), cast-from-var3114-to-var3630=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger], org.apache.dubbo.common.logger.Logger), setRawRule/-1973426308=([org.apache.dubbo.registry.client.migration.MigrationRuleListener, java.lang.String], void), handlers/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.util.concurrent.ConcurrentMap), var950_isEmptyMap/212689853=([java.util.Map], boolean), cast-from-var3592-to-var730=([java.util.concurrent.ConcurrentMap], java.util.Map)}
; {var41=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var557=r0, var1561=r25, var692=java.util.concurrent.LinkedBlockingQueue, var1841=$r26, var2834=java.lang.InterruptedException, var1206=$r23, var3114=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1876=$r24, var1394=java.lang.Throwable, var1104="0-6", var152="", var1400="Poll Rule from config center failed.", var736=org.apache.dubbo.common.utils.StringUtils, var405=$z0, var2435=$r1, var1044=java.util.Objects, var3043=java.lang.Object, var3478=$z1, var742=$r2, var3630=org.apache.dubbo.common.logger.Logger, var1223="Using the following migration rule to migrate:", var1499=$r3, var3592=java.util.concurrent.ConcurrentMap, var2710=$r4, var950=org.apache.dubbo.common.utils.CollectionUtils, var730=java.util.Map, var3321=$z2, var678=java.util.concurrent.ExecutorService, var3055=r29, var3690=$r15}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var41, r0=var557, r25=var1561, java.util.concurrent.LinkedBlockingQueue=var692, $r26=var1841, java.lang.InterruptedException=var2834, $r23=var1206, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3114, $r24=var1876, java.lang.Throwable=var1394, "0-6"=var1104, ""=var152, "Poll Rule from config center failed."=var1400, org.apache.dubbo.common.utils.StringUtils=var736, $z0=var405, $r1=var2435, java.util.Objects=var1044, java.lang.Object=var3043, $z1=var3478, $r2=var742, org.apache.dubbo.common.logger.Logger=var3630, "Using the following migration rule to migrate:"=var1223, $r3=var1499, java.util.concurrent.ConcurrentMap=var3592, $r4=var2710, org.apache.dubbo.common.utils.CollectionUtils=var950, java.util.Map=var730, $z2=var3321, java.util.concurrent.ExecutorService=var678, r29=var3055, $r15=var3690}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r25 = "";	$r26 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.LinkedBlockingQueue ruleQueue>;	$r23 := @caughtexception;	$r24 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r24.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-6", "", "", "Poll Rule from config center failed.", $r23);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r25);	if $z0 == 0 goto $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String rawRule>;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String rawRule>;	$z1 = staticinvoke <java.util.Objects: boolean equals(java.lang.Object,java.lang.Object)>($r1, r25);	if $z1 == 0 goto $r2 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>("Using the following migration rule to migrate:");	$r3 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r3.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void info(java.lang.String)>(r25);	virtualinvoke r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: void setRawRule(java.lang.String)>(r25);	$r4 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.util.concurrent.ConcurrentMap handlers>;	$z2 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isEmptyMap(java.util.Map)>($r4);	if $z2 == 0 goto r29 = null;	r29 = null;	$r15 := @caughtexception;	if r29 == null goto throw $r15;	throw $r15
;block_num 10