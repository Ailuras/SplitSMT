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

(declare-sort var681 0)
(declare-sort var2461 0)
(declare-sort var3582 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3582_isEmpty/-813097145 (String) Bool)
(declare-const null-var681 var681)
(declare-const null-String String)
(declare-const null-ClassObject ClassObject)
(declare-const var832 var681) ; Statement: r1 := @this: org.apache.dubbo.common.convert.multiple.StringToMultiValueConverter 
(assert (not (= var832 null-var681)))
(declare-const var2359 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2359 null-String)))
(declare-const var3273 ClassObject) ; Statement: r2 := @parameter1: java.lang.Class 
(assert (not (= var3273 null-ClassObject)))
(declare-const var3998 ClassObject) ; Statement: r3 := @parameter2: java.lang.Class 
(assert (not (= var3998 null-ClassObject)))
(define-const var2184 Bool (var3582_isEmpty/-813097145 var2359)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto r6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] split(java.lang.String,char)>(r0, 44) 
(assert (not (= (ite var2184 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return null 
(check-sat)
; {var3582_isEmpty/-813097145=([java.lang.String], boolean)}
; {var681=org.apache.dubbo.common.convert.multiple.StringToMultiValueConverter, var832=r1, var2359=r0, var2461=null_type, var3273=r2, var3998=r3, var3582=org.apache.dubbo.common.utils.StringUtils, var2184=$z0}
; {org.apache.dubbo.common.convert.multiple.StringToMultiValueConverter=var681, r1=var832, r0=var2359, null_type=var2461, r2=var3273, r3=var3998, org.apache.dubbo.common.utils.StringUtils=var3582, $z0=var2184}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.multiple.StringToMultiValueConverter;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.Class;	r3 := @parameter2: java.lang.Class;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto r6 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.lang.String[] split(java.lang.String,char)>(r0, 44);	return null
;block_num 2