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

(declare-sort var1613 0)
(declare-sort var863 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var863_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1946 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1946 null-String)))
(define-const var1284 Bool (var863_isEmpty/-813097145 var1946)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0) 
(assert (not (= (ite var1284 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 0 
(check-sat)
; {var863_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1946=r0, var1613=null_type, var863=org.apache.dubbo.common.utils.StringUtils, var1284=$z0}
; {r0=var1946, null_type=var1613, org.apache.dubbo.common.utils.StringUtils=var863, $z0=var1284}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto i0 = staticinvoke <org.apache.dubbo.common.Version: int getIntVersion(java.lang.String)>(r0);	return 0
;block_num 2