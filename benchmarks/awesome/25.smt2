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

(declare-sort var2338 0)
(declare-sort var2794 0)
(declare-sort var3775 0)
(declare-sort var2217 0)
(declare-sort var2445 0)
(declare-sort var1087 0)
(declare-sort var1664 0)
(declare-sort var3675 0)
(declare-sort var2055 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1087!class ClassObject)
(declare-fun newScanner/-1762478447 (var2338 var2794 var3775) var2217)
(declare-fun enumeration/-658349494 (var2217 ClassObject) var2445)
(declare-fun defaultValue/-1238012330 (var2445 var1664) var2445)
(declare-fun cast-from-var1087-to-var1664 (var1087) var1664)
(declare-fun done/1363411092 (var2217) void)
(declare-fun var3675_getInstance/-519208647 (var3775) var3675)
(declare-fun get/-1891924677 (var2445 ClassObject) var1664)
(declare-fun cast-from-var1664-to-var1087 (var1664) var1087)
(declare-fun ordinal/-291641772 (var2055) Int)
(declare-fun cast-from-var1087-to-var2055 (var1087) var2055)
(declare-fun var2794_toString/-646077907 (var2794) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun pushOptions/-127490581 (var3675 (Array Int String)) void)
(declare-const null-var2338 var2338)
(declare-const null-var2794 var2794)
(declare-const null-var3775 var3775)
(declare-const var1087-set var1087)
(declare-const var1483 var2338) ; Statement: r0 := @this: javax0.jamal.builtins.Options 
(assert (not (= var1483 null-var2338)))
(declare-const var2380 var2794) ; Statement: r1 := @parameter0: javax0.jamal.api.Input 
(assert (not (= var2380 null-var2794)))
(declare-const var689 var3775) ; Statement: r2 := @parameter1: javax0.jamal.api.Processor 
(assert (not (= var689 null-var3775)))
(assert true)
(define-const var3140 var2217 (newScanner/-1762478447 var1483 var2380 var689)) ; Statement: r3 = virtualinvoke r0.<javax0.jamal.builtins.Options: javax0.jamal.tools.Scanner$ScannerObject newScanner(javax0.jamal.api.Input,javax0.jamal.api.Processor)>(r1, r2) 
(assert true)
(define-const var1392 var2445 (enumeration/-658349494 var3140 var1087!class)) ; Statement: $r5 = virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: javax0.jamal.tools.param.EnumerationParameter enumeration(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;") 
(define-const var3839 var1087 var1087-set) ; Statement: $r4 = <javax0.jamal.builtins.Options$PushPop: javax0.jamal.builtins.Options$PushPop set> 
(assert true)
(define-const var1254 var2445 (defaultValue/-1238012330 var1392 (cast-from-var1087-to-var1664 var3839))) ; Statement: r6 = virtualinvoke $r5.<javax0.jamal.tools.param.EnumerationParameter: javax0.jamal.tools.param.EnumerationParameter defaultValue(java.lang.Object)>($r4) 
(assert true)
;(assert (done/1363411092 var3140)) ; Statement: virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: void done()>() 

(declare-const var3140!1 var2217)
(define-const var2362 var3675 (var3675_getInstance/-519208647 var689)) ; Statement: r7 = staticinvoke <javax0.jamal.tools.OptionsStore: javax0.jamal.tools.OptionsStore getInstance(javax0.jamal.api.Processor)>(r2) 
(assert true)
(define-const var3104 var1664 (get/-1891924677 var1254 var1087!class)) ; Statement: $r8 = virtualinvoke r6.<javax0.jamal.tools.param.EnumerationParameter: java.lang.Object get(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;") 
(define-const var3620 var1087 (cast-from-var1664-to-var1087 var3104)) ; Statement: $r9 = (javax0.jamal.builtins.Options$PushPop) $r8 
(assert true)
(define-const var2463 Int (ordinal/-291641772 (cast-from-var1087-to-var2055 var3620))) ; Statement: $i0 = virtualinvoke $r9.<javax0.jamal.builtins.Options$PushPop: int ordinal()>() 
 ; Statement: tableswitch($i0) {     case 0: goto $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 1: goto $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 2: goto $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     default: goto return ""; } 
(assert (and (= var2463 0) true)) ; Intersect: Cond: $i0 == 0  and Non Conditional 
(define-const var2239 String (var2794_toString/-646077907 var2380)) ; Statement: $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>() 
(define-const var2731 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var1451 = var2239.split("\u005c||\u005cs+", var2731) ; Statement: $r15 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\||\\s+", $i2) 
(assert true)
;(assert (pushOptions/-127490581 var2362 var1451)) ; Statement: virtualinvoke r7.<javax0.jamal.tools.OptionsStore: void pushOptions(java.lang.String[])>($r15) 

(declare-const var2362!1 var3675)
(declare-const var1451!1 (Array Int String))
 ; Statement: goto [?= return ""] 
(assert true) ; Non Conditional
 ; Statement: return "" 
(check-sat)
; {newScanner/-1762478447=([javax0.jamal.builtins.Options, javax0.jamal.api.Input, javax0.jamal.api.Processor], javax0.jamal.tools.Scanner$ScannerObject), enumeration/-658349494=([javax0.jamal.tools.Scanner$ScannerObject, java.lang.Class], javax0.jamal.tools.param.EnumerationParameter), defaultValue/-1238012330=([javax0.jamal.tools.param.EnumerationParameter, java.lang.Object], javax0.jamal.tools.param.EnumerationParameter), cast-from-var1087-to-var1664=([javax0.jamal.builtins.Options$PushPop], java.lang.Object), done/1363411092=([javax0.jamal.tools.Scanner$ScannerObject], void), var3675_getInstance/-519208647=([javax0.jamal.api.Processor], javax0.jamal.tools.OptionsStore), get/-1891924677=([javax0.jamal.tools.param.EnumerationParameter, java.lang.Class], java.lang.Object), cast-from-var1664-to-var1087=([java.lang.Object], javax0.jamal.builtins.Options$PushPop), ordinal/-291641772=([java.lang.Enum], int), cast-from-var1087-to-var2055=([javax0.jamal.builtins.Options$PushPop], java.lang.Enum), var2794_toString/-646077907=([javax0.jamal.api.Input], java.lang.String), cast-from-Int-to-Int=([int], int), pushOptions/-127490581=([javax0.jamal.tools.OptionsStore, java.lang.String[]], void)}
; {var2338=javax0.jamal.builtins.Options, var1483=r0, var2794=javax0.jamal.api.Input, var2380=r1, var3775=javax0.jamal.api.Processor, var689=r2, var2217=javax0.jamal.tools.Scanner$ScannerObject, var3140=r3, var2445=javax0.jamal.tools.param.EnumerationParameter, var1087=javax0.jamal.builtins.Options$PushPop, var1392=$r5, var3839=$r4, var1664=java.lang.Object, var1254=r6, var3675=javax0.jamal.tools.OptionsStore, var2362=r7, var3104=$r8, var3620=$r9, var2055=java.lang.Enum, var2463=$i0, var2239=$r14, var2731=$i2, var1451=$r15}
; {javax0.jamal.builtins.Options=var2338, r0=var1483, javax0.jamal.api.Input=var2794, r1=var2380, javax0.jamal.api.Processor=var3775, r2=var689, javax0.jamal.tools.Scanner$ScannerObject=var2217, r3=var3140, javax0.jamal.tools.param.EnumerationParameter=var2445, javax0.jamal.builtins.Options$PushPop=var1087, $r5=var1392, $r4=var3839, java.lang.Object=var1664, r6=var1254, javax0.jamal.tools.OptionsStore=var3675, r7=var2362, $r8=var3104, $r9=var3620, java.lang.Enum=var2055, $i0=var2463, $r14=var2239, $i2=var2731, $r15=var1451}
;seq <javax0.jamal.api.Input: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: javax0.jamal.builtins.Options;	r1 := @parameter0: javax0.jamal.api.Input;	r2 := @parameter1: javax0.jamal.api.Processor;	r3 = virtualinvoke r0.<javax0.jamal.builtins.Options: javax0.jamal.tools.Scanner$ScannerObject newScanner(javax0.jamal.api.Input,javax0.jamal.api.Processor)>(r1, r2);	$r5 = virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: javax0.jamal.tools.param.EnumerationParameter enumeration(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;");	$r4 = <javax0.jamal.builtins.Options$PushPop: javax0.jamal.builtins.Options$PushPop set>;	r6 = virtualinvoke $r5.<javax0.jamal.tools.param.EnumerationParameter: javax0.jamal.tools.param.EnumerationParameter defaultValue(java.lang.Object)>($r4);	virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: void done()>();	r7 = staticinvoke <javax0.jamal.tools.OptionsStore: javax0.jamal.tools.OptionsStore getInstance(javax0.jamal.api.Processor)>(r2);	$r8 = virtualinvoke r6.<javax0.jamal.tools.param.EnumerationParameter: java.lang.Object get(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;");	$r9 = (javax0.jamal.builtins.Options$PushPop) $r8;	$i0 = virtualinvoke $r9.<javax0.jamal.builtins.Options$PushPop: int ordinal()>();	tableswitch($i0) {     case 0: goto $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 1: goto $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 2: goto $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     default: goto return ""; };	$r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();	$i2 = (int) -1;	$r15 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\||\\s+", $i2);	virtualinvoke r7.<javax0.jamal.tools.OptionsStore: void pushOptions(java.lang.String[])>($r15);	goto [?= return ""];	return ""
;block_num 3