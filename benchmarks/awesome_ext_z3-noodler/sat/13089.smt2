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

(declare-sort var2461 0)
(declare-sort var2683 0)
(declare-sort var997 0)
(declare-sort var2048 0)
(declare-sort var3359 0)
(declare-sort var1118 0)
(declare-sort var2662 0)
(declare-sort var58 0)
(declare-sort var3660 0)
(declare-sort var2052 0)
(declare-sort var1650 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2461!class ClassObject)
(declare-fun desiredAssertionStatus/-1561484483 (ClassObject) Bool)
(declare-fun arr-var2683-init () (Array Int var2683))
(declare-fun cast-from-ClassObject-to-var2683 (ClassObject) var2683)
(declare-fun var2048_channels/-1873906782 ((Array Int var2683)) var997)
(declare-fun var3359_compile/2141929305 (String) var3359)
(declare-fun var2662_asList/1779083644 ((Array Int var2683)) var1118)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2683__ ((Array Int String)) (Array Int var2683))
(declare-fun var3660_newHashSet/-438716120 (var2052) var58)
(declare-fun cast-from-var1118-to-var2052 (var1118) var2052)
(declare-fun var1650_unmodifiableSet/219896279 (var58) var58)
(declare-const null-__Array__Int__var2683__ (Array Int var2683))
(define-const var890 ClassObject var2461!class) ; Statement: $r0 = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;" 
(assert true)
(define-const var3131 Bool (desiredAssertionStatus/-1561484483 var890)) ; Statement: $z0 = virtualinvoke $r0.<java.lang.Class: boolean desiredAssertionStatus()>() 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var3131 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3408 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= <edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled> = $z1] 
(assert true) ; Non Conditional
(define-const var3718 Bool var3408) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled> = $z1 
(define-const var2188 (Array Int var2683) arr-var2683-init) ; Statement: $r1 = newarray (java.lang.Object)[1] 
(declare-const var2188!1 (Array Int var2683))
(assert (not (= var2188!1 null-__Array__Int__var2683__)))
(assert (= (select var2188!1 0) (cast-from-ClassObject-to-var2683 var2461!class))) ; Statement: $r1[0] = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;" 
(define-const var3442 var997 (var2048_channels/-1873906782 var2188!1)) ; Statement: $r2 = staticinvoke <edu.stanford.nlp.util.logging.Redwood: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels channels(java.lang.Object[])>($r1) 
(define-const var31 var997 var3442) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> = $r2 
(define-const var2641 var3359 (var3359_compile/2141929305 "\u005cp{Punct}+")) ; Statement: $r3 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Punct}+") 
(define-const var420 var3359 var2641) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc> = $r3 
(define-const var983 var3359 (var3359_compile/2141929305 "\u005cp{Digit}+")) ; Statement: $r4 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Digit}+") 
(define-const var2941 var3359 var983) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit> = $r4 
(define-const var130 var3359 (var3359_compile/2141929305 "\u005cP{InArabic}+")) ; Statement: $r5 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\P{InArabic}+") 
(define-const var3499 var3359 var130) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic> = $r5 
(define-const var1477 String "\u0644 \u0641 \u0648 \u0645 \u0645\u0627 \u062d \u062d\u0627 \u0647 \u0647\u0627 \u0643 \u0628 \u0633") ; Statement: $r14 = "\u0644 \u0641 \u0648 \u0645 \u0645\u0627 \u062d \u062d\u0627 \u0647 \u0647\u0627 \u0643 \u0628 \u0633" 
; split operation: var3817 = var1477.split("\u005cs+") ; Statement: $r6 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var301 var1118 (var2662_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2683__ var3817))) ; Statement: $r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6) 
(define-const var2254 var58 (var3660_newHashSet/-438716120 (cast-from-var1118-to-var2052 var301))) ; Statement: $r8 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r7) 
(define-const var2894 var58 (var1650_unmodifiableSet/219896279 var2254)) ; Statement: $r9 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r8) 
(define-const var1029 var58 var2894) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet> = $r9 
(define-const var957 String "\u0644 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0634") ; Statement: $r15 = "\u0644 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0634" 
; split operation: var2971 = var957.split("\u005cs+") ; Statement: $r10 = virtualinvoke $r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1358 var1118 (var2662_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2683__ var2971))) ; Statement: $r11 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r10) 
(define-const var1379 var58 (var3660_newHashSet/-438716120 (cast-from-var1118-to-var2052 var1358))) ; Statement: $r12 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r11) 
(define-const var968 var58 (var1650_unmodifiableSet/219896279 var1379)) ; Statement: $r13 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r12) 
(define-const var3192 var58 var968) ; Statement: <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet> = $r13 
 ; Statement: return 
