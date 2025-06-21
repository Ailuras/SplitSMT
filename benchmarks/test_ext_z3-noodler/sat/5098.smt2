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

(declare-sort var670 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getName/-1958580599 (ClassObject) String)
(declare-fun var670_valueOf/-1186540555 (Int) var670)
(declare-const null-ClassObject ClassObject)
(declare-const var2937 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var2937 null-ClassObject)))
(define-const var1603 String "char") ; Statement: $r2 = "char" 
(assert true)
(define-const var2465 String (getName/-1958580599 var2937)) ; Statement: $r1 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var2377 Bool (= var1603 var2465)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r4 = "boolean" 
(assert (not (= (ite var2377 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2201 var670 (var670_valueOf/-1186540555 0)) ; Statement: $r12 = staticinvoke <java.lang.Character: java.lang.Character valueOf(char)>(0) 
 ; Statement: return $r12 
(check-sat)
; {getName/-1958580599=([java.lang.Class], java.lang.String), var670_valueOf/-1186540555=([char], java.lang.Character)}
; {var2937=r0, var1603=$r2, var2465=$r1, var2377=$z0, var670=java.lang.Character, var2201=$r12}
; {r0=var2937, $r2=var1603, $r1=var2465, $z0=var2377, java.lang.Character=var670, $r12=var2201}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.Class;	$r2 = "char";	$r1 = virtualinvoke r0.<java.lang.Class: java.lang.String getName()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r4 = "boolean";	$r12 = staticinvoke <java.lang.Character: java.lang.Character valueOf(char)>(0);	return $r12
;block_num 2