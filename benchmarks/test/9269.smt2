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

(declare-sort var1732 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1732_interfaceName/709619582 (var1732) String)
(declare-const null-var1732 var1732)
(declare-const null-ClassObject ClassObject)
(declare-const var507 var1732) ; Statement: r0 := @parameter0: org.apache.dubbo.config.annotation.Reference 
(assert (not (= var507 null-var1732)))
(declare-const var988 ClassObject) ; Statement: r5 := @parameter1: java.lang.Class 
(assert (not (= var988 null-ClassObject)))
(define-const var3456 String "") ; Statement: $r2 = "" 
(define-const var2422 String (var1732_interfaceName/709619582 var507)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Reference: java.lang.String interfaceName()>() 
(assert true)
(define-const var3033 Bool (= var3456 var2422)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 != 0 goto $r3 = <java.lang.Void: java.lang.Class TYPE> 
(assert (not (not (= (ite var3033 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3055 String (var1732_interfaceName/709619582 var507)) ; Statement: r14 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Reference: java.lang.String interfaceName()>() 
 ; Statement: goto [?= return r14] 
(assert true) ; Non Conditional
 ; Statement: return r14 
(check-sat)
; {var1732_interfaceName/709619582=([org.apache.dubbo.config.annotation.Reference], java.lang.String)}
; {var1732=org.apache.dubbo.config.annotation.Reference, var507=r0, var988=r5, var3456=$r2, var2422=$r1, var3033=$z0, var3055=r14}
; {org.apache.dubbo.config.annotation.Reference=var1732, r0=var507, r5=var988, $r2=var3456, $r1=var2422, $z0=var3033, r14=var3055}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.config.annotation.Reference;	r5 := @parameter1: java.lang.Class;	$r2 = "";	$r1 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Reference: java.lang.String interfaceName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 != 0 goto $r3 = <java.lang.Void: java.lang.Class TYPE>;	r14 = interfaceinvoke r0.<org.apache.dubbo.config.'annotation'.Reference: java.lang.String interfaceName()>();	goto [?= return r14];	return r14
;block_num 3