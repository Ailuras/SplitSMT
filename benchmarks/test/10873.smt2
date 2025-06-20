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

(declare-sort var3477 0)
(declare-sort var1893 0)
(declare-sort var2339 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2339_isEmpty/-813097145 (String) Bool)
(declare-const null-var3477 var3477)
(declare-const null-String String)
(declare-const var1226 var3477) ; Statement: r1 := @this: com.alibaba.dubbo.common.URL 
(assert (not (= var1226 null-var3477)))
(declare-const var3037 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3037 null-String)))
(declare-const var3530 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3530 null-String)))
(define-const var418 Bool (var2339_isEmpty/-813097145 var3530)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r3 = staticinvoke <com.alibaba.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0) 
(assert (not (= (ite var418 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var2339_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3477=com.alibaba.dubbo.common.URL, var1226=r1, var3037=r2, var1893=null_type, var3530=r0, var2339=org.apache.dubbo.common.utils.StringUtils, var418=$z0}
; {com.alibaba.dubbo.common.URL=var3477, r1=var1226, r2=var3037, null_type=var1893, r0=var3530, org.apache.dubbo.common.utils.StringUtils=var2339, $z0=var418}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: com.alibaba.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r3 = staticinvoke <com.alibaba.dubbo.common.URL: java.lang.String encode(java.lang.String)>(r0);	return r1
;block_num 2