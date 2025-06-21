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

(declare-sort var2510 0)
(declare-sort var3050 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3050_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1151 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1151 null-String)))
(define-const var3645 Bool (var3050_isEmpty/-813097145 var1151)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var3645 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2565 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var3050_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1151=r0, var2510=null_type, var3050=org.apache.dubbo.common.utils.StringUtils, var3645=$z0, var2565=$z1}
; {r0=var1151, null_type=var2510, org.apache.dubbo.common.utils.StringUtils=var3050, $z0=var3645, $z1=var2565}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3