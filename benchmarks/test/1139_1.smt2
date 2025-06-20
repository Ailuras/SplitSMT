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

(declare-sort var3544 0)
(declare-sort var3369 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-const null-var3544 var3544)
(declare-const null-String String)
(declare-const var3916 var3544) ; Statement: r7 := @this: org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker 
(assert (not (= var3916 null-var3544)))
(declare-const var210 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var210 null-String)))
(assert true)
(define-const var3631 Int (indexOf/-1209756239 var210 "/")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/") 
 ; Statement: if i0 <= 0 goto return r0 
(assert (<= var3631 0)) ; Cond: i0 <= 0 
 ; Statement: return r0 
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int)}
; {var3544=org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker, var3916=r7, var210=r0, var3369=null_type, var3631=i0}
; {org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker=var3544, r7=var3916, r0=var210, null_type=var3369, i0=var3631}
;seq <java.lang.String: int indexOf(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1}
;stmts r7 := @this: org.apache.dubbo.rpc.cluster.support.MergeableClusterInvoker;	r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/");	if i0 <= 0 goto return r0;	return r0
;block_num 2