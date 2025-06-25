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

(declare-sort var1183 0)
(declare-sort var2801 0)
(declare-sort var3191 0)
(declare-sort var3505 0)
(declare-sort var421 0)
(declare-sort var1296 0)
(declare-sort var2275 0)
(declare-sort var1417 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3505_asList/1779083644 ((Array Int var421)) var3191)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var421__ ((Array Int String)) (Array Int var421))
(declare-fun var2275_toUntaggedList/1912833419 (var3191) var1296)
(declare-fun var1417-init () var1417)
(declare-fun <init>/1759147341 (var1417 var1183) void)
(declare-fun tagSentence/-1037825378 (var1417 var3191 Bool) var1296)
(declare-fun cast-from-var1296-to-var3191 (var1296) var3191)
(declare-fun getTaggedNice/-1066272226 (var1417) String)
(declare-const null-var1183 var1183)
(declare-const null-String String)
(declare-const var3227 var1183) ; Statement: r5 := @this: edu.stanford.nlp.tagger.maxent.MaxentTagger 
(assert (not (= var3227 null-var1183)))
(declare-const var3001 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3001 null-String)))
; split operation: var1527 = var3001.split("\u005cs+") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var810 var3191 (var3505_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var421__ var1527))) ; Statement: $r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1) 
(define-const var2244 var1296 (var2275_toUntaggedList/1912833419 var810)) ; Statement: r3 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.ArrayList toUntaggedList(java.util.List)>($r2) 
(define-const var2919 var1417 var1417-init) ; Statement: $r4 = new edu.stanford.nlp.tagger.maxent.TestSentence 
(assert true)
;(assert (<init>/1759147341 var2919 var3227)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.tagger.maxent.TestSentence: void <init>(edu.stanford.nlp.tagger.maxent.MaxentTagger)>(r5) 

(declare-const var2919!1 var1417)
(declare-const var3227!1 var1183)
(assert true)
;(assert (tagSentence/-1037825378 var2919!1 (cast-from-var1296-to-var3191 var2244) (ite (= 1 0) true false))) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.tagger.maxent.TestSentence: java.util.ArrayList tagSentence(java.util.List,boolean)>(r3, 0) 

(declare-const var2919!2 var1417)
(declare-const var2244!1 var1296)
(declare-const var2665 Int)
(assert true)
(define-const var3807 String (getTaggedNice/-1066272226 var2919!2)) ; Statement: $r6 = virtualinvoke $r4.<edu.stanford.nlp.tagger.maxent.TestSentence: java.lang.String getTaggedNice()>() 
 ; Statement: return $r6 
(check-sat)
; {var3505_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var421__=([java.lang.String[]], java.lang.Object[]), var2275_toUntaggedList/1912833419=([java.util.List], java.util.ArrayList), var1417-init=([], edu.stanford.nlp.tagger.maxent.TestSentence), <init>/1759147341=([edu.stanford.nlp.tagger.maxent.TestSentence, edu.stanford.nlp.tagger.maxent.MaxentTagger], void), tagSentence/-1037825378=([edu.stanford.nlp.tagger.maxent.TestSentence, java.util.List, boolean], java.util.ArrayList), cast-from-var1296-to-var3191=([java.util.ArrayList], java.util.List), getTaggedNice/-1066272226=([edu.stanford.nlp.tagger.maxent.TestSentence], java.lang.String)}
; {var1183=edu.stanford.nlp.tagger.maxent.MaxentTagger, var3227=r5, var3001=r0, var2801=null_type, var1527=$r1, var3191=java.util.List, var3505=java.util.Arrays, var421=java.lang.Object, var810=$r2, var1296=java.util.ArrayList, var2275=edu.stanford.nlp.ling.SentenceUtils, var2244=r3, var1417=edu.stanford.nlp.tagger.maxent.TestSentence, var2919=$r4, var2665=0, var3807=$r6}
; {edu.stanford.nlp.tagger.maxent.MaxentTagger=var1183, r5=var3227, r0=var3001, null_type=var2801, $r1=var1527, java.util.List=var3191, java.util.Arrays=var3505, java.lang.Object=var421, $r2=var810, java.util.ArrayList=var1296, edu.stanford.nlp.ling.SentenceUtils=var2275, r3=var2244, edu.stanford.nlp.tagger.maxent.TestSentence=var1417, $r4=var2919, 0=var2665, $r6=var3807}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @this: edu.stanford.nlp.tagger.maxent.MaxentTagger;	r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r2 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1);	r3 = staticinvoke <edu.stanford.nlp.ling.SentenceUtils: java.util.ArrayList toUntaggedList(java.util.List)>($r2);	$r4 = new edu.stanford.nlp.tagger.maxent.TestSentence;	specialinvoke $r4.<edu.stanford.nlp.tagger.maxent.TestSentence: void <init>(edu.stanford.nlp.tagger.maxent.MaxentTagger)>(r5);	virtualinvoke $r4.<edu.stanford.nlp.tagger.maxent.TestSentence: java.util.ArrayList tagSentence(java.util.List,boolean)>(r3, 0);	$r6 = virtualinvoke $r4.<edu.stanford.nlp.tagger.maxent.TestSentence: java.lang.String getTaggedNice()>();	return $r6
;block_num 1