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

(declare-sort var2713 0)
(declare-sort var3459 0)
(declare-sort var1467 0)
(declare-sort var2302 0)
(declare-sort var2466 0)
(declare-sort var1016 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-768117495 (var2302 var3459) void)
(declare-fun cast-from-var2713-to-var2302 (var2713) var2302)
(declare-fun fileName/-995256686 (var2713) String)
(declare-fun var3459_getGrammar/185048390 (var3459) var2466)
(declare-fun fileName/976633046 (var2466) String)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun grammarFileName/-995256686 (var2713) String)
(declare-fun ANTLRVersion/-995256686 (var2713) String)
(declare-fun getOptionString/-1090579839 (var2466 String) String)
(declare-fun TokenLabelType/-995256686 (var2713) String)
(declare-fun InputSymbolType/-995256686 (var2713) String)
(declare-const null-var2713 var2713)
(declare-const null-var3459 var3459)
(declare-const null-String String)
(declare-const var1016-VERSION String)
(declare-const var2854 var2713) ; Statement: r0 := @this: org.antlr.v4.codegen.model.OutputFile 
(assert (not (= var2854 null-var2713)))
(declare-const var415 var3459) ; Statement: r1 := @parameter0: org.antlr.v4.codegen.OutputModelFactory 
(assert (not (= var415 null-var3459)))
(declare-const var3985 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3985 null-String)))
(assert true)
;(assert (<init>/-768117495 (cast-from-var2713-to-var2302 var2854) var415)) ; Statement: specialinvoke r0.<org.antlr.v4.codegen.model.OutputModelObject: void <init>(org.antlr.v4.codegen.OutputModelFactory)>(r1) 

(declare-const var2854!1 var2713)
(declare-const var415!1 var3459)
(declare-const var2854!2 var2713)
(assert (not (= var2854!2 null-var2713)))
(assert (= (fileName/-995256686 var2854!2) var3985)) ; Statement: r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String fileName> = r2 
(define-const var1900 var2466 (var3459_getGrammar/185048390 var415!1)) ; Statement: r3 = interfaceinvoke r1.<org.antlr.v4.codegen.OutputModelFactory: org.antlr.v4.tool.Grammar getGrammar()>() 
(define-const var2590 String (fileName/976633046 var1900)) ; Statement: $r4 = r3.<org.antlr.v4.tool.Grammar: java.lang.String fileName> 
(assert true)
(define-const var1218 String (replace/2138489945 var2590 (cast-from-String-to-String "\u005c") (cast-from-String-to-String "/"))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\\", "/") 
(declare-const var2854!3 var2713)
(assert (not (= var2854!3 null-var2713)))
(assert (= (grammarFileName/-995256686 var2854!3) var1218)) ; Statement: r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String grammarFileName> = $r5 
(define-const var1877 String var1016-VERSION) ; Statement: $r6 = <org.antlr.v4.Tool: java.lang.String VERSION> 
(declare-const var2854!4 var2713)
(assert (not (= var2854!4 null-var2713)))
(assert (= (ANTLRVersion/-995256686 var2854!4) var1877)) ; Statement: r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String ANTLRVersion> = $r6 
(assert true)
(define-const var2250 String (getOptionString/-1090579839 var1900 "TokenLabelType")) ; Statement: $r7 = virtualinvoke r3.<org.antlr.v4.tool.Grammar: java.lang.String getOptionString(java.lang.String)>("TokenLabelType") 
(declare-const var2854!5 var2713)
(assert (not (= var2854!5 null-var2713)))
(assert (= (TokenLabelType/-995256686 var2854!5) var2250)) ; Statement: r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String TokenLabelType> = $r7 
(define-const var1641 String (TokenLabelType/-995256686 var2854!5)) ; Statement: $r8 = r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String TokenLabelType> 
(declare-const var2854!6 var2713)
(assert (not (= var2854!6 null-var2713)))
(assert (= (InputSymbolType/-995256686 var2854!6) var1641)) ; Statement: r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String InputSymbolType> = $r8 
 ; Statement: return 
(check-sat)
; {<init>/-768117495=([org.antlr.v4.codegen.model.OutputModelObject, org.antlr.v4.codegen.OutputModelFactory], void), cast-from-var2713-to-var2302=([org.antlr.v4.codegen.model.OutputFile], org.antlr.v4.codegen.model.OutputModelObject), fileName/-995256686=([org.antlr.v4.codegen.model.OutputFile], java.lang.String), var3459_getGrammar/185048390=([org.antlr.v4.codegen.OutputModelFactory], org.antlr.v4.tool.Grammar), fileName/976633046=([org.antlr.v4.tool.Grammar], java.lang.String), replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), grammarFileName/-995256686=([org.antlr.v4.codegen.model.OutputFile], java.lang.String), ANTLRVersion/-995256686=([org.antlr.v4.codegen.model.OutputFile], java.lang.String), getOptionString/-1090579839=([org.antlr.v4.tool.Grammar, java.lang.String], java.lang.String), TokenLabelType/-995256686=([org.antlr.v4.codegen.model.OutputFile], java.lang.String), InputSymbolType/-995256686=([org.antlr.v4.codegen.model.OutputFile], java.lang.String)}
; {var2713=org.antlr.v4.codegen.model.OutputFile, var2854=r0, var3459=org.antlr.v4.codegen.OutputModelFactory, var415=r1, var3985=r2, var1467=null_type, var2302=org.antlr.v4.codegen.model.OutputModelObject, var2466=org.antlr.v4.tool.Grammar, var1900=r3, var2590=$r4, var1218=$r5, var1016=org.antlr.v4.Tool, var1877=$r6, var2250=$r7, var1641=$r8}
; {org.antlr.v4.codegen.model.OutputFile=var2713, r0=var2854, org.antlr.v4.codegen.OutputModelFactory=var3459, r1=var415, r2=var3985, null_type=var1467, org.antlr.v4.codegen.model.OutputModelObject=var2302, org.antlr.v4.tool.Grammar=var2466, r3=var1900, $r4=var2590, $r5=var1218, org.antlr.v4.Tool=var1016, $r6=var1877, $r7=var2250, $r8=var1641}
;seq <java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.antlr.v4.codegen.model.OutputFile;	r1 := @parameter0: org.antlr.v4.codegen.OutputModelFactory;	r2 := @parameter1: java.lang.String;	specialinvoke r0.<org.antlr.v4.codegen.model.OutputModelObject: void <init>(org.antlr.v4.codegen.OutputModelFactory)>(r1);	r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String fileName> = r2;	r3 = interfaceinvoke r1.<org.antlr.v4.codegen.OutputModelFactory: org.antlr.v4.tool.Grammar getGrammar()>();	$r4 = r3.<org.antlr.v4.tool.Grammar: java.lang.String fileName>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>("\\", "/");	r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String grammarFileName> = $r5;	$r6 = <org.antlr.v4.Tool: java.lang.String VERSION>;	r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String ANTLRVersion> = $r6;	$r7 = virtualinvoke r3.<org.antlr.v4.tool.Grammar: java.lang.String getOptionString(java.lang.String)>("TokenLabelType");	r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String TokenLabelType> = $r7;	$r8 = r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String TokenLabelType>;	r0.<org.antlr.v4.codegen.model.OutputFile: java.lang.String InputSymbolType> = $r8;	return
;block_num 1