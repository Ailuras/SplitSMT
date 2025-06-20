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

(declare-sort var3519 0)
(declare-sort var2236 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2236_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-String String)
(declare-const var2074 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2074 null-String)))
(define-const var1617 Bool (var2236_isNotEmpty/-1251449450 var2074)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z4 = 0 
(assert (= (ite var1617 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2237 Bool (ite (= 1 0) true false)) ; Statement: $z4 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z4 
(check-sat)
; {var2236_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var2074=r0, var3519=null_type, var2236=org.apache.dubbo.common.utils.StringUtils, var1617=$z0, var2237=$z4}
; {r0=var2074, null_type=var3519, org.apache.dubbo.common.utils.StringUtils=var2236, $z0=var1617, $z4=var2237}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z4 = 0;	$z4 = 0;	return $z4
;block_num 3