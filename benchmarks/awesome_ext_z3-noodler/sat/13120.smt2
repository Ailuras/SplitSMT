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

(declare-sort var2058 0)
(declare-sort var3021 0)
(declare-sort var2314 0)
(declare-sort var3595 0)
(declare-sort var1509 0)
(declare-sort var3825 0)
(declare-sort var2376 0)
(declare-sort var896 0)
(declare-sort var710 0)
(declare-sort var3053 0)
(declare-sort var298 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2058!class ClassObject)
(declare-fun desiredAssertionStatus/-1561484483 (ClassObject) Bool)
(declare-fun arr-var3021-init () (Array Int var3021))
(declare-fun cast-from-ClassObject-to-var3021 (ClassObject) var3021)
(declare-fun var3595_channels/-1873906782 ((Array Int var3021)) var2314)
(declare-fun var1509_compile/2141929305 (String) var1509)
(declare-fun var2376_asList/1779083644 ((Array Int var3021)) var3825)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var3021__ ((Array Int String)) (Array Int var3021))
(declare-fun var710_newHashSet/-438716120 (var3053) var896)
(declare-fun cast-from-var3825-to-var3053 (var3825) var3053)
(declare-fun var298_unmodifiableSet/219896279 (var896) var896)
(declare-const null-__Array__Int__var3021__ (Array Int var3021))
(define-const var3499 ClassObject var2058!class) ; Statement: $r0 = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;" 
(assert true)
(define-const var276 Bool (desiredAssertionStatus/-1561484483 var3499)) ; Statement: $z0 = virtualinvoke $r0.<java.lang.Class: boolean desiredAssertionStatus()>() 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var276 1 0) 0))) ; Cond: $z0 != 0 
(define-const var26 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
(define-const var2746 Bool var26) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled> = $z1 
(define-const var1418 (Array Int var3021) arr-var3021-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(declare-const var1418!1 (Array Int var3021))
(assert (not (= var1418!1 null-__Array__Int__var3021__)))
(assert (= (select var1418!1 0) (cast-from-ClassObject-to-var3021 var2058!class))) ; Statement: $r1[0] = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;" 
(define-const var1461 var2314 (var3595_channels/-1873906782 var1418!1)) ; Statement: $r2 = staticinvoke <edu.stanford.nlp.util.logging.Redwood: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels channels(java.lang.Object[])>($r1) 
(define-const var3138 var2314 var1461) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> = $r2 
(define-const var237 var1509 (var1509_compile/2141929305 "\u005cp{Punct}+")) ; Statement: $r3 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Punct}+") 
(define-const var3439 var1509 var237) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc> = $r3 
(define-const var3886 var1509 (var1509_compile/2141929305 "\u005cp{Digit}+")) ; Statement: $r4 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Digit}+") 
(define-const var1061 var1509 var3886) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit> = $r4 
(define-const var617 var1509 (var1509_compile/2141929305 "\u005cP{InArabic}+")) ; Statement: $r5 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\P{InArabic}+") 
(define-const var499 var1509 var617) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic> = $r5 
(define-const var3760 String "\u0644 \u0641 \u0648 \u0645 \u0645\u0627 \u062d \u062d\u0627 \u0647 \u0647\u0627 \u0643 \u0628 \u0633") ; Statement: $r14 = "\u0644 \u0641 \u0648 \u0645 \u0645\u0627 \u062d \u062d\u0627 \u0647 \u0647\u0627 \u0643 \u0628 \u0633" 
; split operation: var1322 = var3760.split("\u005cs+") ; Statement: $r6 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3805 var3825 (var2376_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3021__ var1322))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6) 
(define-const var855 var896 (var710_newHashSet/-438716120 (cast-from-var3825-to-var3053 var3805))) ; Statement: $r8 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r7) 
(define-const var3872 var896 (var298_unmodifiableSet/219896279 var855)) ; Statement: $r9 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r8) 
(define-const var3454 var896 var3872) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet> = $r9 
(define-const var2674 String "\u0644 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0634") ; Statement: $r15 = "\u0644 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0634" 
; split operation: var2029 = var2674.split("\u005cs+") ; Statement: $r10 = virtualinvoke $r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3238 var3825 (var2376_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var3021__ var2029))) ; Statement: $r11 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r10) 
(define-const var683 var896 (var710_newHashSet/-438716120 (cast-from-var3825-to-var3053 var3238))) ; Statement: $r12 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r11) 
(define-const var1863 var896 (var298_unmodifiableSet/219896279 var683)) ; Statement: $r13 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r12) 
(define-const var804 var896 var1863) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet> = $r13 
 ; Statement: return 
