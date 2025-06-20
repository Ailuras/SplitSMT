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

(declare-sort var3004 0)
(declare-sort var2930 0)
(declare-sort var2860 0)
(declare-sort var1702 0)
(declare-sort var255 0)
(declare-sort var2407 0)
(declare-sort var3810 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getOptionString/-1090579839 (var3004 String) String)
(declare-fun var2860-init () var2860)
(declare-fun <init>/-1837098426 (var2860 var3004) void)
(declare-fun load/1275204824 (var2860) var1702)
(declare-fun tool/976633046 (var3004) var255)
(declare-fun cast-from-var1702-to-String (var1702) String)
(declare-fun log/967568536 (var255 String String) void)
(declare-fun var1702_keySet/-712633290 (var1702) var2407)
(declare-fun var2407_iterator/1911472585 (var2407) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun Iterator_next/-1124697587 (Iterator) var3810)
(declare-fun cast-from-var3810-to-String (var3810) String)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1702_get/1088891777 (var1702 var3810) var3810)
(declare-fun cast-from-String-to-var3810 (String) var3810)
(declare-fun cast-from-var3810-to-Int (var3810) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun defineTokenName/-46012211 (var3004 String Int) Int)
(declare-const null-var3004 var3004)
(declare-const null-String String)
(declare-const var3428 var3004) ; Statement: r0 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3428 null-var3004)))
(assert true)
(define-const var3613 String (getOptionString/-1090579839 var3428 "tokenVocab")) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.tool.Grammar: java.lang.String getOptionString(java.lang.String)>("tokenVocab") 
 ; Statement: if r1 == null goto return 
(assert (not (= var3613 null-String))) ; Negate: Cond: r1 == null  
(define-const var3989 var2860 var2860-init) ; Statement: $r14 = new org.antlr.v4.parse.TokenVocabParser 
(assert true)
;(assert (<init>/-1837098426 var3989 var3428)) ; Statement: specialinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: void <init>(org.antlr.v4.tool.Grammar)>(r0) 

(declare-const var3989!1 var2860)
(declare-const var3428!1 var3004)
(assert true)
(define-const var2577 var1702 (load/1275204824 var3989!1)) ; Statement: r3 = virtualinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: java.util.Map load()>() 
(define-const var651 var255 (tool/976633046 var3428!1)) ; Statement: $r4 = r0.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool> 
(define-const var1963 String (str.++ "tokens=\u0001" (cast-from-var1702-to-String var2577))) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.util.Map)>(r3) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("tokens=\u0001") 
(assert true)
;(assert (log/967568536 var651 "grammar" var1963)) ; Statement: virtualinvoke $r4.<org.antlr.v4.Tool: void log(java.lang.String,java.lang.String)>("grammar", $r5) 

(declare-const var651!1 var255)
(declare-const var2074 String)
(declare-const var1963!1 String)
(define-const var3871 var2407 (var1702_keySet/-712633290 var2577)) ; Statement: $r6 = interfaceinvoke r3.<java.util.Map: java.util.Set keySet()>() 
(define-const var469 Iterator (var2407_iterator/1911472585 var3871)) ; Statement: r7 = interfaceinvoke $r6.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2402 Bool (Iterator_hasNext/-1669924200 var469)) ; Statement: $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var2402 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3900 var3810 (Iterator_next/-1124697587 var469)) ; Statement: $r8 = interfaceinvoke r7.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var469!1 Iterator)
(define-const var1457 String (cast-from-var3810-to-String var3900)) ; Statement: r9 = (java.lang.String) $r8 
(assert (and true (and (> (str.len var1457) 0) (<= 0 0))))
(define-const var3910 Int (charAt/698050440 var1457 0)) ; Statement: $c0 = virtualinvoke r9.<java.lang.String: char charAt(int)>(0) 
(define-const var3225 Int (cast-from-Int-to-Int var3910)) ; Statement: $i3 = (int) $c0 
 ; Statement: if $i3 != 39 goto $r10 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9) 
(assert (not (= var3225 39))) ; Cond: $i3 != 39 
(define-const var1534 var3810 (var1702_get/1088891777 var2577 (cast-from-String-to-var3810 var1457))) ; Statement: $r10 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9) 
(define-const var453 Int (cast-from-var3810-to-Int var1534)) ; Statement: $r11 = (java.lang.Integer) $r10 
(assert true)
(define-const var1725 Int (intValue/-1815674922 var453)) ; Statement: $i1 = virtualinvoke $r11.<java.lang.Integer: int intValue()>() 
(assert true)
;(assert (defineTokenName/-46012211 var3428!1 var1457 var1725)) ; Statement: virtualinvoke r0.<org.antlr.v4.tool.Grammar: int defineTokenName(java.lang.String,int)>(r9, $i1) 

