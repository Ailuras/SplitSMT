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

(declare-sort var282 0)
(declare-sort var1386 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1386_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2787 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2787 null-String)))
(declare-const var3421 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3421 null-String)))
(define-const var3003 Bool (var1386_isEmpty/-813097145 var2787)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0) 
(assert (not (= (ite var3003 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r0 
(check-sat)
; {var1386_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2787=r0, var282=null_type, var3421=r2, var1386=org.apache.dubbo.common.utils.StringUtils, var3003=$z0}
; {r0=var2787, null_type=var282, r2=var3421, org.apache.dubbo.common.utils.StringUtils=var1386, $z0=var3003}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isWord(java.lang.String)>(r0);	return r0
;block_num 2