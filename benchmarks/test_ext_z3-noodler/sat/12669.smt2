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

(declare-sort var1075 0)
(declare-sort var1190 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCommandName/999015139 (var1075) String)
(declare-const null-var1075 var1075)
(declare-const null-String String)
(declare-const var726 var1075) ; Statement: r1 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var726 null-var1075)))
(declare-const var144 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var144 null-String)))
(assert true)
(define-const var31 String (getCommandName/999015139 var726)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>() 
(assert true)
(define-const var443 Bool (= var144 var31)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getCommandName/999015139=([org.apache.dubbo.qos.api.CommandContext], java.lang.String)}
; {var1075=org.apache.dubbo.qos.api.CommandContext, var726=r1, var144=r0, var1190=null_type, var31=$r2, var443=$z0}
; {org.apache.dubbo.qos.api.CommandContext=var1075, r1=var726, r0=var144, null_type=var1190, $r2=var31, $z0=var443}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r0 := @parameter1: java.lang.String;	$r2 = virtualinvoke r1.<org.apache.dubbo.qos.api.CommandContext: java.lang.String getCommandName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1