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

(declare-sort var3156 0)
(declare-sort var3596 0)
(declare-sort var2818 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rule/-1750759578 (var3156) var2818)
(declare-fun var2818_getInitRule/1239212575 () var2818)
(declare-const null-var3156 var3156)
(declare-const null-String String)
(declare-const null-var2818 var2818)
(declare-const var2002 var3156) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var2002 null-var3156)))
(declare-const var540 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var540 null-String)))
(define-const var45 var2818 (rule/-1750759578 var2002)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
 ; Statement: if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
(assert (not (= var45 null-var2818))) ; Cond: $r1 != null 
(define-const var23 var2818 (rule/-1750759578 var2002)) ; Statement: $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule> 
(assert true) ; Non Conditional
(define-const var3176 var2818 var23) ; Statement: r7 = $r6 
(define-const var2159 String "INIT") ; Statement: $r3 = "INIT" 
(assert true)
(define-const var2934 Bool (= var2159 var540)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2) 
 ; Statement: if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2) 
(assert (not (= (ite var2934 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3176!1 var2818 var2818_getInitRule/1239212575) ; Statement: r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>() 
 ; Statement: goto [?= return r7] 
(assert true) ; Non Conditional
 ; Statement: return r7 
(check-sat)
; {rule/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], org.apache.dubbo.registry.client.migration.model.MigrationRule), var2818_getInitRule/1239212575=([], org.apache.dubbo.registry.client.migration.model.MigrationRule)}
; {var3156=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var2002=r0, var540=r2, var3596=null_type, var2818=org.apache.dubbo.registry.client.migration.model.MigrationRule, var45=$r1, var23=$r6, var3176=r7, var2159=$r3, var2934=$z0}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var3156, r0=var2002, r2=var540, null_type=var3596, org.apache.dubbo.registry.client.migration.model.MigrationRule=var2818, $r1=var45, $r6=var23, r7=var3176, $r3=var2159, $z0=var2934}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r2 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	if $r1 != null goto $r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	$r6 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: org.apache.dubbo.registry.client.migration.model.MigrationRule rule>;	r7 = $r6;	$r3 = "INIT";	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>(r2);	if $z0 == 0 goto r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule parse(java.lang.String)>(r2);	r7 = staticinvoke <org.apache.dubbo.registry.client.migration.model.MigrationRule: org.apache.dubbo.registry.client.migration.model.MigrationRule getInitRule()>();	goto [?= return r7];	return r7
;block_num 5