(check-sat)
; {desiredAssertionStatus/-1561484483=([java.lang.Class], boolean), arr-var3021-init=([], java.lang.Object[]), cast-from-ClassObject-to-var3021=([java.lang.Class], java.lang.Object), var3595_channels/-1873906782=([java.lang.Object[]], edu.stanford.nlp.util.logging.Redwood$RedwoodChannels), var1509_compile/2141929305=([java.lang.String], java.util.regex.Pattern), var2376_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var3021__=([java.lang.String[]], java.lang.Object[]), var710_newHashSet/-438716120=([java.util.Collection], java.util.Set), cast-from-var3825-to-var3053=([java.util.List], java.util.Collection), var298_unmodifiableSet/219896279=([java.util.Set], java.util.Set)}
; {var2058=edu.stanford.nlp.international.arabic.process.IOBUtils, var3499=$r0, var276=$z0, var26=$z1, var2746=<edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled>, var3021=java.lang.Object, var1418=$r1, var2314=edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, var3595=edu.stanford.nlp.util.logging.Redwood, var1461=$r2, var3138=<edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>, var1509=java.util.regex.Pattern, var237=$r3, var3439=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc>, var3886=$r4, var1061=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit>, var617=$r5, var499=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic>, var3760=$r14, var1322=$r6, var3825=java.util.List, var2376=java.util.Arrays, var3805=$r7, var896=java.util.Set, var710=edu.stanford.nlp.util.Generics, var3053=java.util.Collection, var855=$r8, var298=java.util.Collections, var3872=$r9, var3454=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet>, var2674=$r15, var2029=$r10, var3238=$r11, var683=$r12, var1863=$r13, var804=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet>}
; {edu.stanford.nlp.international.arabic.process.IOBUtils=var2058, $r0=var3499, $z0=var276, $z1=var26, <edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled>=var2746, java.lang.Object=var3021, $r1=var1418, edu.stanford.nlp.util.logging.Redwood$RedwoodChannels=var2314, edu.stanford.nlp.util.logging.Redwood=var3595, $r2=var1461, <edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>=var3138, java.util.regex.Pattern=var1509, $r3=var237, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc>=var3439, $r4=var3886, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit>=var1061, $r5=var617, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic>=var499, $r14=var3760, $r6=var1322, java.util.List=var3825, java.util.Arrays=var2376, $r7=var3805, java.util.Set=var896, edu.stanford.nlp.util.Generics=var710, java.util.Collection=var3053, $r8=var855, java.util.Collections=var298, $r9=var3872, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet>=var3454, $r15=var2674, $r10=var2029, $r11=var3238, $r12=var683, $r13=var1863, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet>=var804}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts $r0 = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;";	$z0 = virtualinvoke $r0.<java.lang.Class: boolean desiredAssertionStatus()>();	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	<edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled> = $z1;	$r1 = newarray (java.lang.Object)[1];	$r1[0] = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;";	$r2 = staticinvoke <edu.stanford.nlp.util.logging.Redwood: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels channels(java.lang.Object[])>($r1);	<edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> = $r2;	$r3 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Punct}+");	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc> = $r3;	$r4 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Digit}+");	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit> = $r4;	$r5 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\P{InArabic}+");	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic> = $r5;	$r14 = "\u0644 \u0641 \u0648 \u0645 \u0645\u0627 \u062d \u062d\u0627 \u0647 \u0647\u0627 \u0643 \u0628 \u0633";	$r6 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6);	$r8 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r7);	$r9 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r8);	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet> = $r9;	$r15 = "\u0644 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0634";	$r10 = virtualinvoke $r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r11 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r10);	$r12 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r11);	$r13 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r12);	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet> = $r13;	return
;block_num 3