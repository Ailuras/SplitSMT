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

(declare-sort var1451 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1451_isBlank/-523695098 (String) Bool)
(declare-const null-String String)
(declare-const var900 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var900 null-String)))
(define-const var2118 Bool (var1451_isBlank/-523695098 var900)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var2118 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2979 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var1451_isBlank/-523695098=([java.lang.CharSequence], boolean)}
; {var900=r0, var1451=org.apache.dubbo.common.utils.StringUtils, var2118=$z0, var2979=$z1}
; {r0=var900, org.apache.dubbo.common.utils.StringUtils=var1451, $z0=var2118, $z1=var2979}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.CharSequence;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3