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

(declare-sort var3243 0)
(declare-sort var713 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var713_isBeanPropertyWriteMethod/-1621676998 (var3243) Bool)
(declare-const null-var3243 var3243)
(declare-const var3817 var3243) ; Statement: r0 := @parameter0: java.lang.reflect.Method 
(assert (not (= var3817 null-var3243)))
(define-const var1224 Bool (var713_isBeanPropertyWriteMethod/-1621676998 var3817)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: boolean isBeanPropertyWriteMethod(java.lang.reflect.Method)>(r0) 
 ; Statement: if $z0 == 0 goto return null 
(assert (= (ite var1224 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return null 
(check-sat)
; {var713_isBeanPropertyWriteMethod/-1621676998=([java.lang.reflect.Method], boolean)}
; {var3243=java.lang.reflect.Method, var3817=r0, var713=org.apache.dubbo.common.utils.ReflectUtils, var1224=$z0}
; {java.lang.reflect.Method=var3243, r0=var3817, org.apache.dubbo.common.utils.ReflectUtils=var713, $z0=var1224}
;seq 
;cnt {}
;stmts r0 := @parameter0: java.lang.reflect.Method;	$z0 = staticinvoke <org.apache.dubbo.common.utils.ReflectUtils: boolean isBeanPropertyWriteMethod(java.lang.reflect.Method)>(r0);	if $z0 == 0 goto return null;	return null
;block_num 2