(declare-const var3428!2 var3004)
(declare-const var1457!1 String)
(declare-const var1725!1 Int)
(assert true) ; Non Conditional
 ; Statement: goto [?= $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>()] 
(assert true) ; Non Conditional
(define-const var2402!1 Bool (Iterator_hasNext/-1669924200 var469!1)) ; Statement: $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2402!1 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getOptionString/-1090579839=([org.antlr.v4.tool.Grammar, java.lang.String], java.lang.String), var2860-init=([], org.antlr.v4.parse.TokenVocabParser), <init>/-1837098426=([org.antlr.v4.parse.TokenVocabParser, org.antlr.v4.tool.Grammar], void), load/1275204824=([org.antlr.v4.parse.TokenVocabParser], java.util.Map), tool/976633046=([org.antlr.v4.tool.Grammar], org.antlr.v4.Tool), cast-from-var1702-to-String=([java.util.Map], java.lang.String), log/967568536=([org.antlr.v4.Tool, java.lang.String, java.lang.String], void), var1702_keySet/-712633290=([java.util.Map], java.util.Set), var2407_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var3810-to-String=([java.lang.Object], java.lang.String), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), var1702_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var3810=([java.lang.String], java.lang.Object), cast-from-var3810-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int), defineTokenName/-46012211=([org.antlr.v4.tool.Grammar, java.lang.String, int], int)}
; {var3004=org.antlr.v4.tool.Grammar, var3428=r0, var3613=r1, var2930=null_type, var2860=org.antlr.v4.parse.TokenVocabParser, var3989=$r14, var1702=java.util.Map, var2577=r3, var255=org.antlr.v4.Tool, var651=$r4, var1963=$r5, var2074="grammar", var2407=java.util.Set, var3871=$r6, var469=r7, var2402=$z0, var3810=java.lang.Object, var3900=$r8, var1457=r9, var3910=$c0, var3225=$i3, var1534=$r10, var453=$r11, var1725=$i1}
; {org.antlr.v4.tool.Grammar=var3004, r0=var3428, r1=var3613, null_type=var2930, org.antlr.v4.parse.TokenVocabParser=var2860, $r14=var3989, java.util.Map=var1702, r3=var2577, org.antlr.v4.Tool=var255, $r4=var651, $r5=var1963, "grammar"=var2074, java.util.Set=var2407, $r6=var3871, r7=var469, $z0=var2402, java.lang.Object=var3810, $r8=var3900, r9=var1457, $c0=var3910, $i3=var3225, $r10=var1534, $r11=var453, $i1=var1725}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Grammar;	r1 = virtualinvoke r0.<org.antlr.v4.tool.Grammar: java.lang.String getOptionString(java.lang.String)>("tokenVocab");	if r1 == null goto return;	$r14 = new org.antlr.v4.parse.TokenVocabParser;	specialinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: void <init>(org.antlr.v4.tool.Grammar)>(r0);	r3 = virtualinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: java.util.Map load()>();	$r4 = r0.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool>;	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.util.Map)>(r3) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("tokens=\u0001");	virtualinvoke $r4.<org.antlr.v4.Tool: void log(java.lang.String,java.lang.String)>("grammar", $r5);	$r6 = interfaceinvoke r3.<java.util.Map: java.util.Set keySet()>();	r7 = interfaceinvoke $r6.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	$r8 = interfaceinvoke r7.<java.util.Iterator: java.lang.Object next()>();	r9 = (java.lang.String) $r8;	$c0 = virtualinvoke r9.<java.lang.String: char charAt(int)>(0);	$i3 = (int) $c0;	if $i3 != 39 goto $r10 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9);	$r10 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9);	$r11 = (java.lang.Integer) $r10;	$i1 = virtualinvoke $r11.<java.lang.Integer: int intValue()>();	virtualinvoke r0.<org.antlr.v4.tool.Grammar: int defineTokenName(java.lang.String,int)>(r9, $i1);	goto [?= $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>()];	$z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	return
;block_num 8