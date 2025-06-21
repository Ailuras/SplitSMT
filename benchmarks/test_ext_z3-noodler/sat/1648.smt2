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

(declare-sort var2830 0)
(declare-sort var2716 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-const null-var2830 var2830)
(declare-const null-String String)
(declare-const var279 var2830) ; Statement: r2 := @this: org.apache.dubbo.common.compiler.support.CtClassBuilder 
(assert (not (= var279 null-var2830)))
(declare-const var2736 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2736 null-String)))
(assert true)
(define-const var3731 Int (lastIndexOf/-1292097097 var2736 46)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46) 
 ; Statement: if i0 <= 0 goto return 
(assert (<= var3731 0)) ; Cond: i0 <= 0 
 ; Statement: return 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int)}
; {var2830=org.apache.dubbo.common.compiler.support.CtClassBuilder, var279=r2, var2736=r0, var2716=null_type, var3731=i0}
; {org.apache.dubbo.common.compiler.support.CtClassBuilder=var2830, r2=var279, r0=var2736, null_type=var2716, i0=var3731}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r2 := @this: org.apache.dubbo.common.compiler.support.CtClassBuilder;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(46);	if i0 <= 0 goto return;	return
;block_num 2