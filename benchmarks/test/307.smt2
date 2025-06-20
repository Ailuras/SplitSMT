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

(declare-sort var812 0)
(declare-sort var3732 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var812 var812)
(declare-const null-String String)
(declare-const var915 var812) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.matcher.attachment.AttachmentConditionMatcherFactory 
(assert (not (= var915 null-var812)))
(declare-const var100 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var100 null-String)))
(assert true)
(define-const var426 Bool (startsWith/-1785782452 var100 "attachments")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("attachments") 
 ; Statement: return $z0 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var812=org.apache.dubbo.rpc.cluster.router.condition.matcher.attachment.AttachmentConditionMatcherFactory, var915=r1, var100=r0, var3732=null_type, var426=$z0}
; {org.apache.dubbo.rpc.cluster.router.condition.matcher.attachment.AttachmentConditionMatcherFactory=var812, r1=var915, r0=var100, null_type=var3732, $z0=var426}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.matcher.attachment.AttachmentConditionMatcherFactory;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("attachments");	return $z0
;block_num 1