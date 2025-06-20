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

(declare-sort var239 0)
(declare-sort var1141 0)
(declare-sort var3069 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/146700231 (var3069) String)
(declare-fun cast-from-var1141-to-var3069 (var1141) var3069)
(declare-const null-String String)
(declare-const null-var1141 var1141)
(declare-const var903 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var903 null-String)))
(declare-const var3625 var1141) ; Statement: r1 := @parameter1: java.beans.MethodDescriptor 
(assert (not (= var3625 null-var1141)))
(assert true)
(define-const var1311 String (getName/146700231 (cast-from-var1141-to-var3069 var3625))) ; Statement: $r2 = virtualinvoke r1.<java.beans.MethodDescriptor: java.lang.String getName()>() 
(assert true)
(define-const var1532 Bool (= var903 var1311)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getName/146700231=([java.beans.FeatureDescriptor], java.lang.String), cast-from-var1141-to-var3069=([java.beans.MethodDescriptor], java.beans.FeatureDescriptor)}
; {var903=r0, var239=null_type, var1141=java.beans.MethodDescriptor, var3625=r1, var3069=java.beans.FeatureDescriptor, var1311=$r2, var1532=$z0}
; {r0=var903, null_type=var239, java.beans.MethodDescriptor=var1141, r1=var3625, java.beans.FeatureDescriptor=var3069, $r2=var1311, $z0=var1532}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.beans.MethodDescriptor;	$r2 = virtualinvoke r1.<java.beans.MethodDescriptor: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1