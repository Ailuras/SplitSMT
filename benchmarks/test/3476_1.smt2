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

(declare-sort var3861 0)
(declare-sort var828 0)
(declare-sort var2047 0)
(declare-sort var3317 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3317_isEmpty/-813097145 (String) Bool)
(declare-const null-var3861 var3861)
(declare-const null-String String)
(declare-const null-var2047 var2047)
(declare-const var2096 var3861) ; Statement: r2 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var2096 null-var3861)))
(declare-const var289 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var289 null-String)))
(declare-const var1861 var2047) ; Statement: r1 := @parameter1: java.util.Set 
(assert (not (= var1861 null-var2047)))
(define-const var3323 Bool (var3317_isEmpty/-813097145 var289)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r1) 
(assert (not (= (ite var3323 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return 1 
(check-sat)
; {var3317_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3861=org.apache.dubbo.common.extension.ExtensionLoader, var2096=r2, var289=r0, var828=null_type, var2047=java.util.Set, var1861=r1, var3317=org.apache.dubbo.common.utils.StringUtils, var3323=$z0}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3861, r2=var2096, r0=var289, null_type=var828, java.util.Set=var2047, r1=var1861, org.apache.dubbo.common.utils.StringUtils=var3317, $z0=var3323}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.util.Set;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.CollectionUtils: boolean isNotEmpty(java.util.Collection)>(r1);	return 1
;block_num 2