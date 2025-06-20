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

(declare-sort var2577 0)
(declare-sort var206 0)
(declare-sort var99 0)
(declare-sort var920 0)
(declare-sort var3981 0)
(declare-sort var3346 0)
(declare-sort var1534 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getOptionString/-1090579839 (var2577 String) String)
(declare-fun var99-init () var99)
(declare-fun <init>/-1837098426 (var99 var2577) void)
(declare-fun load/1275204824 (var99) var920)
(declare-fun tool/976633046 (var2577) var3981)
(declare-fun cast-from-var920-to-String (var920) String)
(declare-fun log/967568536 (var3981 String String) void)
(declare-fun var920_keySet/-712633290 (var920) var3346)
(declare-fun var3346_iterator/1911472585 (var3346) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun Iterator_next/-1124697587 (Iterator) var1534)
(declare-fun cast-from-var1534-to-String (var1534) String)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var920_get/1088891777 (var920 var1534) var1534)
(declare-fun cast-from-String-to-var1534 (String) var1534)
(declare-fun cast-from-var1534-to-Int (var1534) Int)
(declare-fun intValue/-1815674922 (Int) Int)
(declare-fun defineStringLiteral/104874579 (var2577 String Int) Int)
(declare-const null-var2577 var2577)
(declare-const null-String String)
(declare-const var3970 var2577) ; Statement: r0 := @this: org.antlr.v4.tool.Grammar 
(assert (not (= var3970 null-var2577)))
(assert true)
(define-const var1839 String (getOptionString/-1090579839 var3970 "tokenVocab")) ; Statement: r1 = virtualinvoke r0.<org.antlr.v4.tool.Grammar: java.lang.String getOptionString(java.lang.String)>("tokenVocab") 
 ; Statement: if r1 == null goto return 
(assert (not (= var1839 null-String))) ; Negate: Cond: r1 == null  
(define-const var1970 var99 var99-init) ; Statement: $r14 = new org.antlr.v4.parse.TokenVocabParser 
(assert true)
;(assert (<init>/-1837098426 var1970 var3970)) ; Statement: specialinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: void <init>(org.antlr.v4.tool.Grammar)>(r0) 

(declare-const var1970!1 var99)
(declare-const var3970!1 var2577)
(assert true)
(define-const var3076 var920 (load/1275204824 var1970!1)) ; Statement: r3 = virtualinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: java.util.Map load()>() 
(define-const var2173 var3981 (tool/976633046 var3970!1)) ; Statement: $r4 = r0.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool> 
(define-const var3242 String (str.++ "tokens=\u0001" (cast-from-var920-to-String var3076))) ; Statement: $r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.util.Map)>(r3) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("tokens=\u0001") 
(assert true)
;(assert (log/967568536 var2173 "grammar" var3242)) ; Statement: virtualinvoke $r4.<org.antlr.v4.Tool: void log(java.lang.String,java.lang.String)>("grammar", $r5) 

(declare-const var2173!1 var3981)
(declare-const var2835 String)
(declare-const var3242!1 String)
(define-const var1828 var3346 (var920_keySet/-712633290 var3076)) ; Statement: $r6 = interfaceinvoke r3.<java.util.Map: java.util.Set keySet()>() 
(define-const var2961 Iterator (var3346_iterator/1911472585 var1828)) ; Statement: r7 = interfaceinvoke $r6.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2529 Bool (Iterator_hasNext/-1669924200 var2961)) ; Statement: $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (not (= (ite var2529 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var3776 var1534 (Iterator_next/-1124697587 var2961)) ; Statement: $r8 = interfaceinvoke r7.<java.util.Iterator: java.lang.Object next()>() 
(declare-const var2961!1 Iterator)
(define-const var3277 String (cast-from-var1534-to-String var3776)) ; Statement: r9 = (java.lang.String) $r8 
(assert (and true (and (> (str.len var3277) 0) (<= 0 0))))
(define-const var573 Int (charAt/698050440 var3277 0)) ; Statement: $c0 = virtualinvoke r9.<java.lang.String: char charAt(int)>(0) 
(define-const var699 Int (cast-from-Int-to-Int var573)) ; Statement: $i3 = (int) $c0 
 ; Statement: if $i3 != 39 goto $r10 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9) 
(assert (not (not (= var699 39)))) ; Negate: Cond: $i3 != 39  
(define-const var1171 var1534 (var920_get/1088891777 var3076 (cast-from-String-to-var1534 var3277))) ; Statement: $r12 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9) 
(define-const var3758 Int (cast-from-var1534-to-Int var1171)) ; Statement: $r13 = (java.lang.Integer) $r12 
(assert true)
(define-const var3179 Int (intValue/-1815674922 var3758)) ; Statement: $i2 = virtualinvoke $r13.<java.lang.Integer: int intValue()>() 
(assert true)
;(assert (defineStringLiteral/104874579 var3970!1 var3277 var3179)) ; Statement: virtualinvoke r0.<org.antlr.v4.tool.Grammar: int defineStringLiteral(java.lang.String,int)>(r9, $i2) 

