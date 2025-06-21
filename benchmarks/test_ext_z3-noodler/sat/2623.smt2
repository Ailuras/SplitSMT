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

(declare-sort var2882 0)
(declare-sort var3477 0)
(declare-sort var63 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var63_isEmpty/-813097145 (String) Bool)
(declare-const null-var2882 var2882)
(declare-const null-String String)
(declare-const var1636 var2882) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1636 null-var2882)))
(declare-const var3228 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3228 null-String)))
(declare-const var2923 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2923 null-String)))
(define-const var1790 Bool (var63_isEmpty/-813097145 var3228)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var1790 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var63_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2882=org.apache.dubbo.common.URLBuilder, var1636=r1, var3228=r0, var3477=null_type, var2923=r2, var63=org.apache.dubbo.common.utils.StringUtils, var1790=$z0}
; {org.apache.dubbo.common.URLBuilder=var2882, r1=var1636, r0=var3228, null_type=var3477, r2=var2923, org.apache.dubbo.common.utils.StringUtils=var63, $z0=var1790}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2