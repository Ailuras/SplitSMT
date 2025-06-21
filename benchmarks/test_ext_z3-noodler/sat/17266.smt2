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

(declare-sort var1102 0)
(declare-sort var2039 0)
(declare-sort var2391 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun name/1633728430 (var2391) String)
(declare-fun cast-from-var2039-to-var2391 (var2039) var2391)
(declare-const null-String String)
(declare-const var2039-POST var2039)
(declare-const var3438 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3438 null-String)))
(define-const var60 var2039 var2039-POST) ; Statement: $r0 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods POST> 
(assert true)
(define-const var2636 String (name/1633728430 (cast-from-var2039-to-var2391 var60))) ; Statement: $r2 = virtualinvoke $r0.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>() 
(assert true)
(define-const var2873 Bool (= var2636 var3438)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1) 
 ; Statement: return $z0 
(check-sat)
; {name/1633728430=([java.lang.Enum], java.lang.String), cast-from-var2039-to-var2391=([org.apache.dubbo.remoting.http12.HttpMethods], java.lang.Enum)}
; {var3438=r1, var1102=null_type, var2039=org.apache.dubbo.remoting.http12.HttpMethods, var60=$r0, var2391=java.lang.Enum, var2636=$r2, var2873=$z0}
; {r1=var3438, null_type=var1102, org.apache.dubbo.remoting.http12.HttpMethods=var2039, $r0=var60, java.lang.Enum=var2391, $r2=var2636, $z0=var2873}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = <org.apache.dubbo.remoting.http12.HttpMethods: org.apache.dubbo.remoting.http12.HttpMethods POST>;	$r2 = virtualinvoke $r0.<org.apache.dubbo.remoting.http12.HttpMethods: java.lang.String name()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>(r1);	return $z0
;block_num 1