(declare-const var3970!2 var2577)
(declare-const var3277!1 String)
(declare-const var3179!1 Int)
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: goto [?= $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>()] 
(assert true) ; Non Conditional
(define-const var2529!1 Bool (Iterator_hasNext/-1669924200 var2961!1)) ; Statement: $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2529!1 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getOptionString/-1090579839=([org.antlr.v4.tool.Grammar, java.lang.String], java.lang.String), var99-init=([], org.antlr.v4.parse.TokenVocabParser), <init>/-1837098426=([org.antlr.v4.parse.TokenVocabParser, org.antlr.v4.tool.Grammar], void), load/1275204824=([org.antlr.v4.parse.TokenVocabParser], java.util.Map), tool/976633046=([org.antlr.v4.tool.Grammar], org.antlr.v4.Tool), cast-from-var920-to-String=([java.util.Map], java.lang.String), log/967568536=([org.antlr.v4.Tool, java.lang.String, java.lang.String], void), var920_keySet/-712633290=([java.util.Map], java.util.Set), var3346_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), Iterator_next/-1124697587=([java.util.Iterator], java.lang.Object), cast-from-var1534-to-String=([java.lang.Object], java.lang.String), charAt/698050440=([java.lang.String, int], char), cast-from-Int-to-Int=([char], int), var920_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var1534=([java.lang.String], java.lang.Object), cast-from-var1534-to-Int=([java.lang.Object], java.lang.Integer), intValue/-1815674922=([java.lang.Integer], int), defineStringLiteral/104874579=([org.antlr.v4.tool.Grammar, java.lang.String, int], int)}
; {var2577=org.antlr.v4.tool.Grammar, var3970=r0, var1839=r1, var206=null_type, var99=org.antlr.v4.parse.TokenVocabParser, var1970=$r14, var920=java.util.Map, var3076=r3, var3981=org.antlr.v4.Tool, var2173=$r4, var3242=$r5, var2835="grammar", var3346=java.util.Set, var1828=$r6, var2961=r7, var2529=$z0, var1534=java.lang.Object, var3776=$r8, var3277=r9, var573=$c0, var699=$i3, var1171=$r12, var3758=$r13, var3179=$i2}
; {org.antlr.v4.tool.Grammar=var2577, r0=var3970, r1=var1839, null_type=var206, org.antlr.v4.parse.TokenVocabParser=var99, $r14=var1970, java.util.Map=var920, r3=var3076, org.antlr.v4.Tool=var3981, $r4=var2173, $r5=var3242, "grammar"=var2835, java.util.Set=var3346, $r6=var1828, r7=var2961, $z0=var2529, java.lang.Object=var1534, $r8=var3776, r9=var3277, $c0=var573, $i3=var699, $r12=var1171, $r13=var3758, $i2=var3179}
;seq <java.lang.String: char charAt(int)>
;cnt {"<java.lang.String: char charAt(int)>": 1}
;stmts r0 := @this: org.antlr.v4.tool.Grammar;	r1 = virtualinvoke r0.<org.antlr.v4.tool.Grammar: java.lang.String getOptionString(java.lang.String)>("tokenVocab");	if r1 == null goto return;	$r14 = new org.antlr.v4.parse.TokenVocabParser;	specialinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: void <init>(org.antlr.v4.tool.Grammar)>(r0);	r3 = virtualinvoke $r14.<org.antlr.v4.parse.TokenVocabParser: java.util.Map load()>();	$r4 = r0.<org.antlr.v4.tool.Grammar: org.antlr.v4.Tool tool>;	$r5 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.util.Map)>(r3) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("tokens=\u0001");	virtualinvoke $r4.<org.antlr.v4.Tool: void log(java.lang.String,java.lang.String)>("grammar", $r5);	$r6 = interfaceinvoke r3.<java.util.Map: java.util.Set keySet()>();	r7 = interfaceinvoke $r6.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	$r8 = interfaceinvoke r7.<java.util.Iterator: java.lang.Object next()>();	r9 = (java.lang.String) $r8;	$c0 = virtualinvoke r9.<java.lang.String: char charAt(int)>(0);	$i3 = (int) $c0;	if $i3 != 39 goto $r10 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9);	$r12 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r9);	$r13 = (java.lang.Integer) $r12;	$i2 = virtualinvoke $r13.<java.lang.Integer: int intValue()>();	virtualinvoke r0.<org.antlr.v4.tool.Grammar: int defineStringLiteral(java.lang.String,int)>(r9, $i2);	goto [?= (branch)];	goto [?= $z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>()];	$z0 = interfaceinvoke r7.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	return
;block_num 8