(check-sat)
; {desiredAssertionStatus/-1561484483=([java.lang.Class], boolean), arr-var2683-init=([], java.lang.Object[]), cast-from-ClassObject-to-var2683=([java.lang.Class], java.lang.Object), var2048_channels/-1873906782=([java.lang.Object[]], edu.stanford.nlp.util.logging.Redwood$RedwoodChannels), var3359_compile/2141929305=([java.lang.String], java.util.regex.Pattern), var2662_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var2683__=([java.lang.String[]], java.lang.Object[]), var3660_newHashSet/-438716120=([java.util.Collection], java.util.Set), cast-from-var1118-to-var2052=([java.util.List], java.util.Collection), var1650_unmodifiableSet/219896279=([java.util.Set], java.util.Set)}
; {var2461=edu.stanford.nlp.international.arabic.process.IOBUtils, var890=$r0, var3131=$z0, var3408=$z1, var3718=<edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled>, var2683=java.lang.Object, var2188=$r1, var997=edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, var2048=edu.stanford.nlp.util.logging.Redwood, var3442=$r2, var31=<edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>, var3359=java.util.regex.Pattern, var2641=$r3, var420=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc>, var983=$r4, var2941=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit>, var130=$r5, var3499=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic>, var1477=$r14, var3817=$r6, var1118=java.util.List, var2662=java.util.Arrays, var301=$r7, var58=java.util.Set, var3660=edu.stanford.nlp.util.Generics, var2052=java.util.Collection, var2254=$r8, var1650=java.util.Collections, var2894=$r9, var1029=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet>, var957=$r15, var2971=$r10, var1358=$r11, var1379=$r12, var968=$r13, var3192=<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet>}
; {edu.stanford.nlp.international.arabic.process.IOBUtils=var2461, $r0=var890, $z0=var3131, $z1=var3408, <edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled>=var3718, java.lang.Object=var2683, $r1=var2188, edu.stanford.nlp.util.logging.Redwood$RedwoodChannels=var997, edu.stanford.nlp.util.logging.Redwood=var2048, $r2=var3442, <edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>=var31, java.util.regex.Pattern=var3359, $r3=var2641, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc>=var420, $r4=var983, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit>=var2941, $r5=var130, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic>=var3499, $r14=var1477, $r6=var3817, java.util.List=var1118, java.util.Arrays=var2662, $r7=var301, java.util.Set=var58, edu.stanford.nlp.util.Generics=var3660, java.util.Collection=var2052, $r8=var2254, java.util.Collections=var1650, $r9=var2894, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet>=var1029, $r15=var957, $r10=var2971, $r11=var1358, $r12=var1379, $r13=var968, <edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet>=var3192}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts $r0 = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;";	$z0 = virtualinvoke $r0.<java.lang.Class: boolean desiredAssertionStatus()>();	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= <edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled> = $z1];	<edu.stanford.nlp.international.arabic.process.IOBUtils: boolean $assertionsDisabled> = $z1;	$r1 = newarray (java.lang.Object)[1];	$r1[0] = class "Ledu/stanford/nlp/international/arabic/process/IOBUtils;";	$r2 = staticinvoke <edu.stanford.nlp.util.logging.Redwood: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels channels(java.lang.Object[])>($r1);	<edu.stanford.nlp.international.arabic.process.IOBUtils: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> = $r2;	$r3 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Punct}+");	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isPunc> = $r3;	$r4 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\p{Digit}+");	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern isDigit> = $r4;	$r5 = staticinvoke <java.util.regex.Pattern: java.util.regex.Pattern compile(java.lang.String)>("\\P{InArabic}+");	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.regex.Pattern notUnicodeArabic> = $r5;	$r14 = "\u0644 \u0641 \u0648 \u0645 \u0645\u0627 \u062d \u062d\u0627 \u0647 \u0647\u0627 \u0643 \u0628 \u0633";	$r6 = virtualinvoke $r14.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r7 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r6);	$r8 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r7);	$r9 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r8);	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arPrefixSet> = $r9;	$r15 = "\u0644 \u0648 \u0645\u0627 \u0647 \u0647\u0627 \u0647\u0645 \u0647\u0646 \u0646\u0627 \u0643\u0645 \u062a\u0646 \u062a\u0645 \u0649 \u064a \u0647\u0645\u0627 \u0643 \u0628 \u0634";	$r10 = virtualinvoke $r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r11 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r10);	$r12 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet(java.util.Collection)>($r11);	$r13 = staticinvoke <java.util.Collections: java.util.Set unmodifiableSet(java.util.Set)>($r12);	<edu.stanford.nlp.international.arabic.process.IOBUtils: java.util.Set arSuffixSet> = $r13;	return
;block_num 3