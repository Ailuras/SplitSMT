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

(declare-sort var675 0)
(declare-sort var3780 0)
(declare-sort var3255 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3255_isEmpty/-813097145 (String) Bool)
(declare-const null-var675 var675)
(declare-const null-String String)
(declare-const var3505 var675) ; Statement: r1 := @parameter0: java.util.Map 
(assert (not (= var3505 null-var675)))
(declare-const var1837 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1837 null-String)))
(define-const var327 Bool (var3255_isEmpty/-813097145 var1837)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto $z2 = 1 
(assert (not (= (ite var327 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2814 Bool (ite (= 1 1) true false)) ; Statement: $z2 = 1 
 ; Statement: goto [?= return $z2] 
(assert true) ; Non Conditional
 ; Statement: return $z2 
(check-sat)
; {var3255_isEmpty/-813097145=([java.lang.String], boolean)}
; {var675=java.util.Map, var3505=r1, var1837=r0, var3780=null_type, var3255=org.apache.dubbo.common.utils.StringUtils, var327=$z0, var2814=$z2}
; {java.util.Map=var675, r1=var3505, r0=var1837, null_type=var3780, org.apache.dubbo.common.utils.StringUtils=var3255, $z0=var327, $z2=var2814}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.util.Map;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto $z2 = 1;	$z2 = 1;	goto [?= return $z2];	return $z2
;block_num 3