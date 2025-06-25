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

(declare-sort var3059 0)
(declare-sort var528 0)
(declare-sort var3656 0)
(declare-sort var881 0)
(declare-sort var684 0)
(declare-sort var1930 0)
(declare-sort var3766 0)
(declare-sort var2942 0)
(declare-sort var953 0)
(declare-sort var278 0)
(declare-sort var2399 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3059-init () var3059)
(declare-fun <init>/894151013 (var3059) void)
(declare-fun cast-from-var3059-to-var528 (var3059) var528)
(declare-fun var3656-init () var3656)
(declare-fun <init>/162799858 (var3656) void)
(declare-fun cast-from-var3656-to-var881 (var3656) var881)
(declare-fun var1930_newHashSet/99871946 () var684)
(declare-fun var953_asList/1779083644 ((Array Int var278)) var2942)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var278__ ((Array Int String)) (Array Int var278))
(declare-fun var684_addAll/-907809033 (var684 var2399) Bool)
(declare-fun cast-from-var2942-to-var2399 (var2942) var2399)
(declare-const var3766-reservedWords var684)
(define-const var1768 var3059 var3059-init) ; Statement: $r0 = new edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter 
(assert true)
;(assert (<init>/894151013 var1768)) ; Statement: specialinvoke $r0.<edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter: void <init>()>() 

(declare-const var1768!1 var3059)
(define-const var3907 var528 (cast-from-var3059-to-var528 var1768!1)) ; Statement: <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.function.Predicate emptyFilter> = $r0 
(define-const var2232 var3656 var3656-init) ; Statement: $r1 = new edu.stanford.nlp.trees.LabeledScoredTreeFactory 
(assert true)
;(assert (<init>/162799858 var2232)) ; Statement: specialinvoke $r1.<edu.stanford.nlp.trees.LabeledScoredTreeFactory: void <init>()>() 

(declare-const var2232!1 var3656)
(define-const var2813 var881 (cast-from-var3656-to-var881 var2232!1)) ; Statement: <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: edu.stanford.nlp.trees.TreeFactory tf> = $r1 
(define-const var417 String "-") ; Statement: <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.lang.String segMarker> = "-" 
(define-const var668 var684 var1930_newHashSet/99871946) ; Statement: $r2 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet()>() 
(define-const var607 var684 var668) ; Statement: <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.Set reservedWords> = $r2 
(define-const var3616 var684 var3766-reservedWords) ; Statement: $r4 = <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.Set reservedWords> 
(define-const var3470 String "-PLUS- -LRB- -RRB-") ; Statement: $r3 = "-PLUS- -LRB- -RRB-" 
; split operation: var3662 = var3470.split("\u005cs+") ; Statement: $r5 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var11 var2942 (var953_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var278__ var3662))) ; Statement: $r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r5) 
;(assert (var684_addAll/-907809033 var3616 (cast-from-var2942-to-var2399 var11))) ; Statement: interfaceinvoke $r4.<java.util.Set: boolean addAll(java.util.Collection)>($r6) 

(declare-const var3616!1 var684)
(declare-const var11!1 var2942)
 ; Statement: return 
(check-sat)
; {var3059-init=([], edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter), <init>/894151013=([edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter], void), cast-from-var3059-to-var528=([edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter], java.util.function.Predicate), var3656-init=([], edu.stanford.nlp.trees.LabeledScoredTreeFactory), <init>/162799858=([edu.stanford.nlp.trees.LabeledScoredTreeFactory], void), cast-from-var3656-to-var881=([edu.stanford.nlp.trees.LabeledScoredTreeFactory], edu.stanford.nlp.trees.TreeFactory), var1930_newHashSet/99871946=([], java.util.Set), var953_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var278__=([java.lang.String[]], java.lang.Object[]), var684_addAll/-907809033=([java.util.Set, java.util.Collection], boolean), cast-from-var2942-to-var2399=([java.util.List], java.util.Collection)}
; {var3059=edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter, var1768=$r0, var528=java.util.function.Predicate, var3907=<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.function.Predicate emptyFilter>, var3656=edu.stanford.nlp.trees.LabeledScoredTreeFactory, var2232=$r1, var881=edu.stanford.nlp.trees.TreeFactory, var2813=<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: edu.stanford.nlp.trees.TreeFactory tf>, var417=<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.lang.String segMarker>, var684=java.util.Set, var1930=edu.stanford.nlp.util.Generics, var668=$r2, var607=<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.Set reservedWords>, var3766=edu.stanford.nlp.trees.international.arabic.ATBTreeUtils, var3616=$r4, var3470=$r3, var3662=$r5, var2942=java.util.List, var953=java.util.Arrays, var278=java.lang.Object, var11=$r6, var2399=java.util.Collection}
; {edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter=var3059, $r0=var1768, java.util.function.Predicate=var528, <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.function.Predicate emptyFilter>=var3907, edu.stanford.nlp.trees.LabeledScoredTreeFactory=var3656, $r1=var2232, edu.stanford.nlp.trees.TreeFactory=var881, <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: edu.stanford.nlp.trees.TreeFactory tf>=var2813, <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.lang.String segMarker>=var417, java.util.Set=var684, edu.stanford.nlp.util.Generics=var1930, $r2=var668, <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.Set reservedWords>=var607, edu.stanford.nlp.trees.international.arabic.ATBTreeUtils=var3766, $r4=var3616, $r3=var3470, $r5=var3662, java.util.List=var2942, java.util.Arrays=var953, java.lang.Object=var278, $r6=var11, java.util.Collection=var2399}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts $r0 = new edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter;	specialinvoke $r0.<edu.stanford.nlp.trees.international.arabic.ArabicTreeNormalizer$ArabicEmptyFilter: void <init>()>();	<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.function.Predicate emptyFilter> = $r0;	$r1 = new edu.stanford.nlp.trees.LabeledScoredTreeFactory;	specialinvoke $r1.<edu.stanford.nlp.trees.LabeledScoredTreeFactory: void <init>()>();	<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: edu.stanford.nlp.trees.TreeFactory tf> = $r1;	<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.lang.String segMarker> = "-";	$r2 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet()>();	<edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.Set reservedWords> = $r2;	$r4 = <edu.stanford.nlp.trees.international.arabic.ATBTreeUtils: java.util.Set reservedWords>;	$r3 = "-PLUS- -LRB- -RRB-";	$r5 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r6 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r5);	interfaceinvoke $r4.<java.util.Set: boolean addAll(java.util.Collection)>($r6);	return
;block_num 1