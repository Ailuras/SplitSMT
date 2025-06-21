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

(declare-sort var2713 0)
(declare-sort var3393 0)
(declare-sort var3624 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3624_isEmpty/-813097145 (String) Bool)
(declare-const null-var2713 var2713)
(declare-const null-String String)
(declare-const var3991 var2713) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var3991 null-var2713)))
(declare-const var247 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var247 null-String)))
(define-const var1128 Bool (var3624_isEmpty/-813097145 var247)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0) 
(assert (not (= (ite var1128 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r1 
(check-sat)
; {var3624_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2713=org.apache.dubbo.common.URLBuilder, var3991=r1, var247=r0, var3393=null_type, var3624=org.apache.dubbo.common.utils.StringUtils, var1128=$z0}
; {org.apache.dubbo.common.URLBuilder=var2713, r1=var3991, r0=var247, null_type=var3393, org.apache.dubbo.common.utils.StringUtils=var3624, $z0=var1128}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseQueryString(java.lang.String)>(r0);	return r1
;block_num 2