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

(declare-sort var1729 0)
(declare-sort var3443 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3443_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2619 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2619 null-String)))
(declare-const var2732 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2732 null-Int)))
(define-const var2864 Bool (var3443_isEmpty/-813097145 var2619)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(i0) 
(assert (not (= (ite var2864 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r0 
(check-sat)
; {var3443_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2619=r0, var1729=null_type, var2732=i0, var3443=org.apache.dubbo.common.utils.StringUtils, var2864=$z0}
; {r0=var2619, null_type=var1729, i0=var2732, org.apache.dubbo.common.utils.StringUtils=var3443, $z0=var2864}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 := @parameter1: int;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto i1 = virtualinvoke r0.<java.lang.String: int indexOf(int)>(i0);	return r0
;block_num 2