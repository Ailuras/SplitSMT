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

(declare-sort var2608 0)
(declare-sort var2241 0)
(declare-sort var2641 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2641_isEmpty/-813097145 (String) Bool)
(declare-const null-var2608 var2608)
(declare-const null-String String)
(declare-const var5 var2608) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var5 null-var2608)))
(declare-const var2478 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2478 null-String)))
(define-const var3761 Bool (var2641_isEmpty/-813097145 var2478)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = newarray (java.lang.String)[1] 
(assert (not (= (ite var3761 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var2641_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2608=org.apache.dubbo.common.URL, var5=r1, var2478=r0, var2241=null_type, var2641=org.apache.dubbo.common.utils.StringUtils, var3761=$z0}
; {org.apache.dubbo.common.URL=var2608, r1=var5, r0=var2478, null_type=var2241, org.apache.dubbo.common.utils.StringUtils=var2641, $z0=var3761}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = newarray (java.lang.String)[1];	return r1
;block_num 2