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

(declare-sort var3192 0)
(declare-sort var915 0)
(declare-sort var2814 0)
(declare-sort var3204 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2814_bootstrap$/1035837133 () var915)
(declare-fun var3204_compile/-253472227 ((Array Int String) var915) var3204)
(declare-const null-String String)
(declare-const var34 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var34 null-String)))
; split operation: var438 = var34.split("\u005cn") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\n") 
(define-const var1680 var915 var2814_bootstrap$/1035837133) ; Statement: $r1 = staticinvoke <org.jline.builtins.Options$getenv__41: java.util.function.Function bootstrap$()>() 
(define-const var3147 var3204 (var3204_compile/-253472227 var438 var1680)) ; Statement: $r3 = staticinvoke <org.jline.builtins.Options: org.jline.builtins.Options compile(java.lang.String[],java.util.function.Function)>($r2, $r1) 
 ; Statement: return $r3 
(check-sat)
; {var2814_bootstrap$/1035837133=([], java.util.function.Function), var3204_compile/-253472227=([java.lang.String[], java.util.function.Function], org.jline.builtins.Options)}
; {var34=r0, var3192=null_type, var438=$r2, var915=java.util.function.Function, var2814=org.jline.builtins.Options$getenv__41, var1680=$r1, var3204=org.jline.builtins.Options, var3147=$r3}
; {r0=var34, null_type=var3192, $r2=var438, java.util.function.Function=var915, org.jline.builtins.Options$getenv__41=var2814, $r1=var1680, org.jline.builtins.Options=var3204, $r3=var3147}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\n");	$r1 = staticinvoke <org.jline.builtins.Options$getenv__41: java.util.function.Function bootstrap$()>();	$r3 = staticinvoke <org.jline.builtins.Options: org.jline.builtins.Options compile(java.lang.String[],java.util.function.Function)>($r2, $r1);	return $r3
;block_num 1