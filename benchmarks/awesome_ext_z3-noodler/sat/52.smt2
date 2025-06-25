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

(declare-sort var3991 0)
(declare-sort var2399 0)
(declare-sort var1560 0)
(declare-sort var3524 0)
(declare-sort var293 0)
(declare-sort var926 0)
(declare-sort var89 0)
(declare-sort var3675 0)
(declare-sort var2514 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var926!class ClassObject)
(declare-fun newScanner/-1762478447 (var3991 var2399 var1560) var3524)
(declare-fun enumeration/-658349494 (var3524 ClassObject) var293)
(declare-fun defaultValue/-1238012330 (var293 var89) var293)
(declare-fun cast-from-var926-to-var89 (var926) var89)
(declare-fun done/1363411092 (var3524) void)
(declare-fun var3675_getInstance/-519208647 (var1560) var3675)
(declare-fun get/-1891924677 (var293 ClassObject) var89)
(declare-fun cast-from-var89-to-var926 (var89) var926)
(declare-fun ordinal/-291641772 (var2514) Int)
(declare-fun cast-from-var926-to-var2514 (var926) var2514)
(declare-fun var2399_toString/-646077907 (var2399) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun popOptions/57805932 (var3675 (Array Int String)) void)
(declare-const null-var3991 var3991)
(declare-const null-var2399 var2399)
(declare-const null-var1560 var1560)
(declare-const var926-set var926)
(declare-const var689 var3991) ; Statement: r0 := @this: javax0.jamal.builtins.Options 
(assert (not (= var689 null-var3991)))
(declare-const var2396 var2399) ; Statement: r1 := @parameter0: javax0.jamal.api.Input 
(assert (not (= var2396 null-var2399)))
(declare-const var1426 var1560) ; Statement: r2 := @parameter1: javax0.jamal.api.Processor 
(assert (not (= var1426 null-var1560)))
(assert true)
(define-const var1573 var3524 (newScanner/-1762478447 var689 var2396 var1426)) ; Statement: r3 = virtualinvoke r0.<javax0.jamal.builtins.Options: javax0.jamal.tools.Scanner$ScannerObject newScanner(javax0.jamal.api.Input,javax0.jamal.api.Processor)>(r1, r2) 
(assert true)
(define-const var925 var293 (enumeration/-658349494 var1573 var926!class)) ; Statement: $r5 = virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: javax0.jamal.tools.param.EnumerationParameter enumeration(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;") 
(define-const var1562 var926 var926-set) ; Statement: $r4 = <javax0.jamal.builtins.Options$PushPop: javax0.jamal.builtins.Options$PushPop set> 
(assert true)
(define-const var2280 var293 (defaultValue/-1238012330 var925 (cast-from-var926-to-var89 var1562))) ; Statement: r6 = virtualinvoke $r5.<javax0.jamal.tools.param.EnumerationParameter: javax0.jamal.tools.param.EnumerationParameter defaultValue(java.lang.Object)>($r4) 
(assert true)
;(assert (done/1363411092 var1573)) ; Statement: virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: void done()>() 

(declare-const var1573!1 var3524)
(define-const var551 var3675 (var3675_getInstance/-519208647 var1426)) ; Statement: r7 = staticinvoke <javax0.jamal.tools.OptionsStore: javax0.jamal.tools.OptionsStore getInstance(javax0.jamal.api.Processor)>(r2) 
(assert true)
(define-const var3290 var89 (get/-1891924677 var2280 var926!class)) ; Statement: $r8 = virtualinvoke r6.<javax0.jamal.tools.param.EnumerationParameter: java.lang.Object get(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;") 
(define-const var210 var926 (cast-from-var89-to-var926 var3290)) ; Statement: $r9 = (javax0.jamal.builtins.Options$PushPop) $r8 
(assert true)
(define-const var2791 Int (ordinal/-291641772 (cast-from-var926-to-var2514 var210))) ; Statement: $i0 = virtualinvoke $r9.<javax0.jamal.builtins.Options$PushPop: int ordinal()>() 
 ; Statement: tableswitch($i0) {     case 0: goto $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 1: goto $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 2: goto $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     default: goto return ""; } 
(assert (and (= var2791 1) (and (not (= var2791 0)) true))) ; Intersect: Cond: $i0 == 1  and Intersect: Negate: Cond: $i0 == 0   and Non Conditional  
(define-const var3220 String (var2399_toString/-646077907 var2396)) ; Statement: $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>() 
(define-const var1516 Int (cast-from-Int-to-Int -1)) ; Statement: $i4 = (int) -1 
; split operation: var26 = var3220.split("\u005c||\u005cs+", var1516) ; Statement: $r13 = virtualinvoke $r12.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\||\\s+", $i4) 
(assert true)
;(assert (popOptions/57805932 var551 var26)) ; Statement: virtualinvoke r7.<javax0.jamal.tools.OptionsStore: void popOptions(java.lang.String[])>($r13) 

(declare-const var551!1 var3675)
(declare-const var26!1 (Array Int String))
 ; Statement: goto [?= return ""] 
(assert true) ; Non Conditional
 ; Statement: return "" 
(check-sat)
; {newScanner/-1762478447=([javax0.jamal.builtins.Options, javax0.jamal.api.Input, javax0.jamal.api.Processor], javax0.jamal.tools.Scanner$ScannerObject), enumeration/-658349494=([javax0.jamal.tools.Scanner$ScannerObject, java.lang.Class], javax0.jamal.tools.param.EnumerationParameter), defaultValue/-1238012330=([javax0.jamal.tools.param.EnumerationParameter, java.lang.Object], javax0.jamal.tools.param.EnumerationParameter), cast-from-var926-to-var89=([javax0.jamal.builtins.Options$PushPop], java.lang.Object), done/1363411092=([javax0.jamal.tools.Scanner$ScannerObject], void), var3675_getInstance/-519208647=([javax0.jamal.api.Processor], javax0.jamal.tools.OptionsStore), get/-1891924677=([javax0.jamal.tools.param.EnumerationParameter, java.lang.Class], java.lang.Object), cast-from-var89-to-var926=([java.lang.Object], javax0.jamal.builtins.Options$PushPop), ordinal/-291641772=([java.lang.Enum], int), cast-from-var926-to-var2514=([javax0.jamal.builtins.Options$PushPop], java.lang.Enum), var2399_toString/-646077907=([javax0.jamal.api.Input], java.lang.String), cast-from-Int-to-Int=([int], int), popOptions/57805932=([javax0.jamal.tools.OptionsStore, java.lang.String[]], void)}
; {var3991=javax0.jamal.builtins.Options, var689=r0, var2399=javax0.jamal.api.Input, var2396=r1, var1560=javax0.jamal.api.Processor, var1426=r2, var3524=javax0.jamal.tools.Scanner$ScannerObject, var1573=r3, var293=javax0.jamal.tools.param.EnumerationParameter, var926=javax0.jamal.builtins.Options$PushPop, var925=$r5, var1562=$r4, var89=java.lang.Object, var2280=r6, var3675=javax0.jamal.tools.OptionsStore, var551=r7, var3290=$r8, var210=$r9, var2514=java.lang.Enum, var2791=$i0, var3220=$r12, var1516=$i4, var26=$r13}
; {javax0.jamal.builtins.Options=var3991, r0=var689, javax0.jamal.api.Input=var2399, r1=var2396, javax0.jamal.api.Processor=var1560, r2=var1426, javax0.jamal.tools.Scanner$ScannerObject=var3524, r3=var1573, javax0.jamal.tools.param.EnumerationParameter=var293, javax0.jamal.builtins.Options$PushPop=var926, $r5=var925, $r4=var1562, java.lang.Object=var89, r6=var2280, javax0.jamal.tools.OptionsStore=var3675, r7=var551, $r8=var3290, $r9=var210, java.lang.Enum=var2514, $i0=var2791, $r12=var3220, $i4=var1516, $r13=var26}
;seq <javax0.jamal.api.Input: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: javax0.jamal.builtins.Options;	r1 := @parameter0: javax0.jamal.api.Input;	r2 := @parameter1: javax0.jamal.api.Processor;	r3 = virtualinvoke r0.<javax0.jamal.builtins.Options: javax0.jamal.tools.Scanner$ScannerObject newScanner(javax0.jamal.api.Input,javax0.jamal.api.Processor)>(r1, r2);	$r5 = virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: javax0.jamal.tools.param.EnumerationParameter enumeration(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;");	$r4 = <javax0.jamal.builtins.Options$PushPop: javax0.jamal.builtins.Options$PushPop set>;	r6 = virtualinvoke $r5.<javax0.jamal.tools.param.EnumerationParameter: javax0.jamal.tools.param.EnumerationParameter defaultValue(java.lang.Object)>($r4);	virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: void done()>();	r7 = staticinvoke <javax0.jamal.tools.OptionsStore: javax0.jamal.tools.OptionsStore getInstance(javax0.jamal.api.Processor)>(r2);	$r8 = virtualinvoke r6.<javax0.jamal.tools.param.EnumerationParameter: java.lang.Object get(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;");	$r9 = (javax0.jamal.builtins.Options$PushPop) $r8;	$i0 = virtualinvoke $r9.<javax0.jamal.builtins.Options$PushPop: int ordinal()>();	tableswitch($i0) {     case 0: goto $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 1: goto $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 2: goto $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     default: goto return ""; };	$r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();	$i4 = (int) -1;	$r13 = virtualinvoke $r12.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\||\\s+", $i4);	virtualinvoke r7.<javax0.jamal.tools.OptionsStore: void popOptions(java.lang.String[])>($r13);	goto [?= return ""];	return ""
;block_num 3