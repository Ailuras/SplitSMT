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

(declare-sort var3978 0)
(declare-sort var1944 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun rawRule/-1750759578 (var3978) String)
(declare-const null-var3978 var3978)
(declare-const null-String String)
(declare-const var776 var3978) ; Statement: r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener 
(assert (not (= var776 null-var3978)))
(declare-const var3925 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var3925 null-String)))
(define-const var2281 String (rawRule/-1750759578 var776)) ; Statement: $r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String rawRule> 
(assert true)
(define-const var900 Bool (= var2281 "INIT")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("INIT") 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var900 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {rawRule/-1750759578=([org.apache.dubbo.registry.client.migration.MigrationRuleListener], java.lang.String)}
; {var3978=org.apache.dubbo.registry.client.migration.MigrationRuleListener, var776=r0, var3925=r3, var1944=null_type, var2281=$r1, var900=$z0}
; {org.apache.dubbo.registry.client.migration.MigrationRuleListener=var3978, r0=var776, r3=var3925, null_type=var1944, $r1=var2281, $z0=var900}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.migration.MigrationRuleListener;	r3 := @parameter0: java.lang.String;	$r1 = r0.<org.apache.dubbo.registry.client.migration.MigrationRuleListener: java.lang.String rawRule>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("INIT");	if $z0 == 0 goto return;	return
;block_num 2