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

(declare-sort var2902 0)
(declare-sort var3574 0)
(declare-sort var2280 0)
(declare-sort var3790 0)
(declare-sort var44 0)
(declare-sort var409 0)
(declare-sort var1183 0)
(declare-sort var3813 0)
(declare-sort var1654 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var409!class ClassObject)
(declare-fun newScanner/-1762478447 (var2902 var3574 var2280) var3790)
(declare-fun enumeration/-658349494 (var3790 ClassObject) var44)
(declare-fun defaultValue/-1238012330 (var44 var1183) var44)
(declare-fun cast-from-var409-to-var1183 (var409) var1183)
(declare-fun done/1363411092 (var3790) void)
(declare-fun var3813_getInstance/-519208647 (var2280) var3813)
(declare-fun get/-1891924677 (var44 ClassObject) var1183)
(declare-fun cast-from-var1183-to-var409 (var1183) var409)
(declare-fun ordinal/-291641772 (var1654) Int)
(declare-fun cast-from-var409-to-var1654 (var409) var1654)
(declare-fun var3574_toString/-646077907 (var3574) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun addOptions/-760988996 (var3813 (Array Int String)) void)
(declare-const null-var2902 var2902)
(declare-const null-var3574 var3574)
(declare-const null-var2280 var2280)
(declare-const var409-set var409)
(declare-const var309 var2902) ; Statement: r0 := @this: javax0.jamal.builtins.Options 
(assert (not (= var309 null-var2902)))
(declare-const var3971 var3574) ; Statement: r1 := @parameter0: javax0.jamal.api.Input 
(assert (not (= var3971 null-var3574)))
(declare-const var779 var2280) ; Statement: r2 := @parameter1: javax0.jamal.api.Processor 
(assert (not (= var779 null-var2280)))
(assert true)
(define-const var1989 var3790 (newScanner/-1762478447 var309 var3971 var779)) ; Statement: r3 = virtualinvoke r0.<javax0.jamal.builtins.Options: javax0.jamal.tools.Scanner$ScannerObject newScanner(javax0.jamal.api.Input,javax0.jamal.api.Processor)>(r1, r2) 
(assert true)
(define-const var1129 var44 (enumeration/-658349494 var1989 var409!class)) ; Statement: $r5 = virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: javax0.jamal.tools.param.EnumerationParameter enumeration(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;") 
(define-const var2173 var409 var409-set) ; Statement: $r4 = <javax0.jamal.builtins.Options$PushPop: javax0.jamal.builtins.Options$PushPop set> 
(assert true)
(define-const var304 var44 (defaultValue/-1238012330 var1129 (cast-from-var409-to-var1183 var2173))) ; Statement: r6 = virtualinvoke $r5.<javax0.jamal.tools.param.EnumerationParameter: javax0.jamal.tools.param.EnumerationParameter defaultValue(java.lang.Object)>($r4) 
(assert true)
;(assert (done/1363411092 var1989)) ; Statement: virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: void done()>() 

(declare-const var1989!1 var3790)
(define-const var1103 var3813 (var3813_getInstance/-519208647 var779)) ; Statement: r7 = staticinvoke <javax0.jamal.tools.OptionsStore: javax0.jamal.tools.OptionsStore getInstance(javax0.jamal.api.Processor)>(r2) 
(assert true)
(define-const var721 var1183 (get/-1891924677 var304 var409!class)) ; Statement: $r8 = virtualinvoke r6.<javax0.jamal.tools.param.EnumerationParameter: java.lang.Object get(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;") 
(define-const var1527 var409 (cast-from-var1183-to-var409 var721)) ; Statement: $r9 = (javax0.jamal.builtins.Options$PushPop) $r8 
(assert true)
(define-const var1882 Int (ordinal/-291641772 (cast-from-var409-to-var1654 var1527))) ; Statement: $i0 = virtualinvoke $r9.<javax0.jamal.builtins.Options$PushPop: int ordinal()>() 
 ; Statement: tableswitch($i0) {     case 0: goto $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 1: goto $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 2: goto $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     default: goto return ""; } 
(assert (and (= var1882 2) (and (not (= var1882 1)) (and (not (= var1882 0)) true)))) ; Intersect: Cond: $i0 == 2  and Intersect: Negate: Cond: $i0 == 1   and Intersect: Negate: Cond: $i0 == 0   and Non Conditional   
(define-const var3886 String (var3574_toString/-646077907 var3971)) ; Statement: $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>() 
(define-const var2316 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
; split operation: var1991 = var3886.split("\u005c||\u005cs+", var2316) ; Statement: $r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\||\\s+", $i6) 
(assert true)
;(assert (addOptions/-760988996 var1103 var1991)) ; Statement: virtualinvoke r7.<javax0.jamal.tools.OptionsStore: void addOptions(java.lang.String[])>($r11) 

(declare-const var1103!1 var3813)
(declare-const var1991!1 (Array Int String))
(assert true) ; Non Conditional
 ; Statement: return "" 
(check-sat)
; {newScanner/-1762478447=([javax0.jamal.builtins.Options, javax0.jamal.api.Input, javax0.jamal.api.Processor], javax0.jamal.tools.Scanner$ScannerObject), enumeration/-658349494=([javax0.jamal.tools.Scanner$ScannerObject, java.lang.Class], javax0.jamal.tools.param.EnumerationParameter), defaultValue/-1238012330=([javax0.jamal.tools.param.EnumerationParameter, java.lang.Object], javax0.jamal.tools.param.EnumerationParameter), cast-from-var409-to-var1183=([javax0.jamal.builtins.Options$PushPop], java.lang.Object), done/1363411092=([javax0.jamal.tools.Scanner$ScannerObject], void), var3813_getInstance/-519208647=([javax0.jamal.api.Processor], javax0.jamal.tools.OptionsStore), get/-1891924677=([javax0.jamal.tools.param.EnumerationParameter, java.lang.Class], java.lang.Object), cast-from-var1183-to-var409=([java.lang.Object], javax0.jamal.builtins.Options$PushPop), ordinal/-291641772=([java.lang.Enum], int), cast-from-var409-to-var1654=([javax0.jamal.builtins.Options$PushPop], java.lang.Enum), var3574_toString/-646077907=([javax0.jamal.api.Input], java.lang.String), cast-from-Int-to-Int=([int], int), addOptions/-760988996=([javax0.jamal.tools.OptionsStore, java.lang.String[]], void)}
; {var2902=javax0.jamal.builtins.Options, var309=r0, var3574=javax0.jamal.api.Input, var3971=r1, var2280=javax0.jamal.api.Processor, var779=r2, var3790=javax0.jamal.tools.Scanner$ScannerObject, var1989=r3, var44=javax0.jamal.tools.param.EnumerationParameter, var409=javax0.jamal.builtins.Options$PushPop, var1129=$r5, var2173=$r4, var1183=java.lang.Object, var304=r6, var3813=javax0.jamal.tools.OptionsStore, var1103=r7, var721=$r8, var1527=$r9, var1654=java.lang.Enum, var1882=$i0, var3886=$r10, var2316=$i6, var1991=$r11}
; {javax0.jamal.builtins.Options=var2902, r0=var309, javax0.jamal.api.Input=var3574, r1=var3971, javax0.jamal.api.Processor=var2280, r2=var779, javax0.jamal.tools.Scanner$ScannerObject=var3790, r3=var1989, javax0.jamal.tools.param.EnumerationParameter=var44, javax0.jamal.builtins.Options$PushPop=var409, $r5=var1129, $r4=var2173, java.lang.Object=var1183, r6=var304, javax0.jamal.tools.OptionsStore=var3813, r7=var1103, $r8=var721, $r9=var1527, java.lang.Enum=var1654, $i0=var1882, $r10=var3886, $i6=var2316, $r11=var1991}
;seq <javax0.jamal.api.Input: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: javax0.jamal.builtins.Options;	r1 := @parameter0: javax0.jamal.api.Input;	r2 := @parameter1: javax0.jamal.api.Processor;	r3 = virtualinvoke r0.<javax0.jamal.builtins.Options: javax0.jamal.tools.Scanner$ScannerObject newScanner(javax0.jamal.api.Input,javax0.jamal.api.Processor)>(r1, r2);	$r5 = virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: javax0.jamal.tools.param.EnumerationParameter enumeration(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;");	$r4 = <javax0.jamal.builtins.Options$PushPop: javax0.jamal.builtins.Options$PushPop set>;	r6 = virtualinvoke $r5.<javax0.jamal.tools.param.EnumerationParameter: javax0.jamal.tools.param.EnumerationParameter defaultValue(java.lang.Object)>($r4);	virtualinvoke r3.<javax0.jamal.tools.Scanner$ScannerObject: void done()>();	r7 = staticinvoke <javax0.jamal.tools.OptionsStore: javax0.jamal.tools.OptionsStore getInstance(javax0.jamal.api.Processor)>(r2);	$r8 = virtualinvoke r6.<javax0.jamal.tools.param.EnumerationParameter: java.lang.Object get(java.lang.Class)>(class "Ljavax0/jamal/builtins/Options$PushPop;");	$r9 = (javax0.jamal.builtins.Options$PushPop) $r8;	$i0 = virtualinvoke $r9.<javax0.jamal.builtins.Options$PushPop: int ordinal()>();	tableswitch($i0) {     case 0: goto $r14 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 1: goto $r12 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     case 2: goto $r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();     default: goto return ""; };	$r10 = interfaceinvoke r1.<javax0.jamal.api.Input: java.lang.String toString()>();	$i6 = (int) -1;	$r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\||\\s+", $i6);	virtualinvoke r7.<javax0.jamal.tools.OptionsStore: void addOptions(java.lang.String[])>($r11);	return ""
;block_num 3