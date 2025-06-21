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

(declare-sort var1784 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1784_isNoneEmpty/-2034882047 ((Array Int String)) Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3119 (Array Int String)) ; Statement: r0 := @parameter0: java.lang.String[] 
(assert (not (= var3119 null-__Array__Int__String__)))
(define-const var1787 Bool (var1784_isNoneEmpty/-2034882047 var3119)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>(r0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var1787 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1918 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var1784_isNoneEmpty/-2034882047=([java.lang.String[]], boolean)}
; {var3119=r0, var1784=org.apache.dubbo.common.utils.StringUtils, var1787=$z0, var1918=$z1}
; {r0=var3119, org.apache.dubbo.common.utils.StringUtils=var1784, $z0=var1787, $z1=var1918}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>": 1}
;stmts r0 := @parameter0: java.lang.String[];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>(r0);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3