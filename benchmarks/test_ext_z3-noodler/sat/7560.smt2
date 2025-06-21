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

(declare-sort var2971 0)
(declare-sort var3861 0)
(declare-sort var1265 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/146700231 (var1265) String)
(declare-fun cast-from-var3861-to-var1265 (var3861) var1265)
(declare-const null-String String)
(declare-const null-var3861 var3861)
(declare-const var475 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var475 null-String)))
(declare-const var3856 var3861) ; Statement: r1 := @parameter1: java.beans.MethodDescriptor 
(assert (not (= var3856 null-var3861)))
(assert true)
(define-const var2437 String (getName/146700231 (cast-from-var3861-to-var1265 var3856))) ; Statement: $r2 = virtualinvoke r1.<java.beans.MethodDescriptor: java.lang.String getName()>() 
(assert true)
(define-const var2172 Bool (= var475 var2437)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getName/146700231=([java.beans.FeatureDescriptor], java.lang.String), cast-from-var3861-to-var1265=([java.beans.MethodDescriptor], java.beans.FeatureDescriptor)}
; {var475=r0, var2971=null_type, var3861=java.beans.MethodDescriptor, var3856=r1, var1265=java.beans.FeatureDescriptor, var2437=$r2, var2172=$z0}
; {r0=var475, null_type=var2971, java.beans.MethodDescriptor=var3861, r1=var3856, java.beans.FeatureDescriptor=var1265, $r2=var2437, $z0=var2172}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.beans.MethodDescriptor;	$r2 = virtualinvoke r1.<java.beans.MethodDescriptor: java.lang.String getName()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1