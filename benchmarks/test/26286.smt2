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

(declare-sort var3221 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun type/1926907315 (var3221) String)
(declare-const null-var3221 var3221)
(declare-const var3640 var3221) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression 
(assert (not (= var3640 null-var3221)))
(define-const var836 String "*") ; Statement: $r2 = "*" 
(define-const var3088 String (type/1926907315 var3640)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String type> 
(assert true)
(define-const var2651 Bool (= var836 var3088)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {type/1926907315=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression], java.lang.String)}
; {var3221=org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression, var3640=r0, var836=$r2, var3088=$r1, var2651=$z0}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression=var3221, r0=var3640, $r2=var836, $r1=var3088, $z0=var2651}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression;	$r2 = "*";	$r1 = r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.condition.MediaTypeExpression: java.lang.String type>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	return $z0
;block_num 1