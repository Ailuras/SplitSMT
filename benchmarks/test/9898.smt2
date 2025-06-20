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

(declare-sort var796 0)
(declare-sort var2275 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2275_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2874 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2874 null-String)))
(define-const var3367 Int null-Int) ; Statement: r12 = null 
(define-const var1775 Bool (var2275_isNotEmpty/-1251449450 var2874)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return r12 
(assert (= (ite var1775 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r12 
(check-sat)
; {var2275_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2874=r0, var796=null_type, var3367=r12, var2275=org.apache.dubbo.common.utils.StringUtils, var1775=$z0}
; {r0=var2874, null_type=var796, r12=var3367, org.apache.dubbo.common.utils.StringUtils=var2275, $z0=var1775}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r12 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return r12;	return r12
;block_num 2