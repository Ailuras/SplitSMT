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

(declare-sort var1504 0)
(declare-sort var2726 0)
(declare-sort var1997 0)
(declare-sort var501 0)
(declare-sort var3327 0)
(declare-sort var2139 0)
(declare-sort var665 0)
(declare-sort var174 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2726_newHashMap/701256970 () var1504)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var1504_put/1464166817 (var1504 var1997 var1997) var1997)
(declare-fun cast-from-String-to-var1997 (String) var1997)
(declare-fun cast-from-Int-to-var1997 (Int) var1997)
(declare-fun var501_argsToMap/2147308891 ((Array Int String) var1504) var1504)
(declare-fun var1504_keySet/-712633290 (var1504) var3327)
(declare-fun var3327_contains/1636690605 (var3327 var1997) Bool)
(declare-fun var2139-init () var2139)
(declare-fun <init>/1038120290 (var2139 String) void)
(declare-fun var174-init () var174)
(declare-fun <init>/760448707 (var174 (Array Int String) var2139 Bool) void)
(declare-fun serializeDictionary/-1855495361 (var174 String) void)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-NullType var665)
(declare-const null-String String)
(declare-const var807 (Array Int String)) ; Statement: r3 := @parameter0: java.lang.String[] 
(assert (not (= var807 null-__Array__Int__String__)))
(define-const var774 String "/u/nlp/data/chinese-dictionaries/plain/ne_wikipedia-utf8.txt,/u/nlp/data/chinese-dictionaries/plain/newsexplorer_entities_utf8.txt,/u/nlp/data/chinese-dictionaries/plain/Ch-name-list-utf8.txt,/u/nlp/data/chinese-dictionaries/plain/wikilex-20070908-zh-en.txt,/u/nlp/data/chinese-dictionaries/plain/adso-1.25-050405-monolingual-clean.utf8.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_108k_normalized.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_mandarintools_normalized.txt,/u/nlp/data/chinese-dictionaries/plain/harbin-ChineseNames_utf8.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_HowNet_normalized.txt") ; Statement: r14 = "/u/nlp/data/chinese-dictionaries/plain/ne_wikipedia-utf8.txt,/u/nlp/data/chinese-dictionaries/plain/newsexplorer_entities_utf8.txt,/u/nlp/data/chinese-dictionaries/plain/Ch-name-list-utf8.txt,/u/nlp/data/chinese-dictionaries/plain/wikilex-20070908-zh-en.txt,/u/nlp/data/chinese-dictionaries/plain/adso-1.25-050405-monolingual-clean.utf8.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_108k_normalized.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_mandarintools_normalized.txt,/u/nlp/data/chinese-dictionaries/plain/harbin-ChineseNames_utf8.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_HowNet_normalized.txt" 
(define-const var2693 String "/u/nlp/data/gale/segtool/stanford-seg/classifiers/dict-chris6.ser.gz") ; Statement: r15 = "/u/nlp/data/gale/segtool/stanford-seg/classifiers/dict-chris6.ser.gz" 
(define-const var1118 var1504 var2726_newHashMap/701256970) ; Statement: r0 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var784 Int (Int_valueOf/-1371140006 1)) ; Statement: $r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(1) 
;(assert (var1504_put/1464166817 var1118 (cast-from-String-to-var1997 "-inputDicts") (cast-from-Int-to-var1997 var784))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("-inputDicts", $r1) 

(declare-const var1118!1 var1504)
(declare-const var3304 String)
(declare-const var784!1 Int)
(define-const var2466 Int (Int_valueOf/-1371140006 1)) ; Statement: $r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(1) 
;(assert (var1504_put/1464166817 var1118!1 (cast-from-String-to-var1997 "-output") (cast-from-Int-to-var1997 var2466))) ; Statement: interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("-output", $r2) 

(declare-const var1118!2 var1504)
(declare-const var1333 String)
(declare-const var2466!1 Int)
(define-const var994 var1504 (var501_argsToMap/2147308891 var807 var1118!2)) ; Statement: r4 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.util.Map argsToMap(java.lang.String[],java.util.Map)>(r3, r0) 
(define-const var1049 var3327 (var1504_keySet/-712633290 var994)) ; Statement: $r5 = interfaceinvoke r4.<java.util.Map: java.util.Set keySet()>() 
(define-const var421 Bool (var3327_contains/1636690605 var1049 (cast-from-String-to-var1997 "-inputDicts"))) ; Statement: $z0 = interfaceinvoke $r5.<java.util.Set: boolean contains(java.lang.Object)>("-inputDicts") 
 ; Statement: if $z0 == 0 goto $r6 = interfaceinvoke r4.<java.util.Map: java.util.Set keySet()>() 
(assert (= (ite var421 1 0) 0)) ; Cond: $z0 == 0 
(define-const var98 var3327 (var1504_keySet/-712633290 var994)) ; Statement: $r6 = interfaceinvoke r4.<java.util.Map: java.util.Set keySet()>() 
(define-const var2748 Bool (var3327_contains/1636690605 var98 (cast-from-String-to-var1997 "-output"))) ; Statement: $z1 = interfaceinvoke $r6.<java.util.Set: boolean contains(java.lang.Object)>("-output") 
 ; Statement: if $z1 == 0 goto $r11 = virtualinvoke r14.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (= (ite var2748 1 0) 0)) ; Cond: $z1 == 0 
