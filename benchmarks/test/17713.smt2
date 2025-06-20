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

(declare-sort var547 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun type/981343671 (var547) String)
(declare-const null-var547 var547)
(declare-const var874 var547) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.message.MediaType 
(assert (not (= var874 null-var547)))
(define-const var465 String "text") ; Statement: $r2 = "text" 
(define-const var1445 String (type/981343671 var874)) ; Statement: $r1 = r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String type> 
(assert true)
(define-const var196 Bool (= var465 var1445)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: return $z0 
(check-sat)
; {type/981343671=([org.apache.dubbo.remoting.http12.message.MediaType], java.lang.String)}
; {var547=org.apache.dubbo.remoting.http12.message.MediaType, var874=r0, var465=$r2, var1445=$r1, var196=$z0}
; {org.apache.dubbo.remoting.http12.message.MediaType=var547, r0=var874, $r2=var465, $r1=var1445, $z0=var196}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.message.MediaType;	$r2 = "text";	$r1 = r0.<org.apache.dubbo.remoting.http12.message.MediaType: java.lang.String type>;	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	return $z0
;block_num 1