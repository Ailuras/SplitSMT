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

(declare-sort var258 0)
(declare-sort var2842 0)
(declare-sort var2773 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2773_isEmpty/-813097145 (String) Bool)
(declare-const null-var258 var258)
(declare-const null-String String)
(declare-const var3881 var258) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3881 null-var258)))
(declare-const var3173 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3173 null-String)))
(declare-const var1930 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1930 null-String)))
(declare-const var3289 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3289 null-String)))
(define-const var3261 Bool (var2773_isEmpty/-813097145 var3173)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var3261 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var2773_isEmpty/-813097145=([java.lang.String], boolean)}
; {var258=org.apache.dubbo.common.URLBuilder, var3881=r1, var3173=r0, var2842=null_type, var1930=r2, var3289=r3, var2773=org.apache.dubbo.common.utils.StringUtils, var3261=$z0}
; {org.apache.dubbo.common.URLBuilder=var258, r1=var3881, r0=var3173, null_type=var2842, r2=var1930, r3=var3289, org.apache.dubbo.common.utils.StringUtils=var2773, $z0=var3261}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2