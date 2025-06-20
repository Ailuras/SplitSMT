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

(declare-sort var3535 0)
(declare-sort var425 0)
(declare-sort var2522 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2522_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var3535 var3535)
(declare-const null-String String)
(declare-const var1335 var3535) ; Statement: r1 := @this: org.apache.dubbo.config.spring.ReferenceBean 
(assert (not (= var1335 null-var3535)))
(declare-const var2848 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2848 null-String)))
(define-const var3439 Bool (var2522_isNotEmpty/-1251449450 var2848)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3439 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var2522_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var3535=org.apache.dubbo.config.spring.ReferenceBean, var1335=r1, var2848=r0, var425=null_type, var2522=org.apache.dubbo.common.utils.StringUtils, var3439=$z0}
; {org.apache.dubbo.config.spring.ReferenceBean=var3535, r1=var1335, r0=var2848, null_type=var425, org.apache.dubbo.common.utils.StringUtils=var2522, $z0=var3439}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.config.spring.ReferenceBean;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto return;	return
;block_num 2