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

(declare-sort var2061 0)
(declare-sort var758 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var758_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2845 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2845 null-String)))
(declare-const var455 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var455 null-String)))
(define-const var3806 Bool (var758_isEmpty/-813097145 var2845)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3806 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var758_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2845=r0, var2061=null_type, var455=r2, var758=org.apache.dubbo.common.utils.StringUtils, var3806=$z0}
; {r0=var2845, null_type=var2061, r2=var455, org.apache.dubbo.common.utils.StringUtils=var758, $z0=var3806}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return;	return
;block_num 2