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

(declare-sort var1008 0)
(declare-sort var3292 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3292_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var3613 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3613 null-String)))
(declare-const var2834 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2834 null-String)))
(declare-const var1951 String) ; Statement: r2 := @parameter2: java.lang.String 
(assert (not (= var1951 null-String)))
(define-const var3041 Bool (var3292_isEmpty/-813097145 var3613)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto r4 = null 
(assert (not (= (ite var3041 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r0 
(check-sat)
; {var3292_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3613=r0, var1008=null_type, var2834=r1, var1951=r2, var3292=org.apache.dubbo.common.utils.StringUtils, var3041=$z0}
; {r0=var3613, null_type=var1008, r1=var2834, r2=var1951, org.apache.dubbo.common.utils.StringUtils=var3292, $z0=var3041}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r2 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto r4 = null;	return r0
;block_num 2