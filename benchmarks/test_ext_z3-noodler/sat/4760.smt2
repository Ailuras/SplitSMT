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

(declare-sort var555 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var555_isBlank/-523695098 (String) Bool)
(declare-const null-String String)
(declare-const var831 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var831 null-String)))
(define-const var1687 Bool (var555_isBlank/-523695098 var831)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var1687 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1628 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var555_isBlank/-523695098=([java.lang.CharSequence], boolean)}
; {var831=r0, var555=org.apache.dubbo.common.utils.StringUtils, var1687=$z0, var1628=$z1}
; {r0=var831, org.apache.dubbo.common.utils.StringUtils=var555, $z0=var1687, $z1=var1628}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.CharSequence;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3