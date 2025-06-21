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

(declare-sort var2374 0)
(declare-sort var2664 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2664_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2935 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2935 null-String)))
(declare-const var2989 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2989 null-String)))
(define-const var2165 Bool (var2664_isEmpty/-813097145 var2935)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = r0 
(assert (= (ite var2165 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2551 String var2935) ; Statement: $r2 = r0 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var2664_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2935=r0, var2374=null_type, var2989=r1, var2664=org.apache.dubbo.common.utils.StringUtils, var2165=$z0, var2551=$r2}
; {r0=var2935, null_type=var2374, r1=var2989, org.apache.dubbo.common.utils.StringUtils=var2664, $z0=var2165, $r2=var2551}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = r0;	$r2 = r0;	return $r2
;block_num 3