; split operation: var1772 = var774.split(",") ; Statement: $r11 = virtualinvoke r14.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3251 var2139 var2139-init) ; Statement: $r7 = new edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor 
(assert true)
;(assert (<init>/1038120290 var3251 null-String)) ; Statement: specialinvoke $r7.<edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor: void <init>(java.lang.String)>(null) 

(declare-const var3251!1 var2139)
(declare-const var3802 var665)
(define-const var2103 var174 var174-init) ; Statement: $r8 = new edu.stanford.nlp.wordseg.ChineseDictionary 
(assert true)
;(assert (<init>/760448707 var2103 var1772 var3251!1 (ite (= 1 1) true false))) ; Statement: specialinvoke $r8.<edu.stanford.nlp.wordseg.ChineseDictionary: void <init>(java.lang.String[],edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor,boolean)>($r11, $r7, 1) 

(declare-const var2103!1 var174)
(declare-const var1772!1 (Array Int String))
(declare-const var3251!2 var2139)
(declare-const var344 Int)
(assert true)
;(assert (serializeDictionary/-1855495361 var2103!1 var2693)) ; Statement: specialinvoke $r8.<edu.stanford.nlp.wordseg.ChineseDictionary: void serializeDictionary(java.lang.String)>(r15) 

(declare-const var2103!2 var174)
(declare-const var2693!1 String)
 ; Statement: return 
