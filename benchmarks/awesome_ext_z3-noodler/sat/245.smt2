(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3435 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isPresent/-317583191 (var3435) Bool)
(declare-fun get/637268509 (var3435) String)
(declare-const null-var3435 var3435)
(declare-const var678 var3435) ; Statement: r0 := @parameter0: javax0.jamal.tools.param.StringParameter 
(assert (not (= var678 null-var3435)))
(assert true)
(define-const var3702 Bool (isPresent/-317583191 var678)) ; Statement: $z0 = virtualinvoke r0.<javax0.jamal.tools.param.StringParameter: boolean isPresent()>() 
 ; Statement: if $z0 == 0 goto $r1 = newarray (java.lang.String)[1] 
(assert (not (= (ite var3702 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2151 String (get/637268509 var678)) ; Statement: $r2 = virtualinvoke r0.<javax0.jamal.tools.param.StringParameter: java.lang.String get()>() 
; split operation: var556 = var2151.split("\u005c|") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|") 
 ; Statement: goto [?= return r3] 
(assert true) ; Non Conditional
 ; Statement: return r3 
(check-sat)
; {isPresent/-317583191=([javax0.jamal.tools.param.StringParameter], boolean), get/637268509=([javax0.jamal.tools.param.StringParameter], java.lang.String)}
; {var3435=javax0.jamal.tools.param.StringParameter, var678=r0, var3702=$z0, var2151=$r2, var556=r3}
; {javax0.jamal.tools.param.StringParameter=var3435, r0=var678, $z0=var3702, $r2=var2151, r3=var556}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: javax0.jamal.tools.param.StringParameter;	$z0 = virtualinvoke r0.<javax0.jamal.tools.param.StringParameter: boolean isPresent()>();	if $z0 == 0 goto $r1 = newarray (java.lang.String)[1];	$r2 = virtualinvoke r0.<javax0.jamal.tools.param.StringParameter: java.lang.String get()>();	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|");	goto [?= return r3];	return r3
;block_num 3