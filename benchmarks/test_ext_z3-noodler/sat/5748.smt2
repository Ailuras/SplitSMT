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

(declare-sort var2290 0)
(declare-sort var121 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var121_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var185 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var185 null-String)))
(declare-const var1603 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1603 null-String)))
(define-const var1452 Bool (var121_isEmpty/-813097145 var185)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = "*" 
(assert (not (= (ite var1452 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: if r2 != null goto $z3 = 0 
(assert (not (= var1603 null-String))) ; Cond: r2 != null 
(define-const var2835 Bool (ite (= 1 0) true false)) ; Statement: $z3 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z3 
(check-sat)
; {var121_isEmpty/-813097145=([java.lang.String], boolean)}
; {var185=r0, var2290=null_type, var1603=r2, var121=org.apache.dubbo.common.utils.StringUtils, var1452=$z0, var2835=$z3}
; {r0=var185, null_type=var2290, r2=var1603, org.apache.dubbo.common.utils.StringUtils=var121, $z0=var1452, $z3=var2835}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = "*";	if r2 != null goto $z3 = 0;	$z3 = 0;	return $z3
;block_num 4