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

(declare-sort var383 0)
(declare-sort var2367 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplicationName/1861025684 (var2367) String)
(declare-const null-String String)
(declare-const null-var2367 var2367)
(declare-const var3398 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3398 null-String)))
(declare-const var753 var2367) ; Statement: r1 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel 
(assert (not (= var753 null-var2367)))
(assert true)
(define-const var455 String (getApplicationName/1861025684 var753)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>() 
(assert true)
(define-const var691 Bool (= var3398 var455)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getApplicationName/1861025684=([org.apache.dubbo.rpc.model.ApplicationModel], java.lang.String)}
; {var3398=r0, var383=null_type, var2367=org.apache.dubbo.rpc.model.ApplicationModel, var753=r1, var455=$r2, var691=$z0}
; {r0=var3398, null_type=var383, org.apache.dubbo.rpc.model.ApplicationModel=var2367, r1=var753, $r2=var455, $z0=var691}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.rpc.model.ApplicationModel;	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ApplicationModel: java.lang.String getApplicationName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1