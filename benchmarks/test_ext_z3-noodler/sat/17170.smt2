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

(declare-sort var1408 0)
(declare-sort var2565 0)
(declare-sort var2988 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1633728430 (var2988) String)
(declare-fun cast-from-var1408-to-var2988 (var1408) var2988)
(declare-const null-var1408 var1408)
(declare-const null-String String)
(declare-const var2046 var1408) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.HttpMethods 
(assert (not (= var2046 null-var1408)))
(declare-const var1728 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1728 null-String)))
(assert true)
(define-const var2403 String (name/1633728430 (cast-from-var1408-to-var2988 var2046))) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>() 
(assert true)
(define-const var2471 Bool (= var2403 var1728)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var1408-to-var2988=([org.apache.dubbo.remoting.http12.HttpMethods], java.lang.Enum)}
; {var1408=org.apache.dubbo.remoting.http12.HttpMethods, var2046=r0, var1728=r1, var2565=null_type, var2988=java.lang.Enum, var2403=$r2, var2471=$z0}
; {org.apache.dubbo.remoting.http12.HttpMethods=var1408, r0=var2046, r1=var1728, null_type=var2565, java.lang.Enum=var2988, $r2=var2403, $z0=var2471}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.HttpMethods;	r1 := @parameter0: java.lang.String;	$r2 = virtualinvoke r0.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	return $z0
;block_num 1