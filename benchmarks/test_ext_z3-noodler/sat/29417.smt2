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

(declare-sort var2548 0)
(declare-sort var2205 0)
(declare-sort var268 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var2205-to-String (var2205) String)
(declare-fun var268_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2548 var2548)
(declare-const null-var2205 var2205)
(declare-const var131 var2548) ; Statement: $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__530 
(assert (not (= var131 null-var2548)))
(declare-const var1709 var2205) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var1709 null-var2205)))
(define-const var467 String (cast-from-var2205-to-String var1709)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var2117 Bool (var268_isNotEmpty/-1251449450 var467)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var2205-to-String=([java.lang.Object], java.lang.String), var268_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2548=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__530, var131=$r0, var2205=java.lang.Object, var1709=$r1, var467=$r2, var268=org.apache.dubbo.common.utils.StringUtils, var2117=$z0}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__530=var2548, $r0=var131, java.lang.Object=var2205, $r1=var1709, $r2=var467, org.apache.dubbo.common.utils.StringUtils=var268, $z0=var2117}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__530;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1