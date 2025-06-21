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

(declare-sort var2539 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-String String)
(declare-const null-var2539 var2539)
(declare-const var1442 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1442 null-String)))
(declare-const var3925 var2539) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.cluster.ClusterInvoker 
(assert (not (= var3925 null-var2539)))
(assert true)
;(assert (append/672562846 var1442 "Interface-Level: \n")) ; Statement: virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Interface-Level: \n") 
(declare-const var1442!1 String)
(assert (= var1442!1 (str.++ var1442 "Interface-Level: \n")))
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var1442=r0, var2539=org.apache.dubbo.rpc.cluster.ClusterInvoker, var3925=r1}
; {r0=var1442, org.apache.dubbo.rpc.cluster.ClusterInvoker=var2539, r1=var3925}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r1 := @parameter1: org.apache.dubbo.rpc.cluster.ClusterInvoker;	virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Interface-Level: \n");	return
;block_num 1