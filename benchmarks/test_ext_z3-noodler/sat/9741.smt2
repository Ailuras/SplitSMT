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

(declare-sort var3322 0)
(declare-sort var3074 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getVersion/25534205 (var3322) String)
(declare-fun var3074_isEmpty/-813097145 (String) Bool)
(declare-const null-var3322 var3322)
(declare-const var2495 var3322) ; Statement: r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var2495 null-var3322)))
(declare-const var3604 var3322) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractInterfaceConfig 
(assert (not (= var3604 null-var3322)))
(assert true)
(define-const var2565 String (getVersion/25534205 var2495)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getVersion()>() 
(define-const var2122 Bool (var3074_isEmpty/-813097145 var2565)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getVersion()>() 
(assert (= (ite var2122 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var1984 String (getVersion/25534205 var2495)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getVersion()>() 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getVersion/25534205=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), var3074_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3322=org.apache.dubbo.config.AbstractInterfaceConfig, var2495=r0, var3604=r2, var2565=$r1, var3074=org.apache.dubbo.common.utils.StringUtils, var2122=$z0, var1984=$r3}
; {org.apache.dubbo.config.AbstractInterfaceConfig=var3322, r0=var2495, r2=var3604, $r1=var2565, org.apache.dubbo.common.utils.StringUtils=var3074, $z0=var2122, $r3=var1984}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.AbstractInterfaceConfig;	r2 := @parameter0: org.apache.dubbo.config.AbstractInterfaceConfig;	$r1 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getVersion()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getVersion()>();	$r3 = virtualinvoke r0.<org.apache.dubbo.config.AbstractInterfaceConfig: java.lang.String getVersion()>();	return $r3
;block_num 3