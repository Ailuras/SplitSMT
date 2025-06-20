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

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-const null-__Array__Int__ClassObject__ (Array Int ClassObject))
(declare-const null-Int Int)
(declare-const var641 (Array Int ClassObject)) ; Statement: r0 := @parameter0: java.lang.Class[] 
(assert (not (= var641 null-__Array__Int__ClassObject__)))
(declare-const var887 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var887 null-Int)))
(define-const var2857 String "org.apache.dubbo.rpc.Invocation") ; Statement: $r3 = "org.apache.dubbo.rpc.Invocation" 
(define-const var3501 ClassObject (select var641 var887)) ; Statement: $r1 = r0[i0] 
(assert true)
(define-const var3009 String (getName/-1958580599 var3501)) ; Statement: $r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var3149 Bool (= var2857 var3009)) ; Statement: $z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getName/-1958580599=([java.lang.Class], java.lang.String)}
; {var641=r0, var887=i0, var2857=$r3, var3501=$r1, var3009=$r2, var3149=$z0}
; {r0=var641, i0=var887, $r3=var2857, $r1=var3501, $r2=var3009, $z0=var3149}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.Class[];	i0 := @parameter1: int;	$r3 = "org.apache.dubbo.rpc.Invocation";	$r1 = r0[i0];	$r2 = virtualinvoke $r1.<java.lang.Class: java.lang.String getName()>();	$z0 = virtualinvoke $r3.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1