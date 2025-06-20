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

(declare-sort var3735 0)
(declare-sort var699 0)
(declare-sort var2730 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var699-to-String (var699) String)
(declare-fun var2730_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3735 var3735)
(declare-const null-var699 var699)
(declare-const var980 var3735) ; Statement: $r0 := @this: org.apache.dubbo.registry.integration.RegistryProtocol$isNotEmpty__1093 
(assert (not (= var980 null-var3735)))
(declare-const var960 var699) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var960 null-var699)))
(define-const var3235 String (cast-from-var699-to-String var960)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var3865 Bool (var2730_isNotEmpty/-1251449450 var3235)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var699-to-String=([java.lang.Object], java.lang.String), var2730_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3735=org.apache.dubbo.registry.integration.RegistryProtocol$isNotEmpty__1093, var980=$r0, var699=java.lang.Object, var960=$r1, var3235=$r2, var2730=org.apache.dubbo.common.utils.StringUtils, var3865=$z0}
; {org.apache.dubbo.registry.integration.RegistryProtocol$isNotEmpty__1093=var3735, $r0=var980, java.lang.Object=var699, $r1=var960, $r2=var3235, org.apache.dubbo.common.utils.StringUtils=var2730, $z0=var3865}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.registry.integration.RegistryProtocol$isNotEmpty__1093;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1