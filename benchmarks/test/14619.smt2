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

(declare-sort var2976 0)
(declare-sort var3195 0)
(declare-sort var1102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rule/-1750759578 (var2976) var1102)
(declare-fun var1102_getInitRule/1239212575 () var1102)
(declare-const null-var2976 var2976)
(declare-const null-String String)
(declare-const null-var1102 var1102)
(declare-const var2551 var2976) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var2551 null-var2976)))
(declare-const var1259 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1259 null-String)))
(define-const var2999 var1102 (rule/-1750759578 var2551)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
 ; Statement: if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
(assert (not (not (= var2999 null-var1102)))) ; Negate: Cond: $r1 != null  
(define-const var1338 var1102 var1102_getInitRule/1239212575) ; Statement: $r6 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>() 
 ; Statement: goto [?= r7 = $r6] 
(assert true) ; Non Conditional
(define-const var1379 var1102 var1338) ; Statement: r7 = $r6 
(define-const var2094 String "INIT") ; Statement: $r3 = "INIT" 
(assert true)
(define-const var2224 Bool (= var2094 var1259)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2) 
(assert (not (= (ite var2224 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1379!1 var1102 var1102_getInitRule/1239212575) ; Statement: r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>() 
 ; Statement: goto [?= return r7] 
(assert true) ; Non Conditional
 ; Statement: return r7 
(check-sat)
; {rule/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.registry.client.migration.model.MigrationRule), var1102_getInitRule/1239212575=([], org.apache.dubbo.registry.client.migration.model.MigrationRule)}
; {var2976=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var2551=r0, var1259=r2, var3195=null_type, var1102=org.apache.dubbo.registry.client.migration.model.MigrationRule, var2999=$r1, var1338=$r6, var1379=r7, var2094=$r3, var2224=$z0}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var2976, r0=var2551, r2=var1259, null_type=var3195, org.apache.dubbo.registry.client.migration.model.MigrationRule=var1102, $r1=var2999, $r6=var1338, r7=var1379, $r3=var2094, $z0=var2224}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	$r6 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>();	goto [?= r7 = $r6];	r7 = $r6;	$r3 = "INIT";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2);	r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>();	goto [?= return r7];	return r7
;block_num 5