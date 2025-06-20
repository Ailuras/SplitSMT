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

(declare-sort var1492 0)
(declare-sort var349 0)
(declare-sort var1710 0)
(declare-sort var2032 0)
(declare-sort var3299 0)
(declare-sort var3595 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rule/-1750759578 (var1492) var1710)
(declare-fun var3299_error/377575788 (var3299 String String String String var3595) void)
(declare-fun cast-from-var2032-to-var3595 (var2032) var3595)
(declare-const null-var1492 var1492)
(declare-const null-String String)
(declare-const null-var1710 var1710)
(declare-const null-var2032 var2032)
(declare-const var1492-logger var3299)
(declare-const var250 var1492) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var250 null-var1492)))
(declare-const var1964 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1964 null-String)))
(define-const var1858 var1710 (rule/-1750759578 var250)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
 ; Statement: if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
(assert (not (= var1858 null-var1710))) ; Cond: $r1 != null 
(define-const var443 var1710 (rule/-1750759578 var250)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
(assert true) ; Non Conditional
(define-const var2230 var1710 var443) ; Statement: r7 = $r6 
(define-const var1707 String "INIT") ; Statement: $r3 = "INIT" 
(assert true)
(define-const var3385 Bool (= var1707 var1964)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2) 
(assert (not (= (ite var3385 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var2495 var2032) ; Statement: $r4 := @caughtexception 
(assert (not (= var2495 null-var2032)))
(define-const var798 var3299 var1492-logger) ; Statement: $r5 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var3299_error/377575788 var798 "0-2" "" "" "Failed to parse migration rule..." (cast-from-var2032-to-var3595 var2495))) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-2", "", "", "Failed to parse migration rule...", $r4) 

(declare-const var798!1 var3299)
(declare-const var2368 String)
(declare-const var2384 String)
(declare-const var2384!1 String)
(declare-const var3255 String)
(declare-const var2495!1 var2032)
(assert true) ; Non Conditional
 ; Statement: return r7 
(check-sat)
; {rule/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.registry.client.migration.model.MigrationRule), var3299_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var2032-to-var3595=([java.lang.Exception], java.lang.Throwable)}
; {var1492=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var250=r0, var1964=r2, var349=null_type, var1710=org.apache.dubbo.registry.client.migration.model.MigrationRule, var1858=$r1, var443=$r6, var2230=r7, var1707=$r3, var3385=$z0, var2032=java.lang.Exception, var2495=$r4, var3299=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var798=$r5, var3595=java.lang.Throwable, var2368="0-2", var2384="", var3255="Failed to parse migration rule..."}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var1492, r0=var250, r2=var1964, null_type=var349, org.apache.dubbo.registry.client.migration.model.MigrationRule=var1710, $r1=var1858, $r6=var443, r7=var2230, $r3=var1707, $z0=var3385, java.lang.Exception=var2032, $r4=var2495, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3299, $r5=var798, java.lang.Throwable=var3595, "0-2"=var2368, ""=var2384, "Failed to parse migration rule..."=var3255}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	$r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	r7 = $r6;	$r3 = "INIT";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2);	$r4 := @caughtexception;	$r5 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-2", "", "", "Failed to parse migration rule...", $r4);	return r7
;block_num 5