(check-sat)
; {var2726_newHashMap/701256970=([], java.util.Map), Int_valueOf/-1371140006=([int], java.lang.Integer), var1504_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1997=([java.lang.String], java.lang.Object), cast-from-Int-to-var1997=([java.lang.Integer], java.lang.Object), var501_argsToMap/2147308891=([java.lang.String[], java.util.Map], java.util.Map), var1504_keySet/-712633290=([java.util.Map], java.util.Set), var3327_contains/1636690605=([java.util.Set, java.lang.Object], boolean), var2139-init=([], edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor), <init>/1038120290=([edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor, java.lang.String], void), var174-init=([], edu.stanford.nlp.wordseg.ChineseDictionary), <init>/760448707=([edu.stanford.nlp.wordseg.ChineseDictionary, java.lang.String[], edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor, boolean], void), serializeDictionary/-1855495361=([edu.stanford.nlp.wordseg.ChineseDictionary, java.lang.String], void)}
; {var807=r3, var774=r14, var2693=r15, var1504=java.util.Map, var2726=edu.stanford.nlp.util.Generics, var1118=r0, var784=$r1, var1997=java.lang.Object, var3304="-inputDicts", var2466=$r2, var1333="-output", var501=edu.stanford.nlp.util.StringUtils, var994=r4, var3327=java.util.Set, var1049=$r5, var421=$z0, var98=$r6, var2748=$z1, var1772=$r11, var2139=edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor, var3251=$r7, var665=null_type, var3802=null, var174=edu.stanford.nlp.wordseg.ChineseDictionary, var2103=$r8, var344=1}
; {r3=var807, r14=var774, r15=var2693, java.util.Map=var1504, edu.stanford.nlp.util.Generics=var2726, r0=var1118, $r1=var784, java.lang.Object=var1997, "-inputDicts"=var3304, $r2=var2466, "-output"=var1333, edu.stanford.nlp.util.StringUtils=var501, r4=var994, java.util.Set=var3327, $r5=var1049, $z0=var421, $r6=var98, $z1=var2748, $r11=var1772, edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor=var2139, $r7=var3251, null_type=var665, null=var3802, edu.stanford.nlp.wordseg.ChineseDictionary=var174, $r8=var2103, 1=var344}
;seq <edu.stanford.nlp.util.StringUtils: java.util.Map argsToMap(java.lang.String[],java.util.Map)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<edu.stanford.nlp.util.StringUtils: java.util.Map argsToMap(java.lang.String[],java.util.Map)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @parameter0: java.lang.String[];	r14 = "/u/nlp/data/chinese-dictionaries/plain/ne_wikipedia-utf8.txt,/u/nlp/data/chinese-dictionaries/plain/newsexplorer_entities_utf8.txt,/u/nlp/data/chinese-dictionaries/plain/Ch-name-list-utf8.txt,/u/nlp/data/chinese-dictionaries/plain/wikilex-20070908-zh-en.txt,/u/nlp/data/chinese-dictionaries/plain/adso-1.25-050405-monolingual-clean.utf8.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_108k_normalized.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_mandarintools_normalized.txt,/u/nlp/data/chinese-dictionaries/plain/harbin-ChineseNames_utf8.txt,/u/nlp/data/chinese-dictionaries/plain/lexicon_HowNet_normalized.txt";	r15 = "/u/nlp/data/gale/segtool/stanford-seg/classifiers/dict-chris6.ser.gz";	r0 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	$r1 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(1);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("-inputDicts", $r1);	$r2 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(1);	interfaceinvoke r0.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>("-output", $r2);	r4 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.util.Map argsToMap(java.lang.String[],java.util.Map)>(r3, r0);	$r5 = interfaceinvoke r4.<java.util.Map: java.util.Set keySet()>();	$z0 = interfaceinvoke $r5.<java.util.Set: boolean contains(java.lang.Object)>("-inputDicts");	if $z0 == 0 goto $r6 = interfaceinvoke r4.<java.util.Map: java.util.Set keySet()>();	$r6 = interfaceinvoke r4.<java.util.Map: java.util.Set keySet()>();	$z1 = interfaceinvoke $r6.<java.util.Set: boolean contains(java.lang.Object)>("-output");	if $z1 == 0 goto $r11 = virtualinvoke r14.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r11 = virtualinvoke r14.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r7 = new edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor;	specialinvoke $r7.<edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor: void <init>(java.lang.String)>(null);	$r8 = new edu.stanford.nlp.wordseg.ChineseDictionary;	specialinvoke $r8.<edu.stanford.nlp.wordseg.ChineseDictionary: void <init>(java.lang.String[],edu.stanford.nlp.process.ChineseDocumentToSentenceProcessor,boolean)>($r11, $r7, 1);	specialinvoke $r8.<edu.stanford.nlp.wordseg.ChineseDictionary: void serializeDictionary(java.lang.String)>(r15);	return
;block_num 3