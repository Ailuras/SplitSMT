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

(declare-sort var3165 0)
(declare-sort var925 0)
(declare-sort var892 0)
(declare-sort var1749 0)
(declare-sort var3702 0)
(declare-sort var2367 0)
(declare-sort var710 0)
(declare-sort var2572 0)
(declare-sort var1356 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var892-init () var892)
(declare-fun <init>/358169345 (var892) void)
(declare-fun tokenize/1633224466 (var3165) Bool)
(declare-fun cast-from-var3702-to-var1749 (var3702) var1749)
(declare-fun var2367_newArrayList/-800970628 () var3702)
(declare-fun var710_toWordList/-1296196856 ((Array Int String)) var1749)
(declare-fun var1749_add/328494887 (var1749 var2572) Bool)
(declare-fun cast-from-var1749-to-var2572 (var1749) var2572)
(declare-fun config/1633224466 (var3165) var1356)
(declare-fun getNThreads/802657535 (var1356) Int)
(declare-fun var1749_iterator/-912451715 (var1749) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun toString/138175384 (var892) String)
(declare-const null-var3165 var3165)
(declare-const null-String String)
(declare-const var2439 var3165) ; Statement: r1 := @this: edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper 
(assert (not (= var2439 null-var3165)))
(declare-const var3785 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3785 null-String)))
(define-const var3466 var892 var892-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var3466)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var3466!1 var892)
(define-const var3372 Bool (tokenize/1633224466 var2439)) ; Statement: $z0 = r1.<edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper: boolean tokenize> 
 ; Statement: if $z0 == 0 goto r27 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.ArrayList newArrayList()>() 
(assert (= (ite var3372 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1895 var1749 (cast-from-var3702-to-var1749 var2367_newArrayList/-800970628)) ; Statement: r27 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.ArrayList newArrayList()>() 
; split operation: var1890 = var3785.split("\u005cs+") ; Statement: $r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1313 var1749 (var710_toWordList/-1296196856 var1890)) ; Statement: $r4 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.List toWordList(java.lang.String[])>($r3) 
;(assert (var1749_add/328494887 var1895 (cast-from-var1749-to-var2572 var1313))) ; Statement: interfaceinvoke r27.<java.util.List: boolean add(java.lang.Object)>($r4) 

(declare-const var1895!1 var1749)
(declare-const var1313!1 var1749)
(assert true) ; Non Conditional
(define-const var3523 var1356 (config/1633224466 var2439)) ; Statement: $r5 = r1.<edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper: edu.stanford.nlp.tagger.maxent.TaggerConfig config> 
(assert true)
(define-const var1716 Int (getNThreads/802657535 var3523)) ; Statement: $i0 = virtualinvoke $r5.<edu.stanford.nlp.tagger.maxent.TaggerConfig: int getNThreads()>() 
 ; Statement: if $i0 == 1 goto r30 = interfaceinvoke r27.<java.util.List: java.util.Iterator iterator()>() 
(assert (= var1716 1)) ; Cond: $i0 == 1 
(define-const var2584 Iterator (var1749_iterator/-912451715 var1895!1)) ; Statement: r30 = interfaceinvoke r27.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var433 Bool (Iterator_hasNext/-1669924200 var2584)) ; Statement: $z1 = interfaceinvoke r30.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 == 0 goto $r6 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
(assert (= (ite var433 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var680 String (toString/138175384 var3466!1)) ; Statement: $r6 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {var892-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), tokenize/1633224466=([edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper], boolean), cast-from-var3702-to-var1749=([java.util.ArrayList], java.util.List), var2367_newArrayList/-800970628=([], java.util.ArrayList), var710_toWordList/-1296196856=([java.lang.String[]], java.util.List), var1749_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var1749-to-var2572=([java.util.List], java.lang.Object), config/1633224466=([edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper], edu.stanford.nlp.tagger.maxent.TaggerConfig), getNThreads/802657535=([edu.stanford.nlp.tagger.maxent.TaggerConfig], int), var1749_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/138175384=([java.io.StringWriter], java.lang.String)}
; {var3165=edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper, var2439=r1, var3785=r2, var925=null_type, var892=java.io.StringWriter, var3466=$r0, var3372=$z0, var1749=java.util.List, var3702=java.util.ArrayList, var2367=edu.stanford.nlp.util.Generics, var1895=r27, var1890=$r3, var710=edu.stanford.nlp.ling.SentenceUtils, var1313=$r4, var2572=java.lang.Object, var1356=edu.stanford.nlp.tagger.maxent.TaggerConfig, var3523=$r5, var1716=$i0, var2584=r30, var433=$z1, var680=$r6}
; {edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper=var3165, r1=var2439, r2=var3785, null_type=var925, java.io.StringWriter=var892, $r0=var3466, $z0=var3372, java.util.List=var1749, java.util.ArrayList=var3702, edu.stanford.nlp.util.Generics=var2367, r27=var1895, $r3=var1890, edu.stanford.nlp.ling.SentenceUtils=var710, $r4=var1313, java.lang.Object=var2572, edu.stanford.nlp.tagger.maxent.TaggerConfig=var1356, $r5=var3523, $i0=var1716, r30=var2584, $z1=var433, $r6=var680}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.io.StringWriter: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper;	r2 := @parameter0: java.lang.String;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$z0 = r1.<edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper: boolean tokenize>;	if $z0 == 0 goto r27 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.ArrayList newArrayList()>();	r27 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.ArrayList newArrayList()>();	$r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r4 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.List toWordList(java.lang.String[])>($r3);	interfaceinvoke r27.<java.util.List: boolean add(java.lang.Object)>($r4);	$r5 = r1.<edu.stanford.nlp.tagger.maxent.MaxentTagger$TaggerWrapper: edu.stanford.nlp.tagger.maxent.TaggerConfig config>;	$i0 = virtualinvoke $r5.<edu.stanford.nlp.tagger.maxent.TaggerConfig: int getNThreads()>();	if $i0 == 1 goto r30 = interfaceinvoke r27.<java.util.List: java.util.Iterator iterator()>();	r30 = interfaceinvoke r27.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke r30.<java.util.Iterator: boolean hasNext()>();	if $z1 == 0 goto $r6 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	$r6 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	return $r6
;block_num 6