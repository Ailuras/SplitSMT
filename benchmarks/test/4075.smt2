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

(declare-sort var2462 0)
(declare-sort var2785 0)
(declare-sort var1162 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1162_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const null-var2785 var2785)
(declare-const var3579 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3579 null-String)))
(declare-const var1818 var2785) ; Statement: r7 := @parameter1: org.apache.dubbo.common.config.Configuration 
(assert (not (= var1818 null-var2785)))
(define-const var3653 Bool (var1162_isEmpty/-813097145 var3579)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r0 
(assert (not (= (ite var3653 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r0 
(check-sat)
; {var1162_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3579=r0, var2462=null_type, var2785=org.apache.dubbo.common.config.Configuration, var1818=r7, var1162=org.apache.dubbo.common.utils.StringUtils, var3653=$z0}
; {r0=var3579, null_type=var2462, org.apache.dubbo.common.config.Configuration=var2785, r7=var1818, org.apache.dubbo.common.utils.StringUtils=var1162, $z0=var3653}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r7 := @parameter1: org.apache.dubbo.common.config.Configuration;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r0;	return r0
;block_num 2