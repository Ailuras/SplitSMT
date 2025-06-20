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

(declare-sort var2961 0)
(declare-sort var998 0)
(declare-sort var3540 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3540_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var2961 var2961)
(declare-const null-String String)
(declare-const null-Float32 Float32)
(declare-const var1208 var2961) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToFloatConverter 
(assert (not (= var1208 null-var2961)))
(declare-const var2770 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2770 null-String)))
(define-const var30 Bool (var3540_isNotEmpty/-1251449450 var2770)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var30 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1235 Float32 null-Float32) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var3540_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2961=org.apache.dubbo.common.convert.StringToFloatConverter, var1208=r1, var2770=r0, var998=null_type, var3540=org.apache.dubbo.common.utils.StringUtils, var30=$z0, var1235=$r2}
; {org.apache.dubbo.common.convert.StringToFloatConverter=var2961, r1=var1208, r0=var2770, null_type=var998, org.apache.dubbo.common.utils.StringUtils=var3540, $z0=var30, $r2=var1235}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToFloatConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3