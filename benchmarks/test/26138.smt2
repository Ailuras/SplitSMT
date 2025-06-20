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

(declare-sort var784 0)
(declare-sort var2588 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/-1799577674 (var784) String)
(declare-fun var2588_isEmpty/-813097145 (String) Bool)
(declare-const null-var784 var784)
(declare-const var3507 var784) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta 
(assert (not (= var3507 null-var784)))
(define-const var2617 String (name/-1799577674 var3507)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String name> 
(define-const var735 Bool (var2588_isEmpty/-813097145 var2617)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {name/-1799577674=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta], java.lang.String), var2588_isEmpty/-813097145=([java.lang.String], boolean)}
; {var784=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta, var3507=r0, var2617=$r1, var2588=org.apache.dubbo.common.utils.StringUtils, var735=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta=var784, r0=var3507, $r1=var2617, org.apache.dubbo.common.utils.StringUtils=var2588, $z0=var735}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta;	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.NamedValueMeta: java.lang.String name>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	return $z0
;block_num 1