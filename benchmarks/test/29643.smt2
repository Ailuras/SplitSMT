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

(declare-sort var2066 0)
(declare-sort var179 0)
(declare-sort var1365 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-var179-to-String (var179) String)
(declare-fun var1365_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2066 var2066)
(declare-const null-var179 var179)
(declare-const var1658 var2066) ; Statement: $r0 := @this: org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610 
(assert (not (= var1658 null-var2066)))
(declare-const var2243 var179) ; Statement: $r1 := @parameter0: java.lang.Object 
(assert (not (= var2243 null-var179)))
(define-const var1398 String (cast-from-var179-to-String var2243)) ; Statement: $r2 = (java.lang.String) $r1 
(define-const var2679 Bool (var1365_isNotEmpty/-1251449450 var1398)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {cast-from-var179-to-String=([java.lang.Object], java.lang.String), var1365_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2066=org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610, var1658=$r0, var179=java.lang.Object, var2243=$r1, var1398=$r2, var1365=org.apache.dubbo.common.utils.StringUtils, var2679=$z0}
; {org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610=var2066, $r0=var1658, java.lang.Object=var179, $r1=var2243, $r2=var1398, org.apache.dubbo.common.utils.StringUtils=var1365, $z0=var2679}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts $r0 := @this: org.apache.dubbo.metadata.AbstractServiceNameMapping$isNotEmpty__610;	$r1 := @parameter0: java.lang.Object;	$r2 = (java.lang.String) $r1;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	return $z0
;block_num 1