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

(declare-sort var2999 0)
(declare-sort var2320 0)
(declare-sort var958 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var958_isEmpty/-813097145 (String) Bool)
(declare-const null-var2999 var2999)
(declare-const null-String String)
(declare-const var3082 var2999) ; Statement: r1 := @this: org.apache.dubbo.common.url.component.URLParam 
(assert (not (= var3082 null-var2999)))
(declare-const var3782 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3782 null-String)))
(declare-const var1571 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1571 null-String)))
(define-const var2163 Bool (var958_isEmpty/-813097145 var3782)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto return r1 
(assert (not (= (ite var2163 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r1 
(check-sat)
; {var958_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2999=org.apache.dubbo.common.url.component.URLParam, var3082=r1, var3782=r0, var2320=null_type, var1571=r2, var958=org.apache.dubbo.common.utils.StringUtils, var2163=$z0}
; {org.apache.dubbo.common.url.component.URLParam=var2999, r1=var3082, r0=var3782, null_type=var2320, r2=var1571, org.apache.dubbo.common.utils.StringUtils=var958, $z0=var2163}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.url.component.URLParam;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto return r1;	return r1
;block_num 2