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

(declare-sort var1606 0)
(declare-sort var2262 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getGroup/-592409098 (var1606) String)
(declare-fun var2262_isEmpty/-813097145 (String) Bool)
(declare-const null-var1606 var1606)
(declare-const var3053 var1606) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var3053 null-var1606)))
(declare-const var87 var1606) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var87 null-var1606)))
(assert true)
(define-const var1930 String (getGroup/-592409098 var3053)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getGroup()>() 
(define-const var1310 Bool (var2262_isEmpty/-813097145 var1930)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getGroup()>() 
(assert (= (ite var1310 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3642 String (getGroup/-592409098 var3053)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getGroup()>() 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getGroup/-592409098=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var2262_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1606=org.apache.dubbo.config.AbstractInterfaceConfig, var3053=r0, var87=r2, var1930=$r1, var2262=org.apache.dubbo.common.utils.StringUtils, var1310=$z0, var3642=$r3}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var1606, r0=var3053, r2=var87, $r1=var1930, org.apache.dubbo.common.utils.StringUtils=var2262, $z0=var1310, $r3=var3642}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r2 := @parameter0: org.apache.dubbo.config.AbstractInterfaceConfig;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getGroup()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getGroup()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getGroup()>();	return $r3
;block_num 3