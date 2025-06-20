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

(declare-sort var3254 0)
(declare-sort var251 0)
(declare-sort var833 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getExtension/-203349416 (var3254 String Bool) var833)
(declare-const null-var3254 var3254)
(declare-const null-String String)
(declare-const null-var833 var833)
(declare-const var15 var3254) ; Statement: r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader 
(assert (not (= var15 null-var3254)))
(declare-const var1630 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1630 null-String)))
(assert true)
(define-const var2981 var833 (getExtension/-203349416 var15 var1630 (ite (= 1 1) true false))) ; Statement: r2 = virtualinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>(r1, 1) 
 ; Statement: if r2 != null goto return r2 
(assert (not (= var2981 null-var833))) ; Cond: r2 != null 
 ; Statement: return r2 
(check-sat)
; {getExtension/-203349416=([org.apache.dubbo.common.extension.ExtensionLoader, java.lang.String, boolean], java.lang.Object)}
; {var3254=org.apache.dubbo.common.extension.ExtensionLoader, var15=r0, var1630=r1, var251=null_type, var833=java.lang.Object, var2981=r2}
; {org.apache.dubbo.common.extension.ExtensionLoader=var3254, r0=var15, r1=var1630, null_type=var251, java.lang.Object=var833, r2=var2981}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.common.extension.ExtensionLoader;	r1 := @parameter0: java.lang.String;	r2 = virtualinvoke r0.<org.apache.dubbo.common.extension.ExtensionLoader: java.lang.Object getExtension(java.lang.String,boolean)>(r1, 1);	if r2 != null goto return r2;	return r2
;block_num 2