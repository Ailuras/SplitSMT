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

(declare-sort var3862 0)
(declare-sort var2317 0)
(declare-sort var2109 0)
(declare-sort var925 0)
(declare-sort var2518 0)
(declare-sort var1009 0)
(declare-sort var1311 0)
(declare-sort var1830 0)
(declare-sort var628 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2317_asList/1779083644 ((Array Int var2109)) var3862)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2109__ ((Array Int String)) (Array Int var2109))
(declare-fun var2518_newHashSet/-438716120 (var1009) var925)
(declare-fun cast-from-var3862-to-var1009 (var3862) var1009)
(declare-fun var1311_unmodifiableSet/219896279 (var925) var925)
(declare-fun var1830-init () var1830)
(declare-fun <init>/457067352 (var1830) void)
(declare-fun cast-from-var1830-to-var628 (var1830) var628)
(define-const var1618 String "DTNN DTNNP DTNNPS DTNNS NN NNP NNS NNPS") ; Statement: $r0 = "DTNN DTNNP DTNNPS DTNNS NN NNP NNS NNPS" 
; split operation: var3788 = var1618.split("\u005cs+") ; Statement: $r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var2564 var3862 (var2317_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2109__ var3788))) ; Statement: $r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1) 
(define-const var1568 var925 (var2518_newHashSet/-438716120 (cast-from-var3862-to-var1009 var2564))) ; Statement: $r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r2) 
(define-const var1650 var925 (var1311_unmodifiableSet/219896279 var1568)) ; Statement: $r4 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r3) 
(define-const var2494 var925 var1650) ; Statement: <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set nnTagClass> = $r4 
(define-const var3484 String "ADJ_NUM DTJJ DTJJR JJ JJR") ; Statement: $r5 = "ADJ_NUM DTJJ DTJJR JJ JJR" 
; split operation: var2064 = var3484.split("\u005cs+") ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1573 var3862 (var2317_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2109__ var2064))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6) 
(define-const var2545 var925 (var2518_newHashSet/-438716120 (cast-from-var3862-to-var1009 var1573))) ; Statement: $r8 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r7) 
(define-const var287 var925 (var1311_unmodifiableSet/219896279 var2545)) ; Statement: $r9 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r8) 
(define-const var1969 var925 var287) ; Statement: <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set jjTagClass> = $r9 
(define-const var3616 String "VBD VBP") ; Statement: $r10 = "VBD VBP" 
; split operation: var2114 = var3616.split("\u005cs+") ; Statement: $r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var984 var3862 (var2317_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2109__ var2114))) ; Statement: $r12 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11) 
(define-const var3798 var925 (var2518_newHashSet/-438716120 (cast-from-var3862-to-var1009 var984))) ; Statement: $r13 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r12) 
(define-const var1602 var925 (var1311_unmodifiableSet/219896279 var3798)) ; Statement: $r14 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r13) 
(define-const var2459 var925 var1602) ; Statement: <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set vbTagClass> = $r14 
(define-const var2745 var1830 var1830-init) ; Statement: $r15 = new edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack 
(assert true)
;(assert (<init>/457067352 var2745)) ; Statement: specialinvoke $r15.<edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack: void <init>()>() 

(declare-const var2745!1 var1830)
(define-const var3589 var628 (cast-from-var1830-to-var628 var2745!1)) ; Statement: <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: edu.stanford.nlp.trees.TreebankLanguagePack tlp> = $r15 
 ; Statement: return 
(check-sat)
; {var2317_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var2109__=([java.lang.String[]], java.lang.Object[]), var2518_newHashSet/-438716120=([java.util.Collection], java.util.Set), cast-from-var3862-to-var1009=([java.util.List], java.util.Collection), var1311_unmodifiableSet/219896279=([java.util.Set], java.util.Set), var1830-init=([], edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack), <init>/457067352=([edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack], void), cast-from-var1830-to-var628=([edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack], edu.stanford.nlp.trees.TreebankLanguagePack)}
; {var1618=$r0, var3788=$r1, var3862=java.util.List, var2317=java.util.Arrays, var2109=java.lang.Object, var2564=$r2, var925=java.util.Set, var2518=edu.stanford.nlp.util.Generics, var1009=java.util.Collection, var1568=$r3, var1311=java.util.Collections, var1650=$r4, var2494=<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set nnTagClass>, var3484=$r5, var2064=$r6, var1573=$r7, var2545=$r8, var287=$r9, var1969=<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set jjTagClass>, var3616=$r10, var2114=$r11, var984=$r12, var3798=$r13, var1602=$r14, var2459=<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set vbTagClass>, var1830=edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack, var2745=$r15, var628=edu.stanford.nlp.trees.TreebankLanguagePack, var3589=<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: edu.stanford.nlp.trees.TreebankLanguagePack tlp>}
; {$r0=var1618, $r1=var3788, java.util.List=var3862, java.util.Arrays=var2317, java.lang.Object=var2109, $r2=var2564, java.util.Set=var925, edu.stanford.nlp.util.Generics=var2518, java.util.Collection=var1009, $r3=var1568, java.util.Collections=var1311, $r4=var1650, <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set nnTagClass>=var2494, $r5=var3484, $r6=var2064, $r7=var1573, $r8=var2545, $r9=var287, <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set jjTagClass>=var1969, $r10=var3616, $r11=var2114, $r12=var984, $r13=var3798, $r14=var1602, <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set vbTagClass>=var2459, edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack=var1830, $r15=var2745, edu.stanford.nlp.trees.TreebankLanguagePack=var628, <edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: edu.stanford.nlp.trees.TreebankLanguagePack tlp>=var3589}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 3}
;stmts $r0 = "DTNN DTNNP DTNNPS DTNNS NN NNP NNS NNPS";	$r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1);	$r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r2);	$r4 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r3);	<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set nnTagClass> = $r4;	$r5 = "ADJ_NUM DTJJ DTJJR JJ JJR";	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6);	$r8 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r7);	$r9 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r8);	<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set jjTagClass> = $r9;	$r10 = "VBD VBP";	$r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r12 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r11);	$r13 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r12);	$r14 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r13);	<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: java.util.Set vbTagClass> = $r14;	$r15 = new edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack;	specialinvoke $r15.<edu.stanford.nlp.trees.international.arabic.ArabicTreebankLanguagePack: void <init>()>();	<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams$AddEquivalencedConjNode: edu.stanford.nlp.trees.TreebankLanguagePack tlp> = $r15;	return
;block_num 1