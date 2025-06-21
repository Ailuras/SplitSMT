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

(declare-sort var2940 0)
(declare-sort var3452 0)
(declare-sort var1023 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3452-to-String (var3452) String)
(declare-fun var1023_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2940 var2940)
(declare-const null-var3452 var3452)
(declare-const var662 var2940) ; Statement: $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__561 
(assert (not (= var662 null-var2940)))
(declare-const var1998 var3452) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var1998 null-var3452)))
(define-const var2779 String (cast-from-var3452-to-String var1998)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var2485 Bool (var1023_isNotEmpty/-1251449450 var2779)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var3452-to-String=([java.lang.Object], java.lang.String), var1023_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2940=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__561, var662=$r0, var3452=java.lang.Object, var1998=$r1, var2779=$r2, var1023=org.apache.dubbo.common.utils.StringUtils, var2485=$z0}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__561=var2940, $r0=var662, java.lang.Object=var3452, $r1=var1998, $r2=var2779, org.apache.dubbo.common.utils.StringUtils=var1023, $z0=var2485}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__561;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1