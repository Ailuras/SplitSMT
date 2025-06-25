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

(declare-sort var2372 0)
(declare-sort var1572 0)
(declare-sort var1108 0)
(declare-sort var1273 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1108_asList/1779083644 ((Array Int var1273)) var1572)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1273__ ((Array Int String)) (Array Int var1273))
(declare-const null-String String)
(declare-const var3241 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3241 null-String)))
(declare-const var2260 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2260 null-String)))
; split operation: var2128 = var3241.split(var2260) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1) 
(define-const var3918 var1572 (var1108_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var1273__ var2128))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r2) 
 ; Statement: return $r3 
(check-sat)
; {var1108_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var1273__=([java.lang.String[]], java.lang.Object[])}
; {var3241=r0, var2372=null_type, var2260=r1, var2128=$r2, var1572=java.util.List, var1108=java.util.Arrays, var1273=java.lang.Object, var3918=$r3}
; {r0=var3241, null_type=var2372, r1=var2260, $r2=var2128, java.util.List=var1572, java.util.Arrays=var1108, java.lang.Object=var1273, $r3=var3918}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1);	$r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r2);	return $r3
;block_num 1