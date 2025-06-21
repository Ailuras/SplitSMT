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

(declare-sort var1073 0)
(declare-sort var3344 0)
(declare-sort var936 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1633728430 (var936) String)
(declare-fun cast-from-var3344-to-var936 (var3344) var936)
(declare-const null-String String)
(declare-const var3344-GET var3344)
(declare-const var3683 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3683 null-String)))
(define-const var233 var3344 var3344-GET) ; Statement: $r0 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods GET> 
(assert true)
(define-const var304 String (name/1633728430 (cast-from-var3344-to-var936 var233))) ; Statement: $r2 = virtualinvoke $r0.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>() 
(assert true)
(define-const var496 Bool (= var304 var3683)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var3344-to-var936=([org.apache.dubbo.remoting.http12.HttpMethods], java.lang.Enum)}
; {var3683=r1, var1073=null_type, var3344=org.apache.dubbo.remoting.http12.HttpMethods, var233=$r0, var936=java.lang.Enum, var304=$r2, var496=$z0}
; {r1=var3683, null_type=var1073, org.apache.dubbo.remoting.http12.HttpMethods=var3344, $r0=var233, java.lang.Enum=var936, $r2=var304, $z0=var496}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods GET>;	$r2 = virtualinvoke $r0.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	return $z0
;block_num 1