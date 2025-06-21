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

(declare-sort var3585 0)
(declare-sort var820 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var820_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var158 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var158 null-String)))
(declare-const var187 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var187 null-String)))
(define-const var1216 Bool (var820_isEmpty/-813097145 var158)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r0 
(assert (not (= (ite var1216 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r0 
(check-sat)
; {var820_isEmpty/-813097145=([java.lang.String], boolean)}
; {var158=r0, var3585=null_type, var187=r1, var820=org.apache.dubbo.common.utils.StringUtils, var1216=$z0}
; {r0=var158, null_type=var3585, r1=var187, org.apache.dubbo.common.utils.StringUtils=var820, $z0=var1216}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r0;	return r0
;block_num 2