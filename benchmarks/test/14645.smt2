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

(declare-sort var2964 0)
(declare-sort var3278 0)
(declare-sort var164 0)
(declare-sort var1550 0)
(declare-sort var1821 0)
(declare-sort var3286 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rule/-1750759578 (var2964) var164)
(declare-fun var164_getInitRule/1239212575 () var164)
(declare-fun var1821_error/377575788 (var1821 String String String String var3286) void)
(declare-fun cast-from-var1550-to-var3286 (var1550) var3286)
(declare-const null-var2964 var2964)
(declare-const null-String String)
(declare-const null-var164 var164)
(declare-const null-var1550 var1550)
(declare-const var2964-logger var1821)
(declare-const var2208 var2964) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var2208 null-var2964)))
(declare-const var3044 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3044 null-String)))
(define-const var716 var164 (rule/-1750759578 var2208)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
 ; Statement: if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
(assert (not (not (= var716 null-var164)))) ; Negate: Cond: $r1 != null  
(define-const var2840 var164 var164_getInitRule/1239212575) ; Statement: $r6 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>() 
 ; Statement: goto [?= r7 = $r6] 
(assert true) ; Non Conditional
(define-const var2728 var164 var2840) ; Statement: r7 = $r6 
(define-const var3156 String "INIT") ; Statement: $r3 = "INIT" 
(assert true)
(define-const var2970 Bool (= var3156 var3044)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2) 
(assert (not (= (ite var2970 1 0) 0))) ; Negate: Cond: $z0 == 0  
(declare-const var1604 var1550) ; Statement: $r4 := @caughtexception 
(assert (not (= var1604 null-var1550)))
(define-const var2885 var1821 var2964-logger) ; Statement: $r5 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
;(assert (var1821_error/377575788 var2885 "0-2" "" "" "Failed to parse migration rule..." (cast-from-var1550-to-var3286 var1604))) ; Statement: interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-2", "", "", "Failed to parse migration rule...", $r4) 

(declare-const var2885!1 var1821)
(declare-const var3959 String)
(declare-const var497 String)
(declare-const var497!1 String)
(declare-const var2080 String)
(declare-const var1604!1 var1550)
(assert true) ; Non Conditional
 ; Statement: return r7 
(check-sat)
; {rule/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.registry.client.migration.model.MigrationRule), var164_getInitRule/1239212575=([], org.apache.dubbo.registry.client.migration.model.MigrationRule), var1821_error/377575788=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), cast-from-var1550-to-var3286=([java.lang.Exception], java.lang.Throwable)}
; {var2964=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var2208=r0, var3044=r2, var3278=null_type, var164=org.apache.dubbo.registry.client.migration.model.MigrationRule, var716=$r1, var2840=$r6, var2728=r7, var3156=$r3, var2970=$z0, var1550=java.lang.Exception, var1604=$r4, var1821=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2885=$r5, var3286=java.lang.Throwable, var3959="0-2", var497="", var2080="Failed to parse migration rule..."}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var2964, r0=var2208, r2=var3044, null_type=var3278, org.apache.dubbo.registry.client.migration.model.MigrationRule=var164, $r1=var716, $r6=var2840, r7=var2728, $r3=var3156, $z0=var2970, java.lang.Exception=var1550, $r4=var1604, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var1821, $r5=var2885, java.lang.Throwable=var3286, "0-2"=var3959, ""=var497, "Failed to parse migration rule..."=var2080}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	$r6 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>();	goto [?= r7 = $r6];	r7 = $r6;	$r3 = "INIT";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2);	$r4 := @caughtexception;	$r5 = <org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	interfaceinvoke $r5.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void error(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("0-2", "", "", "Failed to parse migration rule...", $r4);	return r7
;block_num 5