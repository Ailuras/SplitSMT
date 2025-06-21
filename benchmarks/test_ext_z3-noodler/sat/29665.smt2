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

(declare-sort var3259 0)
(declare-sort var1248 0)
(declare-sort var1107 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var1248-to-String (var1248) String)
(declare-fun var1107_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3259 var3259)
(declare-const null-var1248 var1248)
(declare-const var697 var3259) ; Statement: $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__600 
(assert (not (= var697 null-var3259)))
(declare-const var2223 var1248) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2223 null-var1248)))
(define-const var3801 String (cast-from-var1248-to-String var2223)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var3229 Bool (var1107_isNotEmpty/-1251449450 var3801)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var1248-to-String=([java.lang.Object], java.lang.String), var1107_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3259=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__600, var697=$r0, var1248=java.lang.Object, var2223=$r1, var3801=$r2, var1107=org.apache.dubbo.common.utils.StringUtils, var3229=$z0}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__600=var3259, $r0=var697, java.lang.Object=var1248, $r1=var2223, $r2=var3801, org.apache.dubbo.common.utils.StringUtils=var1107, $z0=var3229}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__600;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1