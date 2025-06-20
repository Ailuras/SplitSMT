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

(declare-sort var1666 0)
(declare-sort var3288 0)
(declare-sort var1190 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var3288-to-String (var3288) String)
(declare-fun var1190_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1666 var1666)
(declare-const null-var3288 var3288)
(declare-const var2738 var1666) ; Statement: $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__502 
(assert (not (= var2738 null-var1666)))
(declare-const var1702 var3288) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var1702 null-var3288)))
(define-const var3116 String (cast-from-var3288-to-String var1702)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var1159 Bool (var1190_isNotEmpty/-1251449450 var3116)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var3288-to-String=([java.lang.Object], java.lang.String), var1190_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1666=org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__502, var2738=$r0, var3288=java.lang.Object, var1702=$r1, var3116=$r2, var1190=org.apache.dubbo.common.utils.StringUtils, var1159=$z0}
; {org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__502=var1666, $r0=var2738, java.lang.Object=var3288, $r1=var1702, $r2=var3116, org.apache.dubbo.common.utils.StringUtils=var1190, $z0=var1159}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.config.bootstrap.builders.InternalServiceConfigBuilder$isNotEmpty__502;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1