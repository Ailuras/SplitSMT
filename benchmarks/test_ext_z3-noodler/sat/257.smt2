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

(declare-sort var462 0)
(declare-sort var3952 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-const null-var462 var462)
(declare-const null-String String)
(declare-const var2542 var462) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.matcher.argument.ArgumentConditionMatcherFactory 
(assert (not (= var2542 null-var462)))
(declare-const var525 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var525 null-String)))
(assert true)
(define-const var486 Bool (startsWith/-1785782452 var525 "arguments")) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("arguments") 
 ; Statement: return $z0 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean)}
; {var462=org.apache.dubbo.rpc.cluster.router.condition.matcher.argument.ArgumentConditionMatcherFactory, var2542=r1, var525=r0, var3952=null_type, var486=$z0}
; {org.apache.dubbo.rpc.cluster.router.condition.matcher.argument.ArgumentConditionMatcherFactory=var462, r1=var2542, r0=var525, null_type=var3952, $z0=var486}
;seq <java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.matcher.argument.ArgumentConditionMatcherFactory;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean startsWith(java.lang.String)>("arguments");	return $z0
;block_num 1