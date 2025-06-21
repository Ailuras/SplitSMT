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

(declare-sort var565 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var565_isNoneEmpty/-2034882047 ((Array Int String)) Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var745 (Array Int String)) ; Statement: r0 := @parameter0: java.lang.String[] 
(assert (not (= var745 null-__Array__Int__String__)))
(define-const var1206 Bool (var565_isNoneEmpty/-2034882047 var745)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>(r0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var1206 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3084 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var565_isNoneEmpty/-2034882047=([java.lang.String[]], boolean)}
; {var745=r0, var565=org.apache.dubbo.common.utils.StringUtils, var1206=$z0, var3084=$z1}
; {r0=var745, org.apache.dubbo.common.utils.StringUtils=var565, $z0=var1206, $z1=var3084}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>": 1}
;stmts r0 := @parameter0: java.lang.String[];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNoneEmpty(java.lang.String[])>(r0);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3