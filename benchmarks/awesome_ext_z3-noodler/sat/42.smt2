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

(declare-sort var55 0)
(declare-sort var806 0)
(declare-sort var2956 0)
(declare-sort var1393 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2956_getRegister/-193481205 (var2956) var1393)
(declare-fun var806_toString/-646077907 (var806) String)
(declare-fun var1393_export/538644832 (var1393 (Array Int String)) void)
(declare-const null-var55 var55)
(declare-const null-var806 var806)
(declare-const null-var2956 var2956)
(declare-const var3279 var55) ; Statement: r5 := @this: javax0.jamal.builtins.Export 
(assert (not (= var3279 null-var55)))
(declare-const var3993 var806) ; Statement: r1 := @parameter0: javax0.jamal.api.Input 
(assert (not (= var3993 null-var806)))
(declare-const var518 var2956) ; Statement: r0 := @parameter1: javax0.jamal.api.Processor 
(assert (not (= var518 null-var2956)))
(define-const var1999 var1393 (var2956_getRegister/-193481205 var518)) ; Statement: $r4 = interfaceinvoke r0.<javax0.jamal.api.Processor: javax0.jamal.api.MacroRegister getRegister()>() 
(define-const var2861 String (var806_toString/-646077907 var3993)) ; Statement: $r2 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>() 
; split operation: var1124 = var2861.split(",") ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
;(assert (var1393_export/538644832 var1999 var1124)) ; Statement: interfaceinvoke $r4.<javax0.jamal.api.MacroRegister: void export(java.lang.String[])>($r3) 

(declare-const var1999!1 var1393)
(declare-const var1124!1 (Array Int String))
 ; Statement: return "" 
(check-sat)
; {var2956_getRegister/-193481205=([javax0.jamal.api.Processor], javax0.jamal.api.MacroRegister), var806_toString/-646077907=([javax0.jamal.api.Input], java.lang.String), var1393_export/538644832=([javax0.jamal.api.MacroRegister, java.lang.String[]], void)}
; {var55=javax0.jamal.builtins.Export, var3279=r5, var806=javax0.jamal.api.Input, var3993=r1, var2956=javax0.jamal.api.Processor, var518=r0, var1393=javax0.jamal.api.MacroRegister, var1999=$r4, var2861=$r2, var1124=$r3}
; {javax0.jamal.builtins.Export=var55, r5=var3279, javax0.jamal.api.Input=var806, r1=var3993, javax0.jamal.api.Processor=var2956, r0=var518, javax0.jamal.api.MacroRegister=var1393, $r4=var1999, $r2=var2861, $r3=var1124}
;seq <javax0.jamal.api.Input: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @this: javax0.jamal.builtins.Export;	r1 := @parameter0: javax0.jamal.api.Input;	r0 := @parameter1: javax0.jamal.api.Processor;	$r4 = interfaceinvoke r0.<javax0.jamal.api.Processor: javax0.jamal.api.MacroRegister getRegister()>();	$r2 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	interfaceinvoke $r4.<javax0.jamal.api.MacroRegister: void export(java.lang.String[])>($r3);	return ""
;block_num 1