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

(declare-sort var1462 0)
(declare-sort var3578 0)
(declare-sort var1432 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1432_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Float32_valueOf/1193455972 (String) Float32)
(declare-const null-var1462 var1462)
(declare-const null-String String)
(declare-const var2430 var1462) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToFloatConverter 
(assert (not (= var2430 null-var1462)))
(declare-const var3153 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3153 null-String)))
(define-const var1579 Bool (var1432_isNotEmpty/-1251449450 var3153)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var1579 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3293 Float32 (Float32_valueOf/1193455972 var3153)) ; Statement: $r2 = staticinvoke <java.lang.Float: java.lang.Float valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1432_isNotEmpty/-1251449450=([java.lang.String], boolean), Float32_valueOf/1193455972=([java.lang.String], java.lang.Float)}
; {var1462=org.apache.dubbo.common.convert.StringToFloatConverter, var2430=r1, var3153=r0, var3578=null_type, var1432=org.apache.dubbo.common.utils.StringUtils, var1579=$z0, var3293=$r2}
; {org.apache.dubbo.common.convert.StringToFloatConverter=var1462, r1=var2430, r0=var3153, null_type=var3578, org.apache.dubbo.common.utils.StringUtils=var1432, $z0=var1579, $r2=var3293}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToFloatConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Float: java.lang.Float valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3