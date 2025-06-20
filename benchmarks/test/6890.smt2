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

(declare-sort var3555 0)
(declare-sort var3601 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3601_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const var1734 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1734 null-String)))
(declare-const var2261 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2261 null-String)))
(define-const var3662 Bool (var3601_isNotEmpty/-1251449450 var1734)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return r0 
(assert (= (ite var3662 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r0 
(check-sat)
; {var3601_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1734=r0, var3555=null_type, var2261=r1, var3601=org.apache.dubbo.common.utils.StringUtils, var3662=$z0}
; {r0=var1734, null_type=var3555, r1=var2261, org.apache.dubbo.common.utils.StringUtils=var3601, $z0=var3662}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return r0;	return r0
;block_num 2