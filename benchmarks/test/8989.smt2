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

(declare-sort var1419 0)
(declare-sort var2361 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun address/-609073947 (var1419) String)
(declare-fun var2361_isEmpty/-813097145 (String) Bool)
(declare-const null-var1419 var1419)
(declare-const var358 var1419) ; Statement: r0 := @this: org.apache.dubbo.config.RegistryConfig 
(assert (not (= var358 null-var1419)))
(define-const var1870 String (address/-609073947 var358)) ; Statement: $r1 = r0.<org.apache.dubbo.config.RegistryConfig: java.lang.String address> 
(define-const var110 Bool (var2361_isEmpty/-813097145 var1870)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 == 0 goto $z2 = 1 
(assert (= (ite var110 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3462 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {address/-609073947=([org.apache.dubbo.config.RegistryConfig], java.lang.String), var2361_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1419=org.apache.dubbo.config.RegistryConfig, var358=r0, var1870=$r1, var2361=org.apache.dubbo.common.utils.StringUtils, var110=$z0, var3462=$z2}
; {org.apache.dubbo.config.RegistryConfig=var1419, r0=var358, $r1=var1870, org.apache.dubbo.common.utils.StringUtils=var2361, $z0=var110, $z2=var3462}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.RegistryConfig;	$r1 = r0.<org.apache.dubbo.config.RegistryConfig: java.lang.String address>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 == 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3