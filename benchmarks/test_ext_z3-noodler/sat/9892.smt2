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

(declare-sort var2967 0)
(declare-sort var790 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var790_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2016 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2016 null-String)))
(declare-const var105 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var105 null-String)))
(define-const var504 Bool (var790_isEmpty/-813097145 var105)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("[") 
(assert (not (= (ite var504 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 
(check-sat)
; {var790_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2016=r1, var2967=null_type, var105=r0, var790=org.apache.dubbo.common.utils.StringUtils, var504=$z0}
; {r1=var2016, null_type=var2967, r0=var105, org.apache.dubbo.common.utils.StringUtils=var790, $z0=var504}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("[");	return
;block_num 2