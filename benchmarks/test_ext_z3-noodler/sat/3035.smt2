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

(declare-sort var3531 0)
(declare-sort var1112 0)
(declare-sort var973 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var973_isEmpty/-813097145 (String) Bool)
(declare-const null-var3531 var3531)
(declare-const null-String String)
(declare-const var116 var3531) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var116 null-var3531)))
(declare-const var2223 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2223 null-String)))
(define-const var719 Bool (var973_isEmpty/-813097145 var2223)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = newarray (java.lang.String)[1] 
(assert (not (= (ite var719 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var973_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3531=org.apache.dubbo.common.URLBuilder, var116=r1, var2223=r0, var1112=null_type, var973=org.apache.dubbo.common.utils.StringUtils, var719=$z0}
; {org.apache.dubbo.common.URLBuilder=var3531, r1=var116, r0=var2223, null_type=var1112, org.apache.dubbo.common.utils.StringUtils=var973, $z0=var719}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = newarray (java.lang.String)[1];	return r1
;block_num 2