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

(declare-sort var3687 0)
(declare-sort var3292 0)
(declare-sort var205 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var205_compile/-253472227 ((Array Int String) var3292) var205)
(declare-const null-String String)
(declare-const null-var3292 var3292)
(declare-const var2393 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2393 null-String)))
(declare-const var3363 var3292) ; Statement: r1 := @parameter1: java.util.function.Function 
(assert (not (= var3363 null-var3292)))
; split operation: var1545 = var2393.split("\u005cn") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\n") 
(define-const var702 var205 (var205_compile/-253472227 var1545 var3363)) ; Statement: $r3 = staticinvoke <org.jline.builtins.Options: org.jline.builtins.Options compile(java.lang.String[],java.util.function.Function)>($r2, r1) 
 ; Statement: return $r3 
(check-sat)
; {var205_compile/-253472227=([java.lang.String[], java.util.function.Function], org.jline.builtins.Options)}
; {var2393=r0, var3687=null_type, var3292=java.util.function.Function, var3363=r1, var1545=$r2, var205=org.jline.builtins.Options, var702=$r3}
; {r0=var2393, null_type=var3687, java.util.function.Function=var3292, r1=var3363, $r2=var1545, org.jline.builtins.Options=var205, $r3=var702}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.util.function.Function;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\n");	$r3 = staticinvoke <org.jline.builtins.Options: org.jline.builtins.Options compile(java.lang.String[],java.util.function.Function)>($r2, r1);	return $r3
;block_num 1