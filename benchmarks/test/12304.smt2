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

(declare-sort var1050 0)
(declare-sort var2970 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplicationName/1861025684 (var2970) String)
(declare-const null-String String)
(declare-const null-var2970 var2970)
(declare-const var214 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var214 null-String)))
(declare-const var3181 var2970) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var3181 null-var2970)))
(assert true)
(define-const var1715 String (getApplicationName/1861025684 var3181)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>() 
(assert true)
(define-const var1063 Bool (= var214 var1715)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getApplicationName/1861025684=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String)}
; {var214=r0, var1050=null_type, var2970=org.apache.dubbo.rpc.model.ApplicationModel, var3181=r1, var1715=$r2, var1063=$z0}
; {r0=var214, null_type=var1050, org.apache.dubbo.rpc.model.ApplicationModel=var2970, r1=var3181, $r2=var1715, $z0=var1063}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel;	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1