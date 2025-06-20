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

(declare-sort var2606 0)
(declare-sort var2819 0)
(declare-sort var1570 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1570_isEmpty/-813097145 (String) Bool)
(declare-const null-var2606 var2606)
(declare-const null-String String)
(declare-const var2980 var2606) ; Statement: r1 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var2980 null-var2606)))
(declare-const var3188 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3188 null-String)))
(declare-const var3570 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3570 null-String)))
(define-const var1572 Bool (var1570_isEmpty/-813097145 var3188)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var1572 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var1570_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2606=org.apache.dubbo.common.url.component.URLParam, var2980=r1, var3188=r0, var2819=null_type, var3570=r2, var1570=org.apache.dubbo.common.utils.StringUtils, var1572=$z0}
; {org.apache.dubbo.common.url.component.URLParam=var2606, r1=var2980, r0=var3188, null_type=var2819, r2=var3570, org.apache.dubbo.common.utils.StringUtils=var1570, $z0=var1572}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.url.component.URLParam;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2